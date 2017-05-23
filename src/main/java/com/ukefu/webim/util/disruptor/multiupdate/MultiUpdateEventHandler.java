package com.ukefu.webim.util.disruptor.multiupdate;

import com.lmax.disruptor.EventHandler;
import com.ukefu.core.UKDataContext;
import com.ukefu.util.event.MultiUpdateEvent;
import com.ukefu.util.event.UserDataEvent;

@SuppressWarnings("rawtypes")
public class MultiUpdateEventHandler implements EventHandler<UserDataEvent>{

	@SuppressWarnings("unchecked")
	@Override
	public void onEvent(UserDataEvent event, long arg1, boolean arg2)
			throws Exception {
		if(event.getEvent()!=null){
			MultiUpdateEvent multiEventEvent = (MultiUpdateEvent)event.getEvent() ;
			if(UKDataContext.MultiUpdateType.SAVE.toString().equals(multiEventEvent.getEventype())){
				multiEventEvent.getCrudRes().delete(multiEventEvent.getData()) ;
				multiEventEvent.getCrudRes().save(multiEventEvent.getData()) ;
			}else if(UKDataContext.MultiUpdateType.DELETE.toString().equals(multiEventEvent.getEventype())){
				multiEventEvent.getCrudRes().delete(multiEventEvent.getData()) ;
			}
		}
	}

}
