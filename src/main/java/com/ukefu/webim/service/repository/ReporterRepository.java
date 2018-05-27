package com.ukefu.webim.service.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.Reporter;

public interface ReporterRepository extends  JpaRepository<Reporter, String> {
	
	public Page<Reporter> findByDataidAndOrgi(String dataid , String orgi , Pageable pageable) ;
}
