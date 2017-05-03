package com.ukefu.webim.service.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.BlackEntity;

public abstract interface BlackListRepository  extends JpaRepository<BlackEntity, String>{
	
	public abstract BlackEntity findByIdAndOrgi(String id ,String orgi);
	
	public abstract BlackEntity findByUseridAndOrgi(String userid , String orgi);
	
	public abstract Page<BlackEntity> findByOrgi(String orgi , Pageable page);
}

