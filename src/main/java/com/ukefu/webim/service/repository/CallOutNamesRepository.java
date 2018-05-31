package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.CallOutNames;
import com.ukefu.webim.web.model.CallOutTask;

public abstract interface CallOutNamesRepository extends JpaRepository<CallOutNames, String> {
	
	public abstract CallOutNames findByIdAndOrgi(String id, String orgi);
	
	public abstract List<CallOutNames> findByNameAndOrgi(String name, String orgi);

	public abstract Page<CallOutNames> findByActidAndOrgi(String actid , String orgi , Pageable page) ;
	
	public abstract List<CallOutNames> findByActidAndOrgi(String actid , String orgi) ;
	
	public abstract Page<CallOutNames> findAll(Specification<CallOutTask> spec, Pageable pageable);  
}
