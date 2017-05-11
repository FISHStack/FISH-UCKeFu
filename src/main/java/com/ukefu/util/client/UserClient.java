package com.ukefu.util.client;

import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.TimeUnit;

import com.google.common.collect.MapMaker;

public class UserClient {
	
	private static ConcurrentMap<String, Object> userClientMap = new MapMaker().concurrencyLevel(32).softKeys().weakValues().expiration(5, TimeUnit.MINUTES).makeMap() ;
	
	public static  ConcurrentMap<String, Object> getUserClientMap(){
		return userClientMap ;
	}
}
