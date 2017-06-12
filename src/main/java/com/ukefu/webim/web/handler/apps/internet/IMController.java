
package com.ukefu.webim.web.handler.apps.internet;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.BrowserClient;
import com.ukefu.util.CheckMobile;
import com.ukefu.util.IP;
import com.ukefu.util.IPTools;
import com.ukefu.util.Menu;
import com.ukefu.util.UKTools;
import com.ukefu.util.extra.DataExchangeInterface;
import com.ukefu.util.webim.WebIMClient;
import com.ukefu.webim.service.acd.ServiceQuene;
import com.ukefu.webim.service.repository.AgentUserContactsRepository;
import com.ukefu.webim.service.repository.ChatMessageRepository;
import com.ukefu.webim.service.repository.ConsultInviteRepository;
import com.ukefu.webim.service.repository.ContactsRepository;
import com.ukefu.webim.service.repository.InviteRecordRepository;
import com.ukefu.webim.service.repository.LeaveMsgRepository;
import com.ukefu.webim.service.repository.OrganRepository;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.util.MessageUtils;
import com.ukefu.webim.util.OnlineUserUtils;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.AgentUserContacts;
import com.ukefu.webim.web.model.Contacts;
import com.ukefu.webim.web.model.CousultInvite;
import com.ukefu.webim.web.model.InviteRecord;
import com.ukefu.webim.web.model.LeaveMsg;
import com.ukefu.webim.web.model.SessionConfig;
import com.ukefu.webim.web.model.UploadStatus;
import com.ukefu.webim.web.model.User;
import com.ukefu.webim.web.model.UserHistory;

@Controller
@RequestMapping("/im")
@EnableAsync
public class IMController extends Handler{
	
	@Value("${uk.im.server.host}")  
    private String host;  
  
    @Value("${uk.im.server.port}")  
    private Integer port; 
    
    @Value("${web.upload-path}")
    private String path;
    
	@Autowired
	private ConsultInviteRepository inviteRepository;
	
	@Autowired
	private ChatMessageRepository chatMessageRes ;
	
	@Autowired
	private InviteRecordRepository inviteRecordRes ;
	
	
	@Autowired
	private OrganRepository organRes ;
	
	@Autowired
	private UserRepository agentRes ;
	
	@Autowired
	private LeaveMsgRepository leaveMsgRes ;
	
	@Autowired
	private ContactsRepository contactsRes ;
	
	@Autowired
	private AgentUserContactsRepository agentUserContactsRes ;
	
