ALTER TABLE uk_act_batch ADD execnum int DEFAULT 0 COMMENT "导入次数";

CREATE TABLE `uk_act_formfilter` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `CODE` varchar(50) DEFAULT NULL,
  `CREATETIME` datetime DEFAULT NULL,
  `CREATER` varchar(32) DEFAULT NULL,
  `UPDATETIME` datetime DEFAULT NULL,
  `ORGI` varchar(32) DEFAULT NULL,
  `USERNAME` varchar(50) DEFAULT NULL,
  `STATUS` varchar(50) DEFAULT NULL,
  `PARENTID` varchar(32) DEFAULT NULL COMMENT '上级ID',
  `FILTERTYPE` varchar(32) DEFAULT NULL COMMENT '筛选类型（批次筛选/元数据筛选）',
  `BATID` varchar(32) DEFAULT NULL COMMENT '筛选表单使用的批次ID',
  `TABLEID` varchar(32) DEFAULT NULL COMMENT '筛选表单使用元数据ID',
  `DATASTATUS` tinyint(4) DEFAULT '0' COMMENT '数据状态',
  `EXECNUM` INT DEFAULT '0' COMMENT '执行次数',
  `INX` int(11) DEFAULT '0' COMMENT '分类排序序号',
  `ORGAN` varchar(32) DEFAULT NULL,
  `DESCRIPTION` text,
  `execnum` int(11) DEFAULT '0' COMMENT '导入次数',
  `filternum` int(11) DEFAULT '0' COMMENT '筛选次数',
  `conditional` int(11) DEFAULT '0' COMMENT '条件个数',

  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


ALTER TABLE uk_callcenter_event ADD datestr varchar(32) DEFAULT 0 COMMENT '坐席通话日期（yyyy-MM-dd）用于每小时通话数量折线图';
ALTER TABLE uk_callcenter_event ADD hourstr varchar(32) DEFAULT 0 COMMENT '坐席通话时间小时（HH）用于每小时通话数量折线图';



ALTER TABLE uk_historyreport ADD dataid varchar(32) COMMENT "数据ID";
ALTER TABLE uk_historyreport ADD title varchar(100) COMMENT "标题";

ALTER TABLE uk_webim_monitor ADD worktype varchar(50) COMMENT "操作类型";
ALTER TABLE uk_webim_monitor ADD workresult varchar(50) COMMENT "操作结果";
ALTER TABLE uk_webim_monitor ADD dataid varchar(50) COMMENT "数据ID";

ALTER TABLE uk_tableproperties ADD phonenumber tinyint DEFAULT 0 COMMENT "是否电话号码";
ALTER TABLE uk_tableproperties ADD phonetype varchar(50) COMMENT "电话号码类型";
ALTER TABLE uk_tableproperties ADD phonememo varchar(50) COMMENT "电话号码备注";

ALTER TABLE uk_tableproperties ADD secfield tinyint DEFAULT 0 COMMENT "隐藏字段";
ALTER TABLE uk_tableproperties ADD secdistype varchar(50) COMMENT "字段隐藏方式";


ALTER TABLE uk_callcenter_event ADD taskid varchar(50) COMMENT "外呼任务ID";
ALTER TABLE uk_callcenter_event ADD actid varchar(50) COMMENT "外呼活动ID";
ALTER TABLE uk_callcenter_event ADD batid varchar(50) COMMENT "外呼批次ID";

ALTER TABLE uk_callcenter_event ADD batid varchar(50) COMMENT "外呼名单ID";
ALTER TABLE uk_callcenter_event ADD statustype varchar(50) COMMENT "外呼名单状态";

ALTER TABLE uk_callcenter_event ADD disphonenum varchar(50) COMMENT "外呼名单号码";
ALTER TABLE uk_callcenter_event ADD distype varchar(50) COMMENT "外呼名单号码隐藏方式";
ALTER TABLE uk_tableproperties ADD styletype varchar(50) COMMENT "显示样式";

