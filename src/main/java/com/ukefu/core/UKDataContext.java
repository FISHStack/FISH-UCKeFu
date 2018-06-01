package com.ukefu.core;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

import org.apache.commons.beanutils.ConvertUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;

import com.ukefu.util.DateConverter;
import com.ukefu.webim.service.resource.ActivityResource;
import com.ukefu.webim.web.model.Log;

public class UKDataContext {

	public static final String USER_SESSION_NAME = "user";
	public static final String GUEST_USER = "guest";
	public static final String IM_USER_SESSION_NAME = "im_user";
	public static final String UKEFU_SYSTEM_DIC = "com.dic.system.template";
	public static final String UKEFU_SYSTEM_AUTH_DIC = "com.dic.auth.resource";
	public static final String UKEFU_SYSTEM_AREA_DIC ="com.dic.address.area" ;
	public static final String UKEFU_SYSTEM_ADPOS_DIC = "com.dic.adv.type" ;
	public static final String UKEFU_SYSTEM_COMMENT_DIC = "com.dic.webim.comment" ;
	public static final String UKEFU_SYSTEM_COMMENT_ITEM_DIC = "com.dic.webim.comment.item" ;
	
	public static final String UKEFU_SYSTEM_DIS_AGENT = "owneruser" ;
	public static final String UKEFU_SYSTEM_DIS_ORGAN = "ownerdept" ;
	public static final String UKEFU_SYSTEM_DIS_TIME = "distime" ;
	
	public static final String UKEFU_SYSTEM_COOKIES_FLAG = "uk_flagid" ;
	public static final String UKEFU_SYSTEM_NO_AI_CONFIG = "NOTEXIST" ;
	
	public static final String SYSTEM_INDEX = "uckefu" ;
	
	
	public static final String UKEFU_SYSTEM_CALLCENTER = "callcenter";
	public static final String UKEFU_SYSTEM_WORKORDEREMAIL = "workordermail";
	public static final String UKEFU_SYSTEM_SMSEMAIL = "callcenter";
	
	public static final String UKEFU_SYSTEM_INFOACQ = "infoacq";		//数据采集模式
	public static final String GUEST_USER_ID_CODE = "R3GUESTUSEKEY" ;
	public static final String WORKORDERS_CLOSED_STATUS = "uckefu_workorders_closed" ;
	public static final String SERVICE_QUENE_NULL_STR = "service_quene_null" ;
	public static final String DEFAULT_TYPE = "default"	;		//默认分类代码
	public static final String START = "start";					//流程默认的开始节点
	public static final String CACHE_SKILL = "cache_skill_";					//技能组的缓存
	public static final String CACHE_AGENT = "cache_agent_";					//坐席列表的缓存
	
	public static final String CUBE_TITLE_MEASURE = "指标" ;
	
	public static final String UKEFU_SYSTEM_AREA = "uckefu_system_area";
	
	public static final String UKEFU_SYSTEM_ADV = "uckefu_system_adv";		//系统广告位
	
	public static final int MAX_IMAGE_WIDTH = 460 ;		
	
	private static boolean imServerRunning = false ;			//IM服务状态
	
	public static final int AGENT_STATUS_MAX_USER = 10 ; 		//每个坐席 最大接待的 咨询数量
	
	public static final String SYSTEM_CACHE_SESSION_CONFIG = "session_config";
	
	public static final String SYSTEM_CACHE_SESSION_CONFIG_LIST = "session_config_list";
	
	public static final String SYSTEM_CACHE_AI_CONFIG = "ai_config";
	
	public static String SYSTEM_ORGI = "ukewo" ;
	
	public static final String USER_CURRENT_ORGI_SESSION = "current_orgi";
	public static Map<String , Boolean> model = new HashMap<String,Boolean>();
	
	public static Map<String , Class<?>> uKeFuResourceMap = new HashMap<String , Class<?>>() ;
	
	private static int WebIMPort = 8081 ;
	
	private static ApplicationContext applicationContext ;
	
	private static ElasticsearchTemplate templet ;
	
	public static BlockingQueue<Log> tempLogQueue = new LinkedBlockingQueue<Log>();
	
