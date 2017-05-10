package com.ukefu.webim.web.handler.apps.agent;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.Menu;
import com.ukefu.util.UKTools;
import com.ukefu.util.client.NettyClients;
import com.ukefu.util.extra.DataExchangeInterface;
import com.ukefu.webim.service.acd.ServiceQuene;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.AgentServiceRepository;
import com.ukefu.webim.service.repository.AgentStatusRepository;
import com.ukefu.webim.service.repository.AgentUserRepository;
import com.ukefu.webim.service.repository.AgentUserTaskRepository;
import com.ukefu.webim.service.repository.BlackListRepository;
import com.ukefu.webim.service.repository.ChatMessageRepository;
import com.ukefu.webim.service.repository.OnlineUserRepository;
import com.ukefu.webim.service.repository.OrganRepository;
import com.ukefu.webim.service.repository.QuickReplyRepository;
import com.ukefu.webim.service.repository.SNSAccountRepository;
import com.ukefu.webim.service.repository.ServiceSummaryRepository;
import com.ukefu.webim.service.repository.TagRelationRepository;
import com.ukefu.webim.service.repository.TagRepository;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.service.repository.WeiXinUserRepository;
import com.ukefu.webim.util.router.OutMessageRouter;
import com.ukefu.webim.util.server.message.ChatMessage;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.AgentService;
import com.ukefu.webim.web.model.AgentServiceSummary;
import com.ukefu.webim.web.model.AgentStatus;
import com.ukefu.webim.web.model.AgentUser;
import com.ukefu.webim.web.model.AgentUserTask;
import com.ukefu.webim.web.model.BlackEntity;
import com.ukefu.webim.web.model.MessageOutContent;
import com.ukefu.webim.web.model.OnlineUser;
import com.ukefu.webim.web.model.Organ;
import com.ukefu.webim.web.model.SessionConfig;
import com.ukefu.webim.web.model.TagRelation;
import com.ukefu.webim.web.model.UploadStatus;
import com.ukefu.webim.web.model.User;
import com.ukefu.webim.web.model.WeiXinUser;

@Controller
@RequestMapping("/agent")
public class AgentController extends Handler {
	
	@Autowired
	private AgentUserRepository agentUserRepository ;
	
	@Autowired
	private AgentStatusRepository agentStatusRepository ;
	
	@Autowired
	private AgentServiceRepository agentServiceRepository;
	
	@Autowired
	private OnlineUserRepository onlineUserRes;
	
	@Autowired
	private WeiXinUserRepository weiXinUserRes;
	
	@Autowired
	private ServiceSummaryRepository serviceSummaryRes ;
	
	@Autowired
	private ChatMessageRepository chatMessageRepository ;
	
	@Autowired 
	private BlackListRepository blackListRes ;
	
	@Autowired
	private TagRepository tagRes ;
	
	@Autowired
	private OrganRepository organRes ;
	
	@Autowired
	private TagRelationRepository tagRelationRes ;
	
	@Autowired
	private QuickReplyRepository quickReplyRes ;
	
	@Autowired
	private AgentUserTaskRepository agentUserTaskRes ;
	
	@Autowired
	private SNSAccountRepository snsAccountRes ;
	
	@Autowired
	private UserRepository userRes ;
	
	@Value("${web.upload-path}")
	private String path;	
	
