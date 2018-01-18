CREATE TABLE `uk_system_message` (
  `ID` varchar(32) NOT NULL,
  `MSGTYPE` varchar(20) DEFAULT NULL,
  `SMTPSERVER` varchar(255) DEFAULT NULL,
  `SMTPUSER` varchar(255) DEFAULT NULL,
  `SMTPPASSWORD` varchar(255) DEFAULT NULL,
  `MAILFROM` varchar(255) DEFAULT NULL,
  `SECLEV` varchar(50) DEFAULT NULL,
  `ORGI` varchar(32) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  `SMSTYPE` varchar(20) DEFAULT NULL,
  `APPKEY` varchar(200) DEFAULT NULL,
  `APPSEC` varchar(200) DEFAULT NULL,
  `SIGN` varchar(50) DEFAULT NULL,
  `TPCODE` varchar(50) DEFAULT NULL,
  `CREATETIME` datetime DEFAULT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




ALTER TABLE uk_systemconfig ADD enablemail tinyint DEFAULT 0;
ALTER TABLE uk_systemconfig ADD enablesms tinyint DEFAULT 0;

ALTER TABLE uk_systemconfig ADD emailid varchar(32);
ALTER TABLE uk_systemconfig ADD emailworkordertp varchar(32);

ALTER TABLE uk_systemconfig ADD smsid varchar(32);
ALTER TABLE uk_systemconfig ADD smsworkordertp varchar(32);


ALTER TABLE uk_systemconfig ADD mailcreatetp varchar(32);
ALTER TABLE uk_systemconfig ADD mailupdatetp varchar(32);
ALTER TABLE uk_systemconfig ADD mailprocesstp varchar(32);
ALTER TABLE uk_systemconfig ADD emailtocreater tinyint DEFAULT 0;
ALTER TABLE uk_systemconfig ADD emailtocreatertp varchar(32);


ALTER TABLE uk_systemconfig ADD smscreatetp varchar(32);
ALTER TABLE uk_systemconfig ADD smsupdatetp varchar(32);
ALTER TABLE uk_systemconfig ADD smsprocesstp varchar(32);
ALTER TABLE uk_systemconfig ADD smstocreater tinyint DEFAULT 0;
ALTER TABLE uk_systemconfig ADD smstocreatertp varchar(32);

