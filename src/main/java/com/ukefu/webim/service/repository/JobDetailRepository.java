package com.ukefu.webim.service.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.JobDetail;
import com.ukefu.webim.web.model.User;

public abstract interface JobDetailRepository extends JpaRepository<JobDetail, String> {
	
	public abstract JobDetail findByIdAndOrgi(String id, String orgi);

	public abstract Page<JobDetail> findByTasktypeAndOrgi(String tasktype , String orgi , Pageable page) ;
	
	public abstract Page<JobDetail> findByTaskstatus(String taskstatus , Pageable page) ;
	
	public abstract List<JobDetail> findByTasktypeAndOrgi(String tasktype , String orgi) ;
	
	public abstract Page<JobDetail> findByPlantaskAndTaskstatusAndNextfiretimeLessThan(boolean plantask ,String taskstatus,Date time , Pageable page) ;
	
	public abstract Page<JobDetail> findAll(Specification<JobDetail> spec, Pageable page) ;
}
