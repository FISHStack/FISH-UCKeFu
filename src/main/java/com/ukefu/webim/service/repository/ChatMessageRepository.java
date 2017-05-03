package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.util.server.message.ChatMessage;

public abstract interface ChatMessageRepository
  extends JpaRepository<ChatMessage, String>
{
  public abstract List<ChatMessage> findBySessionAndOrgi(String session , String orgi);
  
  public abstract Page<ChatMessage> findBySessionAndOrgi(String session, String orgi , Pageable page );
  
  public abstract List<ChatMessage> findByContextidAndOrgi(String contextid , String orgi);
  
  public abstract Page<ChatMessage> findByContextidAndOrgi(String contextid , String orgi, Pageable page );
  
  public abstract Page<ChatMessage> findByAgentserviceidAndOrgi(String agentserviceid, String orgi , Pageable page );
  
  public abstract Page<ChatMessage> findByContextidAndUseridAndOrgi(String contextid ,String userid , String orgi, Pageable page);
}