	@RequestMapping("/index")
	@Menu(type = "apps", subtype = "agent")
	public ModelAndView index(ModelMap map , HttpServletRequest request) {
		ModelAndView view = request(super.createAppsTempletResponse("/apps/agent/index")) ; 
		User user = super.getUser(request) ;
		List<AgentUser> agentUserList = agentUserRepository.findByAgentnoAndOrgi(user.getId() , super.getOrgi(request));
		view.addObject("agentUserList", agentUserList) ;
		
		if(agentUserList.size() > 0){
			AgentUser agentUser = agentUserList.get(0) ;
			agentUser = (AgentUser) agentUserList.get(0);
			view.addObject("curagentuser", agentUser);
			
			if(!StringUtils.isBlank(agentUser.getAgentserviceid())){
				AgentServiceSummary summary = this.serviceSummaryRes.findByAgentserviceidAndOrgi(agentUser.getAgentserviceid(), super.getOrgi(request)) ;
				if(summary!=null){
					view.addObject("summary", summary) ;
				}
			}

			view.addObject("agentUserMessageList", this.chatMessageRepository.findByUsessionAndOrgi(agentUser.getUserid() , super.getOrgi(request), new PageRequest(0, 20, Direction.DESC , "createtime")));
			
			if(UKDataContext.ChannelTypeEnum.WEIXIN.toString().equals(agentUser.getChannel())){
				List<WeiXinUser> weiXinUserList = weiXinUserRes.findByOpenidAndOrgi(agentUser.getUserid(), super.getOrgi(request)) ;
				if(weiXinUserList.size() > 0){
					WeiXinUser weiXinUser = weiXinUserList.get(0) ;
					view.addObject("weiXinUser",weiXinUser);
				}
			}else if(UKDataContext.ChannelTypeEnum.WEBIM.toString().equals(agentUser.getChannel())){
				OnlineUser onlineUser = this.onlineUserRes.findByUseridAndOrgi(agentUser.getUserid(), super.getOrgi(request)) ;
				if(onlineUser!=null){
					if(UKDataContext.OnlineUserOperatorStatus.OFFLINE.toString().equals(onlineUser.getStatus())){
						onlineUser.setBetweentime((int) (onlineUser.getUpdatetime().getTime() - onlineUser.getLogintime().getTime()));
					}else{
						onlineUser.setBetweentime((int) (System.currentTimeMillis() - onlineUser.getLogintime().getTime()));
					}
					view.addObject("onlineUser",onlineUser);
				}
			}
			if(!StringUtils.isBlank(agentUser.getAgentserviceid())){
				AgentService agentService = this.agentServiceRepository.findOne(agentUser.getAgentserviceid()) ;
				view.addObject("curAgentService", agentService) ;
				
				if(agentService!=null){
					/**
					 * 获取关联数据
					 */
					processRelaData(request, agentService, map);
				}
			}
			view.addObject("serviceCount", Integer
					.valueOf(this.agentServiceRepository
							.countByUseridAndOrgiAndStatus(agentUser
									.getUserid(), super.getOrgi(request),
									UKDataContext.AgentUserStatusEnum.END.toString())));
			
			view.addObject("tags", tagRes.findByOrgiAndTagtype(super.getOrgi(request) , UKDataContext.ModelType.USER.toString())) ;
			view.addObject("tagRelationList", tagRelationRes.findByUserid(agentUser.getUserid())) ;
			view.addObject("quickReplyList", quickReplyRes.findByOrgi(super.getOrgi(request))) ;
		}
		return view ;
	}
	
	@RequestMapping("/agentusers")
	@Menu(type = "apps", subtype = "agent")
	public ModelAndView agentusers(HttpServletRequest request , String userid) {
		ModelAndView view = request(super.createRequestPageTempletResponse("/apps/agent/agentusers")) ;
		User user = super.getUser(request) ;
		view.addObject("agentUserList", agentUserRepository.findByAgentnoAndOrgi(user.getId() , super.getOrgi(request))) ;
		List<AgentUser> agentUserList = agentUserRepository.findByUseridAndOrgi(userid, super.getOrgi(request)) ; 
		view.addObject("curagentuser", agentUserList!=null && agentUserList.size() > 0 ? agentUserList.get(0) : null) ;
		return view ;
	}
	
