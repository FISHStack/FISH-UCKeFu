package com.ukefu.webim.util;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.ExtentionRepository;
import com.ukefu.webim.service.repository.SipTrunkRepository;
import com.ukefu.webim.web.model.Extention;
import com.ukefu.webim.web.model.SipTrunk;

public class CallCenterUtils {
	/**
	 * 
	 * @param user
	 * @param orgi
	 * @param id
	 * @param service
	 * @return
	 * @throws Exception
	 */
	public static SipTrunk siptrunk(String extno , SipTrunkRepository sipTrunkRes, ExtentionRepository extRes){
		SipTrunk sipTrunk = null;
		List<Extention> extList = extRes.findByExtention(extno) ;
		if(extList.size() > 0){
			Extention ext = extList.get(0) ;
			if(!StringUtils.isBlank(ext.getSiptrunk())) {
				sipTrunk = (SipTrunk) CacheHelper.getSystemCacheBean().getCacheObject(ext.getSiptrunk(), ext.getOrgi()) ;
				if(sipTrunk == null) {
					sipTrunk = sipTrunkRes.findByIdAndOrgi(ext.getSiptrunk(), ext.getOrgi()) ;
					if(sipTrunk!=null) {
						CacheHelper.getSystemCacheBean().put(sipTrunk.getId() ,sipTrunk , ext.getOrgi()) ;
					}
				}
			}
		}
		return sipTrunk;
	}
}
