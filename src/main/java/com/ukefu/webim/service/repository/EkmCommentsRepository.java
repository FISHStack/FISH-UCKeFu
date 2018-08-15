package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.EkmComments;

public abstract interface EkmCommentsRepository  extends JpaRepository<EkmComments, String>
{
	
	public abstract List<EkmComments> findByKnowledgeidAndDatastatusAndOrgi(String knowledgeid ,boolean datastatus, String orgi );
	
	public abstract Page<EkmComments> findByDatastatusAndKnowledgeidAndOrgi(boolean datastatus,String knowledgeid , String orgi ,Pageable pageable);
	
	public abstract EkmComments findByIdAndOrgi(String id , String orgi );
	
	public abstract Page<EkmComments> findByOrgi(String orgi ,Pageable pageable);
	
	//我收到的评论
	public abstract Page<EkmComments> findByDatastatusAndKnowledgeowerAndOrgi(boolean datastatus,String knowledgeower , String orgi ,Pageable pageable);
	
	//获取-我发出的评论
	public abstract Page<EkmComments> findByDatastatusAndCreaterAndOrgi(boolean datastatus,String creater , String orgi ,Pageable pageable);
	
	public abstract List<EkmComments> findByCreaterAndDatastatusAndAndOrgi(String creater ,boolean datastatus, String orgi );
}