    @RequestMapping("/{id}")
    @Menu(type = "im" , subtype = "point" , access = true)
    public ModelAndView point(HttpServletRequest request , HttpServletResponse response, @PathVariable String id , @Valid String orgi , @Valid String userid , @Valid String title) {
    	ModelAndView view = request(super.createRequestPageTempletResponse("/apps/im/point")) ; 
    	
    	view.addObject("hostname", request.getServerName()) ;
		view.addObject("port", request.getServerPort()) ;
		view.addObject("schema", request.getScheme()) ;
		view.addObject("appid", id) ;
		view.addObject("client", UKTools.getUUID()) ;
		view.addObject("sessionid", request.getSession().getId()) ;
		
		view.addObject("mobile", CheckMobile.check(request.getHeader("User-Agent"))) ;
		
		CousultInvite invite = inviteRepository.findOne(id) ;
    	if(invite!=null){
    		view.addObject("inviteData", invite);
    		view.addObject("orgi",invite.getOrgi());
    		view.addObject("appid",id);
    	//记录用户行为日志
			UserHistory userHistory = new UserHistory() ;
			String url = request.getRequestURL().toString() ;
			if(url.length() >255){
				userHistory.setUrl(url.substring( 0 , 255));
			}else{
				userHistory.setUrl(url);
			}
			userHistory.setParam(UKTools.getParameter(request));
			if(userHistory!=null){
				userHistory.setMaintype("im");
				userHistory.setSubtype("point");
				userHistory.setName("online");
				userHistory.setAdmin(false);
				userHistory.setAccessnum(true);
			}
			User imUser = super.getIMUser(request , userid, null) ;
			if(imUser!=null){
				userHistory.setCreater(imUser.getId());
				userHistory.setUsername(imUser.getUsername());
				userHistory.setOrgi(orgi);
			}
			if(!StringUtils.isBlank(title)){
				if(title.length() > 255){
					userHistory.setTitle(title.substring(0 , 255));
				}else{
					userHistory.setTitle(title);
				}
			}
			userHistory.setOrgi(invite.getOrgi());
			userHistory.setAppid(id);
			userHistory.setSessionid(request.getSession().getId());
			userHistory.setHostname(request.getRemoteHost());
			userHistory.setIp(request.getRemoteAddr());
			IP ipdata = IPTools.getInstance().findGeography(UKTools.getIpAddr(request));
			userHistory.setCountry(ipdata.getCountry());
			userHistory.setProvince(ipdata.getProvince());
			userHistory.setCity(ipdata.getCity());
		    userHistory.setIsp(ipdata.getIsp());
		    
		    BrowserClient client = UKTools.parseClient(request) ;
		    userHistory.setOstype(client.getOs());
		    userHistory.setBrowser(client.getBrowser());
		    userHistory.setMobile(CheckMobile.check(request.getHeader("User-Agent")) ? "1" : "0");
		    
		    
		    /***
		     * 查询 技能组 ， 缓存？ 
		     */
		    view.addObject("skillList", organRes.findByOrgiAndSkill(invite.getOrgi(), true))  ;
		    /**
		     * 查询坐席 ， 缓存？
		     */
		    view.addObject("agentList", agentRes.findByOrgiAndAgent(invite.getOrgi(), true))  ;
		    
			UKTools.published(userHistory);
		}
		
        return view;
    }
    /**
     * 延时获取用户端浏览器的跟踪ID
     * @param request
     * @param response
     * @param orgi
     * @param appid
     * @param userid
     * @param sign
     * @return
     */
    @RequestMapping("/online")
    @Menu(type = "im" , subtype = "online" , access = true)
    public SseEmitter callable(HttpServletRequest request , HttpServletResponse response , @Valid Contacts contacts, final @Valid String orgi , @Valid String appid, final @Valid String userid , @Valid String sign , final @Valid String client) {
		final SseEmitter emitter = new SseEmitter();
		if(!StringUtils.isBlank(userid)){
			emitter.onCompletion(new Runnable() {
				@Override
				public void run() {	
					try {
						OnlineUserUtils.webIMClients.removeClient(userid , client , false) ; //执行了 邀请/再次邀请后终端的
					} catch (Exception e) {
						e.printStackTrace();
					}	
				}
			});
			emitter.onTimeout(new Runnable() {	
				@Override
				public void run() {
					emitter.complete();
					try {
						OnlineUserUtils.webIMClients.removeClient(userid , client , true) ;	//正常的超时断开
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			});
			contacts = processContacts(orgi, contacts, appid, userid);
	    	if(!StringUtils.isBlank(sign)){
	    		OnlineUserUtils.online(super.getIMUser(request , sign , contacts!=null ? contacts.getName() : null) , orgi , request.getSession().getId() , UKDataContext.OnlineUserTypeStatus.WEBIM.toString(), request , UKDataContext.ChannelTypeEnum.WEBIM.toString() , appid , contacts);
	    	}
	    	
	    	OnlineUserUtils.webIMClients.putClient(userid, new WebIMClient(userid  , client , emitter)) ;
		}
		return emitter;
	}
    
    @RequestMapping("/index")
    @Menu(type = "im" , subtype = "index" , access = true)
    public ModelAndView index(HttpServletRequest request , HttpServletResponse response, @Valid String orgi, @Valid String mobile , @Valid String ai , @Valid String client , @Valid String type, @Valid String appid, @Valid String userid, @Valid String sessionid , @Valid String skill, @Valid String agent , @Valid Contacts contacts) throws Exception {
    	ModelAndView view = request(super.createRequestPageTempletResponse("/apps/im/index")) ; 
    	if(!StringUtils.isBlank(appid)){
    		CousultInvite invite = inviteRepository.findOne(appid) ;
    		if(invite!=null){
    			SessionConfig sessionConfig = ServiceQuene.initSessionConfig(super.getOrgi(request)) ;
    			if(UKDataContext.model.get("xiaoe")!=null  && invite.isAi() && ((!StringUtils.isBlank(ai) && ai.equals("true")) || (invite.isAifirst() && ai == null))){	//启用 AI ， 并且 AI优先 接待
    				view = request(super.createRequestPageTempletResponse("/apps/im/ai/index")) ;
    				if(CheckMobile.check(request.getHeader("User-Agent")) || !StringUtils.isBlank(mobile)){
    					view = request(super.createRequestPageTempletResponse("/apps/im/ai/mobile")) ;		//智能机器人 移动端
    				}
    				String userID = UKTools.genIDByKey(sessionid);
    				String nickname = "Guest_" + userID;
    				if(contacts!=null && !StringUtils.isBlank(contacts.getName())){
    					nickname = contacts.getName() ;
    				}
    				view.addObject("username", nickname) ;
    				if(UKDataContext.model.get("xiaoe")!=null){
    					DataExchangeInterface dataExchange = (DataExchangeInterface) UKDataContext.getContext().getBean("topic") ;
    					if(dataExchange!=null){
    						view.addObject("topicList", dataExchange.getListDataByIdAndOrgi(super.getUser(request).getId(), super.getUser(request).getId(),  super.getOrgi(request))) ;
    					}
    				}
    			}else{
    				if(CheckMobile.check(request.getHeader("User-Agent"))){
    					view = request(super.createRequestPageTempletResponse("/apps/im/mobile")) ;	//WebIM移动端。再次点选技能组？
    				}
    			}
    			if(sessionConfig.isHourcheck() && !UKTools.isInWorkingHours(sessionConfig.getWorkinghours()) && invite.isLeavemessage()){		//非工作时间段，跳转到留言页面
	    			view = request(super.createRequestPageTempletResponse("/apps/im/leavemsg")) ;
	    		}else{
	    			view.addObject("chatMessageList", chatMessageRes.findByUsessionAndOrgi(userid , orgi, new PageRequest(0, 20, Direction.DESC , "updatetime"))) ;
	    		}
	    		view.addObject("sessionConfig", sessionConfig);
	    		view.addObject("inviteData", invite);
	    		view.addObject("orgi",invite.getOrgi());
	    	}
    		
	    	view.addObject("hostname", request.getServerName()) ;
			view.addObject("port", port) ;
			view.addObject("appid", appid) ;
			view.addObject("userid", userid) ;
			view.addObject("schema", request.getScheme()) ;
			view.addObject("sessionid", sessionid) ;
			
			if(!StringUtils.isBlank(client)){
				view.addObject("client", client) ;
			}
			if(!StringUtils.isBlank(skill)){
				view.addObject("skill", skill) ;
			}
			if(!StringUtils.isBlank(agent)){
				view.addObject("agent", agent) ;
			}
			
			if(!StringUtils.isBlank(type)){
				view.addObject("type", type) ;
			}
			
			contacts = processContacts(invite.getOrgi(), contacts, appid, userid);
	    	
	//    	OnlineUserUtils.sendWebIMClients(userid , "accept");
	    	Page<InviteRecord> inviteRecordList = inviteRecordRes.findByUseridAndOrgi(userid, orgi , new PageRequest(0, 1, Direction.DESC, "createtime")) ;
	    	if(inviteRecordList.getContent()!=null && inviteRecordList.getContent().size()>0){
	    		InviteRecord record = inviteRecordList.getContent().get(0) ;
	    		record.setUpdatetime(new Date());
	    		record.setResponsetime((int) (System.currentTimeMillis() - record.getCreatetime().getTime()));
	    		record.setResult(UKDataContext.OnlineUserInviteStatus.ACCEPT.toString());
	    		inviteRecordRes.save(record) ;
	    	}
	    	
    	}
        return view;
    }
    
    private Contacts processContacts(String orgi ,Contacts contacts , String appid , String userid){
    	if(contacts!=null){
			
			if(contacts != null && (!StringUtils.isBlank(contacts.getName()) || !StringUtils.isBlank(contacts.getMobile()) || !StringUtils.isBlank(contacts.getEmail()))){
				StringBuffer query = new StringBuffer();
				query.append(contacts.getName()) ;
				if(!StringUtils.isBlank(contacts.getMobile())){
					query.append(" OR ").append(contacts.getMobile()) ;
				}
				if(!StringUtils.isBlank(contacts.getEmail())){
					query.append(" OR ").append(contacts.getEmail()) ;
				}
				Page<Contacts> contactsList = contactsRes.findByOrgi(orgi, false, query.toString(), new PageRequest(0, 1)) ;
				if(contactsList.getContent().size() > 0){
					contacts = contactsList.getContent().get(0) ;
				}else{
//					contactsRes.save(contacts) ;	//需要增加签名验证，避免随便产生垃圾信息，也可以自行修改？
					contacts = null ;
				}
			}
			if(contacts!=null){
				List<AgentUserContacts> agentUserContactsList = agentUserContactsRes.findByUseridAndOrgi(userid, orgi) ;
				if(agentUserContactsList.size() == 0){
    				AgentUserContacts agentUserContacts = new AgentUserContacts() ;
    				agentUserContacts.setAppid(appid);
    				agentUserContacts.setChannel(UKDataContext.ChannelTypeEnum.WEBIM.toString());
    				agentUserContacts.setContactsid(contacts.getId());
    				agentUserContacts.setUserid(userid);
    				agentUserContacts.setOrgi(orgi);
    				agentUserContacts.setCreatetime(new Date());
    				agentUserContactsRes.save(agentUserContacts) ;
				}
			} 
		}
    	return contacts ;
    }
    
    @RequestMapping("/text/{id}")
    @Menu(type = "im" , subtype = "index" , access = true)
    public ModelAndView text(HttpServletRequest request , HttpServletResponse response, @PathVariable String id , @Valid String skill , @Valid String agent) throws Exception {
    	ModelAndView view = request(super.createRequestPageTempletResponse("/apps/im/text")) ; 
    	
    	view.addObject("hostname", request.getServerName()) ;
		view.addObject("port", request.getServerPort()) ;
		view.addObject("schema", request.getScheme()) ;
		view.addObject("appid", id) ;
		if(!StringUtils.isBlank(skill)){
			view.addObject("skill", skill) ;
		}
		if(!StringUtils.isBlank(agent)){
			view.addObject("agent", agent) ;
		}
		
		view.addObject("client", UKTools.getUUID()) ;
		view.addObject("sessionid", request.getSession().getId()) ;
		
		CousultInvite invite = inviteRepository.findOne(id) ;
    	if(invite!=null){
    		view.addObject("inviteData", invite);
    		view.addObject("orgi",invite.getOrgi());
    		view.addObject("appid",id);
    	}
    	
		return view;
    }
    
    
    @RequestMapping("/leavemsg/save")
    @Menu(type = "admin" , subtype = "user")
    public ModelAndView leavemsgsave(HttpServletRequest request ,@Valid String appid ,@Valid LeaveMsg msg) {
    	if(!StringUtils.isBlank(appid)){
    		CousultInvite invite = inviteRepository.findOne(appid) ;
	    	List<LeaveMsg> msgList = leaveMsgRes.findByOrgiAndMobile(invite.getOrgi(), msg.getMobile()) ;
	    	if(msg!=null && msgList.size() == 0){
	    		msg.setOrgi(invite.getOrgi());
	    		leaveMsgRes.save(msg) ;
	    	}
    	}
    	return request(super.createRequestPageTempletResponse("/apps/im/leavemsgsave"));
    }
    
    @RequestMapping("/refuse")
    @Menu(type = "im" , subtype = "refuse" , access = true)
    public void refuse(HttpServletRequest request , HttpServletResponse response, @Valid String orgi , @Valid String appid, @Valid String userid, @Valid String sessionid, @Valid String client) throws Exception {
    	OnlineUserUtils.refuseInvite(userid, orgi);
//    	OnlineUserUtils.sendWebIMClients(userid , "refuse");
    	Page<InviteRecord> inviteRecordList = inviteRecordRes.findByUseridAndOrgi(userid, orgi , new PageRequest(0, 1, Direction.DESC, "createtime")) ;
    	if(inviteRecordList.getContent()!=null && inviteRecordList.getContent().size()>0){
    		InviteRecord record = inviteRecordList.getContent().get(0) ;
    		record.setUpdatetime(new Date());
    		record.setResponsetime((int) (System.currentTimeMillis() - record.getCreatetime().getTime()));
    		record.setResult(UKDataContext.OnlineUserInviteStatus.REFUSE.toString());
    		inviteRecordRes.save(record) ;
    	}
        return;
    }
    
    @RequestMapping("/image/upload")
    @Menu(type = "im" , subtype = "image" , access = true)
    public ModelAndView upload(ModelMap map,HttpServletRequest request , @RequestParam(value = "imgFile", required = false) MultipartFile imgFile , @Valid String channel, @Valid String userid, @Valid String username , @Valid String appid , @Valid String orgi) throws IOException {
    	ModelAndView view = request(super.createRequestPageTempletResponse("/apps/im/upload")) ; 
    	UploadStatus upload = null ;
    	String fileName = null ;
    	if(imgFile!=null && imgFile.getOriginalFilename().lastIndexOf(".") > 0 && !StringUtils.isBlank(userid)){
    		File uploadDir = new File(path , "upload");
    		if(!uploadDir.exists()){
    			uploadDir.mkdirs() ;
    		}
    		String fileid = UKTools.md5(imgFile.getBytes()) ;
    		fileName = "upload/"+fileid+"_original" ;
    		File imageFile = new File(path , fileName) ;
    		FileCopyUtils.copy(imgFile.getBytes(), imageFile);
    		String thumbnailsFileName = "upload/"+fileid ;
    		UKTools.processImage(new File(path , thumbnailsFileName), imageFile) ;
    		
    		
    		upload = new UploadStatus("0" , "/res/image.html?id="+thumbnailsFileName);
    		
    		String image =  request.getScheme()+"://"+request.getServerName()+"/res/image.html?id="+thumbnailsFileName ;
    		if(request.getServerPort() == 80){
    			image = request.getScheme()+"://"+request.getServerName()+"/res/image.html?id="+thumbnailsFileName;
			}else{
				image = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/res/image.html?id="+thumbnailsFileName;
			}
    		if(!StringUtils.isBlank(channel)){
    			MessageUtils.uploadImage(image , channel, userid , username , appid , orgi);
    		}else{
    			MessageUtils.uploadImage(image, userid);
    		}
    	}else{
    		upload = new UploadStatus("请选择图片文件");
    	}
    	map.addAttribute("upload", upload) ;
        return view ; 
    }
}