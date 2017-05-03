package com.ukefu.webim.service.repository;

import com.ukefu.webim.web.model.SNSAccount;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public abstract interface SNSAccountRepository
  extends JpaRepository<SNSAccount, String>
{
  public abstract SNSAccount findByIdAndOrgi(String paramString, String orgi);
  
  public abstract SNSAccount findBySnsidAndOrgi(String snsid, String orgi);
  
  public abstract int countByAppkeyAndOrgi(String appkey, String orgi);
  
  public abstract List<SNSAccount> findBySnstype(String paramString);
}