	static{
		ConvertUtils.register(new DateConverter(), java.util.Date.class); 
		model.put("report", true) ;
		
		uKeFuResourceMap.put(TaskType.ACTIVE.toString(), ActivityResource.class) ;
	}
	
	public enum AskSectionType{
		DEFAULT ;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum ActivityExecType{
		DEFAULT , RECOVERY;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum AgentWorkType{
		MEIDIACHAT,
		CALLCENTER;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum SystemMessageType{
		EMAIL,SMS;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	/**
	 * 名单分配状态：已分配|未分配
	 * @author iceworld
	 *
	 */
	public enum NamesDisStatusType{
		NOT,DISAGENT,DISORGAN;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum ProcessType{
		WORKORDER ;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum QuickTypeEnum{
		PUB,
		PRI;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum FormFilterTypeEnum{
		BATCH,
		BUSINESS;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum NameStatusTypeEnum{
		CALLED,	//已拨打
		NOTCALL	//未拨打
		;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum NamesCalledEnum{
		FAILD,	//拨打失败
		NOANSWER,//无人接听
		EMPNO,	//空号
		ARREARS,//欠费
		APPO,	//预约拨打
		INVALID;//无效名单
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum TagTypeEnum{
		QUALITY;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum StatusTypeEnum{
		INBOUND,
		OUTBOUND;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	
	public enum LogTypeEnum{
		REQUEST,
		CREATE ,
		READ , 
		UPDATE,
		DELETE,
		OTHER,
		INFO,
		WARN,
		ERROR
		;

		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}

	public enum SalesNamesStatus{
		DIST,			//已分配
		NOTDIST;		//未分配
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	

	public enum LeaveMsgStatus{
		PROCESSED,		//已处理
		NOTPROCESS;		//未处理
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	
	public enum AdPosEnum{
		POINT,			
		IMAGE,
		WELCOME,
		INVITE;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum QualityType{
		CHAT,			
		VOICE;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum QualityStatus{
		NO,		//未开启质检
		DIS,		//已分配			
		NODIS;		//未分配
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum CallCenterCallTypeEnum{
		INSIDELINE,
		ORGCALLOUT,
		ORGCALLIN,
		INSIDEQUENE,
		INSIDETRANS,			//已分配
		OUTSIDELINE,
		OUTSIDEQUENE,
		OUTSIDETRANS;		//未分配
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	
	public enum CallServiceStatus{
		INQUENE,
		RING,			//振铃
		INCALL,			//应答
		BRIDGE,			//桥接
		HOLD,			//已挂起
		HANGUP;			//已挂机
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum CallChannelStatus{
		EARLY,
		DOWN;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum WxMpFileType{
		JPG,
		PNG;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum AgentInterType{
		SKILL , 
		AGENT ;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	/**
	 * 会话发起方
	 * @author iceworld
	 *
	 */
	public enum ChatInitiatorType{
		AGENT , 
		USER ;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum ExtentionType{
		LINE, 
		IVR,
		BUSINESS,
		SKILL,
		CONFERENCE,
		QUENE;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum DTMFTypeEnum{
		SATISF,
		PASSWORD,		//密码验证
		IDCARD,			//身份证号码
		CARDNO;			//银行卡号
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	
	public enum AiItemType{
		USERINPUT , 
		AIREPLY;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum MultiUpdateType{
		SAVE , 
		UPDATE,
		DELETE;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum ReportType{
		REPORT;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	

	public enum TaskType{
		BATCH,
		ACTIVE;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum WorkOrdersEventType{
		ACCEPTUSER,		//审批人变更
		OTHER;			//其他变更
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum BpmType{
		WORKORDERS;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum AskOperatorType{
		VIEWS ,
		COMMENTS,
		UPS;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum ModelType{
		USER ,
		WORKORDERS ,
		KBS, 
		SUMMARY,
		CCSUMMARY,WEBIM;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	

	public enum AdapterType{
		TEXT,
		MEDIA,
		AGENT,
		XIAOE,
		INTER;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum MetadataTableType{
		UK_WORKORDERS;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum OnlineUserInviteStatus{
		DEFAULT,
		INVITE,
		REFUSE,
		INSERV,
		ACCEPT;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum CustomerTypeEnum{
		ENTERPRISE ,
		PERSONAL ; 
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum WeiXinEventTypeEnum{
		SUB,
		UNSUB; 
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum ChannelTypeEnum{
		WEIXIN ,
		WEIBO,
		WEBIM,
		PHONE,
		EMAIL, AI;

		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum EventTypeEnum{
		SUB ,
		UNSUB,
		MENU;

		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum AgentStatusEnum{
		READY,
		NOTREADY,
		BUSY,
		NOTBUSY,
		IDLE,
		OFFLINE,
		SERVICES;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum WorkStatusEnum{
		IDLE,
		WAITTING,
		CALLOUT,
		PREVIEW,
		OUTBOUNDCALL;
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum TaskStatusType{
		NORMAL("0"),
		READ("1"),
		QUEUE("5"),
		RUNNING("2"),
		END("3");
		
		private String type ;
		
		TaskStatusType(String type){
			this.type = type ;
		} 
		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}

		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	
	public enum NameSpaceEnum{
		
		IM("/im/user") ,
		AGENT("/im/agent"), 
		ENTIM("/im/ent") ,
		AIIM("/im/ai") ,
		CALLCENTER("/callcenter/event");
		
		private String namespace ;
		
		public String getNamespace() {
			return namespace;
		}

		public void setNamespace(String namespace) {
			this.namespace = namespace;
		}

		NameSpaceEnum(String namespace){
			this.namespace = namespace ;
		}
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum MessageTypeEnum{
		NEW,
		MESSAGE, 
		END,
		TRANS, STATUS , AGENTSTATUS , SERVICE, WRITING;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum CallCenterResultStatusEnum{
		OK;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum MediaTypeEnum{
		TEXT,
		EVENT,
		IMAGE, 
		VIDIO,
		VOICE,LOCATION, FILE , COOPERATION , ACTION;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum CallTypeEnum{
		IN ,
		OUT, 
		SYSTEM,
		INVITE;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum OnlineUserOperatorStatus{
		ONLINE,
		OFFLINE,
		REONLINE,
		CHAT,
		RECHAT,
		BYE,
		SEARCH,
		ACCESS;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum OnlineUserTypeStatus{
		USER,
		WEBIM,
		WEIXIN,
		APP,
		OTHER,
		WEIBO;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum AgentUserStatusEnum{
		INSERVICE,
		INQUENE, END;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public static void setApplicationContext(ApplicationContext context){
		applicationContext = context ;
	}
	
	public static ApplicationContext getContext(){
		return applicationContext ;
	}
	
	public static ElasticsearchTemplate getTemplet() {
		return templet;
	}

	public static void setTemplet(ElasticsearchTemplate templet) {
		UKDataContext.templet = templet;
	}

	public static int getWebIMPort() {
		return WebIMPort;
	}

	public static void setWebIMPort(int webIMPort) {
		WebIMPort = webIMPort;
	}
	/**
	 * 系统级的加密密码 ， 从CA获取
	 * @return
	 */
	public static String getSystemSecrityPassword(){
		return "UCKeFu" ;
	}
	
	public static void setIMServerStatus(boolean running){
		imServerRunning = running ;
	}
	public static boolean getIMServerStatus(){
		return imServerRunning;
	}
	
	public enum FilterConType{
		DIMENSION,
		MEASURE;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	public enum FilterCompType{
		NOT,
		EQUAL;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	public enum FilterValuefilterType{
		COMPARE,
		RANGE;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum FilterConValueType{
		INPUT,
		AUTO,
		USERDEF;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum FilterModelType{
		TEXT,
		DATE,
		SIGSEL,
		SELECT;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}
	
	public enum FilteFunType{
		FILTER,
		RANK;
		
		public String toString(){
			return super.toString().toLowerCase() ;
		}
	}

	/**
	 * 
	 * @param resource
	 * @return
	 */
	public static Class<?> getResource(String resource){
		return uKeFuResourceMap.get(resource) ;
	}
}
