package com.ukefu.webim.service.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.ukefu.webim.web.model.OnlineUser;

public abstract interface OnlineUserRepository extends JpaRepository<OnlineUser, String> {
	public abstract OnlineUser findBySessionidAndOrgi(String paramString, String orgi);
	
	public abstract List<OnlineUser> findByUseridAndOrgi(String userid, String orgi);
	
	public abstract int countByUseridAndOrgi(String userid, String orgi);
	
	public abstract Page<OnlineUser> findByUseridAndOrgi(String userid, String orgi , Pageable page);
	
	public abstract OnlineUser findByOrgiAndSessionid(String orgi , String sessionid);
	
	public abstract Page<OnlineUser> findByOrgiAndStatusAndCreatetimeLessThan(String orgi , String status , Date createtime , Pageable paramPageable);

	public abstract Page<OnlineUser> findByStatusAndCreatetimeLessThan(String status , Date createtime , Pageable paramPageable);
	
	public abstract Page<OnlineUser> findByOrgiAndStatus(String paramString1,String paramString2, Pageable paramPageable);
	
	@Query("select invitestatus , count(id) as users from OnlineUser where orgi = ?1 and status = ?2 group by invitestatus")
	List<Object> findByOrgiAndStatus(String orgi ,String status);
	
	@Query("select result , count(id) as records from InviteRecord where orgi = ?1 and agentno = ?2 and createtime > ?3 and createtime < ?4 group by result")
	List<Object> findByOrgiAndAgentnoAndCreatetimeRange(String orgi ,String agentno , Date start , Date end);
	
	@Query("select result , count(id) as records from InviteRecord where orgi = ?1 and agentno = ?2 group by result")
	List<Object> findByOrgiAndUserid(String orgi ,String userid);

	@Query("select count(id) from AgentService where orgi = ?1 and status = ?2 and agentno = ?3 and createtime > ?4 and createtime < ?5")
	Long countByAgentForAgentUser(String orgi ,String status,String agentno , Date start , Date end);
	
	@Query("select count(id) from AgentService where orgi = ?1 and status = ?2 and agentno = ?3 and createtime > ?4 and createtime < ?5")
	Long countByAgentForAgentService(String orgi ,String status,String agentno , Date start , Date end);
	
	@Query("select avg(sessiontimes) from AgentService where orgi = ?1 and status = ?2 and agentno = ?3 and createtime > ?4 and createtime < ?5")
	Long countByAgentForAvagTime(String orgi ,String status,String agentno , Date start , Date end);
	
	
	@Query("select avg(sessiontimes) from AgentService where orgi = ?1 and status = ?2 and userid = ?3")
	Long countByUserForAvagTime(String orgi ,String status,String userid);
	
	@Query("select createdate as dt, count(distinct ip) as ips ,  count(id) as records from UserHistory where orgi = ?1 and model = ?2 and createtime > ?3 and createtime < ?4 group by createdate order by dt asc")
	List<Object> findByOrgiAndCreatetimeRange(String orgi , String model ,Date start , Date end);
	
	@Query("select createdate as dt, count(id) as users from AgentService where orgi = ?1 and createtime > ?2 and createtime < ?3 group by createdate order by dt asc")
	List<Object> findByOrgiAndCreatetimeRangeForAgent(String orgi , Date start , Date end);
	
	@Query("select osname, count(id) as users from AgentService where orgi = ?1 and createtime > ?2 and createtime < ?3 and channel = ?4 group by osname")
	List<Object> findByOrgiAndCreatetimeRangeForClient(String orgi , Date start , Date end , String channel);
	
	@Query("select browser, count(id) as users from AgentService where orgi = ?1 and createtime > ?2 and createtime < ?3 and channel = ?4 group by browser")
	List<Object> findByOrgiAndCreatetimeRangeForBrowser(String orgi , Date start , Date end , String channel);
	
	@Query("select agentno, count(id) as users from AgentService where orgi = ?1 and userid = ?2 group by agentno")
	List<Object> findByOrgiForDistinctAgent(String orgi , String userid);
	
	@Query("select count(id) from AgentService where orgi = ?1 and appid = ?2 and createtime > ?3 and createtime < ?4")
	Long countByOrgiAndAppidForCount(String orgi ,String appid ,Date start,Date end);
	
	@Query("select count(id) from StatusEvent where discaller = ?1 and misscall = false")
	Long countByCallerFromCallCenter(String caller);
	
	@Query("select count(id) from StatusEvent where discalled = ?1 and misscall = false")
	Long countByCalledFromCallCenter(String called);
	
	@Query("select count(id) from StatusEvent where (discaller = ?1 or discalled = ?1) and misscall = false")
	Long countByAniFromCallCenter(String ani);
	
	
	@Query("select avg(ringduration) from StatusEvent where ani = ?1")
	Long avgByRingDurationFromCallCenter(String ani);
	
	@Query("select avg(duration) from StatusEvent where ani = ?1")
	Long avgByDurationFromCallCenter(String ani);
	
	@Query("select hourstr as dt, count(id) as calls from StatusEvent where orgi = ?1 and datestr = ?2 group by hourstr order by dt asc")
	List<Object> findByOrgiAndDatestrRangeForAgent(String orgi , String start );
	
	@Query("select code as dt, count(id) as co from CallMonitor where orgi = ?1 group by code")
	List<Object> findByOrgiAndStatusRangeForAgent(String orgi);
	
	@Query("select s from StatusEvent s  where startrecord<= ?1 AND ORGI = ?2 AND (discalled = ?3 OR discaller= ?4 )")
	List<Object> findByOrgiAndStartrecord(Date startrecord, String orgi, String discalled, String discaller);
	
	@Query("delete from CallOutNames where actid<= ?2 AND ORGI = ?1")
	void deleteByOrgiAndActid(String orgi, String actid);
}
