package com.ukefu.webim.api;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ukefu.webim.service.repository.*;
import com.ukefu.webim.util.HttpClientUtil;
import com.ukefu.webim.util.server.message.ChatMessage;
import com.ukefu.webim.web.model.AgentServiceSatis;
import com.ukefu.webim.web.model.SNSAccount;
import com.ukefu.webim.web.model.Tenant;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * author: jinxiangyi
 * date:   2018/1/31
 * description:
 */
@RestController
@RequestMapping("/cs/")
public class CSController {

    private static final Logger log = LoggerFactory.getLogger(CSController.class);

    @Autowired
    private TenantRepository tenantRepository;

    @Autowired
    private KnowledgeRepository knowledgeRepository;

    @Autowired
    private ChatMessageRepository chatMessageRepository;

    @Autowired
    private SNSAccountRepository snsAccountRepository;

    @Autowired
    private AgentServiceSatisRepository agentServiceSatisRes;

    @Value("${api.url.ai.answer-matching}")
    private String answerMatchingUrl;

    @Value("${uk.im.server.port}")
    private Integer port;


    /**
     * 调用AI接口获取答案
     * @param phoneNo
     * @param productKey
     * @param question
     * @return
     */
    @RequestMapping(value = "answer/matching", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> answerMatching(String phoneNo, String productKey, String question, String sessionKey){
        log.info("#######  调用AI获取答案入参：phoneNo=" + phoneNo + " productKey=" + productKey + " question=" + question + " sessionKey=" + sessionKey);
        String message = checkBlank(productKey, question, sessionKey);
        if (StringUtils.isNotBlank(message)) {
            return resultMap("303", message, null);
        }

        Tenant tenant = tenantRepository.findById(productKey);
        if (tenant == null) {
            return resultMap("400", "没有找到对应的产品信息！", null);
        }

        Map<String, String> paraMap = new HashMap(5);
        paraMap.put("time", System.currentTimeMillis() + "");
        paraMap.put("phone", phoneNo + "");
        paraMap.put("question_str", question);
        paraMap.put("product_key", productKey);
        long s = System.currentTimeMillis();
        String result = HttpClientUtil.post(answerMatchingUrl, paraMap);
        long e = System.currentTimeMillis();
        log.info("#######  调用AI获取答案结果：" + result,"调用时长"+(e-s));
        if (StringUtils.isBlank(result)) {
            return resultMap("500", "AI接口处理异常！", null);
        }

        JSONObject resultJSON = JSONObject.parseObject(result);
        if (!StringUtils.equals("1", resultJSON.getString("status"))) {
            return resultMap("500", "AI接口处理失败！", null);
        }

        ChatMessage send = new ChatMessage();
        send.setType("message");
        send.setCalltype("in");
        send.setContextid(sessionKey);
        send.setSessionid(sessionKey);
        send.setMessage(question);
        send.setMsgtype("text");
        send.setOrgi(productKey);
        chatMessageRepository.save(send);

        JSONArray arrayJSON = resultJSON.getJSONArray("data");
        for (int i = 0; i < arrayJSON.size(); i++) {
            JSONObject dataJSON = arrayJSON.getJSONObject(i);
            ChatMessage receive = new ChatMessage();
            receive.setCalltype("out");
            receive.setContextid(sessionKey);
            receive.setSessionid(sessionKey);
            receive.setTouser(sessionKey);
            receive.setMsgtype("text");
            receive.setOrgi(productKey);
            // 是否匹配到答案
            String fromkb = dataJSON.getString("fromkb");
            if (StringUtils.equals(fromkb, "0")) {
                String status = dataJSON.getString("status");
                if (StringUtils.equals("12000", status)) {
                    receive.setMessage("AI匹配无结果！");
                } else {
                    receive.setMessage("返回相似问题！");
                }
            } else {
                receive.setMessage(dataJSON.getString("answer"));
            }
            chatMessageRepository.save(receive);
        }
        return resultMap("200", "查询成功", arrayJSON);
    }


    /**
     * 获取热门问题列表
     * @return
     */
    @RequestMapping(value = "hot-issue/list", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> hotIssueList(String productKey){
        log.info("#######  获取热门问题入参：orgi=" + productKey);
        List<String> dataList = knowledgeRepository.findByOrgi(productKey);
        log.info("#######  返回结果：" + JSONArray.toJSONString(dataList));
        if (dataList == null || dataList.size() == 0) {
            return resultMap("400", "该产品尚未设置热门问题", null);
        }
        return resultMap("200", "查询成功", dataList);
    }


    /**
     * 满意度评价
     * @param satis
     * @return
     */
    @RequestMapping(value = "service/evaluation", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> serviceEvaluation(@Valid AgentServiceSatis satis){
        log.info("#######  提交满意度评价入参：" + JSONObject.toJSONString(satis));
        if (satis == null) {
            return resultMap("300", "无法获取评价内容！", null);
        }
        if(StringUtils.isNotBlank(satis.getId())){
            int count = agentServiceSatisRes.countById(satis.getId());
            log.info("#######  count = " + count);
            if(count == 1){
                if(StringUtils.isNotBlank(satis.getSatiscomment()) && satis.getSatiscomment().length() > 255){
                    satis.setSatiscomment(satis.getSatiscomment().substring(0 , 255));
                }
                satis.setSatisfaction(true);
                satis.setSatistime(new Date());
                agentServiceSatisRes.save(satis);
                log.info("#######  满意度评价保存成功");
            }
        }
        return resultMap("200", "评价成功", null);
    }


    /**
     * 转接在线人工客服
     * @param request
     * @param imsign 会话标识
     * @return
     */
    @RequestMapping(value = "manual-service", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> manualService(HttpServletRequest request, String imsign){
        log.info("#######  转接人工客服入参：imsign = " + imsign);
        if (StringUtils.isBlank(imsign)) {
            return resultMap("303", "会话标识不能为空", null);
        }
        SNSAccount snsAccount = snsAccountRepository.findBySnsid(imsign);
        log.info("#######  返回SNSAccount结果：" + JSONObject.toJSONString(snsAccount));
        if (snsAccount == null || StringUtils.isBlank(snsAccount.getOrgi())) {
            return resultMap("400", "该产品尚未接入人工服务", null);
        }
        Map<String, Object> paraMap = new HashMap();
        paraMap.put("appid", imsign);
        paraMap.put("product", snsAccount.getOrgi());
        paraMap.put("session", request.getSession().getId());
        return resultMap("200", "初始化连参数成功", paraMap);
    }


    // 参数为空校验
    private static String checkBlank(String... parameters){
        for (String parameter : parameters) {
            if (StringUtils.isBlank(parameter)) {
                return "必填参数不能为空！";
            }
        }
        return StringUtils.EMPTY;
    }


    // 返回结果定义
    private static Map<String, Object> resultMap(String status, String message, Object data){
        Map<String, Object> resultMap = new HashMap(5);
        resultMap.put("status", status);
        resultMap.put("message", message);
        resultMap.put("data", data);
        return resultMap;
    }

}