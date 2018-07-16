package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.JobDetail;
import com.ukefu.webim.web.model.QueSurveyAnswer;
import com.ukefu.webim.web.model.QueSurveyQuestion;

public abstract interface QueSurveyAnswerRepository extends JpaRepository<QueSurveyAnswer, String>{

  public abstract Page<QueSurveyAnswer> findByOrgi(String orgi ,Pageable paramPageable);

  public abstract List<QueSurveyAnswer> findByOrgi(String orgi);
  
  public abstract List<QueSurveyAnswer> findByOrgiAndId(String orgi, String id);
  
  public abstract QueSurveyAnswer findById(String id);
  
  public abstract Page<QueSurveyAnswer> findByOrgiAndProcessid(String orgi ,String processid,Pageable paramPageable);
  
  public abstract Page<QueSurveyAnswer> findByOrgiAndQuestionid(String orgi, String questionid,Pageable paramPageable);
  
  public abstract Page<QueSurveyAnswer> findAll(Specification<QueSurveyAnswer> spec, Pageable page) ;
}
