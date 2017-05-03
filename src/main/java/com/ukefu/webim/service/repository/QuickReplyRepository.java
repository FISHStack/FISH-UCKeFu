package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.QuickReply;

public abstract interface QuickReplyRepository  extends JpaRepository<QuickReply, String>
{
	public abstract QuickReply findByOrgiAndCreater(String orgi , String creater);
	
	public abstract List<QuickReply> findByOrgi(String orgi);
}

