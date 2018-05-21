package com.ukefu.webim.service.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.ukefu.webim.web.model.StatusEvent;

public interface StatusEventRepository extends JpaRepository<StatusEvent, String> {

	public StatusEvent findById(String id);
	
	public StatusEvent findByIdOrBridgeid(String id,String bridgeid);
	
	public Page<StatusEvent> findByAni(String ani , Pageable page) ;
	
	public Page<StatusEvent> findByOrgi(String orgi , Pageable page) ;
	
	public Page<StatusEvent> findByServicestatusAndOrgi(String servicestatus ,String orgi , Pageable page) ;
	
	public Page<StatusEvent> findByMisscallAndOrgi(boolean misscall ,String orgi , Pageable page) ;
	
	public Page<StatusEvent> findByRecordAndOrgi(boolean record ,String orgi , Pageable page) ;
	
	public Page<StatusEvent> findByCalledAndOrgi(String voicemail ,String orgi , Pageable page) ;
	
	public Page<StatusEvent> findAll(Specification<StatusEvent> spec, Pageable pageable);  //分页按条件查询 

	public int countByAgent(String agent) ;
	
	public int countByAniOrCalled(String ani,String called);
	
	public int countByAni(String ani);
	
	public int countByCalled(String called);
	
	
	
	@Query("select HOUR(starttime) as Hour ,count(*) as count  from StatusEvent where orgi = ?1 and DATE_FORMAT(starttime,'%Y-%m-%d') = ?2 group by HOUR(starttime) order by HOUR(starttime)")
	List<Object> findByOrgiAndStarttime(String orgi , String start);
}
