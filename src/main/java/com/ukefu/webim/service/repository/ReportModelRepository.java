package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.ReportModel;

public interface ReportModelRepository extends JpaRepository<ReportModel, String> {
	public ReportModel findByIdAndOrgi(String id , String orgi);
	
	public List<ReportModel> findByOrgiAndReportid(String orgi , String reportid) ;

	public List<ReportModel> findByParentidAndOrgi(String parentid, String orgi);
	
}
