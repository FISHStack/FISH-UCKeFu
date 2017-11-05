ALTER TABLE uk_callcenter_event ADD SATISF tinyint DEFAULT false;
ALTER TABLE uk_callcenter_event ADD SATISFACTION varchar(50);
ALTER TABLE uk_callcenter_event ADD SATISFACTIONDATE datetime;

update uk_callcenter_event set SATISF = false ;