CREATE TABLE `uk_jobdetail` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `CODE` varchar(50) DEFAULT NULL,
  `CREATETIME` datetime DEFAULT NULL,
  `CREATER` varchar(32) DEFAULT NULL,
  `UPDATETIME` datetime DEFAULT NULL,
  `ORGI` varchar(32) DEFAULT NULL,
  `USERNAME` varchar(50) DEFAULT NULL,
  `STATUS` varchar(50) DEFAULT NULL,
  `PARENTID` varchar(32) DEFAULT NULL COMMENT '上级ID',
  `ACTID` varchar(32) DEFAULT NULL COMMENT '活动ID',
  `INX` int(11) DEFAULT '0' COMMENT '分类排序序号',
  `NAMENUM` int(11) DEFAULT '0' COMMENT '批次包含的名单总数',
  `VALIDNUM` int(11) DEFAULT '0' COMMENT '批次包含的有效名单总数',
  `INVALIDNUM` int(11) DEFAULT '0' COMMENT '批次包含的无效名单总数',
  `ASSIGNED` int(11) DEFAULT '0' COMMENT '已分配名单总数',
  `NOTASSIGNED` int(11) DEFAULT '0' COMMENT '未分配名单总数',
  `ENABLE` tinyint(4) DEFAULT '0' COMMENT '分类状态',
  `DATASTATUS` tinyint(4) DEFAULT '0' COMMENT '数据状态',
  `AREA` text COMMENT '分类描述',
  `imptype` varchar(50) DEFAULT NULL,
  `batchtype` varchar(32) DEFAULT NULL,
  `ORGAN` varchar(32) DEFAULT NULL,
  `impurl` text,
  `filetype` varchar(50) DEFAULT NULL,
  `dbtype` varchar(50) DEFAULT NULL,
  `jdbcurl` text,
  `driverclazz` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `DESCRIPTION` text,
  `execnum` int(11) DEFAULT '0' COMMENT '导入次数',
  `SOURCE` varchar(255) DEFAULT NULL,
  `CLAZZ` varchar(255) DEFAULT NULL,
  `TASKFIRETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CRAWLTASKID` varchar(255) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `NICKNAME` varchar(255) DEFAULT NULL,
  `USERID` varchar(255) DEFAULT NULL,
  `TASKTYPE` varchar(255) DEFAULT NULL,
  `TASKID` varchar(255) DEFAULT NULL,
  `FETCHER` smallint(6) NOT NULL,
  `PAUSE` smallint(6) NOT NULL,
  `PLANTASK` smallint(6) NOT NULL,
  `SECURE_ID` varchar(32) DEFAULT NULL,
  `CONFIGURE_ID` varchar(32) DEFAULT NULL,
  `TAKSPLAN_ID` varchar(32) DEFAULT NULL,
  `CRAWLTASK` varchar(32) DEFAULT NULL,
  `TARGETTASK` varchar(32) DEFAULT NULL,
  `STARTINDEX` int(11) DEFAULT NULL,
  `LASTDATE` timestamp NULL DEFAULT NULL,
  `CREATETABLE` tinyint(4) DEFAULT NULL,
  `MEMO` text,
  `NEXTFIRETIME` timestamp NULL DEFAULT NULL,
  `CRONEXP` varchar(255) DEFAULT NULL,
  `TASKSTATUS` varchar(32) DEFAULT NULL,
  `usearea` varchar(255) DEFAULT '',
  `areafield` varchar(255) DEFAULT NULL,
  `areafieldtype` varchar(32) DEFAULT NULL,
  `arearule` varchar(255) DEFAULT NULL,
  `minareavalue` varchar(255) DEFAULT NULL,
  `maxareavalue` varchar(255) DEFAULT NULL,
  `formatstr` varchar(255) DEFAULT NULL,
  `DATAID` varchar(1000) DEFAULT NULL COMMENT '报表id字符串',
  `DICID` varchar(1000) DEFAULT NULL COMMENT '目录id字符串',
  `taskinfo` longtext COMMENT 'taskinfo信息',
  `FILTERID` varchar(32) DEFAULT NULL,
  `FETCH_SIZE` int(11) DEFAULT NULL,
  `LASTINDEX` int(11) DEFAULT NULL,
  `PAGES` int(11) DEFAULT NULL,
  `plantaskreadtorun` tinyint(4) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `runserver` varchar(100) DEFAULT NULL,
  `actype` varchar(50) DEFAULT NULL,
  `distype` varchar(32) DEFAULT NULL,
  `distpolicy` varchar(50) DEFAULT NULL,
  `policynum` int(11) DEFAULT NULL,
  `busstype` varchar(32) DEFAULT NULL,
  `disnum` varchar(32) DEFAULT NULL COMMENT '默认分配数量',
  `execmd` varchar(32) DEFAULT NULL,
  `exectarget` varchar(50) DEFAULT NULL,
  `exectype` varchar(32) DEFAULT NULL,
  `execto` varchar(32) DEFAULT NULL,
  `threads` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;



