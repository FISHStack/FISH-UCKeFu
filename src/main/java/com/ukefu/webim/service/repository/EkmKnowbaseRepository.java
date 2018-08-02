package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.EkmKnowbase;

public abstract interface EkmKnowbaseRepository  extends JpaRepository<EkmKnowbase, String>
{
	
	public abstract EkmKnowbase findByNameAndOrgi(String name , String orgi );
	
	public abstract EkmKnowbase findByIdAndOrgi(String id , String orgi);
	
	public abstract Page<EkmKnowbase> findAll(Specification<EkmKnowbase> spec, Pageable page) ;
	
	//public abstract Page<EkmExperts> findByOrgiAndBustypeOr(String orgi ,String bustype,String bus ,Pageable paramPageable);
	
	public abstract List<EkmKnowbase> findByOrgi(String orgi);
	
}

