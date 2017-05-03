package com.ukefu.webim.util;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.UKTools;
import com.ukefu.util.client.NettyClients;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.AgentUserTaskRepository;
import com.ukefu.webim.service.repository.ChatMessageRepository;
import com.ukefu.webim.util.server.message.ChatMessage;
import com.ukefu.webim.web.model.AgentUser;
import com.ukefu.webim.web.model.AgentUserTask;
import com.ukefu.webim.web.model.MessageOutContent;

public class MessageUtils {
	/**
	 * 
	 * @param image
	 * @param userid
	 */
	public static void uploadImage(String image , String userid){
		createMessage(image, UKDataContext.MediaTypeEnum.IMAGE.toString(), userid);
	}
	public static void createMessage(String message , String msgtype , String userid){
		AgentUser agentUser = (AgentUser) CacheHelper.getAgentUserCacheBean().getCacheObject(userid, UKDataContext.SYSTEM_ORGI);
		ChatMessage data = new ChatMessage() ;
		data.setUserid(agentUser.getUserid());
		data.setUsername(agentUser.getUsername());
		data.setTouser(agentUser.getAgentno());
		data.setAppid(agentUser.getAppid());
		data.setOrgi(agentUser.getOrgi());
		data.setMessage(message);
		data.setType(UKDataContext.MessageTypeEnum.MESSAGE.toString());
		createMessage(data, msgtype, userid);
	}
	
	public static void createMessage(ChatMessage data , String msgtype , String userid){
		AgentUser agentUser = (AgentUser) CacheHelper.getAgentUserCacheBean().getCacheObject(userid, UKDataContext.SYSTEM_ORGI);
    	MessageOutContent outMessage = new MessageOutContent() ;
    	outMessage.setMessage(data.getMessage());
    	outMessage.setMessageType(msgtype);
    	outMessage.setCalltype(UKDataContext.CallTypeEnum.IN.toString());
    	outMessage.setAgentUser(agentUser);
    	outMessage.setSnsAccount(null);
    	
    	MessageOutContent statusMessage = null ;
    	if(agentUser==null){
    		statusMessage = new MessageOutContent() ;
    		statusMessage.setMessage(data.getMessage());
    		statusMessage.setMessageType(UKDataContext.MessageTypeEnum.STATUS.toString());
    		statusMessage.setCalltype(UKDataContext.CallTypeEnum.OUT.toString());
    		statusMessage.setMessage("当前坐席全忙，请稍候");
    	}else{
    		data.setUserid(agentUser.getUserid());
    		data.setUsername(agentUser.getUsername());
    		data.setId(UKTools.getUUID());
    		data.setTouser(agentUser.getAgentno());
    		
    		data.setAgentuser(agentUser.getId());
    		
    		data.setAgentserviceid(agentUser.getAgentserviceid());
    		
    		data.setAppid(agentUser.getAppid());
    		data.setOrgi(agentUser.getOrgi());
    		
    		data.setMsgtype(msgtype);
    		
    		
    		data.setUsername(agentUser.getUsername());
    		data.setSession(agentUser.getUserid());				//agentUser作为 session id
    		data.setContextid(agentUser.getContextid());
    		data.setCalltype(UKDataContext.CallTypeEnum.IN.toString());
    		if(!StringUtils.isBlank(agentUser.getAgentno())){
    			data.setTouser(agentUser.getAgentno());
    		}
    		data.setChannel(agentUser.getChannel());
    		
    		outMessage.setContextid(agentUser.getContextid());
    		outMessage.setFromUser(data.getUserid());
    		outMessage.setToUser(data.getTouser());
    		outMessage.setChannelMessage(data);
    		outMessage.setNickName(agentUser.getUsername());
    		outMessage.setCreatetime(data.getCreatetime());
    		
    		
    		/**
    		 * 保存消息
    		 */
    		if(UKDataContext.MessageTypeEnum.MESSAGE.toString().equals(data.getType())){
    			UKDataContext.getContext().getBean(ChatMessageRepository.class).save(data) ;
    		}
    		if(data.getType()!=null && data.getType().equals(UKDataContext.MessageTypeEnum.MESSAGE.toString())){
	    		AgentUserTaskRepository agentUserTaskRes = UKDataContext.getContext().getBean(AgentUserTaskRepository.class) ;
	    		AgentUserTask agentUserTask = agentUserTaskRes.getOne(agentUser.getId()) ;
	    		agentUserTask.setLastmessage(new Date());
	    		agentUserTask.setWarnings("0");
	    		agentUserTask.setWarningtime(null);
	    		agentUserTask.setLastmsg(data.getMessage().length() > 100 ? data.getMessage().substring(0 , 100) : data.getMessage());
	    		agentUserTask.setTokenum(agentUserTask.getTokenum()+1);
	    		data.setTokenum(agentUserTask.getTokenum());
	    		agentUserTaskRes.save(agentUserTask) ;
    		}
    	}
    	if(!StringUtils.isBlank(data.getUserid()) && UKDataContext.MessageTypeEnum.MESSAGE.toString().equals(data.getType())){
    		NettyClients.getInstance().sendIMEventMessage(data.getUserid(), UKDataContext.MessageTypeEnum.MESSAGE.toString(), outMessage);
    		if(statusMessage!=null){
    			NettyClients.getInstance().sendIMEventMessage(data.getUserid(), UKDataContext.MessageTypeEnum.STATUS.toString(), statusMessage);
    		}
    	}
    	if(agentUser!=null && !StringUtils.isBlank(agentUser.getAgentno())){
    		//将消息发送给 坐席
    		NettyClients.getInstance().sendAgentEventMessage(agentUser.getAgentno(), UKDataContext.MessageTypeEnum.MESSAGE.toString(), data);
    	}
	}
	
}