	private void processRelaData(HttpServletRequest request , AgentService agentService , ModelMap map){
		map.addAttribute("agentServiceList", agentServiceRepository.findByUseridAndOrgiAndStatus(agentService.getUserid() , super.getOrgi(request), UKDataContext.AgentUserStatusEnum.END.toString())) ;
		if(!StringUtils.isBlank(agentService.getAppid())){
			map.addAttribute("snsAccount", snsAccountRes.findBySnsidAndOrgi(agentService.getAppid(), super.getOrgi(request))  ); 
		}
		
		if(agentService!=null && !StringUtils.isBlank(agentService.getContactsid())){
			if(UKDataContext.model.get("contacts")!=null && !StringUtils.isBlank(agentService.getContactsid())){
				DataExchangeInterface dataExchange = (DataExchangeInterface) UKDataContext.getContext().getBean("contacts") ;
				if(dataExchange!=null){
					map.addAttribute("contacts", dataExchange.getDataByIdAndOrgi(agentService.getContactsid(), super.getOrgi(request))) ;
				}
			}
			if(UKDataContext.model.get("workorders")!=null && !StringUtils.isBlank(agentService.getContactsid())){
				DataExchangeInterface dataExchange = (DataExchangeInterface) UKDataContext.getContext().getBean("workorders") ;
				if(dataExchange!=null){
					map.addAttribute("workOrdersList", dataExchange.getListDataByIdAndOrgi(agentService.getContactsid(), super.getUser(request).getId(),  super.getOrgi(request))) ;
				}
				map.addAttribute("contactsid", agentService.getContactsid()) ;
			}
		}
	}
	
	@RequestMapping("/agentuser")
	@Menu(type = "apps", subtype = "agent")
	public ModelAndView agentuser(ModelMap map , HttpServletRequest request , String id) {
		ModelAndView view = request(super.createRequestPageTempletResponse("/apps/agent/mainagentuser")) ;
		AgentUser agentUser = agentUserRepository.findByIdAndOrgi(id, super.getOrgi(request));
		if(agentUser!=null){
			view.addObject("curagentuser", agentUser) ;
			
			AgentUserTask agentUserTask = agentUserTaskRes.findByIdAndOrgi(id, super.getOrgi(request)) ;
			if(agentUserTask!=null){
				agentUserTask.setTokenum(0);
				agentUserTaskRes.save(agentUserTask) ;
			}
			
			if(!StringUtils.isBlank(agentUser.getAgentserviceid())){
				AgentServiceSummary summary = this.serviceSummaryRes.findByAgentserviceidAndOrgi(agentUser.getAgentserviceid(), super.getOrgi(request)) ;
				if(summary!=null){
					view.addObject("summary", summary) ;
				}
			}
			
			view.addObject("agentUserMessageList", this.chatMessageRepository.findByUsessionAndOrgi(agentUser.getUserid() , super.getOrgi(request), new PageRequest(0, 20, Direction.DESC , "createtime")));
			
			if(UKDataContext.ChannelTypeEnum.WEIXIN.toString().equals(agentUser.getChannel())){
				List<WeiXinUser> weiXinUserList = weiXinUserRes.findByOpenidAndOrgi(agentUser.getUserid(), super.getOrgi(request)) ;
				if(weiXinUserList.size() > 0){
					WeiXinUser weiXinUser = weiXinUserList.get(0) ;
					view.addObject("weiXinUser",weiXinUser);
				}
			}else if(UKDataContext.ChannelTypeEnum.WEBIM.toString().equals(agentUser.getChannel())){
				OnlineUser onlineUser = this.onlineUserRes.findByUseridAndOrgi(agentUser.getUserid(), super.getOrgi(request)) ;
				if(onlineUser!=null){
					if(UKDataContext.OnlineUserOperatorStatus.OFFLINE.toString().equals(onlineUser.getStatus())){
						onlineUser.setBetweentime((int) (onlineUser.getUpdatetime().getTime() - onlineUser.getLogintime().getTime()));
					}else{
						onlineUser.setBetweentime((int) (System.currentTimeMillis() - onlineUser.getLogintime().getTime()));
					}
					view.addObject("onlineUser",onlineUser);
				}
			}
			
			if(!StringUtils.isBlank(agentUser.getAgentserviceid())){
				AgentService agentService = this.agentServiceRepository.findOne(agentUser.getAgentserviceid()) ;
				
				if(agentService!=null){
					/**
					 * 获取关联数据
					 */
					processRelaData(request, agentService, map);
				}
			}
	
			view.addObject("serviceCount", Integer
					.valueOf(this.agentServiceRepository
							.countByUseridAndOrgiAndStatus(agentUser
									.getUserid(), super.getOrgi(request),
									UKDataContext.AgentUserStatusEnum.END
											.toString())));
		}
		
		view.addObject("tags", tagRes.findByOrgiAndTagtype(super.getOrgi(request) , UKDataContext.ModelType.USER.toString())) ;
		view.addObject("tagRelationList", tagRelationRes.findByUserid(agentUser.getUserid())) ;
		view.addObject("quickReplyList", quickReplyRes.findByOrgi(super.getOrgi(request))) ;

		return view ;
	}
	
