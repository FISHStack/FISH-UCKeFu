package com.ukefu.webim.web.handler.api.rest;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.Menu;
import com.ukefu.util.extra.DataExchangeInterface;
import com.ukefu.webim.service.repository.ChatMessageRepository;
import com.ukefu.webim.service.repository.ConsultInviteRepository;
import com.ukefu.webim.util.OnlineUserUtils;
import com.ukefu.webim.util.RestResult;
import com.ukefu.webim.util.RestResultType;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.AiConfig;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/rest/webim")
@Api(value = "在线客服" , description = "在线客服接口功能")
public class ApiIMController extends Handler{

	@Autowired
	private ConsultInviteRepository consultInviteRepository;
	
	@Autowired
	private ChatMessageRepository chatMessageRes ;
	
	/**
	 * 返回在线网站配置
	 * @param request
	 * @param id	snsaccountid
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@Menu(type = "apps" , subtype = "webim" , access = true)
	@ApiOperation("获取在线客服")
    public ResponseEntity<RestResult> list(HttpServletRequest request , @PathVariable String id) {
        return new ResponseEntity<>(new RestResult(RestResultType.OK, OnlineUserUtils.cousult(id ,null, consultInviteRepository)), HttpStatus.OK);
    }
	
	/**
	 * 返回当前访客的会话ID
	 * @param request
	 * @param username	搜索用户名，精确搜索
	 * @return
	 */
	@RequestMapping(value = "/session", method = RequestMethod.GET)
	@Menu(type = "apps" , subtype = "webim" , access = true)
	@ApiOperation("获取在线客服会话ID")
    public ResponseEntity<RestResult> session(HttpServletRequest request) {
        return new ResponseEntity<>(new RestResult(RestResultType.OK, request.getSession().getId()), HttpStatus.OK);
    }
	
	/**
	 * 返回AI配置信息
	 * @param request
	 * @param aiid    , AI标识	
	 * @return
	 */
	@RequestMapping(value = "/ai", method = RequestMethod.GET)
	@Menu(type = "apps" , subtype = "webim" , access = true)
	@ApiOperation("获取在线客服会话ID")
    public ResponseEntity<RestResult> session(HttpServletRequest request , @Valid String aiid, @Valid String orgi) {
		AiConfig aiConfig = null ;
		if(UKDataContext.model.get("xiaoe")!=null && !StringUtils.isBlank(aiid)){	//启用 AI ， 并且 AI优先 接待
			DataExchangeInterface dataInterface = (DataExchangeInterface) UKDataContext.getContext().getBean("aiconfig") ;
			aiConfig = (AiConfig) dataInterface.getDataByIdAndOrgi(aiid, orgi) ;
		}
        return new ResponseEntity<>(new RestResult(RestResultType.OK, aiConfig), HttpStatus.OK);
    }
	
	/**
	 * 返回访客历史消息
	 * @param request
	 * @param userid	访客ID
	 * @p 分页信息
	 * @return
	 */
	@RequestMapping(value = "/chat/his", method = RequestMethod.GET)
	@Menu(type = "apps" , subtype = "webim" , access = true)
	@ApiOperation("获取在线客服会话历史消息")
    public ResponseEntity<RestResult> history(HttpServletRequest request , @Valid String userid, @Valid String orgi) {
        return new ResponseEntity<>(new RestResult(RestResultType.OK, chatMessageRes.findByUsessionAndOrgi(userid , orgi, new PageRequest(super.getP(request), super.getPs(request), Direction.DESC , "updatetime"))), HttpStatus.OK);
    }
}