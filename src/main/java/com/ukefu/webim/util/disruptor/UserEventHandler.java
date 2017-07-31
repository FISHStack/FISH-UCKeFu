package com.ukefu.webim.util.disruptor;

import com.lmax.disruptor.EventHandler;
import com.ukefu.core.UKDataContext;
import com.ukefu.util.event.UserDataEvent;
import com.ukefu.webim.service.repository.OnlineUserRepository;
import com.ukefu.webim.service.repository.UserEventRepository;
import com.ukefu.webim.web.model.OnlineUser;
import com.ukefu.webim.web.model.UserHistory;

public class UserEventHandler implements EventHandler<UserDataEvent>{

	@Override
	public void onEvent(UserDataEvent arg0, long arg1, boolean arg2)
			throws Exception {
		if(arg0.getEvent() instanceof UserHistory){
			UserEventRepository userEventRes = UKDataContext.getContext().getBean(UserEventRepository.class) ;
			userEventRes.save((UserHistory)arg0.getEvent()) ;
		}else if(arg0.getEvent() instanceof OnlineUser){
			OnlineUserRepository onlineUserRes = UKDataContext.getContext().getBean(OnlineUserRepository.class) ;
			onlineUserRes.save((OnlineUser)arg0.getEvent()) ;
		}
	}

}