	@RequestMapping("/workorders/list")
	@Menu(type = "apps", subtype = "workorderslist")
	public ModelAndView workorderslist(HttpServletRequest request , String contactsid , ModelMap map) {
		if(UKDataContext.model.get("workorders")!=null && !StringUtils.isBlank(contactsid)){
			DataExchangeInterface dataExchange = (DataExchangeInterface) UKDataContext.getContext().getBean("workorders") ;
			if(dataExchange!=null){
				map.addAttribute("workOrdersList", dataExchange.getListDataByIdAndOrgi(contactsid , super.getUser(request).getId(), super.getOrgi(request))) ;
			}
			map.addAttribute("contactsid", contactsid) ;
		}
		return request(super.createRequestPageTempletResponse("/apps/agent/workorders")) ;
	}
	
	
	@RequestMapping(value="/ready")  
	@Menu(type = "apps", subtype = "agent")
    public ModelAndView ready(HttpServletRequest request){ 
		User user = super.getUser(request) ;
    	AgentStatus agentStatus = agentStatusRepository.findByAgentnoAndOrgi(user.getId() , super.getOrgi(request));
    	if(agentStatus==null){
    		agentStatus = new AgentStatus() ;
	    	agentStatus.setUserid(user.getId());
	    	agentStatus.setUsername(user.getUsername());
	    	agentStatus.setAgentno(user.getId());
	    	agentStatus.setLogindate(new Date());
	    	
	    	if(!StringUtils.isBlank(user.getOrgan())){
	    		Organ organ = organRes.findByIdAndOrgi(user.getOrgan(), super.getOrgi(request)) ;
	    		if(organ!=null && organ.isSkill()){
	    			agentStatus.setSkill(organ.getId());
	    			agentStatus.setSkillname(organ.getName());
	    		}
	    	}
	    	
	    	SessionConfig sessionConfig = ServiceQuene.initSessionConfig(super.getOrgi(request)) ;
	    	
	    	agentStatus.setUsers(agentUserRepository.countByAgentnoAndStatusAndOrgi(user.getId(), UKDataContext.AgentUserStatusEnum.INSERVICE.toString(), super.getOrgi(request)));
	    	
	    	agentStatus.setOrgi(user.getOrgi());
	    	agentStatus.setMaxusers(sessionConfig.getMaxuser());
	    	agentStatusRepository.save(agentStatus) ;
    	}
    	
    	agentStatus.setStatus(UKDataContext.AgentStatusEnum.READY.toString());
    	CacheHelper.getAgentStatusCacheBean().put(agentStatus.getAgentno(), agentStatus, user.getOrgi());
    	
    	ServiceQuene.allotAgent(agentStatus.getAgentno(), user.getOrgi());
    	
    	return request(super.createAppsTempletResponse("/public/success")) ; 
    }
	
	@RequestMapping(value="/notready") 
	@Menu(type = "apps", subtype = "agent")
    public ModelAndView notready(HttpServletRequest request){ 
		User user = super.getUser(request) ;
		AgentStatus agentStatus = agentStatusRepository.findByAgentnoAndOrgi(user.getId() , super.getOrgi(request));
		if(agentStatus!=null){
			agentStatusRepository.delete(agentStatus);
		}
    	CacheHelper.getAgentStatusCacheBean().delete(super.getUser(request).getId(), user.getOrgi());;
    	ServiceQuene.publishMessage(user.getOrgi());
    	
    	return request(super.createAppsTempletResponse("/public/success")) ; 
    }
	
