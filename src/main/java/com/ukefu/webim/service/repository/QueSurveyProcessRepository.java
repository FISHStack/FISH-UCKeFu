package com.ukefu.webim.service.repository;

import java.util.List;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.QueSurveyProcess;

public abstract interface QueSurveyProcessRepository extends JpaRepository<QueSurveyProcess, String>{

  public abstract Page<QueSurveyProcess> findByOrgi(String orgi ,Pageable paramPageable);

  public abstract List<QueSurveyProcess> findByOrgi(String orgi);
  
  public abstract List<QueSurveyProcess> findByOrgiAndId(String orgi, String id);
  
  public abstract QueSurveyProcess findById(String id);
  
}
