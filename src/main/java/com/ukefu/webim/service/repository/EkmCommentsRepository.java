package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.EkmComments;
import com.ukefu.webim.web.model.EkmExperts;

public abstract interface EkmCommentsRepository  extends JpaRepository<EkmComments, String>
{
	
	public abstract List<EkmExperts> findByKnowledgeidAndDatastatusAndOrgi(String knowledgeid ,boolean datastatus, String orgi );
	
	public abstract EkmComments findByIdAndOrgi(String id , String orgi );
	
}