	@RequestMapping(value="/clean") 
	@Menu(type = "apps", subtype = "clean" , access= false)
    public ModelAndView clean(HttpServletRequest request) throws Exception{ 
		List<AgentUser> agentUserList = agentUserRepository.findByAgentnoAndStatusAndOrgi(super.getUser(request).getId(), UKDataContext.AgentUserStatusEnum.END.toString(), super.getOrgi(request));
		List<AgentService> agentServiceList = new ArrayList<AgentService>();
		for(AgentUser agentUser : agentUserList){
			if(agentUser!=null && super.getUser(request).getId().equals(agentUser.getAgentno())){
				ServiceQuene.deleteAgentUser(agentUser, super.getOrgi(request));
				AgentService agentService = agentServiceRepository.findByIdAndOrgi(agentUser.getAgentserviceid(), super.getOrgi(request)) ;
				agentService.setStatus(UKDataContext.AgentUserStatusEnum.END.toString());
				agentServiceList.add(agentService) ;
			}
		}
		agentServiceRepository.save(agentServiceList) ;
		return request(super
				.createRequestPageTempletResponse("redirect:/agent/index.html"));
    }
	
	
	@RequestMapping({ "/end" })
	@Menu(type = "apps", subtype = "agent")
	public ModelAndView end(HttpServletRequest request, @Valid String userid)
			throws Exception {
		User user = super.getUser(request);
		AgentUser agentUser = agentUserRepository.findByIdAndOrgi(userid, super.getOrgi(request));
		if(agentUser!=null && super.getUser(request).getId().equals(agentUser.getAgentno())){
			ServiceQuene.deleteAgentUser(agentUser, user.getOrgi());
			if(!StringUtils.isBlank(agentUser.getAgentserviceid())){
				AgentService agentService = agentServiceRepository.findByIdAndOrgi(agentUser.getAgentserviceid(), super.getOrgi(request)) ;
				agentService.setStatus(UKDataContext.AgentUserStatusEnum.END.toString());
				agentServiceRepository.save(agentService) ;
			}
		}
		return request(super
				.createRequestPageTempletResponse("redirect:/agent/index.html"));
	}
	
	@RequestMapping({ "/readmsg" })
	@Menu(type = "apps", subtype = "agent")
	public ModelAndView readmsg(HttpServletRequest request, @Valid String userid)
			throws Exception {
		AgentUserTask agentUserTask = agentUserTaskRes.findByIdAndOrgi(userid, super.getOrgi(request));
		if(agentUserTask!=null){
			agentUserTask.setTokenum(0);
			agentUserTaskRes.save(agentUserTask);
		}
		return request(super.createRequestPageTempletResponse("/public/success"));
	}
	
	@RequestMapping({ "/blacklist" })
	@Menu(type = "apps", subtype = "blacklist")
	public ModelAndView blacklist(HttpServletRequest request, @Valid String agentuserid , @Valid String agentserviceid ,  @Valid String userid , @Valid BlackEntity blackEntity)
			throws Exception {
		User user = super.getUser(request);
		OnlineUser onlineUser = onlineUserRes.findByUseridAndOrgi(userid, super.getOrgi(request)) ;
		if(onlineUser!=null){
			BlackEntity tempBlackEntiry = blackListRes.findByUseridAndOrgi(onlineUser.getUserid(), super.getOrgi(request)) ;
			if(tempBlackEntiry == null){
				blackEntity.setUserid(userid);
				blackEntity.setCreater(user.getId());
				blackEntity.setOrgi(super.getOrgi(request));
				blackEntity.setAgentid(user.getId());
				blackEntity.setSessionid(onlineUser.getSessionid());
				blackEntity.setAgentserviceid(agentserviceid);
				blackEntity.setChannel(onlineUser.getChannel());
				blackListRes.save(blackEntity) ;
			}
		}
		return end(request , agentuserid);
	}
	