ALTER TABLE uk_contacts CHANGE mobile mobileno varchar(40);


CREATE TABLE `uk_act_config` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `orgi` varchar(32) DEFAULT NULL COMMENT '租户ID',
  `creater` varchar(32) DEFAULT NULL COMMENT '创建人',
  `username` varchar(32) DEFAULT NULL COMMENT '创建人用户名',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `enablecallout` tinyint(4) DEFAULT '0' COMMENT '启用自动外呼功能',
  `countdown` int(11) DEFAULT '0' COMMENT '倒计时时长',
  `enabletagentthreads` tinyint(4) DEFAULT '0' COMMENT '启用坐席外呼并发控制',
  `agentthreads` int(11) DEFAULT '0' COMMENT '坐席外呼并发数量',
  `enabletaithreads` tinyint(4) DEFAULT '0' COMMENT '启用机器人外呼并发控制',
  `aithreads` int(11) DEFAULT '0' COMMENT '机器人并发数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


ALTER TABLE uk_callcenter_siptrunk ADD province varchar(20) COMMENT "省份";
ALTER TABLE uk_callcenter_siptrunk ADD city varchar(20) COMMENT "城市";


CREATE TABLE `uk_act_callnames` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `CODE` varchar(50) DEFAULT NULL,
  `CREATETIME` datetime DEFAULT NULL,
  `CREATER` varchar(32) DEFAULT NULL,
  `UPDATETIME` datetime DEFAULT NULL,
  `ORGI` varchar(32) DEFAULT NULL,
  `USERNAME` varchar(50) DEFAULT NULL,
  `STATUS` varchar(50) DEFAULT NULL,
  `PARENTID` varchar(32) DEFAULT NULL COMMENT '上级ID',
  `ACTID` varchar(32) DEFAULT NULL COMMENT '活动ID',
  `BATID` varchar(32) DEFAULT NULL COMMENT '活动ID',
  `DATASTATUS` varchar(32) DEFAULT NULL COMMENT '数据状态',
  `CALLS` int(11) DEFAULT '0' COMMENT '拨打次数',
  `FAILDCALLS` int(11) DEFAULT '0' COMMENT '拨打失败次数',
  `invalid` tinyint(4) DEFAULT '0' COMMENT '数据状态',
  `failed` tinyint(4) DEFAULT '0' COMMENT '数据状态',
  `WORKSTATUS` varchar(32) DEFAULT NULL,
  `OPTIME` datetime DEFAULT NULL,
  `ORGAN` varchar(32) DEFAULT NULL,
  `BATNAME` varchar(100) DEFAULT NULL,
  `TASKNAME` varchar(100) DEFAULT NULL,
  `owneruser` varchar(100) DEFAULT NULL,
  `ownerdept` varchar(100) DEFAULT NULL,
  `dataid` varchar(100) DEFAULT NULL,
  `taskid` varchar(100) DEFAULT NULL,
  `filterid` varchar(100) DEFAULT NULL,
  `phonenumber` varchar(100) DEFAULT NULL,
  `leavenum` int(11) DEFAULT '0',
  `metaname` varchar(100) DEFAULT NULL,
  `distype` varchar(100) DEFAULT NULL,
  `previewtime` int(11) DEFAULT '0',
  `previewtimes` int(11) DEFAULT '0',
  `servicetype` text,
  `reservation` tinyint(4) DEFAULT '0',
  `memo` text,
  `firstcalltime` datetime DEFAULT NULL,
  `firstcallstatus` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;




ALTER TABLE uk_callcenter_event ADD siptrunk varchar(32) COMMENT "线路";
ALTER TABLE uk_callcenter_event ADD prefix tinyint(4) COMMENT "号码加拨0";