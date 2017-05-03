package com.ukefu.webim.service.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.WeiXinUser;

public abstract interface WeiXinUserRepository extends JpaRepository<WeiXinUser, String>{
	
	public abstract WeiXinUser findByIdAndOrgi(String id, String orgi);

	public abstract WeiXinUser findByOpenidAndOrgi(String openid, String orgi);
	
	public abstract long countBySnsidAndOrgi(String snsid, String orgi);
	
	public abstract Page<WeiXinUser> findBySnsidAndOrgi(String snsid , String orgi, Pageable page);
}