	@RequestMapping("/tagrelation")
	@Menu(type = "apps", subtype = "tagrelation")
    public ModelAndView tagrelation(ModelMap map , HttpServletRequest request , @Valid String userid , @Valid String tagid,@Valid String dataid) {
		TagRelation tagRelation = tagRelationRes.findByUseridAndTagid(userid, tagid) ;
		if(tagRelation==null){
			tagRelation = new TagRelation();
			tagRelation.setUserid(userid);
			tagRelation.setTagid(tagid);
			tagRelation.setDataid(dataid);
			tagRelationRes.save(tagRelation) ;
		}else{
			tagRelationRes.delete(tagRelation);
		}
		return request(super
				.createRequestPageTempletResponse("/public/success"));
    }
	
	@RequestMapping("/image/upload")
    @Menu(type = "im" , subtype = "image" , access = false)
    public ModelAndView upload(ModelMap map,HttpServletRequest request , @RequestParam(value = "imgFile", required = false) MultipartFile imgFile , @Valid String id) throws IOException {
    	ModelAndView view = request(super.createRequestPageTempletResponse("/apps/agent/upload")) ; 
    	UploadStatus upload = null ;
    	String fileName = null ;
    	if(imgFile!=null && imgFile.getOriginalFilename().lastIndexOf(".") > 0){
    		File uploadDir = new File(path , "upload");
    		if(!uploadDir.exists()){
    			uploadDir.mkdirs() ;
    		}
    		fileName = "upload/"+UKTools.md5(imgFile.getBytes())+imgFile.getOriginalFilename().substring(imgFile.getOriginalFilename().lastIndexOf(".")) ;
    		FileCopyUtils.copy(imgFile.getBytes(), new File(path , fileName));
    		
    		String fileURL =  request.getScheme()+"://"+request.getServerName()+"/res/image.html?id="+fileName ;
    		if(request.getServerPort() == 80){
    			fileURL = request.getScheme()+"://"+request.getServerName()+"/res/image.html?id="+fileName;
			}else{
				fileURL = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/res/image.html?id="+fileName;
			}
    		upload = new UploadStatus("0" , fileURL); //图片直接发送给 客户，不用返回
    		OutMessageRouter router = null ; 
    		AgentUser agentUser = agentUserRepository.findByIdAndOrgi(id, super.getOrgi(request)) ;
			
			if(agentUser!=null){
	    		router  = (OutMessageRouter) UKDataContext.getContext().getBean(agentUser.getChannel()) ;
	    		MessageOutContent outMessage = new MessageOutContent() ;
	    		if(router!=null){
	    			outMessage.setMessage(fileURL);
					outMessage.setMessageType(UKDataContext.MediaTypeEnum.IMAGE.toString());
					outMessage.setCalltype(UKDataContext.CallTypeEnum.OUT.toString());
					outMessage.setCreatetime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
					outMessage.setNickName(super.getUser(request).getUsername());
					
	    			router.handler(agentUser.getUserid(), UKDataContext.MessageTypeEnum.MESSAGE.toString(), agentUser.getAppid(), outMessage);
	    		}
	    		//同时发送消息给 坐席
	    		ChatMessage data = new ChatMessage() ;
	    		data.setId(UKTools.getUUID());
	    		data.setContextid(agentUser.getContextid());
	    		
	    		data.setAgentserviceid(agentUser.getAgentserviceid());
	    		
	    		data.setCalltype(UKDataContext.CallTypeEnum.OUT.toString());
	    		if(!StringUtils.isBlank(agentUser.getAgentno())){
	    			data.setTouser(agentUser.getUserid());
	    		}
	    		data.setChannel(agentUser.getChannel());
	    		
	    		data.setUsession(agentUser.getUserid());
	    		data.setAppid(agentUser.getAppid());
	    		data.setUserid(super.getUser(request).getId());
	    		data.setMessage(outMessage.getMessage());
	    		
	    		data.setOrgi(super.getUser(request).getOrgi());
	    		
	    		data.setCreater(super.getUser(request).getId());
	    		data.setUsername(super.getUser(request).getUsername());
	    		
	    		data.setMsgtype(UKDataContext.MediaTypeEnum.IMAGE.toString());
	    		chatMessageRepository.save(data) ;
	    		
	    		NettyClients.getInstance().sendAgentEventMessage(agentUser.getAgentno(), UKDataContext.MessageTypeEnum.MESSAGE.toString(), data);
			}
    		
    	}else{
    		upload = new UploadStatus("请选择图片文件");
    	}
    	map.addAttribute("upload", upload) ;
        return view ; 
    }
	
	
	@RequestMapping(value="/contacts")  
	@Menu(type = "apps", subtype = "contacts")
    public ModelAndView contacts(ModelMap map , HttpServletRequest request , @Valid String contactsid , @Valid String userid , @Valid String agentserviceid, @Valid String agentuserid){ 
		if(!StringUtils.isBlank(userid) && !StringUtils.isBlank(contactsid)){
			OnlineUser onlineUser = this.onlineUserRes.findByUseridAndOrgi(userid, super.getOrgi(request)) ;
			if(onlineUser!=null){
				onlineUser.setContactsid(contactsid);
				this.onlineUserRes.save(onlineUser) ;
			}
			AgentService agentService = this.agentServiceRepository.findOne(agentserviceid) ;
			if(agentService!=null){
				agentService.setContactsid(contactsid);
				this.agentServiceRepository.save(agentService) ;
			}
			DataExchangeInterface dataExchange = (DataExchangeInterface) UKDataContext.getContext().getBean("contacts") ;
			if(dataExchange!=null){
				map.addAttribute("contacts", dataExchange.getDataByIdAndOrgi(contactsid, super.getOrgi(request))) ;
			}
		}
		
    	return request(super.createRequestPageTempletResponse("/apps/agent/contacts")) ; 
    }
	
