package com.ukefu.webim.service.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.AgentServiceSummary;

public interface ServiceSummaryRepository extends JpaRepository<AgentServiceSummary, String>{
	
	public abstract AgentServiceSummary findByAgentserviceidAndOrgi(String agentserviceid , String orgi);
}
