CREATE TABLE `uk_datadic` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `TITLE` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `PARENTID` varchar(32) DEFAULT NULL,
  `TYPE` varchar(32) DEFAULT NULL,
  `MEMO` varchar(255) DEFAULT NULL,
  `ORGI` varchar(32) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `CREATETIME` timestamp NULL DEFAULT NULL,
  `UPDATETIME` timestamp NULL DEFAULT NULL,
  `CREATER` varchar(255) DEFAULT NULL,
  `PUBLISHEDTYPE` varchar(32) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `TABTYPE` varchar(32) DEFAULT NULL,
  `DSTYPE` varchar(32) DEFAULT NULL,
  `DSTEMPLET` varchar(255) DEFAULT NULL,
  `SORTINDEX` int(11) DEFAULT NULL,
  `DICTYPE` varchar(32) DEFAULT NULL,
  `ICONCLASS` varchar(100) DEFAULT NULL,
  `CSSSTYLE` varchar(255) DEFAULT NULL,
  `AUTHCODE` varchar(100) DEFAULT NULL,
  `DEFAULTMENU` tinyint(4) DEFAULT NULL,
  `DATAID` varchar(32) DEFAULT NULL,
  `DICICON` varchar(32) DEFAULT NULL,
  `CURICON` varchar(32) DEFAULT NULL,
  `BGCOLOR` varchar(32) DEFAULT NULL,
  `CURBGCOLOR` varchar(32) DEFAULT NULL,
  `MENUPOS` varchar(32) DEFAULT NULL,
  `DISTITLE` varchar(100) DEFAULT NULL,
  `NAVMENU` tinyint(4) DEFAULT '0',
  `QUICKMENU` tinyint(4) DEFAULT '0',
  `PROJECTID` varchar(32) DEFAULT NULL,
  `SPSEARCH` tinyint(4) DEFAULT NULL,
  UNIQUE KEY `SQL121227155530400` (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE uk_templet ADD layoutcols int default 0;

ALTER TABLE uk_agentstatus ADD workstatus varchar(50);
ALTER TABLE uk_system_message ADD moreparam text;
ALTER TABLE uk_templet ADD datatype varchar(32) default null;
ALTER TABLE uk_templet ADD charttype varchar(32) default null;

alter table uk_system_message modify column smstype varchar(32);

/*
Navicat MySQL Data Transfer

Source Server         : ljc
Source Server Version : 50556
Source Host           : localhost:3306
Source Database       : 333

Target Server Type    : MYSQL
Target Server Version : 50556
File Encoding         : 65001

Date: 2018-03-29 17:18:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for uk_columnproperties
-- ----------------------------
CREATE TABLE `uk_columnproperties` (
  `id` varchar(32) NOT NULL,
  `format` varchar(255) DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `width` varchar(255) DEFAULT NULL,
  `suffix` varchar(255) DEFAULT NULL,
  `font` varchar(255) DEFAULT NULL,
  `colname` varchar(255) DEFAULT NULL,
  `border` varchar(255) DEFAULT NULL,
  `decimalCount` varchar(255) DEFAULT NULL,
  `sepsymbol` varchar(255) DEFAULT NULL,
  `alignment` varchar(255) DEFAULT NULL,
  `fontStyle` varchar(255) DEFAULT NULL,
  `fontColor` varchar(255) DEFAULT NULL,
  `paramName` varchar(255) DEFAULT NULL,
  `orgi` varchar(255) DEFAULT NULL,
  `dataid` varchar(255) DEFAULT NULL,
  `modelid` varchar(255) DEFAULT NULL,
  `dataname` varchar(255) DEFAULT NULL,
  `cur` varchar(255) DEFAULT NULL,
  `hyp` varchar(255) DEFAULT NULL,
  `timeFormat` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `SORTINDEX` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_cube
-- ----------------------------
CREATE TABLE `uk_cube` (
  `ID` varchar(255) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DB` varchar(32) DEFAULT NULL,
  `ORGI` varchar(32) DEFAULT NULL,
  `MPOSLEFT` varchar(32) DEFAULT NULL,
  `MPOSTOP` varchar(32) DEFAULT NULL,
  `TYPEID` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `DSTYPE` varchar(255) DEFAULT NULL,
  `MODELTYPE` varchar(32) DEFAULT NULL,
  `createdata` varchar(32) DEFAULT NULL,
  `startindex` int(11) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `dataid` varchar(32) DEFAULT NULL,
  `dataflag` varchar(255) DEFAULT NULL,
  `CREATER` varchar(32) DEFAULT NULL,
  `UPDATETIME` timestamp NULL DEFAULT NULL,
  `CUBEFILE` longtext,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_cube_type
-- ----------------------------
CREATE TABLE `uk_cube_type` (
  `id` varchar(32) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '维度名称',
  `createtime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `creater` varchar(32) DEFAULT NULL COMMENT '创建人',
  `orgi` varchar(32) DEFAULT NULL COMMENT '租户id',
  `parentid` varchar(32) DEFAULT NULL COMMENT '模型分类上级ID',
  `inx` int(11) DEFAULT NULL COMMENT '分类排序序号',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `description` varchar(255) DEFAULT NULL COMMENT '分类描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_cubelevel
-- ----------------------------
CREATE TABLE `uk_cubelevel` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `COLUMNAME` varchar(255) DEFAULT NULL,
  `UNIQUEMEMBERS` smallint(6) DEFAULT NULL,
  `TYPE` varchar(32) DEFAULT NULL,
  `LEVELTYPE` varchar(32) DEFAULT NULL,
  `TABLENAME` varchar(255) DEFAULT NULL,
  `CUBEID` varchar(32) DEFAULT NULL,
  `ORGI` varchar(32) DEFAULT NULL,
  `SORTINDEX` int(11) DEFAULT NULL,
  `PARAMETERS` longtext,
  `ATTRIBUE` longtext,
  `DIMID` varchar(32) DEFAULT NULL,
  `PERMISSIONS` smallint(6) DEFAULT NULL,
  `TABLEPROPERTY` varchar(32) DEFAULT NULL,
  `FORMATSTR` varchar(255) DEFAULT NULL,
  `description` text,
  `creater` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_cubemeasure
-- ----------------------------
CREATE TABLE `uk_cubemeasure` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `COLUMNAME` varchar(255) DEFAULT NULL,
  `UNIQUEMEMBERS` smallint(6) DEFAULT NULL,
  `TYPE` varchar(32) DEFAULT NULL,
  `LEVELTYPE` varchar(32) DEFAULT NULL,
  `TABLENAME` varchar(255) DEFAULT NULL,
  `CUBEID` varchar(32) DEFAULT NULL,
  `ORGI` varchar(32) DEFAULT NULL,
  `SORTINDEX` int(11) DEFAULT NULL,
  `PARAMETERS` longtext,
  `ATTRIBUE` longtext,
  `MID` varchar(32) DEFAULT NULL,
  `AGGREGATOR` varchar(32) DEFAULT NULL,
  `FORMATSTRING` varchar(255) DEFAULT NULL,
  `CALCULATEDMEMBER` smallint(6) DEFAULT NULL,
  `MODELTYPE` varchar(32) DEFAULT NULL,
  `MEASURE` varchar(32) DEFAULT NULL,
  `description` text,
  `creater` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_cubemetadata
-- ----------------------------
CREATE TABLE `uk_cubemetadata` (
  `ID` varchar(32) NOT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `CODE` varchar(255) DEFAULT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TB` varchar(32) DEFAULT NULL,
  `ORGI` varchar(255) DEFAULT NULL,
  `CUBEID` varchar(32) DEFAULT NULL,
  `POSTOP` varchar(32) DEFAULT NULL,
  `POSLEFT` varchar(32) DEFAULT NULL,
  `MTYPE` varchar(5) DEFAULT NULL,
  `NAMEALIAS` varchar(255) DEFAULT NULL,
  `PARAMETERS` varchar(255) DEFAULT NULL,
  `ATTRIBUE` longtext,
  `creater` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_dimension
-- ----------------------------
CREATE TABLE `uk_dimension` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `CODE` varchar(255) DEFAULT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CUBEID` varchar(32) DEFAULT NULL,
  `ORGI` varchar(255) DEFAULT NULL,
  `TYPE` varchar(32) DEFAULT NULL,
  `SORTINDEX` int(11) DEFAULT NULL,
  `PARAMETERS` longtext,
  `ATTRIBUE` longtext,
  `POSLEFT` varchar(32) DEFAULT NULL,
  `POSTOP` varchar(32) DEFAULT NULL,
  `FORMATSTR` varchar(32) DEFAULT NULL,
  `MODELTYPE` varchar(32) DEFAULT NULL,
  `DIM` varchar(32) DEFAULT NULL,
  `ALLMEMBERNAME` varchar(32) DEFAULT NULL,
  `FKFIELD` varchar(255) DEFAULT NULL,
  `FKTABLE` varchar(255) DEFAULT NULL,
  `FKTABLEID` varchar(255) DEFAULT NULL,
  `CREATER` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_drilldown
-- ----------------------------
CREATE TABLE `uk_drilldown` (
  `id` varchar(32) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `orgi` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `dataid` varchar(255) DEFAULT NULL,
  `dataname` varchar(255) DEFAULT NULL,
  `tdstyle` varchar(255) DEFAULT NULL,
  `reportid` varchar(255) DEFAULT NULL,
  `modelid` varchar(255) DEFAULT NULL,
  `paramname` varchar(255) DEFAULT NULL,
  `paramtype` varchar(255) DEFAULT NULL,
  `paramurl` varchar(255) DEFAULT NULL,
  `paramtarget` varchar(255) DEFAULT NULL,
  `paramreport` varchar(255) DEFAULT NULL,
  `paramvalue` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_publishedcube
-- ----------------------------
CREATE TABLE `uk_publishedcube` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DB` varchar(32) DEFAULT NULL,
  `ORGI` varchar(32) DEFAULT NULL,
  `MPOSLEFT` varchar(32) DEFAULT NULL,
  `MPOSTOP` varchar(32) DEFAULT NULL,
  `TYPEID` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `DSTYPE` varchar(255) DEFAULT NULL,
  `MODELTYPE` varchar(32) DEFAULT NULL,
  `createdata` varchar(32) DEFAULT NULL,
  `startindex` int(11) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `dataid` varchar(32) DEFAULT NULL,
  `dataflag` varchar(255) DEFAULT NULL,
  `DATAVERSION` int(11) DEFAULT NULL,
  `CREATER` varchar(255) DEFAULT NULL,
  `USERID` varchar(32) DEFAULT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `CUBECONTENT` longtext,
  `DBID` varchar(32) DEFAULT NULL,
  `DICLOCATION` varchar(255) DEFAULT NULL,
  `USEREMAIL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_publishedreport
-- ----------------------------
CREATE TABLE `uk_publishedreport` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ORGI` varchar(32) DEFAULT NULL,
  `DICID` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `reporttype` varchar(255) DEFAULT NULL,
  `startindex` int(11) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `dataid` varchar(32) DEFAULT NULL,
  `dataflag` varchar(255) DEFAULT NULL,
  `DATAVERSION` int(11) DEFAULT NULL,
  `CREATER` varchar(255) DEFAULT NULL,
  `REPORTCONTENT` longtext,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_report
-- ----------------------------
CREATE TABLE `uk_report` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REPORTTYPE` varchar(32) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `ORGI` varchar(32) DEFAULT NULL,
  `OBJECTCOUNT` int(11) DEFAULT NULL,
  `DICID` varchar(32) DEFAULT NULL,
  `CREATETIME` datetime DEFAULT NULL,
  `DESCRIPTION` longtext,
  `HTML` longtext,
  `REPORTPACKAGE` varchar(255) DEFAULT NULL,
  `USEACL` varchar(32) DEFAULT NULL,
  `status` varchar(32) DEFAULT NULL,
  `rolename` text,
  `userid` text,
  `blacklist` text,
  `REPORTCONTENT` longtext,
  `reportmodel` varchar(32) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `creater` varchar(255) DEFAULT NULL,
  `reportversion` int(11) DEFAULT NULL,
  `publishedtype` varchar(32) DEFAULT NULL,
  `tabtype` varchar(32) DEFAULT NULL,
  `USERNAME` varchar(32) DEFAULT NULL,
  `USEREMAIL` varchar(255) DEFAULT NULL,
  `CACHE` smallint(6) DEFAULT NULL,
  `EXTPARAM` varchar(255) DEFAULT NULL,
  `TARGETREPORT` varchar(32) DEFAULT NULL,
  `DATASTATUS` tinyint(4) DEFAULT NULL,
  `CODE` varchar(100) DEFAULT NULL,
  `SOURCE` varchar(50) DEFAULT NULL,
  `VIEWTYPE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_reportfilter
-- ----------------------------
CREATE TABLE `uk_reportfilter` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `dataid` varchar(32) DEFAULT NULL,
  `dataname` varchar(255) DEFAULT NULL,
  `modelid` varchar(32) DEFAULT NULL,
  `reportid` varchar(32) DEFAULT NULL,
  `contype` varchar(32) DEFAULT NULL,
  `filtertype` varchar(32) DEFAULT NULL,
  `formatstr` varchar(255) DEFAULT NULL,
  `convalue` varchar(255) DEFAULT NULL,
  `userdefvalue` text,
  `valuefiltertype` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(32) DEFAULT NULL,
  `orgi` varchar(32) DEFAULT NULL,
  `content` text,
  `valuestr` varchar(255) DEFAULT NULL,
  `filterprefix` varchar(255) DEFAULT NULL,
  `filtersuffix` varchar(255) DEFAULT NULL,
  `modeltype` varchar(32) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `funtype` varchar(32) DEFAULT NULL,
  `measureid` varchar(32) DEFAULT NULL,
  `valuecompare` varchar(32) DEFAULT NULL,
  `defaultvalue` text,
  `comparetype` varchar(32) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `cubeid` varchar(32) DEFAULT NULL,
  `mustvalue` varchar(32) DEFAULT NULL,
  `groupids` text,
  `defaultvaluerule` text,
  `dimid` varchar(32) DEFAULT NULL,
  `endvalue` text,
  `filtertemplet` varchar(255) DEFAULT NULL,
  `noformatvalue` text,
  `startvalue` varchar(255) DEFAULT NULL,
  `sortindex` int(11) DEFAULT NULL,
  `cascadeid` varchar(32) DEFAULT NULL,
  `tableproperty` varchar(32) DEFAULT NULL,
  `tableid` varchar(32) DEFAULT NULL,
  `fieldid` varchar(32) DEFAULT NULL,
  `fktableid` varchar(32) DEFAULT NULL,
  `filterfieldid` varchar(32) DEFAULT NULL,
  `isdic` tinyint(4) DEFAULT NULL,
  `diccode` varchar(255) DEFAULT NULL,
  `keyfield` varchar(32) DEFAULT NULL,
  `valuefield` varchar(32) DEFAULT NULL,
  `fkfieldid` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uk_reportmodel
-- ----------------------------
CREATE TABLE `uk_reportmodel` (
  `id` varchar(50) NOT NULL,
  `posx` varchar(50) DEFAULT NULL,
  `posy` varchar(50) DEFAULT NULL,
  `poswidth` varchar(50) DEFAULT NULL,
  `posheight` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `reportid` varchar(50) DEFAULT NULL,
  `modeltype` varchar(50) DEFAULT NULL,
  `sortindex` int(11) DEFAULT NULL,
  `stylestr` varchar(50) DEFAULT NULL,
  `labeltext` varchar(50) DEFAULT NULL,
  `cssclassname` varchar(50) DEFAULT NULL,
  `mposleft` varchar(50) DEFAULT NULL,
  `mpostop` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `exchangerw` tinyint(4) DEFAULT '0',
  `publishedcubeid` varchar(50) DEFAULT NULL,
  `rowdimension` text,
  `coldimension` text,
  `measure` varchar(50) DEFAULT NULL,
  `dstype` varchar(50) DEFAULT NULL,
  `dbtype` varchar(50) DEFAULT NULL,
  `orgi` varchar(50) DEFAULT NULL,
  `objectid` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `filterstr` varchar(50) DEFAULT NULL,
  `sortstr` varchar(50) DEFAULT NULL,
  `viewtype` varchar(50) DEFAULT NULL,
  `chartemplet` varchar(50) DEFAULT NULL,
  `chartype` varchar(50) DEFAULT NULL,
  `chartdatatype` varchar(50) DEFAULT NULL,
  `chart3d` varchar(50) DEFAULT NULL,
  `xtitle` varchar(50) DEFAULT NULL,
  `ytitle` varchar(50) DEFAULT NULL,
  `charttitle` varchar(50) DEFAULT NULL,
  `displayborder` varchar(50) DEFAULT NULL,
  `bordercolor` varchar(50) DEFAULT NULL,
  `displaydesc` varchar(50) DEFAULT NULL,
  `formdisplay` varchar(50) DEFAULT NULL,
  `labelstyle` varchar(50) DEFAULT NULL,
  `formname` varchar(50) DEFAULT NULL,
  `defaultvalue` varchar(50) DEFAULT NULL,
  `querytext` varchar(50) DEFAULT NULL,
  `tempquey` varchar(50) DEFAULT NULL,
  `displaytitle` tinyint(4) DEFAULT '0',
  `clearzero` tinyint(4) DEFAULT '0',
  `titlestr` varchar(50) DEFAULT NULL,
  `width` varchar(50) DEFAULT NULL,
  `height` varchar(50) DEFAULT NULL,
  `widthunit` varchar(50) DEFAULT NULL,
  `heightunit` varchar(50) DEFAULT NULL,
  `defheight` varchar(50) DEFAULT NULL,
  `defwidth` varchar(50) DEFAULT NULL,
  `neckwidth` varchar(50) DEFAULT NULL,
  `neckheight` varchar(50) DEFAULT NULL,
  `extparam` varchar(50) DEFAULT NULL,
  `marginright` varchar(50) DEFAULT NULL,
  `colorstr` varchar(50) DEFAULT NULL,
  `start` varchar(50) DEFAULT NULL,
  `end` varchar(50) DEFAULT NULL,
  `rowformatstr` varchar(50) DEFAULT NULL,
  `colformatstr` varchar(50) DEFAULT NULL,
  `publishtype` varchar(50) DEFAULT NULL,
  `editview` varchar(50) DEFAULT NULL,
  `expandbtm` tinyint(4) DEFAULT '0',
  `expandrgt` tinyint(4) DEFAULT '0',
  `curtab` varchar(50) DEFAULT NULL,
  `hiddencolstr` varchar(50) DEFAULT NULL,
  `eventstr` varchar(50) DEFAULT NULL,
  `dsmodel` varchar(50) DEFAULT NULL,
  `html` text,
  `sqldialect` varchar(255) DEFAULT NULL,
  `pagesize` int(11) DEFAULT NULL,
  `isloadfulldata` varchar(50) DEFAULT NULL,
  `isexport` tinyint(4) DEFAULT '0',
  `selectdata` tinyint(4) DEFAULT '0',
  `exporttitle` varchar(50) DEFAULT NULL,
  `colsize` int(11) DEFAULT NULL,
  `sorttype` varchar(50) DEFAULT NULL,
  `sortname` varchar(50) DEFAULT NULL,
  `mid` varchar(32) DEFAULT NULL,
  `parentid` varchar(32) DEFAULT NULL,
  `templetid` varchar(32) DEFAULT NULL,
  `colspan` int(11) DEFAULT NULL,
  `colindex` int(11) DEFAULT NULL,
  `chartcontent` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE `uk_log_request` (
  `id` varchar(32) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `parameters` longtext,
  `throwable` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `usermail` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `orgi` varchar(255) DEFAULT NULL,
  `error` text,
  `classname` varchar(255) DEFAULT NULL,
  `starttime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `detailtype` varchar(255) DEFAULT NULL,
  `url` text,
  `reportdic` varchar(255) DEFAULT NULL,
  `reportname` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `statues` varchar(255) DEFAULT NULL,
  `methodname` text,
  `linenumber` varchar(255) DEFAULT NULL,
  `querytime` int(255) DEFAULT NULL,
  `optext` varchar(255) DEFAULT NULL,
  `field6` varchar(255) DEFAULT NULL,
  `field7` varchar(255) DEFAULT NULL,
  `field8` varchar(255) DEFAULT NULL,
  `flowid` varchar(32) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `funtype` varchar(32) DEFAULT NULL,
  `fundesc` varchar(255) DEFAULT NULL,
  `triggerwarning` varchar(32) DEFAULT NULL,
  `triggertime` varchar(32) DEFAULT NULL,
  `createdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