	@RequestMapping(value="/summary")  
	@Menu(type = "apps", subtype = "summary")
    public ModelAndView summary(ModelMap map , HttpServletRequest request , @Valid String userid , @Valid String agentserviceid, @Valid String agentuserid){ 
		if(!StringUtils.isBlank(userid) && !StringUtils.isBlank(agentuserid)){
			AgentUser agentUser = this.agentUserRepository.findByIdAndOrgi(agentuserid, super.getOrgi(request)) ;
			if(agentUser!=null && !StringUtils.isBlank(agentUser.getAgentserviceid())){
				AgentServiceSummary summary = this.serviceSummaryRes.findByAgentserviceidAndOrgi(agentUser.getAgentserviceid(), super.getOrgi(request)) ;
				if(summary!=null){
					map.addAttribute("summary", summary) ;
				}
			}
			map.addAttribute("tags", tagRes.findByOrgiAndTagtype(super.getOrgi(request) , UKDataContext.ModelType.SUMMARY.toString())) ;
			map.addAttribute("userid", userid) ;
			map.addAttribute("agentserviceid", agentserviceid) ;
			map.addAttribute("agentuserid", agentuserid) ;
			
		}
		
    	return request(super.createRequestPageTempletResponse("/apps/agent/summary")) ; 
    }
	
	@RequestMapping(value="/summary/save")  
	@Menu(type = "apps", subtype = "summarysave")
    public ModelAndView summarysave(ModelMap map , HttpServletRequest request , @Valid AgentServiceSummary summary , @Valid String contactsid , @Valid String userid , @Valid String agentserviceid, @Valid String agentuserid){ 
		if(!StringUtils.isBlank(userid) && !StringUtils.isBlank(agentuserid)){
			summary.setOrgi(super.getOrgi(request));
			summary.setCreater(super.getUser(request).getId());
			summary.setCreatetime(new Date());
			serviceSummaryRes.save(summary) ;
		}
		
    	return request(super.createRequestPageTempletResponse("redirect:/agent/agentuser.html?id="+agentuserid)) ; 
    }
	
