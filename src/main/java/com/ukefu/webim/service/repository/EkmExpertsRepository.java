package com.ukefu.webim.service.repository;

import java.util.List;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.EkmExperts;

public abstract interface EkmExpertsRepository  extends JpaRepository<EkmExperts, String>
{
	
	public abstract EkmExperts findByUseridAndOrgi(String userid , String orgi );
	
	public abstract EkmExperts findByRoleidAndOrgi(String userid , String orgi );
	
	public abstract EkmExperts findByIdAndOrgi(String id , String orgi);
	
	public abstract Page<EkmExperts> findByBustypeAndOrgi(String bustype ,String orgi ,Pageable paramPageable);
	
	public abstract List<EkmExperts> findByOrgi(String orgi);
	
}