	@RequestMapping(value="/transfer")  
	@Menu(type = "apps", subtype = "transfer")
    public ModelAndView transfer(ModelMap map , HttpServletRequest request , @Valid String userid , @Valid String agentserviceid, @Valid String agentuserid){ 
		if(!StringUtils.isBlank(userid) && !StringUtils.isBlank(agentuserid)){
			map.addAttribute("organList", organRes.findByOrgi(super.getOrgi(request))) ;
			
			List<String> usersids = new ArrayList<String>();
			
			Collection<?> users =  CacheHelper.getAgentStatusCacheBean().getAllCacheObject(super.getOrgi(request)) ;
			Iterator<?> iterator = users.iterator() ;
			while(iterator.hasNext()){
				String agentno = (String) iterator.next() ;
				if(agentno!=null && !agentno.equals(super.getUser(request).getId())){
					usersids.add(agentno) ;
				}
			}
			List<User> userList = userRes.findAll(usersids) ;
			for(User user : userList){
				user.setAgentStatus((AgentStatus) CacheHelper.getAgentStatusCacheBean().getCacheObject(user.getId(), super.getOrgi(request)));
			}
			map.addAttribute("userList", userList) ;
			map.addAttribute("userid", userid) ;
			map.addAttribute("agentserviceid", agentserviceid) ;
			map.addAttribute("agentuserid", agentuserid) ;
			
		}
		
    	return request(super.createRequestPageTempletResponse("/apps/agent/transfer")) ; 
    }
	
	@RequestMapping(value="/transfer/save")  
	@Menu(type = "apps", subtype = "transfersave")
    public ModelAndView transfersave(ModelMap map , HttpServletRequest request , @Valid String userid , @Valid String agentserviceid, @Valid String agentuserid, @Valid String agentno){ 
		if(!StringUtils.isBlank(userid) && !StringUtils.isBlank(agentuserid) && !StringUtils.isBlank(agentno)){
			AgentUser agentUser = (AgentUser) CacheHelper.getAgentUserCacheBean().getCacheObject(userid, super.getOrgi(request)) ;
			if(agentUser != null){
				agentUser.setAgentno(agentno);
				CacheHelper.getAgentUserCacheBean().put(userid , agentUser , super.getOrgi(request)) ;
				agentUserRepository.save(agentUser) ;
				if(UKDataContext.AgentUserStatusEnum.INSERVICE.toString().equals(agentUser.getStatus())){		//转接 ， 发送消息给 目标坐席
					AgentStatus agentStatus = (AgentStatus) CacheHelper.getAgentStatusCacheBean().getCacheObject(super.getUser(request).getId(), super.getOrgi(request)) ;
					
					if(agentStatus!=null){
						ServiceQuene.updateAgentStatus(agentStatus, agentUser, super.getOrgi(request), false);
					}
					
					AgentStatus transAgentStatus = (AgentStatus) CacheHelper.getAgentStatusCacheBean().getCacheObject(agentno, super.getOrgi(request)) ;
					if(transAgentStatus!=null){
						ServiceQuene.updateAgentStatus(transAgentStatus, agentUser, super.getOrgi(request), true);
					}
					NettyClients.getInstance().sendAgentEventMessage(agentno, UKDataContext.MessageTypeEnum.NEW.toString(), agentUser);
				}
			}else{
				agentUser = agentUserRepository.findByIdAndOrgi(agentuserid, super.getOrgi(request));
				if(agentUser!=null){
					agentUser.setAgentno(agentno);	
					agentUserRepository.save(agentUser) ;
				}
			}
			
			AgentService agentService = this.agentServiceRepository.findByIdAndOrgi(agentserviceid, super.getOrgi(request)) ;
			if(agentService!=null){
				agentService.setAgentno(agentno);
				agentServiceRepository.save(agentService) ;
			}
		}
		
    	return request(super.createRequestPageTempletResponse("redirect:/agent/index.html")) ; 
    }
}