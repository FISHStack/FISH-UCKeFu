prompt
prompt Creating table MD_PROJECTS
prompt ==========================
prompt
create table KEFU5.MD_PROJECTS
(
  id                INTEGER not null,
  project_name      VARCHAR2(4000) not null,
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_PROJECTS
  is 'This is a top level container for a set of connections.';
comment on column KEFU5.MD_PROJECTS.id
  is 'Primary key';
comment on column KEFU5.MD_PROJECTS.project_name
  is 'Name of the project //OBJECTNAME';
alter table KEFU5.MD_PROJECTS
  add constraint MD_PROJECTS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table MD_CONNECTIONS
prompt =============================
prompt
create table KEFU5.MD_CONNECTIONS
(
  id                          INTEGER not null,
  project_id_fk               INTEGER not null,
  type                        VARCHAR2(4000),
  host                        VARCHAR2(4000),
  port                        INTEGER,
  username                    VARCHAR2(4000),
  password                    VARCHAR2(4000),
  dburl                       VARCHAR2(4000),
  name                        VARCHAR2(255),
  native_sql                  CLOB,
  num_catalogs                INTEGER,
  num_columns                 INTEGER,
  num_constraints             INTEGER,
  num_groups                  INTEGER,
  num_roles                   INTEGER,
  num_indexes                 INTEGER,
  num_other_objects           INTEGER,
  num_packages                INTEGER,
  num_privileges              INTEGER,
  num_schemas                 INTEGER,
  num_sequences               INTEGER,
  num_stored_programs         INTEGER,
  num_synonyms                INTEGER,
  num_tables                  INTEGER,
  num_tablespaces             INTEGER,
  num_triggers                INTEGER,
  num_user_defined_data_types INTEGER,
  num_users                   INTEGER,
  num_views                   INTEGER,
  comments                    VARCHAR2(4000),
  security_group_id           INTEGER default 0 not null,
  created_on                  DATE default sysdate not null,
  created_by                  VARCHAR2(255),
  last_updated_on             DATE,
  last_updated_by             VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_CONNECTIONS
  is 'This table is used to store connection information.  For example, in migrations, we could be carrying out a consolidation which occurs across many connections.';
comment on column KEFU5.MD_CONNECTIONS.id
  is 'Primary key';
comment on column KEFU5.MD_CONNECTIONS.project_id_fk
  is 'The project to which this connection belongs //PARENTFIELD';
comment on column KEFU5.MD_CONNECTIONS.type
  is 'The type of the connection - For example it could be used to store "ORACLE" or "MYSQL"';
comment on column KEFU5.MD_CONNECTIONS.host
  is 'The host to which this connection connects.';
comment on column KEFU5.MD_CONNECTIONS.port
  is 'The port to which this connection connects';
comment on column KEFU5.MD_CONNECTIONS.username
  is 'The username used to make the connection';
comment on column KEFU5.MD_CONNECTIONS.password
  is 'The password used to make this connection';
comment on column KEFU5.MD_CONNECTIONS.dburl
  is 'The database url used to make this connection';
comment on column KEFU5.MD_CONNECTIONS.name
  is '//OBJECTNAME';
comment on column KEFU5.MD_CONNECTIONS.native_sql
  is 'The native sql used to create this connection';
alter table KEFU5.MD_CONNECTIONS
  add constraint MD_CONNECTIONS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_CONNECTIONS
  add constraint MD_CONNECTIONS_MD_PROJECT_FK1 foreign key (PROJECT_ID_FK)
  references KEFU5.MD_PROJECTS (ID) on delete cascade;

prompt
prompt Creating table MD_ADDITIONAL_PROPERTIES
prompt =======================================
prompt
create table KEFU5.MD_ADDITIONAL_PROPERTIES
(
  id                INTEGER not null,
  connection_id_fk  INTEGER not null,
  ref_id_fk         INTEGER not null,
  ref_type          VARCHAR2(4000) not null,
  property_order    INTEGER,
  prop_key          VARCHAR2(4000) not null,
  value             VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_ADDITIONAL_PROPERTIES
  is 'This table is used to store additional properties in key-value pairs.  It is designed to store "other information" that is not supported in the main database object table.';
comment on column KEFU5.MD_ADDITIONAL_PROPERTIES.id
  is 'Primary Key';
comment on column KEFU5.MD_ADDITIONAL_PROPERTIES.connection_id_fk
  is 'Connection to which this belongs //PARENTFIELD';
comment on column KEFU5.MD_ADDITIONAL_PROPERTIES.ref_id_fk
  is 'The object to which this property blongs';
comment on column KEFU5.MD_ADDITIONAL_PROPERTIES.ref_type
  is 'Type of object that this property belongs to';
comment on column KEFU5.MD_ADDITIONAL_PROPERTIES.property_order
  is 'This is to handle a situation where multiple properties have a relevant order, or multiple properties have multiple values';
comment on column KEFU5.MD_ADDITIONAL_PROPERTIES.prop_key
  is 'The keyname for this property';
comment on column KEFU5.MD_ADDITIONAL_PROPERTIES.value
  is 'The value for this property';
alter table KEFU5.MD_ADDITIONAL_PROPERTIES
  add constraint MD_ADDITIONAL_PROPERTIES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_ADDITIONAL_PROPERTIES
  add constraint MD_ADDITIONAL_PROPERTIES__FK1 foreign key (CONNECTION_ID_FK)
  references KEFU5.MD_CONNECTIONS (ID) on delete cascade;

prompt
prompt Creating table MD_CATALOGS
prompt ==========================
prompt
create table KEFU5.MD_CATALOGS
(
  id                INTEGER not null,
  connection_id_fk  INTEGER not null,
  catalog_name      VARCHAR2(4000),
  dummy_flag        CHAR(1) default 'N',
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_CATALOGS
  is 'Store catalogs in this table.';
comment on column KEFU5.MD_CATALOGS.connection_id_fk
  is 'Foreign key into the connections table - Shows what connection this catalog belongs to //PARENTFIELD';
comment on column KEFU5.MD_CATALOGS.catalog_name
  is 'Name of the catalog //OBJECTNAME';
comment on column KEFU5.MD_CATALOGS.dummy_flag
  is 'Flag to show if this catalog is a "dummy" catalog which is used as a placeholder for those platforms that do not support catalogs.  ''N'' signifies that this is NOT a dummy catalog, while ''Y'' signifies that it is.';
comment on column KEFU5.MD_CATALOGS.native_sql
  is 'THe SQL used to create this catalog';
comment on column KEFU5.MD_CATALOGS.native_key
  is 'A unique identifier used to identify the catalog at source.';
alter table KEFU5.MD_CATALOGS
  add constraint MD_CATALOGS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_CATALOGS
  add constraint MD_CATALOGS_MD_CONNECTION_FK1 foreign key (CONNECTION_ID_FK)
  references KEFU5.MD_CONNECTIONS (ID) on delete cascade;

prompt
prompt Creating table MD_SCHEMAS
prompt =========================
prompt
create table KEFU5.MD_SCHEMAS
(
  id                INTEGER not null,
  catalog_id_fk     INTEGER not null,
  name              VARCHAR2(4000),
  type              CHAR(1),
  character_set     VARCHAR2(4000),
  version_tag       VARCHAR2(40),
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_SCHEMAS
  is 'This is the holder for schemas';
comment on column KEFU5.MD_SCHEMAS.id
  is 'Primary Key';
comment on column KEFU5.MD_SCHEMAS.catalog_id_fk
  is 'Catalog to which this schema blongs //PARENTFIELD';
comment on column KEFU5.MD_SCHEMAS.name
  is 'Name of the schema //OBJECTNAME';
comment on column KEFU5.MD_SCHEMAS.type
  is 'Type of this schema.  Eaxamples are ''CAPTURED'' OR ''CONVERTED''';
comment on column KEFU5.MD_SCHEMAS.character_set
  is 'The characterset of this schema';
comment on column KEFU5.MD_SCHEMAS.version_tag
  is 'A version string that can be used for tagging/baseling a schema';
comment on column KEFU5.MD_SCHEMAS.native_sql
  is 'The native SQL used to create this schema';
comment on column KEFU5.MD_SCHEMAS.native_key
  is 'A unique identifier that this schema is known as in its source state.';
alter table KEFU5.MD_SCHEMAS
  add constraint MD_SCHEMAS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_SCHEMAS
  add constraint MD_SCHEMAS_MD_CATALOGS_FK1 foreign key (CATALOG_ID_FK)
  references KEFU5.MD_CATALOGS (ID) on delete cascade;

prompt
prompt Creating table MD_TABLES
prompt ========================
prompt
create table KEFU5.MD_TABLES
(
  id                    INTEGER not null,
  schema_id_fk          INTEGER not null,
  table_name            VARCHAR2(4000) not null,
  native_sql            CLOB,
  native_key            VARCHAR2(4000),
  qualified_native_name VARCHAR2(4000) not null,
  comments              VARCHAR2(4000),
  security_group_id     INTEGER default 0 not null,
  created_on            DATE default sysdate not null,
  created_by            VARCHAR2(255),
  last_updated_on       DATE,
  last_updated_by       VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_TABLES
  is 'Table used to store information about tables.';
comment on column KEFU5.MD_TABLES.id
  is 'Primary Key';
comment on column KEFU5.MD_TABLES.schema_id_fk
  is 'Schema in which this table resides //PARENTFIELD';
comment on column KEFU5.MD_TABLES.table_name
  is 'Name of the table //OBJECTNAME';
comment on column KEFU5.MD_TABLES.native_sql
  is 'SQL Used to create this table at soruce';
comment on column KEFU5.MD_TABLES.native_key
  is 'Unique identifier for this table at source';
alter table KEFU5.MD_TABLES
  add constraint MD_TABLES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_TABLES
  add constraint MD_TABLES_MD_SCHEMAS_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_COLUMNS
prompt =========================
prompt
create table KEFU5.MD_COLUMNS
(
  id                        INTEGER not null,
  table_id_fk               INTEGER not null,
  column_name               VARCHAR2(4000) not null,
  column_order              INTEGER not null,
  column_type               VARCHAR2(4000),
  precision                 INTEGER,
  scale                     INTEGER,
  nullable                  CHAR(1),
  default_value             VARCHAR2(4000),
  native_sql                CLOB,
  native_key                VARCHAR2(4000),
  datatype_transformed_flag CHAR(1),
  comments                  VARCHAR2(4000),
  security_group_id         INTEGER default 0 not null,
  created_by                VARCHAR2(255),
  created_on                DATE default sysdate not null,
  last_updated_by           VARCHAR2(255),
  last_updated_on           DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_COLUMNS
  is 'Column information is stored in this table.';
comment on column KEFU5.MD_COLUMNS.id
  is 'Primary Key';
comment on column KEFU5.MD_COLUMNS.table_id_fk
  is 'The table that this column is part of //PARENTFIELD';
comment on column KEFU5.MD_COLUMNS.column_name
  is 'The name of the column //OBJECTNAME';
comment on column KEFU5.MD_COLUMNS.column_order
  is 'The order this appears in the table';
comment on column KEFU5.MD_COLUMNS.column_type
  is 'The type of the column';
comment on column KEFU5.MD_COLUMNS.precision
  is 'The precision on the column';
comment on column KEFU5.MD_COLUMNS.scale
  is 'The scale of the column';
comment on column KEFU5.MD_COLUMNS.nullable
  is 'Yes or No.  Null signifies NO';
comment on column KEFU5.MD_COLUMNS.default_value
  is 'Default value on the column';
comment on column KEFU5.MD_COLUMNS.native_sql
  is 'The SQL used to create this column at source';
comment on column KEFU5.MD_COLUMNS.native_key
  is 'Unique identifier for this object at source';
comment on column KEFU5.MD_COLUMNS.datatype_transformed_flag
  is 'This is set to ''Y'' to show if the data type was transformed.  This is useful so we don''t apply more than 1 datatype transformation to a column';
alter table KEFU5.MD_COLUMNS
  add constraint MD_COLUMNS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_COLUMNS
  add constraint MD_COLUMNS_MD_TABLES_FK1 foreign key (TABLE_ID_FK)
  references KEFU5.MD_TABLES (ID) on delete cascade;

prompt
prompt Creating table MD_CONSTRAINTS
prompt =============================
prompt
create table KEFU5.MD_CONSTRAINTS
(
  id                INTEGER not null,
  delete_clause     VARCHAR2(4000),
  name              VARCHAR2(4000),
  constraint_type   VARCHAR2(4000),
  table_id_fk       INTEGER not null,
  reftable_id_fk    INTEGER,
  constraint_text   CLOB,
  language          VARCHAR2(40) not null,
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_CONSTRAINTS
  is 'Table for storing information about a constraint';
comment on column KEFU5.MD_CONSTRAINTS.id
  is 'Primary Key';
comment on column KEFU5.MD_CONSTRAINTS.delete_clause
  is 'delete option , can be either CASCADE, RESTRICT or NULL';
comment on column KEFU5.MD_CONSTRAINTS.name
  is 'Name of the constraint //OBJECTNAME';
comment on column KEFU5.MD_CONSTRAINTS.constraint_type
  is 'Type of the constraint (e.g. CHECK)';
comment on column KEFU5.MD_CONSTRAINTS.table_id_fk
  is 'Table on which this constraint exists //PARENTFIELD';
comment on column KEFU5.MD_CONSTRAINTS.reftable_id_fk
  is 'Used in foreign keys - this gives the table that we refer to.';
comment on column KEFU5.MD_CONSTRAINTS.constraint_text
  is 'The text of the constraint';
comment on column KEFU5.MD_CONSTRAINTS.language
  is '//PUBLIC';
alter table KEFU5.MD_CONSTRAINTS
  add constraint MD_CONSTRAINTS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_CONSTRAINTS
  add constraint MD_CONSTRAINTS_MD_TABLES_FK1 foreign key (TABLE_ID_FK)
  references KEFU5.MD_TABLES (ID) on delete cascade;

prompt
prompt Creating table MD_CONSTRAINT_DETAILS
prompt ====================================
prompt
create table KEFU5.MD_CONSTRAINT_DETAILS
(
  id                INTEGER not null,
  ref_flag          CHAR(1) default 'N',
  constraint_id_fk  INTEGER not null,
  column_id_fk      INTEGER,
  column_portion    INTEGER,
  constraint_text   CLOB,
  detail_order      INTEGER not null,
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_CONSTRAINT_DETAILS
  is 'Constraint details show what columns are "involved" in a constraint.';
comment on column KEFU5.MD_CONSTRAINT_DETAILS.id
  is 'Primary Key';
comment on column KEFU5.MD_CONSTRAINT_DETAILS.ref_flag
  is '"N" or Null signify that this column is the colum that is used in the constraint.  A flag of Y signifies that the colum is a referenced column (i.e. part of a foreign key constraint)';
comment on column KEFU5.MD_CONSTRAINT_DETAILS.constraint_id_fk
  is 'Constraint that this detail belongs to //PARENTFIELD';
comment on column KEFU5.MD_CONSTRAINT_DETAILS.column_portion
  is 'The portion of a column this detail belongs (e.g. for constrints on substrings)';
comment on column KEFU5.MD_CONSTRAINT_DETAILS.constraint_text
  is 'The text of the constraint';
alter table KEFU5.MD_CONSTRAINT_DETAILS
  add constraint MD_CONSTRAINT_DETAILS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_CONSTRAINT_DETAILS
  add constraint MD_CONSTRAINT_DETAILS_MD__FK1 foreign key (CONSTRAINT_ID_FK)
  references KEFU5.MD_CONSTRAINTS (ID) on delete cascade;
alter table KEFU5.MD_CONSTRAINT_DETAILS
  add constraint MD_CONSTRAINT_DETAILS_MD__FK2 foreign key (COLUMN_ID_FK)
  references KEFU5.MD_COLUMNS (ID) on delete cascade;

prompt
prompt Creating table MD_DERIVATIVES
prompt =============================
prompt
create table KEFU5.MD_DERIVATIVES
(
  id                       INTEGER not null,
  src_id                   INTEGER not null,
  src_type                 VARCHAR2(4000),
  derived_id               INTEGER not null,
  derived_type             VARCHAR2(4000),
  derived_connection_id_fk INTEGER not null,
  transformed              CHAR(1),
  original_identifier      VARCHAR2(4000),
  new_identifier           VARCHAR2(4000),
  derived_object_namespace VARCHAR2(40),
  derivative_reason        VARCHAR2(10),
  security_group_id        INTEGER default 0 not null,
  created_on               DATE default sysdate not null,
  created_by               VARCHAR2(255),
  last_updated_on          DATE,
  last_updated_by          VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_DERIVATIVES
  is 'This table is used to store objects that are derived from each other.  For example in a migration an auto-increment column in a source model could be mapped to a primary key, and a sequence, and a trigger.  The MD_DERIVATIVES table would store the fact that these 3 objects are derived from the auto-increment column.';
comment on column KEFU5.MD_DERIVATIVES.transformed
  is 'Set this field to ''Y'' if we carry out any sort of transformation on teh derived object.';
create index KEFU5.MD_DERIVATIVES_PERF_IDX on KEFU5.MD_DERIVATIVES (SRC_ID, DERIVED_CONNECTION_ID_FK)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_DERIVATIVES
  add constraint MIGRDREIVATIVES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_DERIVATIVES
  add constraint MD_DERIVATIVES_MD_CONNECT_FK1 foreign key (DERIVED_CONNECTION_ID_FK)
  references KEFU5.MD_CONNECTIONS (ID) on delete cascade;

prompt
prompt Creating table MD_GROUPS
prompt ========================
prompt
create table KEFU5.MD_GROUPS
(
  id                INTEGER not null,
  schema_id_fk      INTEGER not null,
  group_name        VARCHAR2(4000),
  group_flag        CHAR(1),
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_GROUPS
  is 'Groups of users in a schema';
comment on column KEFU5.MD_GROUPS.id
  is 'Primary Key';
comment on column KEFU5.MD_GROUPS.schema_id_fk
  is 'Schema in which this object belongs //PARENTFIELD';
comment on column KEFU5.MD_GROUPS.group_name
  is 'Name of the group //OBJECTNAME';
comment on column KEFU5.MD_GROUPS.group_flag
  is 'This is a flag to signify a group or a role.  If this is ''R'' it means the group is known as a Role.  Any other value means it is known as a group.';
comment on column KEFU5.MD_GROUPS.native_sql
  is 'SQL Used to generate this object at source';
comment on column KEFU5.MD_GROUPS.native_key
  is 'Unique id for this object at source';
alter table KEFU5.MD_GROUPS
  add constraint MD_GROUPS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_GROUPS
  add constraint MD_GROUPS_MD_SCHEMAS_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_USERS
prompt =======================
prompt
create table KEFU5.MD_USERS
(
  id                INTEGER not null,
  schema_id_fk      INTEGER not null,
  username          VARCHAR2(4000) not null,
  password          VARCHAR2(4000),
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_USERS
  is 'User information.';
comment on column KEFU5.MD_USERS.id
  is 'Primary Key';
comment on column KEFU5.MD_USERS.schema_id_fk
  is 'Shema in which this object belongs //PARENTFIELD';
comment on column KEFU5.MD_USERS.username
  is 'Username for login //OBJECTNAME';
comment on column KEFU5.MD_USERS.password
  is 'Password for login';
comment on column KEFU5.MD_USERS.native_sql
  is 'SQL Used to create this object at source';
comment on column KEFU5.MD_USERS.native_key
  is 'Unique identifier for this object at source.';
alter table KEFU5.MD_USERS
  add constraint MD_USERS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_USERS
  add constraint MD_USERS_MD_SCHEMAS_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_GROUP_MEMBERS
prompt ===============================
prompt
create table KEFU5.MD_GROUP_MEMBERS
(
  id                 INTEGER not null,
  group_id_fk        INTEGER not null,
  user_id_fk         INTEGER,
  group_member_id_fk INTEGER,
  security_group_id  INTEGER default 0 not null,
  created_on         DATE default sysdate not null,
  created_by         VARCHAR2(255),
  last_updated_on    DATE,
  last_updated_by    VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_GROUP_MEMBERS
  is 'This table is used to store the members of a group.';
comment on column KEFU5.MD_GROUP_MEMBERS.id
  is 'Primary Key';
comment on column KEFU5.MD_GROUP_MEMBERS.user_id_fk
  is 'Id of member';
comment on column KEFU5.MD_GROUP_MEMBERS.group_member_id_fk
  is 'groups can be members of groups';
alter table KEFU5.MD_GROUP_MEMBERS
  add constraint MD_GROUP_MEMBERS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_GROUP_MEMBERS
  add constraint MD_GROUPMEMBERS_MD_GROUPS_FK1 foreign key (GROUP_ID_FK)
  references KEFU5.MD_GROUPS (ID) on delete cascade;
alter table KEFU5.MD_GROUP_MEMBERS
  add constraint MD_GROUPMEMBERS_MD_GROUPS_FK2 foreign key (GROUP_MEMBER_ID_FK)
  references KEFU5.MD_GROUPS (ID) on delete cascade;
alter table KEFU5.MD_GROUP_MEMBERS
  add constraint MD_GROUPMEMBERS_MD_USERS_FK1 foreign key (USER_ID_FK)
  references KEFU5.MD_USERS (ID) on delete cascade;

prompt
prompt Creating table MD_PRIVILEGES
prompt ============================
prompt
create table KEFU5.MD_PRIVILEGES
(
  id                  INTEGER not null,
  schema_id_fk        INTEGER not null,
  privilege_name      VARCHAR2(4000) not null,
  privelege_object_id INTEGER,
  privelegeobjecttype VARCHAR2(4000) not null,
  privelege_type      VARCHAR2(4000) not null,
  admin_option        CHAR(1),
  native_sql          CLOB not null,
  native_key          VARCHAR2(4000),
  comments            VARCHAR2(4000),
  security_group_id   INTEGER default 0 not null,
  created_on          DATE default sysdate not null,
  created_by          VARCHAR2(255),
  last_updated_on     DATE,
  last_updated_by     VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_PRIVILEGES
  is 'This table stores privilege information';
comment on column KEFU5.MD_PRIVILEGES.id
  is 'Primary Key';
comment on column KEFU5.MD_PRIVILEGES.schema_id_fk
  is 'The schema to which this object belongs //PARENTFIELD';
comment on column KEFU5.MD_PRIVILEGES.privilege_name
  is 'The name of the privilege //OBJECTNAME';
comment on column KEFU5.MD_PRIVILEGES.privelege_object_id
  is 'This references the table, view, etc on which the privelege exists.  This can be NULL for things like system wide privileges';
comment on column KEFU5.MD_PRIVILEGES.privelegeobjecttype
  is 'The type the privelege is on (e.g. INDEX)';
comment on column KEFU5.MD_PRIVILEGES.privelege_type
  is 'e.g.select';
comment on column KEFU5.MD_PRIVILEGES.admin_option
  is 'Flag to show if this was granted with admin option.  ''Y'' means it was granted with admin option ''N'' means it was NOT granted with admin option.  NULL means not applicable (e.g. not known, not supported by source platform, etc.)';
comment on column KEFU5.MD_PRIVILEGES.native_sql
  is 'The SQL used to create this privilege at source';
comment on column KEFU5.MD_PRIVILEGES.native_key
  is 'An identifier for this object at source.';
alter table KEFU5.MD_PRIVILEGES
  add constraint MD_PRIVILEGES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_PRIVILEGES
  add constraint MD_PRIVILEGES_MD_SCHEMAS_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_GROUP_PRIVILEGES
prompt ==================================
prompt
create table KEFU5.MD_GROUP_PRIVILEGES
(
  id                INTEGER not null,
  group_id_fk       INTEGER not null,
  privilege_id_fk   INTEGER not null,
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_GROUP_PRIVILEGES
  is 'This table stores the privileges granted to a group (or role)';
alter table KEFU5.MD_GROUP_PRIVILEGES
  add constraint MD_GROUP_PRIVILEGES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_GROUP_PRIVILEGES
  add constraint MD_GROUP_PRIVILEGES_MD_GR_FK1 foreign key (GROUP_ID_FK)
  references KEFU5.MD_GROUPS (ID) on delete cascade;
alter table KEFU5.MD_GROUP_PRIVILEGES
  add constraint MD_GROUP_PRIVILEGES_MD_PR_FK1 foreign key (PRIVILEGE_ID_FK)
  references KEFU5.MD_PRIVILEGES (ID) on delete cascade;

prompt
prompt Creating table MD_INDEXES
prompt =========================
prompt
create table KEFU5.MD_INDEXES
(
  id                INTEGER not null,
  index_type        VARCHAR2(4000),
  table_id_fk       INTEGER not null,
  index_name        VARCHAR2(4000),
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(4000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_INDEXES
  is 'This table is used to store information about the indexes in a schema';
comment on column KEFU5.MD_INDEXES.id
  is 'Primary Key';
comment on column KEFU5.MD_INDEXES.index_type
  is 'Type of the index e.g. PRIMARY';
comment on column KEFU5.MD_INDEXES.table_id_fk
  is 'Table that this index is on //PARENTFIELD';
comment on column KEFU5.MD_INDEXES.index_name
  is 'Name of the index //OBJECTNAME';
comment on column KEFU5.MD_INDEXES.native_sql
  is 'SQL used to create the index at source';
comment on column KEFU5.MD_INDEXES.native_key
  is 'A unique identifier for this object at the source';
alter table KEFU5.MD_INDEXES
  add constraint MD_INDEXES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_INDEXES
  add constraint MD_INDEXES_MD_TABLES_FK1 foreign key (TABLE_ID_FK)
  references KEFU5.MD_TABLES (ID) on delete cascade;

prompt
prompt Creating table MD_INDEX_DETAILS
prompt ===============================
prompt
create table KEFU5.MD_INDEX_DETAILS
(
  id                INTEGER not null,
  index_id_fk       INTEGER not null,
  column_id_fk      INTEGER not null,
  index_portion     INTEGER,
  detail_order      INTEGER not null,
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_INDEX_DETAILS
  is 'This table stores the details of an index.  It shows what columns are "part" of the index.';
comment on column KEFU5.MD_INDEX_DETAILS.index_id_fk
  is 'The index to which this detail belongs. //PARENTFIELD';
comment on column KEFU5.MD_INDEX_DETAILS.index_portion
  is 'To support indexing on part of a field';
alter table KEFU5.MD_INDEX_DETAILS
  add constraint MD_INDEX_DETAILS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_INDEX_DETAILS
  add constraint MD_INDEX_DETAILS_MD_COLUM_FK1 foreign key (COLUMN_ID_FK)
  references KEFU5.MD_COLUMNS (ID) on delete cascade;
alter table KEFU5.MD_INDEX_DETAILS
  add constraint MD_INDEX_DETAILS_MD_INDEX_FK1 foreign key (INDEX_ID_FK)
  references KEFU5.MD_INDEXES (ID) on delete cascade;

prompt
prompt Creating table MD_MIGR_DEPENDENCY
prompt =================================
prompt
create table KEFU5.MD_MIGR_DEPENDENCY
(
  id                 INTEGER not null,
  connection_id_fk   INTEGER not null,
  parent_id          INTEGER not null,
  child_id           INTEGER not null,
  parent_object_type VARCHAR2(4000) not null,
  child_object_type  VARCHAR2(4000) not null,
  security_group_id  INTEGER default 0 not null,
  created_on         DATE default sysdate not null,
  created_by         VARCHAR2(255),
  last_updated_on    DATE,
  last_updated_by    VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.MD_MIGR_DEPENDENCY.connection_id_fk
  is 'The connection that this exists in //PARENTFIELD';
alter table KEFU5.MD_MIGR_DEPENDENCY
  add constraint MIGR_DEPENDENCY_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_MIGR_DEPENDENCY
  add constraint MIGR_DEPENDENCY_FK foreign key (CONNECTION_ID_FK)
  references KEFU5.MD_CONNECTIONS (ID) on delete cascade;

prompt
prompt Creating table MD_MIGR_PARAMETER
prompt ================================
prompt
create table KEFU5.MD_MIGR_PARAMETER
(
  id                INTEGER not null,
  connection_id_fk  INTEGER not null,
  object_id         INTEGER not null,
  object_type       VARCHAR2(4000) not null,
  param_existing    INTEGER not null,
  param_order       INTEGER not null,
  param_name        VARCHAR2(4000) not null,
  param_type        VARCHAR2(4000) not null,
  param_data_type   VARCHAR2(4000) not null,
  percision         INTEGER,
  scale             INTEGER,
  nullable          CHAR(1) not null,
  default_value     VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.MD_MIGR_PARAMETER.connection_id_fk
  is 'the connection in which this belongs //PARENTFIELD';
comment on column KEFU5.MD_MIGR_PARAMETER.param_existing
  is '1 represents a new parameter for PL/SQL that was not present in the origional. 0 represents a n existing parameter that was present in the origional';
comment on column KEFU5.MD_MIGR_PARAMETER.param_order
  is 'IF -1 THEN THIS PARAM IS A RETURN PARAMETER. 1 WILL BE THE FIRST PARAMETER IN THE PARAMETER LIST';
alter table KEFU5.MD_MIGR_PARAMETER
  add constraint MIGR_PARAMETER_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_MIGR_PARAMETER
  add constraint MIGR_PARAMETER_FK foreign key (CONNECTION_ID_FK)
  references KEFU5.MD_CONNECTIONS (ID) on delete cascade;

prompt
prompt Creating table MD_MIGR_WEAKDEP
prompt ==============================
prompt
create table KEFU5.MD_MIGR_WEAKDEP
(
  id                INTEGER not null,
  connection_id_fk  INTEGER not null,
  schema_id_fk      INTEGER not null,
  parent_id         INTEGER not null,
  child_name        VARCHAR2(4000) not null,
  parent_type       VARCHAR2(4000) not null,
  child_type        VARCHAR2(4000) not null,
  security_group_id NUMBER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.MD_MIGR_WEAKDEP.child_name
  is 'name of the child,  as weak dependencies dont have reference to child id';
comment on column KEFU5.MD_MIGR_WEAKDEP.parent_type
  is 'MD_<tablename>';
comment on column KEFU5.MD_MIGR_WEAKDEP.child_type
  is 'Generic Type (not MD_<tablename>)';
alter table KEFU5.MD_MIGR_WEAKDEP
  add constraint MIGR_WEAKDEP_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_MIGR_WEAKDEP
  add constraint MIGR_WEAKDEP_FK1 foreign key (CONNECTION_ID_FK)
  references KEFU5.MD_CONNECTIONS (ID) on delete cascade;
alter table KEFU5.MD_MIGR_WEAKDEP
  add constraint MIGR_WEAKDEP_FK2 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_OTHER_OBJECTS
prompt ===============================
prompt
create table KEFU5.MD_OTHER_OBJECTS
(
  id                INTEGER not null,
  schema_id_fk      INTEGER not null,
  name              VARCHAR2(4000),
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_OTHER_OBJECTS
  is 'For storing objects that don''t belong anywhere else';
comment on column KEFU5.MD_OTHER_OBJECTS.id
  is 'Primary Key';
comment on column KEFU5.MD_OTHER_OBJECTS.schema_id_fk
  is 'Schema to which this object blongs. //PARENTFIELD';
comment on column KEFU5.MD_OTHER_OBJECTS.name
  is 'Name of this object //OBJECTNAME';
comment on column KEFU5.MD_OTHER_OBJECTS.native_sql
  is 'The native SQL used to create this object';
comment on column KEFU5.MD_OTHER_OBJECTS.native_key
  is 'A key that identifies this object at source.';
alter table KEFU5.MD_OTHER_OBJECTS
  add constraint MD_OTHER_OBJECTS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_OTHER_OBJECTS
  add constraint MD_OTHER_OBJECTS_MD_SCHEM_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_PACKAGES
prompt ==========================
prompt
create table KEFU5.MD_PACKAGES
(
  id                INTEGER not null,
  schema_id_fk      INTEGER not null,
  name              VARCHAR2(4000) not null,
  package_header    CLOB,
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  language          VARCHAR2(40) not null,
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_PACKAGES
  is 'For storing packages';
comment on column KEFU5.MD_PACKAGES.id
  is 'Primary Key';
comment on column KEFU5.MD_PACKAGES.schema_id_fk
  is 'the schema in which this package resides //PARENTFIELD';
comment on column KEFU5.MD_PACKAGES.name
  is 'Name of this package //OBJECTNAME';
comment on column KEFU5.MD_PACKAGES.native_sql
  is 'The SQL used to create this package at source';
comment on column KEFU5.MD_PACKAGES.native_key
  is 'A unique identifer for this object at source.';
comment on column KEFU5.MD_PACKAGES.language
  is '//PUBLIC';
alter table KEFU5.MD_PACKAGES
  add constraint MD_PACKAGES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_PACKAGES
  add constraint MD_PACKAGES_MD_SCHEMAS_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_REGISTRY
prompt ==========================
prompt
create table KEFU5.MD_REGISTRY
(
  object_type VARCHAR2(30) not null,
  object_name VARCHAR2(30) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table KEFU5.MD_REGISTRY
  is 'Table to store information on the MD_ repository.  This lists the objects to be dropped if you wish to remove the repository';
alter table KEFU5.MD_REGISTRY
  add constraint MD_REGISTRY_PK primary key (OBJECT_TYPE, OBJECT_NAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MD_REPOVERSIONS
prompt ==============================
prompt
create table KEFU5.MD_REPOVERSIONS
(
  revision INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table KEFU5.MD_REPOVERSIONS
  is 'This table is used to version this schema for future requirements.';

prompt
prompt Creating table MD_SEQUENCES
prompt ===========================
prompt
create table KEFU5.MD_SEQUENCES
(
  id                INTEGER not null,
  schema_id_fk      INTEGER not null,
  name              VARCHAR2(4000) not null,
  seq_start         NUMBER not null,
  incr              NUMBER default 1 not null,
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255) default '0' not null,
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_SEQUENCES
  is 'For storing information on sequences.';
comment on column KEFU5.MD_SEQUENCES.id
  is 'Primary Key';
comment on column KEFU5.MD_SEQUENCES.schema_id_fk
  is 'The schema to which this object belongs. //PARENTFIELD';
comment on column KEFU5.MD_SEQUENCES.name
  is 'Name of this sequence //OBJECTNAME';
comment on column KEFU5.MD_SEQUENCES.seq_start
  is 'Starting point of the sequence';
comment on column KEFU5.MD_SEQUENCES.incr
  is 'Increment value of the sequence';
comment on column KEFU5.MD_SEQUENCES.native_sql
  is 'SQL used to create this object at source';
comment on column KEFU5.MD_SEQUENCES.native_key
  is 'Identifier for this object at source.';
alter table KEFU5.MD_SEQUENCES
  add constraint MD_SEQUENCES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_SEQUENCES
  add constraint MD_SEQUENCES_MD_SCHEMAS_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_STORED_PROGRAMS
prompt =================================
prompt
create table KEFU5.MD_STORED_PROGRAMS
(
  id                INTEGER not null,
  schema_id_fk      INTEGER not null,
  programtype       VARCHAR2(20),
  name              VARCHAR2(4000),
  package_id_fk     INTEGER,
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  language          VARCHAR2(40) not null,
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_STORED_PROGRAMS
  is 'Container for stored programs.';
comment on column KEFU5.MD_STORED_PROGRAMS.id
  is 'Primary Key';
comment on column KEFU5.MD_STORED_PROGRAMS.schema_id_fk
  is 'Schema to which this object belongs.  Note that the PACKAGE_ID_FK (if present also leads us to the relevant schema), however a stored program may or may not belong in a package.  If it is in a package, then the SCHEMA_ID_FK and the SCHEME_ID_FK in the parent package should match //PARENTFIELD';
comment on column KEFU5.MD_STORED_PROGRAMS.programtype
  is 'Java/TSQL/PLSQL, etc.';
comment on column KEFU5.MD_STORED_PROGRAMS.name
  is 'Name of the stored program //OBJECTNAME';
comment on column KEFU5.MD_STORED_PROGRAMS.package_id_fk
  is 'The package to which this object belongs';
comment on column KEFU5.MD_STORED_PROGRAMS.native_sql
  is 'The SQL used to create this object at source';
comment on column KEFU5.MD_STORED_PROGRAMS.native_key
  is 'A unique indetifier for this object at source';
comment on column KEFU5.MD_STORED_PROGRAMS.language
  is '//PUBLIC';
create index KEFU5.MD_STORED_PROGRAS_IDX2 on KEFU5.MD_STORED_PROGRAMS (SCHEMA_ID_FK, UPPER(NAME))
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 166;
create index KEFU5.MD_STORED_PROGS_IDX on KEFU5.MD_STORED_PROGRAMS (ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_STORED_PROGRAMS
  add constraint MD_STORED_PROGRAMS_MD_PAC_FK1 foreign key (PACKAGE_ID_FK)
  references KEFU5.MD_PACKAGES (ID) on delete cascade;
alter table KEFU5.MD_STORED_PROGRAMS
  add constraint MD_STORED_PROGRAMS_MD_SCH_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_SYNONYMS
prompt ==========================
prompt
create table KEFU5.MD_SYNONYMS
(
  id                 INTEGER not null,
  schema_id_fk       INTEGER not null,
  name               VARCHAR2(4000) not null,
  synonym_for_id     INTEGER not null,
  for_object_type    VARCHAR2(4000) not null,
  private_visibility CHAR(1),
  native_sql         CLOB,
  native_key         VARCHAR2(4000),
  comments           VARCHAR2(4000),
  security_group_id  INTEGER default 0 not null,
  created_on         DATE default sysdate not null,
  created_by         VARCHAR2(255),
  last_updated_on    DATE,
  last_updated_by    VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_SYNONYMS
  is 'For storing synonym information.';
comment on column KEFU5.MD_SYNONYMS.id
  is 'Primary Key';
comment on column KEFU5.MD_SYNONYMS.schema_id_fk
  is 'The schema to which this object belongs //PARENTFIELD';
comment on column KEFU5.MD_SYNONYMS.name
  is 'Synonym name //OBJECTNAME';
comment on column KEFU5.MD_SYNONYMS.synonym_for_id
  is 'What object this is a synonym for';
comment on column KEFU5.MD_SYNONYMS.for_object_type
  is 'The type this is a synonym for (e.g. INDEX)';
comment on column KEFU5.MD_SYNONYMS.private_visibility
  is 'Visibility - Private or Public.  If Private_visibility = ''Y'' means this is a private synonym.  Anything else means it is a public synonym';
comment on column KEFU5.MD_SYNONYMS.native_sql
  is 'The SQL used to create this object at source';
comment on column KEFU5.MD_SYNONYMS.native_key
  is 'An identifier for this object at source.';
alter table KEFU5.MD_SYNONYMS
  add constraint MD_SYNONYMS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_SYNONYMS
  add constraint MD_SYNONYMS_MD_SCHEMAS_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_TABLESPACES
prompt =============================
prompt
create table KEFU5.MD_TABLESPACES
(
  id                INTEGER not null,
  schema_id_fk      INTEGER not null,
  tablespace_name   VARCHAR2(4000),
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_TABLESPACES
  is 'For storing information about tablespaces.';
comment on column KEFU5.MD_TABLESPACES.id
  is 'Primary Key';
comment on column KEFU5.MD_TABLESPACES.schema_id_fk
  is 'Schema to which this tablespace belongs //PARENTFIELD';
comment on column KEFU5.MD_TABLESPACES.tablespace_name
  is 'Name of the table space //OBJECTNAME';
comment on column KEFU5.MD_TABLESPACES.native_sql
  is 'The SQL used to create this tablespace';
comment on column KEFU5.MD_TABLESPACES.native_key
  is 'A unique identifier for this object at source';
alter table KEFU5.MD_TABLESPACES
  add constraint MD_TABLESPACES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_TABLESPACES
  add constraint MD_TABLESPACES_MD_SCHEMAS_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_TRIGGERS
prompt ==========================
prompt
create table KEFU5.MD_TRIGGERS
(
  id                  INTEGER not null,
  table_or_view_id_fk INTEGER not null,
  trigger_on_flag     CHAR(1) not null,
  trigger_name        VARCHAR2(4000),
  trigger_timing      VARCHAR2(4000),
  trigger_operation   VARCHAR2(4000),
  trigger_event       VARCHAR2(4000),
  native_sql          CLOB,
  native_key          VARCHAR2(4000),
  language            VARCHAR2(40) not null,
  comments            VARCHAR2(4000),
  security_group_id   INTEGER default 0 not null,
  created_on          DATE default sysdate not null,
  created_by          VARCHAR2(255),
  last_updated_on     DATE,
  last_updated_by     VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_TRIGGERS
  is 'For storing information about triggers.';
comment on column KEFU5.MD_TRIGGERS.id
  is 'Primary Key';
comment on column KEFU5.MD_TRIGGERS.table_or_view_id_fk
  is 'Table on which this trigger fires';
comment on column KEFU5.MD_TRIGGERS.trigger_on_flag
  is 'Flag to show iif the trigger is on a table or a view.  If it is a table this should be ''T''. If it is on a view this should be ''V''';
comment on column KEFU5.MD_TRIGGERS.trigger_name
  is 'Name of the trigger //OBJECTNAME';
comment on column KEFU5.MD_TRIGGERS.trigger_timing
  is 'before, after ,etc.';
comment on column KEFU5.MD_TRIGGERS.trigger_operation
  is 'insert, delete, etc.';
comment on column KEFU5.MD_TRIGGERS.trigger_event
  is 'The actual trigger that gets fired ';
comment on column KEFU5.MD_TRIGGERS.native_sql
  is 'The full definition ';
comment on column KEFU5.MD_TRIGGERS.native_key
  is 'UInique identifer for this object at source';
comment on column KEFU5.MD_TRIGGERS.language
  is '//PUBLIC';
alter table KEFU5.MD_TRIGGERS
  add constraint MD_TRIGGERS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table MD_USER_DEFINED_DATA_TYPES
prompt =========================================
prompt
create table KEFU5.MD_USER_DEFINED_DATA_TYPES
(
  id                INTEGER not null,
  schema_id_fk      INTEGER not null,
  data_type_name    VARCHAR2(4000) not null,
  definition        VARCHAR2(4000) not null,
  native_sql        CLOB not null,
  native_key        VARCHAR2(4000),
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_USER_DEFINED_DATA_TYPES
  is 'For sotring information on user defined data types.';
comment on column KEFU5.MD_USER_DEFINED_DATA_TYPES.id
  is 'Primary Key';
comment on column KEFU5.MD_USER_DEFINED_DATA_TYPES.schema_id_fk
  is 'Schema to which this object blongs. //PARENTFIELD';
comment on column KEFU5.MD_USER_DEFINED_DATA_TYPES.data_type_name
  is 'The name of the data type //OBJECTNAME';
comment on column KEFU5.MD_USER_DEFINED_DATA_TYPES.definition
  is 'The definition of the data type';
comment on column KEFU5.MD_USER_DEFINED_DATA_TYPES.native_sql
  is 'The native SQL used to create this object';
comment on column KEFU5.MD_USER_DEFINED_DATA_TYPES.native_key
  is 'An unique identifier for this object at source.';
alter table KEFU5.MD_USER_DEFINED_DATA_TYPES
  add constraint MD_USER_DEFINED_DATA_TYPES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_USER_DEFINED_DATA_TYPES
  add constraint MD_USER_DEFINED_DATA_TYPE_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MD_USER_PRIVILEGES
prompt =================================
prompt
create table KEFU5.MD_USER_PRIVILEGES
(
  id                INTEGER not null,
  user_id_fk        INTEGER not null,
  privilege_id_fk   INTEGER,
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_udpated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_USER_PRIVILEGES
  is 'This table stores privileges granted to individual users';
comment on column KEFU5.MD_USER_PRIVILEGES.id
  is 'Primary Key';
comment on column KEFU5.MD_USER_PRIVILEGES.user_id_fk
  is 'User';
comment on column KEFU5.MD_USER_PRIVILEGES.privilege_id_fk
  is 'Privilege';
alter table KEFU5.MD_USER_PRIVILEGES
  add constraint MD_USER_PRIVILEGES_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_USER_PRIVILEGES
  add constraint MD_USER_PRIVILEGES_MD_PRI_FK1 foreign key (PRIVILEGE_ID_FK)
  references KEFU5.MD_PRIVILEGES (ID) on delete cascade;
alter table KEFU5.MD_USER_PRIVILEGES
  add constraint MD_USER_PRIVILEGES_MD_USE_FK1 foreign key (USER_ID_FK)
  references KEFU5.MD_USERS (ID) on delete cascade;

prompt
prompt Creating table MD_VIEWS
prompt =======================
prompt
create table KEFU5.MD_VIEWS
(
  id                INTEGER not null,
  schema_id_fk      INTEGER not null,
  view_name         VARCHAR2(4000),
  native_sql        CLOB,
  native_key        VARCHAR2(4000),
  language          VARCHAR2(40) not null,
  comments          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MD_VIEWS
  is 'For storing information on views.';
comment on column KEFU5.MD_VIEWS.id
  is 'Primary Key';
comment on column KEFU5.MD_VIEWS.schema_id_fk
  is 'The schema to which this obect blongs. //PARENTFIELD';
comment on column KEFU5.MD_VIEWS.view_name
  is 'The name of the view //OBJECTNAME';
comment on column KEFU5.MD_VIEWS.native_sql
  is 'The SQL used to create this object at source';
comment on column KEFU5.MD_VIEWS.native_key
  is 'An identifier for this object at source.';
comment on column KEFU5.MD_VIEWS.language
  is '//PUBLIC';
alter table KEFU5.MD_VIEWS
  add constraint MD_VIEWS_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MD_VIEWS
  add constraint MD_VIEWS_MD_SCHEMAS_FK1 foreign key (SCHEMA_ID_FK)
  references KEFU5.MD_SCHEMAS (ID) on delete cascade;

prompt
prompt Creating table MIGRATION_RESERVED_WORDS
prompt =======================================
prompt
create table KEFU5.MIGRATION_RESERVED_WORDS
(
  keyword VARCHAR2(40) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MIGRLOG
prompt ======================
prompt
create table KEFU5.MIGRLOG
(
  id              INTEGER not null,
  parent_log_id   INTEGER,
  log_date        TIMESTAMP(6) not null,
  severity        NUMBER(4) not null,
  logtext         VARCHAR2(4000),
  phase           VARCHAR2(20),
  ref_object_id   INTEGER,
  ref_object_type VARCHAR2(4000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index KEFU5.MIGRLOG_PERF_IDX on KEFU5.MIGRLOG (REF_OBJECT_ID, SEVERITY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MIGRLOG
  add constraint MIGRLOG_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MIGRLOG
  add constraint MIGR_MIGRLOG_FK foreign key (PARENT_LOG_ID)
  references KEFU5.MIGRLOG (ID);

prompt
prompt Creating table MIGR_DATATYPE_TRANSFORM_MAP
prompt ==========================================
prompt
create table KEFU5.MIGR_DATATYPE_TRANSFORM_MAP
(
  id                INTEGER not null,
  project_id_fk     INTEGER not null,
  map_name          VARCHAR2(4000),
  security_group_id INTEGER default 0 not null,
  created_on        DATE default sysdate not null,
  created_by        VARCHAR2(255),
  last_updated_on   DATE,
  last_updated_by   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table KEFU5.MIGR_DATATYPE_TRANSFORM_MAP
  is 'Table for storing data type maps.  A map is simply a collection of rules';
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_MAP.id
  is 'Primary Key';
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_MAP.project_id_fk
  is '//PARENTFIELD';
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_MAP.map_name
  is 'A name for the map';
alter table KEFU5.MIGR_DATATYPE_TRANSFORM_MAP
  add constraint MIGR_DATATYPE_TRANSFORM_M_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MIGR_DATATYPE_TRANSFORM_MAP
  add constraint MIGR_DATATYPE_TRANSFORM_M_FK1 foreign key (PROJECT_ID_FK)
  references KEFU5.MD_PROJECTS (ID) on delete cascade;

prompt
prompt Creating table MIGR_DATATYPE_TRANSFORM_RULE
prompt ===========================================
prompt
create table KEFU5.MIGR_DATATYPE_TRANSFORM_RULE
(
  id                    INTEGER not null,
  map_id_fk             INTEGER not null,
  source_data_type_name VARCHAR2(4000) not null,
  source_precision      NUMBER,
  source_scale          NUMBER,
  target_data_type_name VARCHAR2(4000) not null,
  target_precision      NUMBER,
  target_scale          NUMBER,
  security_group_id     INTEGER default 0 not null,
  created_on            DATE default sysdate not null,
  created_by            VARCHAR2(255),
  last_updated_on       DATE,
  last_updated_by       VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_RULE.id
  is 'Primary Key';
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_RULE.map_id_fk
  is 'The map to which this rule belongs //PARENTFIELD';
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_RULE.source_data_type_name
  is 'Source data type';
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_RULE.source_precision
  is 'Precison to match';
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_RULE.source_scale
  is 'scale to match';
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_RULE.target_data_type_name
  is 'data type name to transform to';
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_RULE.target_precision
  is 'precision to map to ';
comment on column KEFU5.MIGR_DATATYPE_TRANSFORM_RULE.target_scale
  is 'scale to map to';
alter table KEFU5.MIGR_DATATYPE_TRANSFORM_RULE
  add constraint MIGR_DATATYPE_TRANSFORM_R_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MIGR_DATATYPE_TRANSFORM_RULE
  add constraint MIGR_DATATYPE_TRANSFORM_R_FK1 foreign key (MAP_ID_FK)
  references KEFU5.MIGR_DATATYPE_TRANSFORM_MAP (ID) on delete cascade;

prompt
prompt Creating table MIGR_GENERATION_ORDER
prompt ====================================
prompt
create table KEFU5.MIGR_GENERATION_ORDER
(
  id               INTEGER not null,
  connection_id_fk INTEGER not null,
  object_id        INTEGER not null,
  object_type      VARCHAR2(4000) not null,
  generation_order INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.MIGR_GENERATION_ORDER.connection_id_fk
  is '//PARENTFIELD';
alter table KEFU5.MIGR_GENERATION_ORDER
  add constraint MIGR_GENERATION_ORDER_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.MIGR_GENERATION_ORDER
  add constraint MIGR_GENERATION_ORDER_MD__FK1 foreign key (CONNECTION_ID_FK)
  references KEFU5.MD_CONNECTIONS (ID) on delete cascade;

prompt
prompt Creating table UK_AGENTSERVICE
prompt ==============================
prompt
create table KEFU5.UK_AGENTSERVICE
(
  id                VARCHAR2(32 CHAR) not null,
  username          VARCHAR2(100 CHAR),
  agentno           VARCHAR2(100 CHAR),
  userid            VARCHAR2(100 CHAR),
  channel           VARCHAR2(100 CHAR),
  logindate         DATE,
  source            VARCHAR2(100 CHAR),
  endtime           DATE,
  nickname          VARCHAR2(100 CHAR),
  city              VARCHAR2(100 CHAR),
  province          VARCHAR2(100 CHAR),
  country           VARCHAR2(100 CHAR),
  headimgurl        VARCHAR2(255 CHAR),
  waittingtime      NUMBER(10) default '0',
  tokenum           NUMBER(10) default '0',
  createtime        DATE,
  updatetime        DATE,
  status            VARCHAR2(100 CHAR),
  appid             VARCHAR2(100 CHAR),
  sessiontype       VARCHAR2(100 CHAR),
  contextid         VARCHAR2(100 CHAR),
  agentserviceid    VARCHAR2(100 CHAR),
  orgi              VARCHAR2(100 CHAR),
  snsuser           VARCHAR2(100 CHAR),
  lastmessage       DATE,
  waittingtimestart DATE,
  lastgetmessage    DATE,
  lastmsg           VARCHAR2(100 CHAR),
  agentskill        VARCHAR2(100 CHAR),
  create_time       DATE,
  creater           VARCHAR2(255 CHAR),
  update_time       DATE,
  update_user       VARCHAR2(255 CHAR),
  assignedto        VARCHAR2(255 CHAR),
  wfstatus          VARCHAR2(255 CHAR),
  shares            VARCHAR2(255 CHAR),
  owner             VARCHAR2(255 CHAR),
  datadept          VARCHAR2(255 CHAR),
  intime            NUMBER(10),
  batid             VARCHAR2(32 CHAR),
  ipaddr            VARCHAR2(50 CHAR),
  osname            VARCHAR2(100 CHAR),
  browser           VARCHAR2(100 CHAR),
  sessiontimes      NUMBER(10),
  servicetime       DATE,
  region            VARCHAR2(255 CHAR),
  agentusername     VARCHAR2(32 CHAR),
  times             NUMBER(10),
  dataid            VARCHAR2(32 CHAR),
  contactsid        VARCHAR2(32 CHAR),
  createdate        VARCHAR2(32 CHAR),
  name              VARCHAR2(100 CHAR),
  email             VARCHAR2(100 CHAR),
  phone             VARCHAR2(100 CHAR),
  resion            VARCHAR2(255 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_AGENTSERVICE.id
  is '主键ID';
comment on column KEFU5.UK_AGENTSERVICE.username
  is '创建人用户名';
comment on column KEFU5.UK_AGENTSERVICE.agentno
  is '坐席ID';
comment on column KEFU5.UK_AGENTSERVICE.userid
  is '用户ID';
comment on column KEFU5.UK_AGENTSERVICE.channel
  is '渠道';
comment on column KEFU5.UK_AGENTSERVICE.logindate
  is '登录时间';
comment on column KEFU5.UK_AGENTSERVICE.source
  is '来源';
comment on column KEFU5.UK_AGENTSERVICE.endtime
  is '结束时间';
comment on column KEFU5.UK_AGENTSERVICE.nickname
  is '昵称';
comment on column KEFU5.UK_AGENTSERVICE.city
  is '城市';
comment on column KEFU5.UK_AGENTSERVICE.province
  is '省份';
comment on column KEFU5.UK_AGENTSERVICE.country
  is '国家';
comment on column KEFU5.UK_AGENTSERVICE.headimgurl
  is '头像URL';
comment on column KEFU5.UK_AGENTSERVICE.waittingtime
  is '等待时间';
comment on column KEFU5.UK_AGENTSERVICE.tokenum
  is '未回复消息数量';
comment on column KEFU5.UK_AGENTSERVICE.createtime
  is '创建时间';
comment on column KEFU5.UK_AGENTSERVICE.updatetime
  is '更新时间';
comment on column KEFU5.UK_AGENTSERVICE.status
  is '状态';
comment on column KEFU5.UK_AGENTSERVICE.appid
  is 'SNSID';
comment on column KEFU5.UK_AGENTSERVICE.sessiontype
  is '会话类型';
comment on column KEFU5.UK_AGENTSERVICE.contextid
  is '会话ID';
comment on column KEFU5.UK_AGENTSERVICE.agentserviceid
  is '服务记录ID';
comment on column KEFU5.UK_AGENTSERVICE.orgi
  is '租户ID';
comment on column KEFU5.UK_AGENTSERVICE.snsuser
  is '用户ID（微信）';
comment on column KEFU5.UK_AGENTSERVICE.lastmessage
  is '最后一条消息时间';
comment on column KEFU5.UK_AGENTSERVICE.waittingtimestart
  is '进入排队时间';
comment on column KEFU5.UK_AGENTSERVICE.lastgetmessage
  is '坐席最后一条消息时间';
comment on column KEFU5.UK_AGENTSERVICE.lastmsg
  is '最后一条消息内容';
comment on column KEFU5.UK_AGENTSERVICE.agentskill
  is '技能组';
comment on column KEFU5.UK_AGENTSERVICE.create_time
  is '创建时间';
comment on column KEFU5.UK_AGENTSERVICE.creater
  is '创建人';
comment on column KEFU5.UK_AGENTSERVICE.update_time
  is '修改时间';
comment on column KEFU5.UK_AGENTSERVICE.update_user
  is '修改人';
comment on column KEFU5.UK_AGENTSERVICE.assignedto
  is '分配目标用户';
comment on column KEFU5.UK_AGENTSERVICE.wfstatus
  is '流程状态';
comment on column KEFU5.UK_AGENTSERVICE.shares
  is '分享给';
comment on column KEFU5.UK_AGENTSERVICE.owner
  is '所属人';
comment on column KEFU5.UK_AGENTSERVICE.datadept
  is '创建人部门';
comment on column KEFU5.UK_AGENTSERVICE.intime
  is '接入时间';
comment on column KEFU5.UK_AGENTSERVICE.batid
  is '批次ID';
comment on column KEFU5.UK_AGENTSERVICE.ipaddr
  is 'IP地址';
comment on column KEFU5.UK_AGENTSERVICE.osname
  is '操作系统名称';
comment on column KEFU5.UK_AGENTSERVICE.browser
  is '浏览器';
comment on column KEFU5.UK_AGENTSERVICE.sessiontimes
  is '会话时长';
comment on column KEFU5.UK_AGENTSERVICE.servicetime
  is '服务时长';
comment on column KEFU5.UK_AGENTSERVICE.region
  is '区域';
comment on column KEFU5.UK_AGENTSERVICE.agentusername
  is '坐席用户名';
comment on column KEFU5.UK_AGENTSERVICE.times
  is '消息数量';
comment on column KEFU5.UK_AGENTSERVICE.dataid
  is '数据ID';
comment on column KEFU5.UK_AGENTSERVICE.contactsid
  is '联系人ID';
comment on column KEFU5.UK_AGENTSERVICE.createdate
  is '消息到达时间';
comment on column KEFU5.UK_AGENTSERVICE.name
  is '访客填写的姓名';
comment on column KEFU5.UK_AGENTSERVICE.email
  is '访客填写的邮件地址';
comment on column KEFU5.UK_AGENTSERVICE.phone
  is '访客填写的电话号码';
comment on column KEFU5.UK_AGENTSERVICE.resion
  is '访客填写的来访原因';
alter table KEFU5.UK_AGENTSERVICE
  add constraint PRIMARY primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_AGENTSTATUS
prompt =============================
prompt
create table KEFU5.UK_AGENTSTATUS
(
  id             VARCHAR2(32 CHAR) not null,
  agentno        VARCHAR2(100 CHAR),
  logindate      DATE,
  status         VARCHAR2(100 CHAR),
  orgi           VARCHAR2(100 CHAR),
  agentserviceid VARCHAR2(100 CHAR),
  serusernum     NUMBER(10) default '0',
  skill          VARCHAR2(100 CHAR),
  skillname      VARCHAR2(100 CHAR),
  users          NUMBER(10) default '0',
  maxusers       NUMBER(10) default '0',
  username       VARCHAR2(100 CHAR),
  name           VARCHAR2(100 CHAR),
  updatetime     DATE,
  userid         VARCHAR2(100 CHAR),
  createtime     DATE,
  creater        VARCHAR2(255 CHAR),
  update_time    DATE,
  update_user    VARCHAR2(255 CHAR),
  assignedto     VARCHAR2(255 CHAR),
  wfstatus       VARCHAR2(255 CHAR),
  shares         VARCHAR2(255 CHAR),
  owner          VARCHAR2(255 CHAR),
  datadept       VARCHAR2(255 CHAR),
  batid          VARCHAR2(32 CHAR),
  pulluser       NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_AGENTSTATUS.id
  is '主键ID';
comment on column KEFU5.UK_AGENTSTATUS.agentno
  is '坐席ID';
comment on column KEFU5.UK_AGENTSTATUS.logindate
  is '登录时间';
comment on column KEFU5.UK_AGENTSTATUS.status
  is '状态';
comment on column KEFU5.UK_AGENTSTATUS.orgi
  is '租户ID';
comment on column KEFU5.UK_AGENTSTATUS.agentserviceid
  is '服务ID';
comment on column KEFU5.UK_AGENTSTATUS.serusernum
  is '服务用户数';
comment on column KEFU5.UK_AGENTSTATUS.skill
  is '技能组';
comment on column KEFU5.UK_AGENTSTATUS.skillname
  is '技能组名称';
comment on column KEFU5.UK_AGENTSTATUS.users
  is '接入用户数';
comment on column KEFU5.UK_AGENTSTATUS.maxusers
  is '最大接入用户数';
comment on column KEFU5.UK_AGENTSTATUS.username
  is '用户名';
comment on column KEFU5.UK_AGENTSTATUS.name
  is '名称';
comment on column KEFU5.UK_AGENTSTATUS.updatetime
  is '更新时间';
comment on column KEFU5.UK_AGENTSTATUS.userid
  is '用户ID';
comment on column KEFU5.UK_AGENTSTATUS.createtime
  is '创建时间';
comment on column KEFU5.UK_AGENTSTATUS.creater
  is '创建人';
comment on column KEFU5.UK_AGENTSTATUS.update_time
  is '修改时间';
comment on column KEFU5.UK_AGENTSTATUS.update_user
  is '修改人';
comment on column KEFU5.UK_AGENTSTATUS.assignedto
  is '分配目标用户';
comment on column KEFU5.UK_AGENTSTATUS.wfstatus
  is '流程状态';
comment on column KEFU5.UK_AGENTSTATUS.shares
  is '分享给';
comment on column KEFU5.UK_AGENTSTATUS.owner
  is '所属人';
comment on column KEFU5.UK_AGENTSTATUS.datadept
  is '创建人部门';
comment on column KEFU5.UK_AGENTSTATUS.batid
  is '批次ID';
comment on column KEFU5.UK_AGENTSTATUS.pulluser
  is '是否允许拉取用户';

prompt
prompt Creating table UK_AGENTUSER
prompt ===========================
prompt
create table KEFU5.UK_AGENTUSER
(
  id                VARCHAR2(32 CHAR) not null,
  username          VARCHAR2(100 CHAR),
  agentno           VARCHAR2(100 CHAR),
  userid            VARCHAR2(100 CHAR),
  channel           VARCHAR2(100 CHAR),
  logindate         DATE,
  source            VARCHAR2(100 CHAR),
  endtime           DATE,
  nickname          VARCHAR2(100 CHAR),
  city              VARCHAR2(100 CHAR),
  province          VARCHAR2(100 CHAR),
  country           VARCHAR2(100 CHAR),
  headimgurl        VARCHAR2(255 CHAR),
  waittingtime      NUMBER(10) default '0',
  tokenum           NUMBER(10) default '0',
  createtime        DATE,
  updatetime        DATE,
  status            VARCHAR2(100 CHAR),
  appid             VARCHAR2(100 CHAR),
  sessiontype       VARCHAR2(100 CHAR),
  contextid         VARCHAR2(100 CHAR),
  agentserviceid    VARCHAR2(100 CHAR),
  orgi              VARCHAR2(100 CHAR),
  snsuser           VARCHAR2(100 CHAR),
  lastmessage       DATE,
  waittingtimestart DATE,
  lastgetmessage    DATE,
  lastmsg           VARCHAR2(100 CHAR),
  agentskill        VARCHAR2(100 CHAR),
  create_time       DATE,
  creater           VARCHAR2(255 CHAR),
  update_time       DATE,
  update_user       VARCHAR2(255 CHAR),
  assignedto        VARCHAR2(255 CHAR),
  wfstatus          VARCHAR2(255 CHAR),
  shares            VARCHAR2(255 CHAR),
  owner             VARCHAR2(255 CHAR),
  datadept          VARCHAR2(255 CHAR),
  intime            NUMBER(10),
  batid             VARCHAR2(32 CHAR),
  ipaddr            VARCHAR2(50 CHAR),
  osname            VARCHAR2(100 CHAR),
  browser           VARCHAR2(100 CHAR),
  sessiontimes      NUMBER(10),
  servicetime       DATE,
  region            VARCHAR2(255 CHAR),
  agentservice      VARCHAR2(32 CHAR),
  warnings          VARCHAR2(11 CHAR),
  warningtime       DATE,
  reptime           DATE,
  reptimes          VARCHAR2(10 CHAR),
  skill             VARCHAR2(32 CHAR),
  agent             VARCHAR2(32 CHAR),
  name              VARCHAR2(100 CHAR),
  phone             VARCHAR2(100 CHAR),
  email             VARCHAR2(100 CHAR),
  resion            VARCHAR2(255 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_AGENTUSER.id
  is '主键ID';
comment on column KEFU5.UK_AGENTUSER.username
  is '用户名';
comment on column KEFU5.UK_AGENTUSER.agentno
  is '坐席ID';
comment on column KEFU5.UK_AGENTUSER.userid
  is '用户ID';
comment on column KEFU5.UK_AGENTUSER.channel
  is '渠道';
comment on column KEFU5.UK_AGENTUSER.logindate
  is '登录时间';
comment on column KEFU5.UK_AGENTUSER.source
  is '来源';
comment on column KEFU5.UK_AGENTUSER.endtime
  is '结束时间';
comment on column KEFU5.UK_AGENTUSER.nickname
  is '昵称';
comment on column KEFU5.UK_AGENTUSER.city
  is '城市';
comment on column KEFU5.UK_AGENTUSER.province
  is '省份';
comment on column KEFU5.UK_AGENTUSER.country
  is '国家';
comment on column KEFU5.UK_AGENTUSER.headimgurl
  is '头像URL';
comment on column KEFU5.UK_AGENTUSER.waittingtime
  is '等待时长';
comment on column KEFU5.UK_AGENTUSER.tokenum
  is '接入次数';
comment on column KEFU5.UK_AGENTUSER.createtime
  is '创建时间';
comment on column KEFU5.UK_AGENTUSER.updatetime
  is '更新时间';
comment on column KEFU5.UK_AGENTUSER.status
  is '状态';
comment on column KEFU5.UK_AGENTUSER.appid
  is 'SNSID';
comment on column KEFU5.UK_AGENTUSER.sessiontype
  is '会话类型';
comment on column KEFU5.UK_AGENTUSER.contextid
  is '会话ID';
comment on column KEFU5.UK_AGENTUSER.agentserviceid
  is '服务记录ID';
comment on column KEFU5.UK_AGENTUSER.orgi
  is '租户ID';
comment on column KEFU5.UK_AGENTUSER.snsuser
  is 'SNS用户ID';
comment on column KEFU5.UK_AGENTUSER.lastmessage
  is '最后一条消息时间';
comment on column KEFU5.UK_AGENTUSER.waittingtimestart
  is '进入队列时间';
comment on column KEFU5.UK_AGENTUSER.lastgetmessage
  is '最后一条消息时间';
comment on column KEFU5.UK_AGENTUSER.lastmsg
  is '最后一条消息';
comment on column KEFU5.UK_AGENTUSER.agentskill
  is '技能组';
comment on column KEFU5.UK_AGENTUSER.create_time
  is '创建时间';
comment on column KEFU5.UK_AGENTUSER.creater
  is '创建人';
comment on column KEFU5.UK_AGENTUSER.update_time
  is '修改时间';
comment on column KEFU5.UK_AGENTUSER.update_user
  is '修改人';
comment on column KEFU5.UK_AGENTUSER.assignedto
  is '分配目标用户';
comment on column KEFU5.UK_AGENTUSER.wfstatus
  is '流程状态';
comment on column KEFU5.UK_AGENTUSER.shares
  is '分享给';
comment on column KEFU5.UK_AGENTUSER.owner
  is '所属人';
comment on column KEFU5.UK_AGENTUSER.datadept
  is '创建人部门';
comment on column KEFU5.UK_AGENTUSER.intime
  is '接入时间';
comment on column KEFU5.UK_AGENTUSER.batid
  is '批次ID';
comment on column KEFU5.UK_AGENTUSER.ipaddr
  is 'IP地址';
comment on column KEFU5.UK_AGENTUSER.osname
  is '操作系统名称';
comment on column KEFU5.UK_AGENTUSER.browser
  is '浏览器';
comment on column KEFU5.UK_AGENTUSER.sessiontimes
  is '会话时长';
comment on column KEFU5.UK_AGENTUSER.servicetime
  is '服务次数';
comment on column KEFU5.UK_AGENTUSER.region
  is '地区';
comment on column KEFU5.UK_AGENTUSER.agentservice
  is '服务ID';
comment on column KEFU5.UK_AGENTUSER.warnings
  is '提醒次数';
comment on column KEFU5.UK_AGENTUSER.warningtime
  is '提醒时间';
comment on column KEFU5.UK_AGENTUSER.reptime
  is '坐席最后一次回复时间';
comment on column KEFU5.UK_AGENTUSER.reptimes
  is '坐席回复次数';
comment on column KEFU5.UK_AGENTUSER.skill
  is '技能组';
comment on column KEFU5.UK_AGENTUSER.agent
  is '坐席ID';
comment on column KEFU5.UK_AGENTUSER.name
  is '用户录入的姓名';
comment on column KEFU5.UK_AGENTUSER.phone
  is '访客录入的电话';
comment on column KEFU5.UK_AGENTUSER.email
  is '访客录入的邮件';
comment on column KEFU5.UK_AGENTUSER.resion
  is '访客录入的来访原因';
alter table KEFU5.UK_AGENTUSER
  add constraint PRIMARY_1 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_AGENTUSER_CONTACTS
prompt ====================================
prompt
create table KEFU5.UK_AGENTUSER_CONTACTS
(
  id         VARCHAR2(32 CHAR) not null,
  orgi       VARCHAR2(32 CHAR),
  appid      VARCHAR2(32 CHAR),
  channel    VARCHAR2(32 CHAR),
  userid     VARCHAR2(32 CHAR),
  contactsid VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_AGENTUSER_CONTACTS.id
  is '主键ID';
comment on column KEFU5.UK_AGENTUSER_CONTACTS.orgi
  is '租户ID';
comment on column KEFU5.UK_AGENTUSER_CONTACTS.appid
  is 'SNSID';
comment on column KEFU5.UK_AGENTUSER_CONTACTS.channel
  is '渠道';
comment on column KEFU5.UK_AGENTUSER_CONTACTS.userid
  is '用户ID';
comment on column KEFU5.UK_AGENTUSER_CONTACTS.contactsid
  is '联系人ID';
comment on column KEFU5.UK_AGENTUSER_CONTACTS.username
  is '创建人用户名';
comment on column KEFU5.UK_AGENTUSER_CONTACTS.creater
  is '创建人ID';
comment on column KEFU5.UK_AGENTUSER_CONTACTS.createtime
  is '创建时间';
alter table KEFU5.UK_AGENTUSER_CONTACTS
  add constraint PRIMARY_2 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_ATTACHMENT_FILE
prompt =================================
prompt
create table KEFU5.UK_ATTACHMENT_FILE
(
  id         VARCHAR2(32 CHAR) not null,
  orgi       VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  organ      VARCHAR2(32 CHAR),
  datastatus NUMBER(3),
  title      VARCHAR2(255 CHAR),
  url        VARCHAR2(255 CHAR),
  updatetime DATE,
  filelength NUMBER(10),
  filetype   VARCHAR2(255 CHAR),
  image      NUMBER(3),
  dataid     VARCHAR2(32 CHAR),
  model      VARCHAR2(32 CHAR),
  fileid     VARCHAR2(32 CHAR),
  modelid    VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_ATTACHMENT_FILE.id
  is '主键ID';
comment on column KEFU5.UK_ATTACHMENT_FILE.orgi
  is '租户ID';
comment on column KEFU5.UK_ATTACHMENT_FILE.creater
  is '创建人ID';
comment on column KEFU5.UK_ATTACHMENT_FILE.createtime
  is '创建时间';
comment on column KEFU5.UK_ATTACHMENT_FILE.organ
  is '组织机构ID';
comment on column KEFU5.UK_ATTACHMENT_FILE.datastatus
  is '数据状态（逻辑删除）';
comment on column KEFU5.UK_ATTACHMENT_FILE.title
  is '标题';
comment on column KEFU5.UK_ATTACHMENT_FILE.url
  is '地址';
comment on column KEFU5.UK_ATTACHMENT_FILE.updatetime
  is '更新时间';
comment on column KEFU5.UK_ATTACHMENT_FILE.filelength
  is '文件长度';
comment on column KEFU5.UK_ATTACHMENT_FILE.filetype
  is '文件类型';
comment on column KEFU5.UK_ATTACHMENT_FILE.image
  is '是否图片';
comment on column KEFU5.UK_ATTACHMENT_FILE.dataid
  is '数据ID';
comment on column KEFU5.UK_ATTACHMENT_FILE.model
  is '所属功能模块';
comment on column KEFU5.UK_ATTACHMENT_FILE.fileid
  is '文件ID';
comment on column KEFU5.UK_ATTACHMENT_FILE.modelid
  is '所属模块数据ID';
alter table KEFU5.UK_ATTACHMENT_FILE
  add constraint PRIMARY_3 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_BLACKLIST
prompt ===========================
prompt
create table KEFU5.UK_BLACKLIST
(
  id             VARCHAR2(32 CHAR) not null,
  orgi           VARCHAR2(32 CHAR),
  userid         VARCHAR2(32 CHAR),
  contactid      VARCHAR2(32 CHAR),
  sessionid      VARCHAR2(32 CHAR),
  createtime     DATE,
  channel        VARCHAR2(20 CHAR),
  creater        VARCHAR2(32 CHAR),
  agentid        VARCHAR2(32 CHAR),
  phone          VARCHAR2(20 CHAR),
  openid         VARCHAR2(100 CHAR),
  description    CLOB,
  agentserviceid VARCHAR2(32 CHAR),
  times          NUMBER(10),
  chattime       NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_BLACKLIST.id
  is '主键ID';
comment on column KEFU5.UK_BLACKLIST.orgi
  is '租户ID';
comment on column KEFU5.UK_BLACKLIST.userid
  is '用户ID';
comment on column KEFU5.UK_BLACKLIST.contactid
  is '联系人ID';
comment on column KEFU5.UK_BLACKLIST.sessionid
  is '会话ID';
comment on column KEFU5.UK_BLACKLIST.createtime
  is '创建时间';
comment on column KEFU5.UK_BLACKLIST.channel
  is '渠道';
comment on column KEFU5.UK_BLACKLIST.creater
  is '创家人';
comment on column KEFU5.UK_BLACKLIST.agentid
  is '坐席ID';
comment on column KEFU5.UK_BLACKLIST.phone
  is '电话号码';
comment on column KEFU5.UK_BLACKLIST.openid
  is '微信号';
comment on column KEFU5.UK_BLACKLIST.description
  is '描述';
comment on column KEFU5.UK_BLACKLIST.agentserviceid
  is '坐席服务ID';
comment on column KEFU5.UK_BLACKLIST.times
  is '次数';
comment on column KEFU5.UK_BLACKLIST.chattime
  is '对话次数';
alter table KEFU5.UK_BLACKLIST
  add constraint PRIMARY_4 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_BPM_PROCESS
prompt =============================
prompt
create table KEFU5.UK_BPM_PROCESS
(
  id          VARCHAR2(32 CHAR) not null,
  name        VARCHAR2(50 CHAR),
  code        VARCHAR2(50 CHAR),
  createtime  DATE,
  creater     VARCHAR2(32 CHAR),
  updatetime  DATE,
  orgi        VARCHAR2(32 CHAR),
  username    VARCHAR2(50 CHAR),
  content     CLOB,
  status      VARCHAR2(20 CHAR),
  title       VARCHAR2(50 CHAR),
  published   NUMBER(3),
  processid   VARCHAR2(50 CHAR),
  processtype VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_BPM_PROCESS.id
  is '主键ID';
comment on column KEFU5.UK_BPM_PROCESS.name
  is '名称';
comment on column KEFU5.UK_BPM_PROCESS.code
  is '代码';
comment on column KEFU5.UK_BPM_PROCESS.createtime
  is '创建时间';
comment on column KEFU5.UK_BPM_PROCESS.creater
  is '创建人';
comment on column KEFU5.UK_BPM_PROCESS.updatetime
  is '更新时间';
comment on column KEFU5.UK_BPM_PROCESS.orgi
  is '租户ID';
comment on column KEFU5.UK_BPM_PROCESS.username
  is '用户名';
comment on column KEFU5.UK_BPM_PROCESS.content
  is '流程文本内容';
comment on column KEFU5.UK_BPM_PROCESS.status
  is '流程状态';
comment on column KEFU5.UK_BPM_PROCESS.title
  is '流程标题';
comment on column KEFU5.UK_BPM_PROCESS.published
  is '流程发布状态';
comment on column KEFU5.UK_BPM_PROCESS.processid
  is '流程ID';
comment on column KEFU5.UK_BPM_PROCESS.processtype
  is '流程类型';
alter table KEFU5.UK_BPM_PROCESS
  add constraint PRIMARY_5 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CALLCENTER_ACL
prompt ================================
prompt
create table KEFU5.UK_CALLCENTER_ACL
(
  id           VARCHAR2(32 CHAR) not null,
  creater      VARCHAR2(32 CHAR),
  createtime   DATE,
  updatetime   DATE,
  name         VARCHAR2(100 CHAR),
  orgi         VARCHAR2(100 CHAR),
  hostid       VARCHAR2(32 CHAR),
  type         VARCHAR2(32 CHAR),
  strategy     CLOB,
  defaultvalue VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_CALLCENTER_ACL.id
  is '主键ID';
comment on column KEFU5.UK_CALLCENTER_ACL.creater
  is '创建人';
comment on column KEFU5.UK_CALLCENTER_ACL.createtime
  is '创建时间';
comment on column KEFU5.UK_CALLCENTER_ACL.updatetime
  is '更新时间';
comment on column KEFU5.UK_CALLCENTER_ACL.name
  is '名称';
comment on column KEFU5.UK_CALLCENTER_ACL.orgi
  is '租户ID';
comment on column KEFU5.UK_CALLCENTER_ACL.hostid
  is 'PBX服务器ID';
comment on column KEFU5.UK_CALLCENTER_ACL.type
  is '类型';
comment on column KEFU5.UK_CALLCENTER_ACL.strategy
  is '策略内容';
comment on column KEFU5.UK_CALLCENTER_ACL.defaultvalue
  is '默认值';
alter table KEFU5.UK_CALLCENTER_ACL
  add constraint PRIMARY_6 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CALLCENTER_EVENT
prompt ==================================
prompt
create table KEFU5.UK_CALLCENTER_EVENT
(
  id             VARCHAR2(100 CHAR) not null,
  name           VARCHAR2(50 CHAR),
  code           VARCHAR2(50 CHAR),
  createtime     DATE,
  creater        VARCHAR2(32 CHAR),
  updatetime     DATE,
  orgi           VARCHAR2(32 CHAR),
  username       VARCHAR2(50 CHAR),
  source         VARCHAR2(50 CHAR),
  answer         VARCHAR2(50 CHAR),
  current_bak    NUMBER(3),
  init           NUMBER(3),
  caller         VARCHAR2(50 CHAR),
  calling        VARCHAR2(50 CHAR),
  called         VARCHAR2(50 CHAR),
  agentype       VARCHAR2(50 CHAR),
  quene          VARCHAR2(50 CHAR),
  ani            VARCHAR2(50 CHAR),
  touser         VARCHAR2(50 CHAR),
  direction      VARCHAR2(50 CHAR),
  state          VARCHAR2(50 CHAR),
  agent          VARCHAR2(50 CHAR),
  action         VARCHAR2(50 CHAR),
  host           VARCHAR2(50 CHAR),
  ipaddr         VARCHAR2(50 CHAR),
  localdatetime  VARCHAR2(50 CHAR),
  status         VARCHAR2(50 CHAR),
  time           FLOAT,
  starttime      DATE,
  endtime        DATE,
  duration       NUMBER(10),
  inside         NUMBER(3),
  misscall       NUMBER(3),
  record         NUMBER(3),
  recordtime     NUMBER(10),
  startrecord    DATE,
  endrecord      DATE,
  answertime     DATE,
  ringduration   NUMBER(10),
  servicesummary NUMBER(3),
  serviceid      VARCHAR2(32 CHAR),
  recordfile     VARCHAR2(255 CHAR),
  callback       NUMBER(3),
  ccquene        VARCHAR2(50 CHAR),
  servicestatus  VARCHAR2(20 CHAR),
  channelstatus  VARCHAR2(50 CHAR),
  country        VARCHAR2(50 CHAR),
  province       VARCHAR2(50 CHAR),
  city           VARCHAR2(50 CHAR),
  isp            VARCHAR2(50 CHAR),
  voicecalled    VARCHAR2(50 CHAR),
  contactsid     VARCHAR2(32 CHAR),
  extention      VARCHAR2(32 CHAR),
  hostid         VARCHAR2(32 CHAR),
  calltype       VARCHAR2(20 CHAR),
  calldir        VARCHAR2(30 CHAR),
  otherdir       VARCHAR2(30 CHAR),
  otherlegdest   VARCHAR2(50 CHAR),
  bridgeid       VARCHAR2(100 CHAR),
  bridge         NUMBER(3),
  recordfilename VARCHAR2(100 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_CALLCENTER_EVENT.id
  is '主键ID';
comment on column KEFU5.UK_CALLCENTER_EVENT.name
  is '名称';
comment on column KEFU5.UK_CALLCENTER_EVENT.code
  is '代码';
comment on column KEFU5.UK_CALLCENTER_EVENT.createtime
  is '创建时间';
comment on column KEFU5.UK_CALLCENTER_EVENT.creater
  is '创建人';
comment on column KEFU5.UK_CALLCENTER_EVENT.updatetime
  is '更新时间';
comment on column KEFU5.UK_CALLCENTER_EVENT.orgi
  is '租户ID';
comment on column KEFU5.UK_CALLCENTER_EVENT.username
  is '用户名';
comment on column KEFU5.UK_CALLCENTER_EVENT.source
  is '来源';
comment on column KEFU5.UK_CALLCENTER_EVENT.answer
  is '应答时间';
comment on column KEFU5.UK_CALLCENTER_EVENT.current_bak
  is '当前通话';
comment on column KEFU5.UK_CALLCENTER_EVENT.init
  is '初始通话';
comment on column KEFU5.UK_CALLCENTER_EVENT.caller
  is '呼叫发起号码';
comment on column KEFU5.UK_CALLCENTER_EVENT.calling
  is '呼叫对象';
comment on column KEFU5.UK_CALLCENTER_EVENT.called
  is '被叫号码';
comment on column KEFU5.UK_CALLCENTER_EVENT.agentype
  is '坐席类型';
comment on column KEFU5.UK_CALLCENTER_EVENT.quene
  is '队列名称';
comment on column KEFU5.UK_CALLCENTER_EVENT.ani
  is '主叫号码';
comment on column KEFU5.UK_CALLCENTER_EVENT.touser
  is '目标用户';
comment on column KEFU5.UK_CALLCENTER_EVENT.direction
  is '呼叫方向';
comment on column KEFU5.UK_CALLCENTER_EVENT.state
  is '状态';
comment on column KEFU5.UK_CALLCENTER_EVENT.agent
  is '坐席工号';
comment on column KEFU5.UK_CALLCENTER_EVENT.action
  is '事件动作';
comment on column KEFU5.UK_CALLCENTER_EVENT.host
  is '时间主机';
comment on column KEFU5.UK_CALLCENTER_EVENT.ipaddr
  is '主机IP';
comment on column KEFU5.UK_CALLCENTER_EVENT.localdatetime
  is '时间发起时间';
comment on column KEFU5.UK_CALLCENTER_EVENT.status
  is '状态代码';
comment on column KEFU5.UK_CALLCENTER_EVENT.time
  is '时间秒值';
comment on column KEFU5.UK_CALLCENTER_EVENT.starttime
  is '通话开始时间';
comment on column KEFU5.UK_CALLCENTER_EVENT.endtime
  is '通话结束时间';
comment on column KEFU5.UK_CALLCENTER_EVENT.duration
  is '通话时长';
comment on column KEFU5.UK_CALLCENTER_EVENT.inside
  is '内线';
comment on column KEFU5.UK_CALLCENTER_EVENT.misscall
  is '是否漏话';
comment on column KEFU5.UK_CALLCENTER_EVENT.record
  is '是否录音';
comment on column KEFU5.UK_CALLCENTER_EVENT.recordtime
  is '录音时长';
comment on column KEFU5.UK_CALLCENTER_EVENT.startrecord
  is '开始录音时间';
comment on column KEFU5.UK_CALLCENTER_EVENT.endrecord
  is '结束录音时间';
comment on column KEFU5.UK_CALLCENTER_EVENT.answertime
  is '应答时间';
comment on column KEFU5.UK_CALLCENTER_EVENT.ringduration
  is '振铃时长';
comment on column KEFU5.UK_CALLCENTER_EVENT.servicesummary
  is '是否记录服务小结';
comment on column KEFU5.UK_CALLCENTER_EVENT.serviceid
  is '服务记录ID';
comment on column KEFU5.UK_CALLCENTER_EVENT.recordfile
  is '录音文件名';
comment on column KEFU5.UK_CALLCENTER_EVENT.callback
  is '回呼';
comment on column KEFU5.UK_CALLCENTER_EVENT.ccquene
  is '转接队列';
comment on column KEFU5.UK_CALLCENTER_EVENT.servicestatus
  is '当前呼叫状态';
comment on column KEFU5.UK_CALLCENTER_EVENT.channelstatus
  is '事件中的呼叫状态';
comment on column KEFU5.UK_CALLCENTER_EVENT.country
  is '来电国家';
comment on column KEFU5.UK_CALLCENTER_EVENT.province
  is '来电号码归属省份';
comment on column KEFU5.UK_CALLCENTER_EVENT.city
  is '来电归属号码城市';
comment on column KEFU5.UK_CALLCENTER_EVENT.isp
  is '来电号码运营商';
comment on column KEFU5.UK_CALLCENTER_EVENT.contactsid
  is '联系人ID';
comment on column KEFU5.UK_CALLCENTER_EVENT.extention
  is '分机ID';
comment on column KEFU5.UK_CALLCENTER_EVENT.hostid
  is 'PBX服务器ID';
comment on column KEFU5.UK_CALLCENTER_EVENT.calltype
  is '呼叫方向类型|计费类型';
comment on column KEFU5.UK_CALLCENTER_EVENT.otherdir
  is '对边呼叫方向';
comment on column KEFU5.UK_CALLCENTER_EVENT.bridgeid
  is '桥接ID';
comment on column KEFU5.UK_CALLCENTER_EVENT.bridge
  is '是否有桥接';
comment on column KEFU5.UK_CALLCENTER_EVENT.recordfilename
  is '录音文件名';
alter table KEFU5.UK_CALLCENTER_EVENT
  add constraint PRIMARY_7 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CALLCENTER_EXTENTION
prompt ======================================
prompt
create table KEFU5.UK_CALLCENTER_EXTENTION
(
  id          VARCHAR2(32 CHAR) not null,
  creater     VARCHAR2(32 CHAR),
  createtime  DATE,
  updatetime  DATE,
  extention   VARCHAR2(100 CHAR),
  orgi        VARCHAR2(100 CHAR),
  hostid      VARCHAR2(100 CHAR),
  agentno     VARCHAR2(50 CHAR),
  password    VARCHAR2(100 CHAR),
  callout     NUMBER(3),
  playnum     NUMBER(3),
  record      NUMBER(3),
  extype      VARCHAR2(50 CHAR),
  description VARCHAR2(255 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_CALLCENTER_EXTENTION.id
  is '主键ID';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.creater
  is '创建人';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.createtime
  is '创建时间';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.updatetime
  is '更新时间';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.extention
  is '分机号';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.orgi
  is '租户ID';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.hostid
  is 'PBX服务ID';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.agentno
  is '坐席工号';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.password
  is '密码';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.callout
  is '允许呼出';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.playnum
  is '播报工号';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.record
  is '录音';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.extype
  is '分机类型';
comment on column KEFU5.UK_CALLCENTER_EXTENTION.description
  is '描述';
alter table KEFU5.UK_CALLCENTER_EXTENTION
  add constraint PRIMARY_8 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CALLCENTER_IVR
prompt ================================
prompt
create table KEFU5.UK_CALLCENTER_IVR
(
  id                VARCHAR2(32 CHAR) not null,
  creater           VARCHAR2(32 CHAR),
  createtime        DATE,
  updatetime        DATE,
  name              VARCHAR2(100 CHAR),
  orgi              VARCHAR2(100 CHAR),
  hostid            VARCHAR2(32 CHAR),
  type              VARCHAR2(32 CHAR),
  greetlong         VARCHAR2(100 CHAR),
  greetshort        VARCHAR2(100 CHAR),
  invalidsound      VARCHAR2(100 CHAR),
  exitsound         VARCHAR2(100 CHAR),
  confirmmacro      VARCHAR2(50 CHAR),
  confirmkey        VARCHAR2(50 CHAR),
  ttsengine         VARCHAR2(20 CHAR),
  ttsvoice          VARCHAR2(50 CHAR),
  confirmattempts   VARCHAR2(50 CHAR),
  timeout           NUMBER(10),
  interdigittimeout NUMBER(10),
  maxfailures       NUMBER(10),
  maxtimeouts       NUMBER(10),
  digitlen          NUMBER(10),
  menucontent       CLOB,
  action            VARCHAR2(50 CHAR),
  digits            VARCHAR2(50 CHAR),
  param             VARCHAR2(255 CHAR),
  parentid          VARCHAR2(32 CHAR),
  extentionid       VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_CALLCENTER_IVR.id
  is '主键ID';
comment on column KEFU5.UK_CALLCENTER_IVR.creater
  is '创建人ID';
comment on column KEFU5.UK_CALLCENTER_IVR.createtime
  is '创建时间';
comment on column KEFU5.UK_CALLCENTER_IVR.updatetime
  is '更新时间';
comment on column KEFU5.UK_CALLCENTER_IVR.name
  is '名称';
comment on column KEFU5.UK_CALLCENTER_IVR.orgi
  is '租户ID';
comment on column KEFU5.UK_CALLCENTER_IVR.hostid
  is 'PBX服务器ID';
comment on column KEFU5.UK_CALLCENTER_IVR.type
  is '类型';
comment on column KEFU5.UK_CALLCENTER_IVR.greetlong
  is '欢迎提示语音';
comment on column KEFU5.UK_CALLCENTER_IVR.greetshort
  is '欢迎提示短语音';
comment on column KEFU5.UK_CALLCENTER_IVR.invalidsound
  is '无效输入提示语音';
comment on column KEFU5.UK_CALLCENTER_IVR.exitsound
  is '离开语音';
comment on column KEFU5.UK_CALLCENTER_IVR.ttsengine
  is 'TTS引擎';
comment on column KEFU5.UK_CALLCENTER_IVR.ttsvoice
  is 'TTS语音';
comment on column KEFU5.UK_CALLCENTER_IVR.timeout
  is '超时时间';
alter table KEFU5.UK_CALLCENTER_IVR
  add constraint PRIMARY_9 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CALLCENTER_MEDIA
prompt ==================================
prompt
create table KEFU5.UK_CALLCENTER_MEDIA
(
  id         VARCHAR2(32 CHAR) not null,
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  name       VARCHAR2(100 CHAR),
  orgi       VARCHAR2(100 CHAR),
  hostid     VARCHAR2(32 CHAR),
  type       VARCHAR2(32 CHAR),
  filename   VARCHAR2(255 CHAR),
  content    VARCHAR2(50 CHAR),
  filelength NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_CALLCENTER_MEDIA.id
  is '主键ID';
comment on column KEFU5.UK_CALLCENTER_MEDIA.creater
  is '创建人ID';
comment on column KEFU5.UK_CALLCENTER_MEDIA.createtime
  is '创建时间';
comment on column KEFU5.UK_CALLCENTER_MEDIA.updatetime
  is '更新时间';
comment on column KEFU5.UK_CALLCENTER_MEDIA.name
  is '名称';
comment on column KEFU5.UK_CALLCENTER_MEDIA.orgi
  is '租户ID';
comment on column KEFU5.UK_CALLCENTER_MEDIA.hostid
  is 'PBX服务ID';
comment on column KEFU5.UK_CALLCENTER_MEDIA.type
  is '类型';
comment on column KEFU5.UK_CALLCENTER_MEDIA.filename
  is '文件名';
comment on column KEFU5.UK_CALLCENTER_MEDIA.content
  is '文件类型';
comment on column KEFU5.UK_CALLCENTER_MEDIA.filelength
  is '语音文件长度';
alter table KEFU5.UK_CALLCENTER_MEDIA
  add constraint PRIMARY_10 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CALLCENTER_PBXHOST
prompt ====================================
prompt
create table KEFU5.UK_CALLCENTER_PBXHOST
(
  id             VARCHAR2(32 CHAR) not null,
  creater        VARCHAR2(32 CHAR),
  createtime     DATE,
  updatetime     DATE,
  name           VARCHAR2(100 CHAR),
  orgi           VARCHAR2(100 CHAR),
  hostname       VARCHAR2(100 CHAR),
  port           NUMBER(10),
  password       VARCHAR2(100 CHAR),
  ipaddr         VARCHAR2(32 CHAR),
  callbacknumber VARCHAR2(50 CHAR),
  autoanswer     NUMBER(3),
  callcenter     NUMBER(3),
  recordpath     VARCHAR2(100 CHAR),
  ivrpath        VARCHAR2(100 CHAR),
  fspath         VARCHAR2(100 CHAR),
  device         VARCHAR2(50 CHAR),
  callbacktype   VARCHAR2(32 CHAR),
  sipautoanswer  NUMBER(3),
  abscodec       VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_CALLCENTER_PBXHOST.id
  is '主键ID';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.creater
  is '创建人';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.createtime
  is '创建时间';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.updatetime
  is '更新时间';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.name
  is '名称';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.orgi
  is '租户ID';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.hostname
  is '主机名';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.port
  is '端口';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.password
  is '密码';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.ipaddr
  is 'IP地址';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.callbacknumber
  is '回呼号码';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.autoanswer
  is '启用自动接听';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.callcenter
  is '启用呼叫中心功能';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.recordpath
  is '录音文件位置';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.ivrpath
  is 'IVR文件位置';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.fspath
  is 'FS安装路径';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.device
  is '语音设备类型';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.callbacktype
  is '回呼送号号码';
comment on column KEFU5.UK_CALLCENTER_PBXHOST.sipautoanswer
  is 'SIP自动应答';
alter table KEFU5.UK_CALLCENTER_PBXHOST
  add constraint PRIMARY_11 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CALLCENTER_ROUTER
prompt ===================================
prompt
create table KEFU5.UK_CALLCENTER_ROUTER
(
  id            VARCHAR2(32 CHAR) not null,
  creater       VARCHAR2(32 CHAR),
  createtime    DATE,
  updatetime    DATE,
  name          VARCHAR2(100 CHAR),
  orgi          VARCHAR2(100 CHAR),
  hostid        VARCHAR2(32 CHAR),
  type          VARCHAR2(32 CHAR),
  regex         VARCHAR2(255 CHAR),
  allow         NUMBER(3),
  falsebreak    NUMBER(3),
  routerinx     NUMBER(10),
  routercontent CLOB,
  field         VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_CALLCENTER_ROUTER.id
  is '主键ID';
comment on column KEFU5.UK_CALLCENTER_ROUTER.creater
  is '创建人';
comment on column KEFU5.UK_CALLCENTER_ROUTER.createtime
  is '创建时间';
comment on column KEFU5.UK_CALLCENTER_ROUTER.updatetime
  is '更新时间';
comment on column KEFU5.UK_CALLCENTER_ROUTER.name
  is '名称';
comment on column KEFU5.UK_CALLCENTER_ROUTER.orgi
  is '租户ID';
comment on column KEFU5.UK_CALLCENTER_ROUTER.hostid
  is 'PBX服务器ID';
comment on column KEFU5.UK_CALLCENTER_ROUTER.type
  is '类型';
comment on column KEFU5.UK_CALLCENTER_ROUTER.regex
  is '匹配正则';
comment on column KEFU5.UK_CALLCENTER_ROUTER.allow
  is '允许';
comment on column KEFU5.UK_CALLCENTER_ROUTER.falsebreak
  is '异常终止';
comment on column KEFU5.UK_CALLCENTER_ROUTER.routerinx
  is '编号';
comment on column KEFU5.UK_CALLCENTER_ROUTER.routercontent
  is '路由规则';
comment on column KEFU5.UK_CALLCENTER_ROUTER.field
  is '字段名称';
alter table KEFU5.UK_CALLCENTER_ROUTER
  add constraint PRIMARY_12 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CALLCENTER_SIPTRUNK
prompt =====================================
prompt
create table KEFU5.UK_CALLCENTER_SIPTRUNK
(
  id            VARCHAR2(32 CHAR) not null,
  creater       VARCHAR2(32 CHAR),
  createtime    DATE,
  updatetime    DATE,
  name          VARCHAR2(100 CHAR),
  orgi          VARCHAR2(100 CHAR),
  hostid        VARCHAR2(32 CHAR),
  type          VARCHAR2(32 CHAR),
  sipcontent    CLOB,
  sipserver     VARCHAR2(50 CHAR),
  extention     VARCHAR2(50 CHAR),
  outnumber     VARCHAR2(50 CHAR),
  prefix        VARCHAR2(50 CHAR),
  port          NUMBER(10),
  exptime       NUMBER(10),
  retry         NUMBER(10),
  register      NUMBER(3),
  fromuser      NUMBER(3),
  transprotocol NUMBER(3),
  username      VARCHAR2(50 CHAR),
  authuser      VARCHAR2(50 CHAR),
  password      VARCHAR2(50 CHAR),
  protocol      VARCHAR2(50 CHAR),
  heartbeat     NUMBER(10),
  dtmf          VARCHAR2(20 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.id
  is '组件ID';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.creater
  is '创建人';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.createtime
  is '创建时间';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.updatetime
  is '更新时间';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.name
  is 'SIP中继名称';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.orgi
  is '租户ID';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.hostid
  is 'PBX服务器ID';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.type
  is '类型';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.sipcontent
  is 'SIP配置内容';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.sipserver
  is '服务器地址';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.extention
  is '转分机号';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.outnumber
  is '出局号码';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.prefix
  is '前缀';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.port
  is '端口';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.exptime
  is '超时时长';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.retry
  is '重试次数';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.register
  is '是否注册';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.fromuser
  is '是否添加FROM';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.transprotocol
  is '协议';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.username
  is '用户名';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.authuser
  is '认证用户名';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.password
  is '密码';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.protocol
  is '协议';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.heartbeat
  is '心跳时长';
comment on column KEFU5.UK_CALLCENTER_SIPTRUNK.dtmf
  is 'DTMF协议';
alter table KEFU5.UK_CALLCENTER_SIPTRUNK
  add constraint PRIMARY_13 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CALLCENTER_SKILL
prompt ==================================
prompt
create table KEFU5.UK_CALLCENTER_SKILL
(
  id         VARCHAR2(32 CHAR) not null,
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  orgi       VARCHAR2(100 CHAR),
  name       VARCHAR2(100 CHAR),
  skill      VARCHAR2(50 CHAR),
  password   VARCHAR2(100 CHAR),
  quene      VARCHAR2(100 CHAR),
  hostid     VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_CALLCENTER_SKILL.id
  is '主键ID';
comment on column KEFU5.UK_CALLCENTER_SKILL.creater
  is '创建人ID';
comment on column KEFU5.UK_CALLCENTER_SKILL.createtime
  is '创建时间';
comment on column KEFU5.UK_CALLCENTER_SKILL.updatetime
  is '更新时间';
comment on column KEFU5.UK_CALLCENTER_SKILL.orgi
  is '租户ID';
comment on column KEFU5.UK_CALLCENTER_SKILL.name
  is '名称';
comment on column KEFU5.UK_CALLCENTER_SKILL.skill
  is '技能组名称';
comment on column KEFU5.UK_CALLCENTER_SKILL.password
  is '密码';
comment on column KEFU5.UK_CALLCENTER_SKILL.quene
  is '队列名称';
comment on column KEFU5.UK_CALLCENTER_SKILL.hostid
  is 'PBX服务器ID';
alter table KEFU5.UK_CALLCENTER_SKILL
  add constraint PRIMARY_14 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CALLCENTER_SKILLEXT
prompt =====================================
prompt
create table KEFU5.UK_CALLCENTER_SKILLEXT
(
  id         VARCHAR2(32 CHAR) default '主键ID' not null,
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  name       VARCHAR2(100 CHAR),
  orgi       VARCHAR2(100 CHAR),
  skillid    VARCHAR2(32 CHAR),
  extention  VARCHAR2(32 CHAR),
  hostid     VARCHAR2(32 CHAR),
  type       VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_CALLCENTER_SKILLEXT.creater
  is '创建人';
comment on column KEFU5.UK_CALLCENTER_SKILLEXT.createtime
  is '创建时间';
comment on column KEFU5.UK_CALLCENTER_SKILLEXT.updatetime
  is '更新时间';
comment on column KEFU5.UK_CALLCENTER_SKILLEXT.name
  is '名称';
comment on column KEFU5.UK_CALLCENTER_SKILLEXT.orgi
  is '租户ID';
comment on column KEFU5.UK_CALLCENTER_SKILLEXT.skillid
  is '技能组ID';
comment on column KEFU5.UK_CALLCENTER_SKILLEXT.extention
  is '分机';
comment on column KEFU5.UK_CALLCENTER_SKILLEXT.hostid
  is 'PBX服务器ID';
comment on column KEFU5.UK_CALLCENTER_SKILLEXT.type
  is '类型';
alter table KEFU5.UK_CALLCENTER_SKILLEXT
  add constraint PRIMARY_15 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_CHAT_MESSAGE
prompt ==============================
prompt
create table KEFU5.UK_CHAT_MESSAGE
(
  type           VARCHAR2(100 CHAR),
  id             VARCHAR2(32 CHAR) not null,
  calltype       VARCHAR2(32 CHAR),
  contextid      VARCHAR2(50 CHAR),
  usession       VARCHAR2(100 CHAR),
  touser         VARCHAR2(50 CHAR),
  channel        VARCHAR2(32 CHAR),
  tousername     VARCHAR2(100 CHAR),
  appid          VARCHAR2(50 CHAR),
  userid         VARCHAR2(100 CHAR),
  nickname       VARCHAR2(100 CHAR),
  message        CLOB,
  msgtype        VARCHAR2(100 CHAR),
  orgi           VARCHAR2(100 CHAR),
  msgid          VARCHAR2(100 CHAR),
  expmsg         VARCHAR2(100 CHAR),
  name           VARCHAR2(255 CHAR),
  createtime     VARCHAR2(50 CHAR),
  creater        VARCHAR2(255 CHAR),
  updatetime     FLOAT,
  update_user    VARCHAR2(255 CHAR),
  username       VARCHAR2(255 CHAR),
  assignedto     VARCHAR2(255 CHAR),
  wfstatus       VARCHAR2(255 CHAR),
  shares         VARCHAR2(255 CHAR),
  owner          VARCHAR2(255 CHAR),
  datadept       VARCHAR2(255 CHAR),
  batid          VARCHAR2(32 CHAR),
  model          VARCHAR2(32 CHAR),
  chatype        VARCHAR2(32 CHAR),
  agentserviceid VARCHAR2(32 CHAR),
  mediaid        VARCHAR2(255 CHAR),
  locx           VARCHAR2(20 CHAR),
  locy           VARCHAR2(20 CHAR),
  duration       VARCHAR2(30 CHAR),
  scale          VARCHAR2(10 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_CHAT_MESSAGE.type
  is '类型';
comment on column KEFU5.UK_CHAT_MESSAGE.id
  is '主键ID';
comment on column KEFU5.UK_CHAT_MESSAGE.calltype
  is '对话方向';
comment on column KEFU5.UK_CHAT_MESSAGE.contextid
  is '会话ID';
comment on column KEFU5.UK_CHAT_MESSAGE.usession
  is '会话ID';
comment on column KEFU5.UK_CHAT_MESSAGE.touser
  is '目标用户';
comment on column KEFU5.UK_CHAT_MESSAGE.channel
  is '渠道';
comment on column KEFU5.UK_CHAT_MESSAGE.tousername
  is '目标用户名';
comment on column KEFU5.UK_CHAT_MESSAGE.appid
  is 'SNSID';
comment on column KEFU5.UK_CHAT_MESSAGE.userid
  is '用户名';
comment on column KEFU5.UK_CHAT_MESSAGE.nickname
  is '昵称';
comment on column KEFU5.UK_CHAT_MESSAGE.message
  is '消息内容';
comment on column KEFU5.UK_CHAT_MESSAGE.msgtype
  is '消息类型';
comment on column KEFU5.UK_CHAT_MESSAGE.orgi
  is '租户ID';
comment on column KEFU5.UK_CHAT_MESSAGE.msgid
  is '消息ID（微信）';
comment on column KEFU5.UK_CHAT_MESSAGE.name
  is '名称';
comment on column KEFU5.UK_CHAT_MESSAGE.createtime
  is '创建时间';
comment on column KEFU5.UK_CHAT_MESSAGE.creater
  is '创建人';
comment on column KEFU5.UK_CHAT_MESSAGE.updatetime
  is '修改时间';
comment on column KEFU5.UK_CHAT_MESSAGE.update_user
  is '修改人';
comment on column KEFU5.UK_CHAT_MESSAGE.username
  is '用户名';
comment on column KEFU5.UK_CHAT_MESSAGE.assignedto
  is '分配目标用户';
comment on column KEFU5.UK_CHAT_MESSAGE.wfstatus
  is '流程状态';
comment on column KEFU5.UK_CHAT_MESSAGE.shares
  is '分享给';
comment on column KEFU5.UK_CHAT_MESSAGE.owner
  is '所属人';
comment on column KEFU5.UK_CHAT_MESSAGE.datadept
  is '创建人部门';
comment on column KEFU5.UK_CHAT_MESSAGE.batid
  is '批次ID';
comment on column KEFU5.UK_CHAT_MESSAGE.model
  is '消息所属组件';
comment on column KEFU5.UK_CHAT_MESSAGE.chatype
  is '对话类型';
comment on column KEFU5.UK_CHAT_MESSAGE.agentserviceid
  is '坐席服务ID';
comment on column KEFU5.UK_CHAT_MESSAGE.mediaid
  is '媒体文件ID（微信）';
comment on column KEFU5.UK_CHAT_MESSAGE.locx
  is '地理位置';
comment on column KEFU5.UK_CHAT_MESSAGE.locy
  is '地理位置';
comment on column KEFU5.UK_CHAT_MESSAGE.duration
  is '会话时长';
comment on column KEFU5.UK_CHAT_MESSAGE.scale
  is '地图级别';
alter table KEFU5.UK_CHAT_MESSAGE
  add constraint PRIMARY_16 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_CONSULT_INVITE
prompt ================================
prompt
create table KEFU5.UK_CONSULT_INVITE
(
  id                         VARCHAR2(32 CHAR) not null,
  impid                      VARCHAR2(32 CHAR),
  orgi                       VARCHAR2(32 CHAR),
  owner                      VARCHAR2(32 CHAR),
  processid                  VARCHAR2(32 CHAR),
  shares                     VARCHAR2(32 CHAR),
  update_time                DATE,
  update_user                VARCHAR2(32 CHAR),
  username                   VARCHAR2(32 CHAR),
  wfstatus                   VARCHAR2(32 CHAR),
  consult_invite_model       VARCHAR2(32 CHAR),
  consult_invite_content     VARCHAR2(255 CHAR),
  consult_invite_position    VARCHAR2(32 CHAR),
  consult_invite_color       VARCHAR2(32 CHAR),
  consult_invite_right       NUMBER(10),
  consult_invite_left        NUMBER(10),
  consult_invite_bottom      NUMBER(10),
  consult_invite_top         NUMBER(10),
  create_time                DATE,
  name                       VARCHAR2(50 CHAR),
  consult_invite_width       NUMBER(10),
  consult_invite_poptype     VARCHAR2(32 CHAR),
  consult_invite_fontsize    NUMBER(10),
  consult_invite_fontstyle   VARCHAR2(32 CHAR),
  consult_invite_fontcolor   VARCHAR2(32 CHAR),
  consult_invite_interval    NUMBER(10),
  consult_invite_repeat      VARCHAR2(32 CHAR),
  consult_invite_hight       NUMBER(10),
  snsaccountid               VARCHAR2(56 CHAR),
  consult_vsitorbtn_position VARCHAR2(32 CHAR),
  consult_vsitorbtn_content  VARCHAR2(32 CHAR),
  consult_vsitorbtn_right    VARCHAR2(32 CHAR),
  consult_vsitorbtn_left     VARCHAR2(32 CHAR),
  consult_vsitorbtn_top      VARCHAR2(32 CHAR),
  consult_vsitorbtn_color    VARCHAR2(32 CHAR),
  consult_vsitorbtn_model    VARCHAR2(32 CHAR),
  consult_vsitorbtn_bottom   VARCHAR2(32 CHAR),
  consult_invite_backimg     VARCHAR2(32 CHAR),
  datadept                   VARCHAR2(32 CHAR),
  agent_online               VARCHAR2(32 CHAR),
  consult_dialog_color       VARCHAR2(32 CHAR),
  consult_dialog_logo        VARCHAR2(100 CHAR),
  consult_dialog_headimg     VARCHAR2(100 CHAR),
  consult_vsitorbtn_display  NUMBER(10),
  dialog_name                VARCHAR2(100 CHAR),
  dialog_address             VARCHAR2(100 CHAR),
  dialog_phone               VARCHAR2(32 CHAR),
  dialog_mail                VARCHAR2(100 CHAR),
  dialog_introduction        CLOB,
  dialog_message             CLOB,
  dialog_ad                  VARCHAR2(100 CHAR),
  consult_invite_enable      NUMBER(3),
  consult_invite_accept      VARCHAR2(50 CHAR),
  consult_invite_later       VARCHAR2(50 CHAR),
  consult_invite_delay       NUMBER(10),
  consult_invite_bg          VARCHAR2(100 CHAR),
  leavemessage               NUMBER(3),
  lvmname                    NUMBER(3),
  lvmphone                   NUMBER(3),
  lvmemail                   NUMBER(3),
  lvmaddress                 NUMBER(3),
  lvmqq                      NUMBER(3) default '0',
  lvmcontent                 NUMBER(3),
  workinghours               CLOB,
  lvmopentype                VARCHAR2(32 CHAR),
  skill                      NUMBER(3) default '0',
  notinwhmsg                 CLOB,
  consult_skill_logo         VARCHAR2(100 CHAR),
  consult_skill_title        VARCHAR2(50 CHAR),
  consult_skill_img          VARCHAR2(100 CHAR),
  consult_skill_msg          CLOB,
  consult_skill_numbers      NUMBER(10),
  consult_skill_maxagent     NUMBER(10),
  consult_skill_bottomtitle  VARCHAR2(50 CHAR),
  ai                         NUMBER(3) default '0',
  aifirst                    NUMBER(3) default '0',
  aisearch                   NUMBER(3) default '0',
  aimsg                      CLOB,
  aisuccesstip               VARCHAR2(100 CHAR),
  ainame                     VARCHAR2(50 CHAR),
  consult_info               NUMBER(3),
  consult_info_name          NUMBER(3),
  consult_info_email         NUMBER(3),
  consult_info_phone         NUMBER(3),
  consult_info_resion        NUMBER(3),
  consult_info_message       CLOB,
  consult_info_cookies       NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_CONSULT_INVITE.id
  is '主键ID';
comment on column KEFU5.UK_CONSULT_INVITE.impid
  is '批次ID';
comment on column KEFU5.UK_CONSULT_INVITE.orgi
  is '租户ID';
comment on column KEFU5.UK_CONSULT_INVITE.owner
  is '数据拥有人';
comment on column KEFU5.UK_CONSULT_INVITE.processid
  is '流程ID';
comment on column KEFU5.UK_CONSULT_INVITE.shares
  is '分享给';
comment on column KEFU5.UK_CONSULT_INVITE.update_time
  is '更新时间';
comment on column KEFU5.UK_CONSULT_INVITE.update_user
  is '修改人';
comment on column KEFU5.UK_CONSULT_INVITE.username
  is '用户名';
comment on column KEFU5.UK_CONSULT_INVITE.wfstatus
  is '流程状态';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_model
  is '邀请模式';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_content
  is '邀请框文本';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_position
  is '邀请框位置';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_color
  is '邀请框颜色';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_right
  is '邀请框距右边位置';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_left
  is '邀请框距左侧';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_bottom
  is '邀请框距下边位置';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_top
  is '邀请框距顶部位置';
comment on column KEFU5.UK_CONSULT_INVITE.create_time
  is '创建时间';
comment on column KEFU5.UK_CONSULT_INVITE.name
  is '名称';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_width
  is '邀请框宽度';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_poptype
  is '邀请框悬浮位置';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_fontsize
  is '邀请框文本字体';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_fontstyle
  is '邀请框文本样式';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_fontcolor
  is '邀请框文本颜色';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_interval
  is '邀请框弹出频率';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_repeat
  is '邀请框背景平铺';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_hight
  is '邀请框高度';
comment on column KEFU5.UK_CONSULT_INVITE.snsaccountid
  is 'SNSID';
comment on column KEFU5.UK_CONSULT_INVITE.consult_vsitorbtn_position
  is '悬浮图标位置';
comment on column KEFU5.UK_CONSULT_INVITE.consult_vsitorbtn_content
  is '悬浮框文本';
comment on column KEFU5.UK_CONSULT_INVITE.consult_vsitorbtn_right
  is '悬浮框距右侧位置';
comment on column KEFU5.UK_CONSULT_INVITE.consult_vsitorbtn_left
  is '悬浮框距左侧位置';
comment on column KEFU5.UK_CONSULT_INVITE.consult_vsitorbtn_top
  is '悬浮框距顶部';
comment on column KEFU5.UK_CONSULT_INVITE.consult_vsitorbtn_color
  is '悬浮框颜色';
comment on column KEFU5.UK_CONSULT_INVITE.consult_vsitorbtn_model
  is '悬浮框模式';
comment on column KEFU5.UK_CONSULT_INVITE.consult_vsitorbtn_bottom
  is '悬浮框距底部';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_backimg
  is '悬浮框背景图片';
comment on column KEFU5.UK_CONSULT_INVITE.datadept
  is '数据部门';
comment on column KEFU5.UK_CONSULT_INVITE.agent_online
  is '坐席在线';
comment on column KEFU5.UK_CONSULT_INVITE.consult_dialog_color
  is '对话框颜色';
comment on column KEFU5.UK_CONSULT_INVITE.consult_dialog_logo
  is '对话框LOGO';
comment on column KEFU5.UK_CONSULT_INVITE.consult_dialog_headimg
  is '对话框头像';
comment on column KEFU5.UK_CONSULT_INVITE.consult_vsitorbtn_display
  is '显示按钮';
comment on column KEFU5.UK_CONSULT_INVITE.dialog_name
  is '对话显示名称';
comment on column KEFU5.UK_CONSULT_INVITE.dialog_address
  is '对话框地址';
comment on column KEFU5.UK_CONSULT_INVITE.dialog_phone
  is '对话框电话号码';
comment on column KEFU5.UK_CONSULT_INVITE.dialog_mail
  is '对话框邮件';
comment on column KEFU5.UK_CONSULT_INVITE.dialog_introduction
  is '对话框介绍';
comment on column KEFU5.UK_CONSULT_INVITE.dialog_message
  is '对话框欢迎信息';
comment on column KEFU5.UK_CONSULT_INVITE.dialog_ad
  is '对话框广告';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_enable
  is '启用邀请框';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_accept
  is '邀请框统一按钮文本';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_later
  is '延迟弹出邀请框';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_delay
  is '邀请框延迟时间';
comment on column KEFU5.UK_CONSULT_INVITE.consult_invite_bg
  is '邀请框背景图片';
comment on column KEFU5.UK_CONSULT_INVITE.leavemessage
  is '留言提示文本';
comment on column KEFU5.UK_CONSULT_INVITE.lvmname
  is '留言框显示名称字段';
comment on column KEFU5.UK_CONSULT_INVITE.lvmphone
  is '留言卡电话号码字段';
comment on column KEFU5.UK_CONSULT_INVITE.lvmemail
  is '留言卡Email字段';
comment on column KEFU5.UK_CONSULT_INVITE.lvmaddress
  is '留言卡地址字段';
comment on column KEFU5.UK_CONSULT_INVITE.lvmqq
  is '留言框QQ';
comment on column KEFU5.UK_CONSULT_INVITE.lvmcontent
  is '留言卡留言内容字段';
comment on column KEFU5.UK_CONSULT_INVITE.workinghours
  is '工作时间段';
comment on column KEFU5.UK_CONSULT_INVITE.lvmopentype
  is '留言卡弹出模式';
comment on column KEFU5.UK_CONSULT_INVITE.skill
  is '技能组';
comment on column KEFU5.UK_CONSULT_INVITE.notinwhmsg
  is '非工作时间段提示文本';
comment on column KEFU5.UK_CONSULT_INVITE.consult_skill_logo
  is '技能组图标';
comment on column KEFU5.UK_CONSULT_INVITE.consult_skill_title
  is '技能组提示标题';
comment on column KEFU5.UK_CONSULT_INVITE.consult_skill_img
  is '技能组显示背景图片';
comment on column KEFU5.UK_CONSULT_INVITE.consult_skill_msg
  is '技能组提示文本内容';
comment on column KEFU5.UK_CONSULT_INVITE.consult_skill_numbers
  is '显示技能组成员数量';
comment on column KEFU5.UK_CONSULT_INVITE.consult_skill_maxagent
  is '显示技能组下最大用户数';
comment on column KEFU5.UK_CONSULT_INVITE.consult_skill_bottomtitle
  is '技能组底部标题';
comment on column KEFU5.UK_CONSULT_INVITE.ai
  is '启用AI';
comment on column KEFU5.UK_CONSULT_INVITE.aifirst
  is 'AI优先显示';
comment on column KEFU5.UK_CONSULT_INVITE.aisearch
  is 'AI搜索文本';
comment on column KEFU5.UK_CONSULT_INVITE.aimsg
  is 'AI欢迎信息';
comment on column KEFU5.UK_CONSULT_INVITE.consult_info
  is '启用咨询信息收集功能';
comment on column KEFU5.UK_CONSULT_INVITE.consult_info_name
  is '填写姓名';
comment on column KEFU5.UK_CONSULT_INVITE.consult_info_email
  is '填写 邮件地址';
comment on column KEFU5.UK_CONSULT_INVITE.consult_info_phone
  is '填写 电话号码';
comment on column KEFU5.UK_CONSULT_INVITE.consult_info_resion
  is '填写咨询问题';
comment on column KEFU5.UK_CONSULT_INVITE.consult_info_message
  is '咨询窗口显示的欢迎语';
comment on column KEFU5.UK_CONSULT_INVITE.consult_info_cookies
  is '在Cookies中存储用户信息';
alter table KEFU5.UK_CONSULT_INVITE
  add constraint PRIMARY_17 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_CONTACTS
prompt ==========================
prompt
create table KEFU5.UK_CONTACTS
(
  id             VARCHAR2(32 CHAR) not null,
  gender         VARCHAR2(60 CHAR),
  birthday       VARCHAR2(50 CHAR),
  ctype          VARCHAR2(60 CHAR),
  ckind          VARCHAR2(60 CHAR),
  clevel         VARCHAR2(60 CHAR),
  ccode          VARCHAR2(60 CHAR),
  nickname       VARCHAR2(64 CHAR),
  sarea          VARCHAR2(60 CHAR),
  csource        VARCHAR2(64 CHAR),
  language       VARCHAR2(40 CHAR),
  marriage       VARCHAR2(60 CHAR),
  education      VARCHAR2(60 CHAR),
  identifytype   VARCHAR2(60 CHAR),
  identifynumber VARCHAR2(40 CHAR),
  website        VARCHAR2(255 CHAR),
  email          VARCHAR2(128 CHAR),
  emailalt       VARCHAR2(128 CHAR),
  mobile         VARCHAR2(40 CHAR),
  mobilealt      VARCHAR2(40 CHAR),
  phone          VARCHAR2(40 CHAR),
  extension      VARCHAR2(40 CHAR),
  phonealt       VARCHAR2(40 CHAR),
  extensionalt   VARCHAR2(40 CHAR),
  familyphone    VARCHAR2(40 CHAR),
  familyphonealt VARCHAR2(40 CHAR),
  fax            VARCHAR2(40 CHAR),
  faxalt         VARCHAR2(40 CHAR),
  country        VARCHAR2(60 CHAR),
  province       VARCHAR2(60 CHAR),
  city           VARCHAR2(60 CHAR),
  address        CLOB,
  postcode       VARCHAR2(40 CHAR),
  enterpriseid   VARCHAR2(60 CHAR),
  company        CLOB,
  department     VARCHAR2(40 CHAR),
  duty           VARCHAR2(40 CHAR),
  deptpr         VARCHAR2(40 CHAR),
  validstatus    VARCHAR2(50 CHAR),
  weixin         VARCHAR2(60 CHAR),
  weixinname     VARCHAR2(60 CHAR),
  weixinid       VARCHAR2(255 CHAR),
  weibo          VARCHAR2(255 CHAR),
  weiboid        VARCHAR2(255 CHAR),
  qqcode         VARCHAR2(32 CHAR),
  touchtime      DATE,
  datastatus     NUMBER(3),
  processid      VARCHAR2(60 CHAR),
  creater        VARCHAR2(60 CHAR),
  username       VARCHAR2(60 CHAR),
  updateuser     VARCHAR2(60 CHAR),
  memo           VARCHAR2(255 CHAR),
  updateusername VARCHAR2(60 CHAR),
  updatetime     DATE,
  orgi           VARCHAR2(60 CHAR),
  compper        VARCHAR2(255 CHAR),
  createtime     DATE,
  name           VARCHAR2(255 CHAR),
  assignedto     VARCHAR2(255 CHAR),
  wfstatus       VARCHAR2(255 CHAR),
  shares         VARCHAR2(255 CHAR),
  owner          VARCHAR2(255 CHAR),
  datadept       VARCHAR2(255 CHAR),
  entcusid       VARCHAR2(32 CHAR),
  pinyin         VARCHAR2(10 CHAR),
  organ          VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_CONTACTS.id
  is '联系人ID';
comment on column KEFU5.UK_CONTACTS.gender
  is '联系人性别';
comment on column KEFU5.UK_CONTACTS.birthday
  is '出生日期';
comment on column KEFU5.UK_CONTACTS.ctype
  is '联系人类型';
comment on column KEFU5.UK_CONTACTS.ckind
  is '联系人类别';
comment on column KEFU5.UK_CONTACTS.clevel
  is '联系人级别';
comment on column KEFU5.UK_CONTACTS.ccode
  is '联系人代码';
comment on column KEFU5.UK_CONTACTS.nickname
  is '联系人昵称';
comment on column KEFU5.UK_CONTACTS.sarea
  is '发货地址区县';
comment on column KEFU5.UK_CONTACTS.csource
  is '联系人来源';
comment on column KEFU5.UK_CONTACTS.language
  is '语言';
comment on column KEFU5.UK_CONTACTS.marriage
  is '婚姻状况';
comment on column KEFU5.UK_CONTACTS.education
  is '学历';
comment on column KEFU5.UK_CONTACTS.identifytype
  is '证件类型';
comment on column KEFU5.UK_CONTACTS.identifynumber
  is '证件号码';
comment on column KEFU5.UK_CONTACTS.website
  is '网址';
comment on column KEFU5.UK_CONTACTS.email
  is '电子邮件';
comment on column KEFU5.UK_CONTACTS.emailalt
  is '备用电子邮件';
comment on column KEFU5.UK_CONTACTS.mobile
  is '手机号码';
comment on column KEFU5.UK_CONTACTS.mobilealt
  is '备用手机号码';
comment on column KEFU5.UK_CONTACTS.phone
  is '办公电话';
comment on column KEFU5.UK_CONTACTS.extension
  is '办公分机';
comment on column KEFU5.UK_CONTACTS.phonealt
  is '备用办公电话';
comment on column KEFU5.UK_CONTACTS.extensionalt
  is '备用办公分机';
comment on column KEFU5.UK_CONTACTS.familyphone
  is '住宅电话';
comment on column KEFU5.UK_CONTACTS.familyphonealt
  is '备用住宅电话';
comment on column KEFU5.UK_CONTACTS.fax
  is '传真号码';
comment on column KEFU5.UK_CONTACTS.faxalt
  is '备用传真号码';
comment on column KEFU5.UK_CONTACTS.country
  is '国家';
comment on column KEFU5.UK_CONTACTS.province
  is '省';
comment on column KEFU5.UK_CONTACTS.city
  is '市(区)县';
comment on column KEFU5.UK_CONTACTS.address
  is '地址';
comment on column KEFU5.UK_CONTACTS.postcode
  is '邮政编码';
comment on column KEFU5.UK_CONTACTS.enterpriseid
  is '企(事)业单位';
comment on column KEFU5.UK_CONTACTS.company
  is '公司';
comment on column KEFU5.UK_CONTACTS.department
  is '部门';
comment on column KEFU5.UK_CONTACTS.duty
  is '职务';
comment on column KEFU5.UK_CONTACTS.deptpr
  is '直接上级领导';
comment on column KEFU5.UK_CONTACTS.validstatus
  is '效力状态';
comment on column KEFU5.UK_CONTACTS.weixin
  is '微信号';
comment on column KEFU5.UK_CONTACTS.weixinname
  is '微信昵称';
comment on column KEFU5.UK_CONTACTS.weixinid
  is '微信ID';
comment on column KEFU5.UK_CONTACTS.weibo
  is '微博昵称';
comment on column KEFU5.UK_CONTACTS.weiboid
  is '微博ID';
comment on column KEFU5.UK_CONTACTS.qqcode
  is 'QQ账号';
comment on column KEFU5.UK_CONTACTS.touchtime
  is '最后联系时间';
comment on column KEFU5.UK_CONTACTS.datastatus
  is '数据状态';
comment on column KEFU5.UK_CONTACTS.processid
  is '流程ID';
comment on column KEFU5.UK_CONTACTS.creater
  is '创建人ID';
comment on column KEFU5.UK_CONTACTS.username
  is '创建人姓名';
comment on column KEFU5.UK_CONTACTS.updateuser
  is '修改人ID';
comment on column KEFU5.UK_CONTACTS.memo
  is '联系人备注';
comment on column KEFU5.UK_CONTACTS.updateusername
  is '修改人姓名';
comment on column KEFU5.UK_CONTACTS.updatetime
  is '修改时间';
comment on column KEFU5.UK_CONTACTS.orgi
  is '租户标识';
comment on column KEFU5.UK_CONTACTS.createtime
  is '创建时间';
comment on column KEFU5.UK_CONTACTS.name
  is '名称';
comment on column KEFU5.UK_CONTACTS.assignedto
  is '分配目标用户';
comment on column KEFU5.UK_CONTACTS.wfstatus
  is '流程状态';
comment on column KEFU5.UK_CONTACTS.shares
  is '分享给';
comment on column KEFU5.UK_CONTACTS.owner
  is '所属人';
comment on column KEFU5.UK_CONTACTS.datadept
  is '创建人部门';
alter table KEFU5.UK_CONTACTS
  add constraint PRIMARY_18 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_DATAEVENT
prompt ===========================
prompt
create table KEFU5.UK_DATAEVENT
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  tpid       VARCHAR2(32 CHAR),
  propertity VARCHAR2(50 CHAR),
  field      VARCHAR2(50 CHAR),
  newvalue   VARCHAR2(255 CHAR),
  oldvalue   VARCHAR2(255 CHAR),
  orgi       VARCHAR2(32 CHAR),
  modifyid   VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  dataid     VARCHAR2(32 CHAR),
  eventtype  VARCHAR2(32 CHAR),
  content    VARCHAR2(255 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_DATAEVENT.id
  is '主键ID';
comment on column KEFU5.UK_DATAEVENT.name
  is '名称';
comment on column KEFU5.UK_DATAEVENT.tpid
  is '字段ID';
comment on column KEFU5.UK_DATAEVENT.propertity
  is '属性名称';
comment on column KEFU5.UK_DATAEVENT.field
  is '字段名称';
comment on column KEFU5.UK_DATAEVENT.newvalue
  is '变更后的值';
comment on column KEFU5.UK_DATAEVENT.oldvalue
  is '变更前的值';
comment on column KEFU5.UK_DATAEVENT.orgi
  is '租户ID';
comment on column KEFU5.UK_DATAEVENT.modifyid
  is '变更ID';
comment on column KEFU5.UK_DATAEVENT.creater
  is '创建人';
comment on column KEFU5.UK_DATAEVENT.createtime
  is '创建时间';
comment on column KEFU5.UK_DATAEVENT.dataid
  is '数据ID';
comment on column KEFU5.UK_DATAEVENT.eventtype
  is '事件类型';
comment on column KEFU5.UK_DATAEVENT.content
  is '变更内容';
alter table KEFU5.UK_DATAEVENT
  add constraint PRIMARY_19 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_ENTCUSTOMER
prompt =============================
prompt
create table KEFU5.UK_ENTCUSTOMER
(
  id                VARCHAR2(32 CHAR) not null,
  name              VARCHAR2(255 CHAR),
  etype             VARCHAR2(60 CHAR),
  ekind             VARCHAR2(60 CHAR),
  elevel            VARCHAR2(60 CHAR),
  ecode             VARCHAR2(60 CHAR),
  nickname          VARCHAR2(64 CHAR),
  esource           VARCHAR2(64 CHAR),
  origincode        VARCHAR2(60 CHAR),
  corporation       VARCHAR2(60 CHAR),
  leadername        VARCHAR2(40 CHAR),
  leadermobile      VARCHAR2(40 CHAR),
  leadermobile2     VARCHAR2(40 CHAR),
  leaderphone       VARCHAR2(40 CHAR),
  leaderemail       VARCHAR2(60 CHAR),
  website           VARCHAR2(255 CHAR),
  email             VARCHAR2(128 CHAR),
  emailalt          VARCHAR2(128 CHAR),
  phone             VARCHAR2(40 CHAR),
  phonealt          VARCHAR2(40 CHAR),
  fax               VARCHAR2(40 CHAR),
  faxalt            VARCHAR2(40 CHAR),
  country           VARCHAR2(60 CHAR),
  province          VARCHAR2(60 CHAR),
  city              VARCHAR2(60 CHAR),
  sarea             VARCHAR2(60 CHAR),
  address           VARCHAR2(255 CHAR),
  postcode          VARCHAR2(40 CHAR),
  businessscope     CLOB,
  capital           VARCHAR2(40 CHAR),
  stockcode         VARCHAR2(40 CHAR),
  bankaccount       VARCHAR2(40 CHAR),
  registeredaddress CLOB,
  esize             VARCHAR2(60 CHAR),
  industry          VARCHAR2(60 CHAR),
  validstatus       VARCHAR2(50 CHAR),
  weixin            VARCHAR2(60 CHAR),
  weibo             VARCHAR2(255 CHAR),
  touchtime         DATE,
  dzip              VARCHAR2(32 CHAR),
  daddress          VARCHAR2(255 CHAR),
  darea             VARCHAR2(60 CHAR),
  dcity             VARCHAR2(60 CHAR),
  dprovince         VARCHAR2(60 CHAR),
  datastatus        VARCHAR2(2 CHAR),
  processid         VARCHAR2(60 CHAR),
  description       CLOB,
  creater           VARCHAR2(60 CHAR),
  username          BLOB,
  updateuser        VARCHAR2(60 CHAR),
  updateusername    VARCHAR2(60 CHAR),
  updatetime        DATE,
  orgi              VARCHAR2(60 CHAR),
  createtime        DATE,
  assignedto        VARCHAR2(255 CHAR),
  wfstatus          VARCHAR2(255 CHAR),
  shares            VARCHAR2(255 CHAR),
  owner             VARCHAR2(255 CHAR),
  datadept          VARCHAR2(255 CHAR),
  batid             VARCHAR2(32 CHAR),
  maturity          VARCHAR2(32 CHAR),
  entcusid          VARCHAR2(32 CHAR),
  pinyin            VARCHAR2(10 CHAR),
  organ             VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_ENTCUSTOMER.id
  is '单位ID';
comment on column KEFU5.UK_ENTCUSTOMER.name
  is '企(事)业单位名称';
comment on column KEFU5.UK_ENTCUSTOMER.etype
  is '单位性质';
comment on column KEFU5.UK_ENTCUSTOMER.ekind
  is '客户类别';
comment on column KEFU5.UK_ENTCUSTOMER.elevel
  is '客户级别';
comment on column KEFU5.UK_ENTCUSTOMER.ecode
  is '单位代码';
comment on column KEFU5.UK_ENTCUSTOMER.nickname
  is '单位简称';
comment on column KEFU5.UK_ENTCUSTOMER.esource
  is '来源';
comment on column KEFU5.UK_ENTCUSTOMER.origincode
  is '组织机构代码';
comment on column KEFU5.UK_ENTCUSTOMER.corporation
  is '法人';
comment on column KEFU5.UK_ENTCUSTOMER.leadername
  is '联系人姓名';
comment on column KEFU5.UK_ENTCUSTOMER.leadermobile
  is '联系人手机';
comment on column KEFU5.UK_ENTCUSTOMER.leadermobile2
  is '联系人手机2';
comment on column KEFU5.UK_ENTCUSTOMER.leaderphone
  is '联系人座机';
comment on column KEFU5.UK_ENTCUSTOMER.leaderemail
  is '联系人电子邮件';
comment on column KEFU5.UK_ENTCUSTOMER.website
  is '网址';
comment on column KEFU5.UK_ENTCUSTOMER.email
  is '电子邮件';
comment on column KEFU5.UK_ENTCUSTOMER.emailalt
  is '备用电子邮件';
comment on column KEFU5.UK_ENTCUSTOMER.phone
  is '办公电话';
comment on column KEFU5.UK_ENTCUSTOMER.phonealt
  is '备用办公电话';
comment on column KEFU5.UK_ENTCUSTOMER.fax
  is '传真号码';
comment on column KEFU5.UK_ENTCUSTOMER.faxalt
  is '备用传真号码';
comment on column KEFU5.UK_ENTCUSTOMER.country
  is '国家';
comment on column KEFU5.UK_ENTCUSTOMER.province
  is '省';
comment on column KEFU5.UK_ENTCUSTOMER.city
  is '市区县';
comment on column KEFU5.UK_ENTCUSTOMER.sarea
  is '区县';
comment on column KEFU5.UK_ENTCUSTOMER.address
  is '地址';
comment on column KEFU5.UK_ENTCUSTOMER.postcode
  is '邮政编码';
comment on column KEFU5.UK_ENTCUSTOMER.businessscope
  is '经营范围';
comment on column KEFU5.UK_ENTCUSTOMER.capital
  is '注册资本';
comment on column KEFU5.UK_ENTCUSTOMER.stockcode
  is '股票代码';
comment on column KEFU5.UK_ENTCUSTOMER.bankaccount
  is '对公银行账号';
comment on column KEFU5.UK_ENTCUSTOMER.registeredaddress
  is '注册地址';
comment on column KEFU5.UK_ENTCUSTOMER.esize
  is '单位规模';
comment on column KEFU5.UK_ENTCUSTOMER.industry
  is '所属行业';
comment on column KEFU5.UK_ENTCUSTOMER.validstatus
  is '效力状态';
comment on column KEFU5.UK_ENTCUSTOMER.weixin
  is '微信公众号';
comment on column KEFU5.UK_ENTCUSTOMER.weibo
  is '微博号';
comment on column KEFU5.UK_ENTCUSTOMER.touchtime
  is '最后联系时间';
comment on column KEFU5.UK_ENTCUSTOMER.dzip
  is '发货地址邮编';
comment on column KEFU5.UK_ENTCUSTOMER.daddress
  is '发货地址';
comment on column KEFU5.UK_ENTCUSTOMER.darea
  is '发货地址-区县';
comment on column KEFU5.UK_ENTCUSTOMER.dcity
  is '发货地址-城市';
comment on column KEFU5.UK_ENTCUSTOMER.dprovince
  is '发货地址-省份';
comment on column KEFU5.UK_ENTCUSTOMER.datastatus
  is '数据状态';
comment on column KEFU5.UK_ENTCUSTOMER.processid
  is '流程ID';
comment on column KEFU5.UK_ENTCUSTOMER.description
  is '描述';
comment on column KEFU5.UK_ENTCUSTOMER.creater
  is '创建人ID';
comment on column KEFU5.UK_ENTCUSTOMER.username
  is '创建人姓名';
comment on column KEFU5.UK_ENTCUSTOMER.updateuser
  is '修改人ID';
comment on column KEFU5.UK_ENTCUSTOMER.updateusername
  is '修改人姓名';
comment on column KEFU5.UK_ENTCUSTOMER.updatetime
  is '修改时间';
comment on column KEFU5.UK_ENTCUSTOMER.orgi
  is '租户标识';
comment on column KEFU5.UK_ENTCUSTOMER.createtime
  is '创建时间';
comment on column KEFU5.UK_ENTCUSTOMER.assignedto
  is '分配目标用户';
comment on column KEFU5.UK_ENTCUSTOMER.wfstatus
  is '流程状态';
comment on column KEFU5.UK_ENTCUSTOMER.shares
  is '分享给';
comment on column KEFU5.UK_ENTCUSTOMER.owner
  is '所属人';
comment on column KEFU5.UK_ENTCUSTOMER.datadept
  is '创建人部门';
alter table KEFU5.UK_ENTCUSTOMER
  add constraint PRIMARY_20 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_FANS
prompt ======================
prompt
create table KEFU5.UK_FANS
(
  id         VARCHAR2(32 CHAR) not null,
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  user_      VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_FANS.id
  is '主键ID';
comment on column KEFU5.UK_FANS.creater
  is '创建人';
comment on column KEFU5.UK_FANS.createtime
  is '创建时间';
comment on column KEFU5.UK_FANS.updatetime
  is '更新时间';
comment on column KEFU5.UK_FANS.user_
  is '用户ID';
alter table KEFU5.UK_FANS
  add constraint PRIMARY_21 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_FAVORITES
prompt ===========================
prompt
create table KEFU5.UK_FAVORITES
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR),
  orderid    VARCHAR2(32 CHAR),
  title      VARCHAR2(255 CHAR),
  model      VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_FAVORITES.id
  is '主键ID';
comment on column KEFU5.UK_FAVORITES.name
  is '名称';
comment on column KEFU5.UK_FAVORITES.code
  is '编码';
comment on column KEFU5.UK_FAVORITES.createtime
  is '创建时间';
comment on column KEFU5.UK_FAVORITES.creater
  is '创建人';
comment on column KEFU5.UK_FAVORITES.updatetime
  is '更新时间';
comment on column KEFU5.UK_FAVORITES.orgi
  is '租户ID';
comment on column KEFU5.UK_FAVORITES.username
  is '用户名';
comment on column KEFU5.UK_FAVORITES.orderid
  is '数据ID';
comment on column KEFU5.UK_FAVORITES.title
  is '标题';
comment on column KEFU5.UK_FAVORITES.model
  is '所属组件';
alter table KEFU5.UK_FAVORITES
  add constraint PRIMARY_22 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_FS_EVENT_SOCKET
prompt =================================
prompt
create table KEFU5.UK_FS_EVENT_SOCKET
(
  id                 NUMBER(10) not null,
  hostname           VARCHAR2(50 CHAR) not null,
  nat_map            VARCHAR2(20 CHAR) default 'false',
  listen_ip          VARCHAR2(50 CHAR) default '0.0.0.0',
  listen_port        NUMBER(10) default '8021',
  password           VARCHAR2(50 CHAR) default 'ClueCon',
  apply_inbound_acl  VARCHAR2(50 CHAR) default 'lan',
  stop_on_bind_error VARCHAR2(50 CHAR) default 'true',
  addtime            VARCHAR2(20 CHAR),
  updatetime         VARCHAR2(20 CHAR),
  connected          NUMBER(10),
  connected_result   VARCHAR2(50 CHAR),
  show_calls         NUMBER(10),
  enable             NUMBER(10) default '1'
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_FS_EVENT_SOCKET.id
  is '主键';
comment on column KEFU5.UK_FS_EVENT_SOCKET.hostname
  is 'fs服务名称';
comment on column KEFU5.UK_FS_EVENT_SOCKET.nat_map
  is 'nat_map';
comment on column KEFU5.UK_FS_EVENT_SOCKET.listen_ip
  is 'listen_ip';
comment on column KEFU5.UK_FS_EVENT_SOCKET.listen_port
  is 'listen_port';
comment on column KEFU5.UK_FS_EVENT_SOCKET.addtime
  is '创建时间';
comment on column KEFU5.UK_FS_EVENT_SOCKET.updatetime
  is '修改时间';
comment on column KEFU5.UK_FS_EVENT_SOCKET.connected
  is 'connected 0-未连接 1-已连接 2 已停止';
comment on column KEFU5.UK_FS_EVENT_SOCKET.connected_result
  is '连接结果';
comment on column KEFU5.UK_FS_EVENT_SOCKET.show_calls
  is '容许通话数';
comment on column KEFU5.UK_FS_EVENT_SOCKET.enable
  is '是否启用';
create unique index KEFU5.AK_KEY_2 on KEFU5.UK_FS_EVENT_SOCKET (HOSTNAME)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.UK_FS_EVENT_SOCKET
  add constraint PRIMARY_23 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_GENERATION
prompt ============================
prompt
create table KEFU5.UK_GENERATION
(
  id         VARCHAR2(32 CHAR) not null,
  model      VARCHAR2(32 CHAR),
  startinx   NUMBER(10),
  orgi       VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_GENERATION.id
  is '主键ID';
comment on column KEFU5.UK_GENERATION.model
  is '所属组件';
comment on column KEFU5.UK_GENERATION.startinx
  is '开始位置';
comment on column KEFU5.UK_GENERATION.orgi
  is '租户ID';
comment on column KEFU5.UK_GENERATION.creater
  is '创建人';
comment on column KEFU5.UK_GENERATION.createtime
  is '创建时间';
alter table KEFU5.UK_GENERATION
  add constraint PRIMARY_24 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_HISTORYREPORT
prompt ===============================
prompt
create table KEFU5.UK_HISTORYREPORT
(
  id         VARCHAR2(32 CHAR) not null,
  bytes      NUMBER(10) not null,
  threads    NUMBER(10) not null,
  type       VARCHAR2(255 CHAR),
  status     VARCHAR2(255 CHAR),
  errormsg   VARCHAR2(255 CHAR),
  createtime DATE,
  starttime  DATE,
  endtime    DATE,
  amount     VARCHAR2(255 CHAR),
  pages      NUMBER(10) not null,
  errors     NUMBER(10) not null,
  orgi       VARCHAR2(32 CHAR),
  tabledirid VARCHAR2(32 CHAR),
  tableid    VARCHAR2(32 CHAR),
  total      NUMBER(10),
  userid     VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_HISTORYREPORT.id
  is '主键ID';
comment on column KEFU5.UK_HISTORYREPORT.bytes
  is '传输数据量';
comment on column KEFU5.UK_HISTORYREPORT.threads
  is '线程数量';
comment on column KEFU5.UK_HISTORYREPORT.type
  is '类型';
comment on column KEFU5.UK_HISTORYREPORT.status
  is '状态';
comment on column KEFU5.UK_HISTORYREPORT.errormsg
  is '错误提示';
comment on column KEFU5.UK_HISTORYREPORT.createtime
  is '创建时间';
comment on column KEFU5.UK_HISTORYREPORT.starttime
  is '开始时间';
comment on column KEFU5.UK_HISTORYREPORT.endtime
  is '结束时间';
comment on column KEFU5.UK_HISTORYREPORT.amount
  is '提醒';
comment on column KEFU5.UK_HISTORYREPORT.pages
  is '记录数量';
comment on column KEFU5.UK_HISTORYREPORT.errors
  is '错误数';
comment on column KEFU5.UK_HISTORYREPORT.orgi
  is '租户ID';
comment on column KEFU5.UK_HISTORYREPORT.tabledirid
  is '数据表目录ID';
comment on column KEFU5.UK_HISTORYREPORT.tableid
  is '数据表ID';
comment on column KEFU5.UK_HISTORYREPORT.total
  is '总数';
comment on column KEFU5.UK_HISTORYREPORT.userid
  is '用户ID';
comment on column KEFU5.UK_HISTORYREPORT.username
  is '用户名';
alter table KEFU5.UK_HISTORYREPORT
  add constraint PRIMARY_25 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_IMGROUP
prompt =========================
prompt
create table KEFU5.UK_IMGROUP
(
  id         VARCHAR2(32 CHAR) not null,
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  tipmessage CLOB,
  descript   CLOB,
  name       VARCHAR2(100 CHAR),
  orgi       VARCHAR2(100 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_IMGROUP.id
  is '主键ID';
comment on column KEFU5.UK_IMGROUP.creater
  is '创建人';
comment on column KEFU5.UK_IMGROUP.createtime
  is '创建时间';
comment on column KEFU5.UK_IMGROUP.updatetime
  is '更新时间';
comment on column KEFU5.UK_IMGROUP.tipmessage
  is '提示消息';
comment on column KEFU5.UK_IMGROUP.descript
  is '描述';
comment on column KEFU5.UK_IMGROUP.name
  is '分组名称';
comment on column KEFU5.UK_IMGROUP.orgi
  is '租户ID';
alter table KEFU5.UK_IMGROUP
  add constraint PRIMARY_26 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_IMGROUP_USER
prompt ==============================
prompt
create table KEFU5.UK_IMGROUP_USER
(
  id         VARCHAR2(32 CHAR) not null,
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  name       VARCHAR2(100 CHAR),
  orgi       VARCHAR2(100 CHAR),
  user_id    VARCHAR2(32 CHAR),
  imgroup_id VARCHAR2(32 CHAR),
  admin      NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_IMGROUP_USER.id
  is '主键ID';
comment on column KEFU5.UK_IMGROUP_USER.creater
  is '创建人ID';
comment on column KEFU5.UK_IMGROUP_USER.createtime
  is '创建时间';
comment on column KEFU5.UK_IMGROUP_USER.updatetime
  is '更新时间';
comment on column KEFU5.UK_IMGROUP_USER.name
  is '名称';
comment on column KEFU5.UK_IMGROUP_USER.orgi
  is '租户ID';
comment on column KEFU5.UK_IMGROUP_USER.user_id
  is '用户ID';
comment on column KEFU5.UK_IMGROUP_USER.imgroup_id
  is '分组ID';
comment on column KEFU5.UK_IMGROUP_USER.admin
  is '是否管理员';
alter table KEFU5.UK_IMGROUP_USER
  add constraint PRIMARY_27 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_INSTRUCTION
prompt =============================
prompt
create table KEFU5.UK_INSTRUCTION
(
  id             VARCHAR2(96 CHAR) not null,
  name           VARCHAR2(96 CHAR),
  code           VARCHAR2(96 CHAR),
  plugin         VARCHAR2(96 CHAR),
  memo           CLOB,
  status         VARCHAR2(96 CHAR),
  orgi           VARCHAR2(96 CHAR),
  createtime     DATE,
  userid         VARCHAR2(96 CHAR),
  type           VARCHAR2(96 CHAR),
  parent         VARCHAR2(96 CHAR),
  username       VARCHAR2(96 CHAR),
  scope          VARCHAR2(15 CHAR),
  tipdefault     NUMBER(5),
  matcherule     VARCHAR2(96 CHAR),
  userbind       NUMBER(5),
  interfacetype  VARCHAR2(96 CHAR),
  adapter        VARCHAR2(96 CHAR),
  interfaceurl   CLOB,
  interfaceparam CLOB,
  messagetype    VARCHAR2(96 CHAR),
  keyword        VARCHAR2(100 CHAR),
  eventype       VARCHAR2(32 CHAR),
  snsid          VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_INSTRUCTION.id
  is '主键ID';
comment on column KEFU5.UK_INSTRUCTION.name
  is '名称';
comment on column KEFU5.UK_INSTRUCTION.code
  is '编码';
comment on column KEFU5.UK_INSTRUCTION.plugin
  is '插件';
comment on column KEFU5.UK_INSTRUCTION.memo
  is '备注';
comment on column KEFU5.UK_INSTRUCTION.status
  is '状态';
comment on column KEFU5.UK_INSTRUCTION.orgi
  is '租户ID';
comment on column KEFU5.UK_INSTRUCTION.createtime
  is '创建时间';
comment on column KEFU5.UK_INSTRUCTION.userid
  is '用户ID';
comment on column KEFU5.UK_INSTRUCTION.type
  is '类型';
comment on column KEFU5.UK_INSTRUCTION.parent
  is '上级指令';
comment on column KEFU5.UK_INSTRUCTION.username
  is '用户名';
comment on column KEFU5.UK_INSTRUCTION.scope
  is '作用域';
comment on column KEFU5.UK_INSTRUCTION.tipdefault
  is '默认提示';
comment on column KEFU5.UK_INSTRUCTION.matcherule
  is '匹配规则';
comment on column KEFU5.UK_INSTRUCTION.userbind
  is '用户绑定';
comment on column KEFU5.UK_INSTRUCTION.interfacetype
  is '接口类型';
comment on column KEFU5.UK_INSTRUCTION.adapter
  is '适配程序';
comment on column KEFU5.UK_INSTRUCTION.interfaceurl
  is '接口URL';
comment on column KEFU5.UK_INSTRUCTION.interfaceparam
  is '接口参数';
comment on column KEFU5.UK_INSTRUCTION.messagetype
  is '消息类型';
comment on column KEFU5.UK_INSTRUCTION.keyword
  is '关键词';
comment on column KEFU5.UK_INSTRUCTION.eventype
  is '菜单事件类型';
comment on column KEFU5.UK_INSTRUCTION.snsid
  is 'SNSID';
alter table KEFU5.UK_INSTRUCTION
  add constraint PRIMARY_28 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_INVITERECORD
prompt ==============================
prompt
create table KEFU5.UK_INVITERECORD
(
  id           VARCHAR2(32 CHAR) not null,
  orgi         VARCHAR2(32 CHAR),
  userid       VARCHAR2(32 CHAR),
  agentno      VARCHAR2(32 CHAR),
  createtime   DATE,
  updatetime   DATE,
  result       VARCHAR2(10 CHAR),
  responsetime NUMBER(10),
  appid        VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_INVITERECORD.id
  is '主键ID';
comment on column KEFU5.UK_INVITERECORD.orgi
  is '租户ID';
comment on column KEFU5.UK_INVITERECORD.userid
  is '用户ID';
comment on column KEFU5.UK_INVITERECORD.agentno
  is '坐席ID';
comment on column KEFU5.UK_INVITERECORD.createtime
  is '创建时间';
comment on column KEFU5.UK_INVITERECORD.updatetime
  is '更新时间';
comment on column KEFU5.UK_INVITERECORD.result
  is '记录';
comment on column KEFU5.UK_INVITERECORD.responsetime
  is '响应时间';
comment on column KEFU5.UK_INVITERECORD.appid
  is 'SNSID';
alter table KEFU5.UK_INVITERECORD
  add constraint PRIMARY_29 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_KBS_EXPERT
prompt ============================
prompt
create table KEFU5.UK_KBS_EXPERT
(
  id         VARCHAR2(32 CHAR) not null,
  user_id    VARCHAR2(32 CHAR),
  kbstype    VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  orgi       VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_KBS_EXPERT.id
  is '主键ID';
comment on column KEFU5.UK_KBS_EXPERT.user_id
  is '用户ID';
comment on column KEFU5.UK_KBS_EXPERT.kbstype
  is '知识库分类';
comment on column KEFU5.UK_KBS_EXPERT.creater
  is '创建人';
comment on column KEFU5.UK_KBS_EXPERT.createtime
  is '创建时间';
comment on column KEFU5.UK_KBS_EXPERT.orgi
  is '租户ID';
alter table KEFU5.UK_KBS_EXPERT
  add constraint PRIMARY_30 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_KBS_TOPIC
prompt ===========================
prompt
create table KEFU5.UK_KBS_TOPIC
(
  id          VARCHAR2(32 CHAR) not null,
  sessionid   VARCHAR2(32 CHAR),
  title       VARCHAR2(255 CHAR),
  content     CLOB,
  keyword     VARCHAR2(100 CHAR),
  summary     VARCHAR2(255 CHAR),
  anonymous   NUMBER(3),
  begintime   DATE,
  endtime     DATE,
  top         NUMBER(3),
  essence     NUMBER(3),
  accept      NUMBER(3),
  finish      NUMBER(3),
  answers     NUMBER(10),
  views       NUMBER(10),
  followers   NUMBER(10),
  collections NUMBER(10),
  comments    NUMBER(10),
  mobile      NUMBER(3),
  status      VARCHAR2(32 CHAR),
  tptype      VARCHAR2(32 CHAR),
  cate        VARCHAR2(32 CHAR),
  username    VARCHAR2(32 CHAR),
  orgi        VARCHAR2(32 CHAR),
  creater     VARCHAR2(32 CHAR),
  createtime  DATE,
  updatetime  DATE,
  memo        VARCHAR2(32 CHAR),
  price       NUMBER(10),
  organ       VARCHAR2(32 CHAR),
  sms         VARCHAR2(255 CHAR),
  tts         VARCHAR2(255 CHAR),
  email       CLOB,
  weixin      CLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_KBS_TOPIC.id
  is '主键ID';
comment on column KEFU5.UK_KBS_TOPIC.sessionid
  is '会话ID';
comment on column KEFU5.UK_KBS_TOPIC.title
  is '主题';
comment on column KEFU5.UK_KBS_TOPIC.content
  is '知识库内容';
comment on column KEFU5.UK_KBS_TOPIC.keyword
  is '关键词';
comment on column KEFU5.UK_KBS_TOPIC.summary
  is '摘要';
comment on column KEFU5.UK_KBS_TOPIC.anonymous
  is '允许匿名访问';
comment on column KEFU5.UK_KBS_TOPIC.begintime
  is '有效期开始时间';
comment on column KEFU5.UK_KBS_TOPIC.endtime
  is '有效期结束时间';
comment on column KEFU5.UK_KBS_TOPIC.top
  is '是否置顶';
comment on column KEFU5.UK_KBS_TOPIC.essence
  is '精华';
comment on column KEFU5.UK_KBS_TOPIC.accept
  is '允许评论';
comment on column KEFU5.UK_KBS_TOPIC.finish
  is '已结束';
comment on column KEFU5.UK_KBS_TOPIC.answers
  is '回答数量';
comment on column KEFU5.UK_KBS_TOPIC.views
  is '使用次数';
comment on column KEFU5.UK_KBS_TOPIC.followers
  is '关注人数';
comment on column KEFU5.UK_KBS_TOPIC.collections
  is '引用次数';
comment on column KEFU5.UK_KBS_TOPIC.comments
  is '回复数';
comment on column KEFU5.UK_KBS_TOPIC.mobile
  is '移动端支持';
comment on column KEFU5.UK_KBS_TOPIC.status
  is '状态';
comment on column KEFU5.UK_KBS_TOPIC.tptype
  is '分类ID';
comment on column KEFU5.UK_KBS_TOPIC.cate
  is '分类ID';
comment on column KEFU5.UK_KBS_TOPIC.username
  is '用户名';
comment on column KEFU5.UK_KBS_TOPIC.orgi
  is '租户ID';
comment on column KEFU5.UK_KBS_TOPIC.creater
  is '创建人';
comment on column KEFU5.UK_KBS_TOPIC.createtime
  is '创建时间';
comment on column KEFU5.UK_KBS_TOPIC.updatetime
  is '修改时间';
comment on column KEFU5.UK_KBS_TOPIC.memo
  is '备注';
comment on column KEFU5.UK_KBS_TOPIC.price
  is '权重';
comment on column KEFU5.UK_KBS_TOPIC.organ
  is '组织机构';
comment on column KEFU5.UK_KBS_TOPIC.sms
  is '短信模板';
comment on column KEFU5.UK_KBS_TOPIC.tts
  is 'TTS模板';
comment on column KEFU5.UK_KBS_TOPIC.email
  is '邮件模板';
comment on column KEFU5.UK_KBS_TOPIC.weixin
  is '微信回复模板';

prompt
prompt Creating table UK_KBS_TYPE
prompt ==========================
prompt
create table KEFU5.UK_KBS_TYPE
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR),
  parentid   VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_KBS_TYPE.parentid
  is '知识库分类';
alter table KEFU5.UK_KBS_TYPE
  add constraint PRIMARY_31 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_LEAVEMSG
prompt ==========================
prompt
create table KEFU5.UK_LEAVEMSG
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  mobile     VARCHAR2(32 CHAR),
  email      VARCHAR2(100 CHAR),
  address    VARCHAR2(255 CHAR),
  qq         VARCHAR2(30 CHAR),
  content    VARCHAR2(255 CHAR),
  orgi       VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  msgstatus  VARCHAR2(20 CHAR),
  contactsid VARCHAR2(32 CHAR),
  userid     VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_LEAVEMSG.id
  is '主键ID';
comment on column KEFU5.UK_LEAVEMSG.name
  is '姓名';
comment on column KEFU5.UK_LEAVEMSG.mobile
  is '手机';
comment on column KEFU5.UK_LEAVEMSG.email
  is '邮件';
comment on column KEFU5.UK_LEAVEMSG.address
  is '地址';
comment on column KEFU5.UK_LEAVEMSG.qq
  is 'QQ';
comment on column KEFU5.UK_LEAVEMSG.content
  is '留言内容';
comment on column KEFU5.UK_LEAVEMSG.orgi
  is '租户ID';
comment on column KEFU5.UK_LEAVEMSG.creater
  is '创建人';
comment on column KEFU5.UK_LEAVEMSG.createtime
  is '创建时间';
comment on column KEFU5.UK_LEAVEMSG.msgstatus
  is '消息状态';
comment on column KEFU5.UK_LEAVEMSG.contactsid
  is '匹配联系人ID';
comment on column KEFU5.UK_LEAVEMSG.userid
  is '用户ID';
alter table KEFU5.UK_LEAVEMSG
  add constraint PRIMARY_32 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_MESSAGE
prompt =========================
prompt
create table KEFU5.UK_MESSAGE
(
  id         VARCHAR2(32 CHAR) not null,
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  userid     VARCHAR2(32 CHAR),
  content    CLOB,
  status     VARCHAR2(10 CHAR),
  fromuser   VARCHAR2(32 CHAR),
  touser     VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_MESSAGE.id
  is '主键ID';
comment on column KEFU5.UK_MESSAGE.createtime
  is '创建时间';
comment on column KEFU5.UK_MESSAGE.creater
  is '创建人';
comment on column KEFU5.UK_MESSAGE.updatetime
  is '更新时间';
comment on column KEFU5.UK_MESSAGE.userid
  is '用户ID';
comment on column KEFU5.UK_MESSAGE.content
  is '消息内容';
comment on column KEFU5.UK_MESSAGE.status
  is '状态';
comment on column KEFU5.UK_MESSAGE.fromuser
  is '来源用户';
comment on column KEFU5.UK_MESSAGE.touser
  is '目标用户';
alter table KEFU5.UK_MESSAGE
  add constraint PRIMARY_33 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_ONLINEUSER
prompt ============================
prompt
create table KEFU5.UK_ONLINEUSER
(
  assignedto   VARCHAR2(255 CHAR) not null,
  creater      VARCHAR2(255 CHAR),
  datastatus   VARCHAR2(255 CHAR),
  id           VARCHAR2(32 CHAR) not null,
  impid        VARCHAR2(255 CHAR),
  ipcode       VARCHAR2(255 CHAR),
  orgi         VARCHAR2(255 CHAR),
  owner        VARCHAR2(255 CHAR),
  processid    VARCHAR2(255 CHAR),
  shares       VARCHAR2(255 CHAR),
  updatetime   DATE,
  updateuser   VARCHAR2(255 CHAR),
  username     VARCHAR2(255 CHAR),
  wfstatus     VARCHAR2(255 CHAR),
  resolution   VARCHAR2(255 CHAR),
  opersystem   VARCHAR2(100 CHAR),
  ip           VARCHAR2(32 CHAR),
  hostname     VARCHAR2(32 CHAR),
  browser      VARCHAR2(32 CHAR),
  status       VARCHAR2(11 CHAR),
  userid       VARCHAR2(52 CHAR),
  logintime    DATE,
  sessionid    VARCHAR2(100 CHAR),
  createtime   DATE,
  usertype     VARCHAR2(52 CHAR),
  optype       VARCHAR2(52 CHAR),
  mobile       VARCHAR2(10 CHAR),
  olduser      VARCHAR2(10 CHAR),
  country      VARCHAR2(50 CHAR),
  region       VARCHAR2(200 CHAR),
  city         VARCHAR2(50 CHAR),
  isp          VARCHAR2(100 CHAR),
  province     VARCHAR2(50 CHAR),
  betweentime  NUMBER(10),
  datestr      VARCHAR2(20 CHAR),
  keyword      VARCHAR2(100 CHAR),
  source       VARCHAR2(50 CHAR),
  title        VARCHAR2(255 CHAR),
  url          VARCHAR2(255 CHAR),
  useragent    CLOB,
  invitetimes  NUMBER(10),
  invitestatus VARCHAR2(10 CHAR),
  refusetimes  NUMBER(10),
  channel      VARCHAR2(32 CHAR),
  appid        VARCHAR2(32 CHAR),
  contactsid   VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_ONLINEUSER.assignedto
  is '分配给目标';
comment on column KEFU5.UK_ONLINEUSER.creater
  is '创建人';
comment on column KEFU5.UK_ONLINEUSER.datastatus
  is '时间状态';
comment on column KEFU5.UK_ONLINEUSER.id
  is '主键ID';
comment on column KEFU5.UK_ONLINEUSER.impid
  is '批次ID';
comment on column KEFU5.UK_ONLINEUSER.ipcode
  is 'IP编码';
comment on column KEFU5.UK_ONLINEUSER.orgi
  is '租户ID';
comment on column KEFU5.UK_ONLINEUSER.owner
  is '所属用户';
comment on column KEFU5.UK_ONLINEUSER.processid
  is '流程ID';
comment on column KEFU5.UK_ONLINEUSER.shares
  is '分享给';
comment on column KEFU5.UK_ONLINEUSER.updatetime
  is '更新时间';
comment on column KEFU5.UK_ONLINEUSER.updateuser
  is '更新用户';
comment on column KEFU5.UK_ONLINEUSER.username
  is '用户名';
comment on column KEFU5.UK_ONLINEUSER.wfstatus
  is '流程状态';
comment on column KEFU5.UK_ONLINEUSER.opersystem
  is '操作系统';
comment on column KEFU5.UK_ONLINEUSER.ip
  is 'IP';
comment on column KEFU5.UK_ONLINEUSER.hostname
  is '主机名称';
comment on column KEFU5.UK_ONLINEUSER.browser
  is '浏览器';
comment on column KEFU5.UK_ONLINEUSER.status
  is '状态';
comment on column KEFU5.UK_ONLINEUSER.userid
  is '用户ID';
comment on column KEFU5.UK_ONLINEUSER.logintime
  is '访问时间';
comment on column KEFU5.UK_ONLINEUSER.sessionid
  is '会话ID';
comment on column KEFU5.UK_ONLINEUSER.createtime
  is '创建时间';
comment on column KEFU5.UK_ONLINEUSER.usertype
  is '访客类型';
comment on column KEFU5.UK_ONLINEUSER.optype
  is '操作类型';
comment on column KEFU5.UK_ONLINEUSER.mobile
  is '移动端';
comment on column KEFU5.UK_ONLINEUSER.olduser
  is '老用户';
comment on column KEFU5.UK_ONLINEUSER.country
  is '访客国家';
comment on column KEFU5.UK_ONLINEUSER.region
  is '访客区域';
comment on column KEFU5.UK_ONLINEUSER.city
  is '城市';
comment on column KEFU5.UK_ONLINEUSER.isp
  is '接入运营商';
comment on column KEFU5.UK_ONLINEUSER.province
  is '省份';
comment on column KEFU5.UK_ONLINEUSER.betweentime
  is '停留时间';
comment on column KEFU5.UK_ONLINEUSER.datestr
  is '时间';
comment on column KEFU5.UK_ONLINEUSER.keyword
  is '搜索引擎关键词';
comment on column KEFU5.UK_ONLINEUSER.source
  is '来源';
comment on column KEFU5.UK_ONLINEUSER.title
  is '标题';
comment on column KEFU5.UK_ONLINEUSER.url
  is '来源URL';
comment on column KEFU5.UK_ONLINEUSER.useragent
  is 'UA';
comment on column KEFU5.UK_ONLINEUSER.invitetimes
  is '要求次数';
comment on column KEFU5.UK_ONLINEUSER.invitestatus
  is '邀请状态';
comment on column KEFU5.UK_ONLINEUSER.refusetimes
  is '拒绝次数';
comment on column KEFU5.UK_ONLINEUSER.channel
  is '渠道';
comment on column KEFU5.UK_ONLINEUSER.appid
  is 'SNSID';
comment on column KEFU5.UK_ONLINEUSER.contactsid
  is '联系人ID';
alter table KEFU5.UK_ONLINEUSER
  add constraint PRIMARY_34 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_ONLINEUSER_HIS
prompt ================================
prompt
create table KEFU5.UK_ONLINEUSER_HIS
(
  assignedto   VARCHAR2(255 CHAR) not null,
  creater      VARCHAR2(255 CHAR),
  datastatus   VARCHAR2(255 CHAR),
  id           VARCHAR2(32 CHAR) not null,
  impid        VARCHAR2(255 CHAR),
  ipcode       VARCHAR2(255 CHAR),
  orgi         VARCHAR2(255 CHAR),
  owner        VARCHAR2(255 CHAR),
  processid    VARCHAR2(255 CHAR),
  shares       VARCHAR2(255 CHAR),
  updatetime   DATE,
  updateuser   VARCHAR2(255 CHAR),
  username     VARCHAR2(255 CHAR),
  wfstatus     VARCHAR2(255 CHAR),
  resolution   VARCHAR2(255 CHAR),
  opersystem   VARCHAR2(100 CHAR),
  ip           VARCHAR2(32 CHAR),
  hostname     VARCHAR2(32 CHAR),
  browser      VARCHAR2(32 CHAR),
  status       VARCHAR2(11 CHAR),
  userid       VARCHAR2(52 CHAR),
  logintime    DATE,
  sessionid    VARCHAR2(100 CHAR),
  createtime   DATE,
  usertype     VARCHAR2(52 CHAR),
  optype       VARCHAR2(52 CHAR),
  mobile       VARCHAR2(10 CHAR),
  olduser      VARCHAR2(10 CHAR),
  country      VARCHAR2(50 CHAR),
  region       VARCHAR2(200 CHAR),
  city         VARCHAR2(50 CHAR),
  isp          VARCHAR2(100 CHAR),
  province     VARCHAR2(50 CHAR),
  betweentime  NUMBER(10),
  datestr      VARCHAR2(20 CHAR),
  keyword      VARCHAR2(100 CHAR),
  source       VARCHAR2(50 CHAR),
  title        VARCHAR2(255 CHAR),
  url          VARCHAR2(255 CHAR),
  useragent    CLOB,
  invitetimes  NUMBER(10),
  invitestatus VARCHAR2(10 CHAR),
  refusetimes  NUMBER(10),
  channel      VARCHAR2(32 CHAR),
  appid        VARCHAR2(32 CHAR),
  contactsid   VARCHAR2(32 CHAR),
  dataid       VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_ONLINEUSER_HIS.assignedto
  is '分配给目标';
comment on column KEFU5.UK_ONLINEUSER_HIS.creater
  is '创建人';
comment on column KEFU5.UK_ONLINEUSER_HIS.datastatus
  is '时间状态';
comment on column KEFU5.UK_ONLINEUSER_HIS.id
  is '主键ID';
comment on column KEFU5.UK_ONLINEUSER_HIS.impid
  is '批次ID';
comment on column KEFU5.UK_ONLINEUSER_HIS.ipcode
  is 'IP编码';
comment on column KEFU5.UK_ONLINEUSER_HIS.orgi
  is '租户ID';
comment on column KEFU5.UK_ONLINEUSER_HIS.owner
  is '所属用户';
comment on column KEFU5.UK_ONLINEUSER_HIS.processid
  is '流程ID';
comment on column KEFU5.UK_ONLINEUSER_HIS.shares
  is '分享给';
comment on column KEFU5.UK_ONLINEUSER_HIS.updatetime
  is '更新时间';
comment on column KEFU5.UK_ONLINEUSER_HIS.updateuser
  is '更新用户';
comment on column KEFU5.UK_ONLINEUSER_HIS.username
  is '用户名';
comment on column KEFU5.UK_ONLINEUSER_HIS.wfstatus
  is '流程状态';
comment on column KEFU5.UK_ONLINEUSER_HIS.opersystem
  is '操作系统';
comment on column KEFU5.UK_ONLINEUSER_HIS.ip
  is 'IP';
comment on column KEFU5.UK_ONLINEUSER_HIS.hostname
  is '主机名称';
comment on column KEFU5.UK_ONLINEUSER_HIS.browser
  is '浏览器';
comment on column KEFU5.UK_ONLINEUSER_HIS.status
  is '状态';
comment on column KEFU5.UK_ONLINEUSER_HIS.userid
  is '用户ID';
comment on column KEFU5.UK_ONLINEUSER_HIS.logintime
  is '访问时间';
comment on column KEFU5.UK_ONLINEUSER_HIS.sessionid
  is '会话ID';
comment on column KEFU5.UK_ONLINEUSER_HIS.createtime
  is '创建时间';
comment on column KEFU5.UK_ONLINEUSER_HIS.usertype
  is '访客类型';
comment on column KEFU5.UK_ONLINEUSER_HIS.optype
  is '操作类型';
comment on column KEFU5.UK_ONLINEUSER_HIS.mobile
  is '移动端';
comment on column KEFU5.UK_ONLINEUSER_HIS.olduser
  is '老用户';
comment on column KEFU5.UK_ONLINEUSER_HIS.country
  is '访客国家';
comment on column KEFU5.UK_ONLINEUSER_HIS.region
  is '访客区域';
comment on column KEFU5.UK_ONLINEUSER_HIS.city
  is '城市';
comment on column KEFU5.UK_ONLINEUSER_HIS.isp
  is '接入运营商';
comment on column KEFU5.UK_ONLINEUSER_HIS.province
  is '省份';
comment on column KEFU5.UK_ONLINEUSER_HIS.betweentime
  is '停留时间';
comment on column KEFU5.UK_ONLINEUSER_HIS.datestr
  is '时间';
comment on column KEFU5.UK_ONLINEUSER_HIS.keyword
  is '搜索引擎关键词';
comment on column KEFU5.UK_ONLINEUSER_HIS.source
  is '来源';
comment on column KEFU5.UK_ONLINEUSER_HIS.title
  is '标题';
comment on column KEFU5.UK_ONLINEUSER_HIS.url
  is '来源URL';
comment on column KEFU5.UK_ONLINEUSER_HIS.useragent
  is 'UA';
comment on column KEFU5.UK_ONLINEUSER_HIS.invitetimes
  is '要求次数';
comment on column KEFU5.UK_ONLINEUSER_HIS.invitestatus
  is '邀请状态';
comment on column KEFU5.UK_ONLINEUSER_HIS.refusetimes
  is '拒绝次数';
comment on column KEFU5.UK_ONLINEUSER_HIS.channel
  is '渠道';
comment on column KEFU5.UK_ONLINEUSER_HIS.appid
  is 'SNSID';
comment on column KEFU5.UK_ONLINEUSER_HIS.contactsid
  is '联系人ID';
comment on column KEFU5.UK_ONLINEUSER_HIS.dataid
  is '关联的OnlineUser数据ID';
alter table KEFU5.UK_ONLINEUSER_HIS
  add constraint PRIMARY_35 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_ORDERSCOMMENT
prompt ===============================
prompt
create table KEFU5.UK_ORDERSCOMMENT
(
  id         VARCHAR2(32 CHAR) not null,
  username   VARCHAR2(50 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  dataid     VARCHAR2(32 CHAR),
  content    CLOB,
  updatetime DATE,
  optimal    NUMBER(3),
  prirep     NUMBER(3),
  up         NUMBER(10),
  comments   NUMBER(10),
  admin      NUMBER(3),
  datastatus NUMBER(3),
  orgi       VARCHAR2(50 CHAR),
  cate       VARCHAR2(32 CHAR),
  optype     VARCHAR2(32 CHAR),
  ipcode     VARCHAR2(100 CHAR),
  country    VARCHAR2(100 CHAR),
  province   VARCHAR2(100 CHAR),
  city       VARCHAR2(100 CHAR),
  isp        VARCHAR2(100 CHAR),
  region     VARCHAR2(100 CHAR),
  rowcount   NUMBER(10),
  key        VARCHAR2(100 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_ORDERSCOMMENT.id
  is '主键ID';
comment on column KEFU5.UK_ORDERSCOMMENT.username
  is '用户名';
comment on column KEFU5.UK_ORDERSCOMMENT.creater
  is '创建人ID';
comment on column KEFU5.UK_ORDERSCOMMENT.createtime
  is '创建时间';
comment on column KEFU5.UK_ORDERSCOMMENT.dataid
  is '数据记录ID';
comment on column KEFU5.UK_ORDERSCOMMENT.content
  is '回复内容';
comment on column KEFU5.UK_ORDERSCOMMENT.updatetime
  is '更新时间';
comment on column KEFU5.UK_ORDERSCOMMENT.optimal
  is '操作次数';
comment on column KEFU5.UK_ORDERSCOMMENT.prirep
  is '是否私有回复';
comment on column KEFU5.UK_ORDERSCOMMENT.up
  is '点赞';
comment on column KEFU5.UK_ORDERSCOMMENT.comments
  is '回复数量';
comment on column KEFU5.UK_ORDERSCOMMENT.admin
  is '是否管理员';
comment on column KEFU5.UK_ORDERSCOMMENT.datastatus
  is '数据状态';
comment on column KEFU5.UK_ORDERSCOMMENT.orgi
  is '租户ID';
comment on column KEFU5.UK_ORDERSCOMMENT.cate
  is '分类';
comment on column KEFU5.UK_ORDERSCOMMENT.optype
  is '操作类型';
comment on column KEFU5.UK_ORDERSCOMMENT.ipcode
  is 'IP编码';
comment on column KEFU5.UK_ORDERSCOMMENT.country
  is '国家';
comment on column KEFU5.UK_ORDERSCOMMENT.province
  is '省份';
comment on column KEFU5.UK_ORDERSCOMMENT.city
  is '城市';
comment on column KEFU5.UK_ORDERSCOMMENT.isp
  is '运营商';
comment on column KEFU5.UK_ORDERSCOMMENT.region
  is '地区';
comment on column KEFU5.UK_ORDERSCOMMENT.rowcount
  is '编号';
comment on column KEFU5.UK_ORDERSCOMMENT.key
  is '关键词';
alter table KEFU5.UK_ORDERSCOMMENT
  add constraint PRIMARY_36 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_ORGAN
prompt =======================
prompt
create table KEFU5.UK_ORGAN
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR),
  parent     VARCHAR2(32 CHAR),
  skill      NUMBER(3) default '0'
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_ORGAN.id
  is '主键ID';
comment on column KEFU5.UK_ORGAN.name
  is '名称';
comment on column KEFU5.UK_ORGAN.code
  is '代码';
comment on column KEFU5.UK_ORGAN.createtime
  is '创建时间';
comment on column KEFU5.UK_ORGAN.creater
  is '创建人';
comment on column KEFU5.UK_ORGAN.updatetime
  is '更新时间';
comment on column KEFU5.UK_ORGAN.orgi
  is '租户ID';
comment on column KEFU5.UK_ORGAN.username
  is '用户名';
comment on column KEFU5.UK_ORGAN.parent
  is '父级ID';
comment on column KEFU5.UK_ORGAN.skill
  is '启用技能组';
alter table KEFU5.UK_ORGAN
  add constraint PRIMARY_37 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_ORGANROLE
prompt ===========================
prompt
create table KEFU5.UK_ORGANROLE
(
  id         VARCHAR2(32 CHAR) not null,
  organ_id   VARCHAR2(32 CHAR),
  role_id    VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  orgi       VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_ORGANROLE.id
  is '主键ID';
comment on column KEFU5.UK_ORGANROLE.organ_id
  is '机构ID';
comment on column KEFU5.UK_ORGANROLE.role_id
  is '角色ID';
comment on column KEFU5.UK_ORGANROLE.creater
  is '创建人';
comment on column KEFU5.UK_ORGANROLE.createtime
  is '创建时间';
comment on column KEFU5.UK_ORGANROLE.orgi
  is '租户ID';
alter table KEFU5.UK_ORGANROLE
  add constraint PRIMARY_38 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_PROPERTIESEVENT
prompt =================================
prompt
create table KEFU5.UK_PROPERTIESEVENT
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  tpid       VARCHAR2(32 CHAR),
  propertity VARCHAR2(50 CHAR),
  field      VARCHAR2(50 CHAR),
  newvalue   VARCHAR2(255 CHAR),
  oldvalue   VARCHAR2(255 CHAR),
  orgi       VARCHAR2(32 CHAR),
  modifyid   VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  dataid     VARCHAR2(32 CHAR),
  textvalue  VARCHAR2(255 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_PROPERTIESEVENT.id
  is '主键ID';
comment on column KEFU5.UK_PROPERTIESEVENT.name
  is '名称';
comment on column KEFU5.UK_PROPERTIESEVENT.tpid
  is '字段ID';
comment on column KEFU5.UK_PROPERTIESEVENT.propertity
  is '字段';
comment on column KEFU5.UK_PROPERTIESEVENT.field
  is '阻断名称';
comment on column KEFU5.UK_PROPERTIESEVENT.newvalue
  is '变更后的值';
comment on column KEFU5.UK_PROPERTIESEVENT.oldvalue
  is '变更前的值';
comment on column KEFU5.UK_PROPERTIESEVENT.orgi
  is '租户ID';
comment on column KEFU5.UK_PROPERTIESEVENT.modifyid
  is '修改ID';
comment on column KEFU5.UK_PROPERTIESEVENT.creater
  is '创建人';
comment on column KEFU5.UK_PROPERTIESEVENT.createtime
  is '创建时间';
comment on column KEFU5.UK_PROPERTIESEVENT.dataid
  is '数据记录ID';
comment on column KEFU5.UK_PROPERTIESEVENT.textvalue
  is '文本值';
alter table KEFU5.UK_PROPERTIESEVENT
  add constraint PRIMARY_39 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_QUICKREPLY
prompt ============================
prompt
create table KEFU5.UK_QUICKREPLY
(
  id         VARCHAR2(32 CHAR) not null,
  title      VARCHAR2(255 CHAR),
  content    CLOB,
  type       VARCHAR2(10 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  cate       VARCHAR2(32 CHAR),
  orgi       VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_QUICKREPLY.id
  is '主键ID';
comment on column KEFU5.UK_QUICKREPLY.title
  is '标题';
comment on column KEFU5.UK_QUICKREPLY.content
  is '内容';
comment on column KEFU5.UK_QUICKREPLY.type
  is '类型';
comment on column KEFU5.UK_QUICKREPLY.creater
  is '创建人';
comment on column KEFU5.UK_QUICKREPLY.createtime
  is '创建时间';
comment on column KEFU5.UK_QUICKREPLY.cate
  is '分类';
comment on column KEFU5.UK_QUICKREPLY.orgi
  is '租户ID';
alter table KEFU5.UK_QUICKREPLY
  add constraint PRIMARY_40 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_RECENTUSER
prompt ============================
prompt
create table KEFU5.UK_RECENTUSER
(
  id         VARCHAR2(32 CHAR) not null,
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  name       VARCHAR2(100 CHAR),
  orgi       VARCHAR2(100 CHAR),
  user_id    VARCHAR2(32 CHAR),
  lastmsg    VARCHAR2(100 CHAR),
  newmsg     NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_RECENTUSER.id
  is '主键ID';
comment on column KEFU5.UK_RECENTUSER.creater
  is '创建人ID';
comment on column KEFU5.UK_RECENTUSER.createtime
  is '创建时间';
comment on column KEFU5.UK_RECENTUSER.updatetime
  is '更新时间';
comment on column KEFU5.UK_RECENTUSER.name
  is '名称';
comment on column KEFU5.UK_RECENTUSER.orgi
  is '租户ID';
comment on column KEFU5.UK_RECENTUSER.user_id
  is '用户ID';
comment on column KEFU5.UK_RECENTUSER.lastmsg
  is '最后一条消息';
comment on column KEFU5.UK_RECENTUSER.newmsg
  is '未读消息数量';
alter table KEFU5.UK_RECENTUSER
  add constraint PRIMARY_41 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_ROLE
prompt ======================
prompt
create table KEFU5.UK_ROLE
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_ROLE.id
  is '主键ID';
comment on column KEFU5.UK_ROLE.name
  is '名称';
comment on column KEFU5.UK_ROLE.code
  is '代码';
comment on column KEFU5.UK_ROLE.createtime
  is '创建时间';
comment on column KEFU5.UK_ROLE.creater
  is '创建人';
comment on column KEFU5.UK_ROLE.updatetime
  is '更新时间';
comment on column KEFU5.UK_ROLE.orgi
  is '租户ID';
comment on column KEFU5.UK_ROLE.username
  is '用户名';
alter table KEFU5.UK_ROLE
  add constraint PRIMARY_42 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_ROLE_AUTH
prompt ===========================
prompt
create table KEFU5.UK_ROLE_AUTH
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR),
  roleid     VARCHAR2(32 CHAR),
  dicid      VARCHAR2(32 CHAR),
  dicvalue   VARCHAR2(30 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_ROLE_AUTH.id
  is '主键ID';
comment on column KEFU5.UK_ROLE_AUTH.name
  is '名称';
comment on column KEFU5.UK_ROLE_AUTH.code
  is '代码';
comment on column KEFU5.UK_ROLE_AUTH.createtime
  is '创建时间';
comment on column KEFU5.UK_ROLE_AUTH.creater
  is '创建人';
comment on column KEFU5.UK_ROLE_AUTH.updatetime
  is '更新时间';
comment on column KEFU5.UK_ROLE_AUTH.orgi
  is '租户ID';
comment on column KEFU5.UK_ROLE_AUTH.username
  is '用户名';
comment on column KEFU5.UK_ROLE_AUTH.roleid
  is '角色ID';
comment on column KEFU5.UK_ROLE_AUTH.dicid
  is '权限ID';
comment on column KEFU5.UK_ROLE_AUTH.dicvalue
  is '权限代码';
alter table KEFU5.UK_ROLE_AUTH
  add constraint PRIMARY_43 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_SALES_PRODUCT
prompt ===============================
prompt
create table KEFU5.UK_SALES_PRODUCT
(
  id         VARCHAR2(32 CHAR) not null,
  title      VARCHAR2(255 CHAR),
  content    CLOB,
  keyword    VARCHAR2(100 CHAR),
  summary    VARCHAR2(255 CHAR),
  status     VARCHAR2(32 CHAR),
  tptype     VARCHAR2(32 CHAR),
  cate       VARCHAR2(32 CHAR),
  username   VARCHAR2(32 CHAR),
  orgi       VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  memo       VARCHAR2(32 CHAR),
  price      NUMBER(10),
  organ      VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table KEFU5.UK_SALES_PRODUCT
  add constraint PRIMARY_44 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_SALES_PRODUCT_TYPE
prompt ====================================
prompt
create table KEFU5.UK_SALES_PRODUCT_TYPE
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table KEFU5.UK_SALES_PRODUCT_TYPE
  add constraint PRIMARY_45 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_SECRET
prompt ========================
prompt
create table KEFU5.UK_SECRET
(
  id         VARCHAR2(32 CHAR) not null,
  creater    VARCHAR2(32 CHAR),
  createtime VARCHAR2(32 CHAR),
  password   VARCHAR2(100 CHAR),
  orgi       VARCHAR2(32 CHAR),
  model      VARCHAR2(32 CHAR),
  enable     NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_SECRET.id
  is '主键ID';
comment on column KEFU5.UK_SECRET.creater
  is '创建人';
comment on column KEFU5.UK_SECRET.createtime
  is '创建时间';
comment on column KEFU5.UK_SECRET.password
  is '二次密码';
comment on column KEFU5.UK_SECRET.orgi
  is '租户ID';
comment on column KEFU5.UK_SECRET.model
  is '所属组件';
comment on column KEFU5.UK_SECRET.enable
  is '是否启用';
alter table KEFU5.UK_SECRET
  add constraint PRIMARY_46 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_SERVICESUMMARY
prompt ================================
prompt
create table KEFU5.UK_SERVICESUMMARY
(
  id             VARCHAR2(32 CHAR) not null,
  agentusername  VARCHAR2(100 CHAR),
  agentno        VARCHAR2(32 CHAR),
  status         VARCHAR2(32 CHAR),
  times          NUMBER(10),
  servicetime    DATE,
  orgi           VARCHAR2(50 CHAR),
  username       VARCHAR2(100 CHAR),
  userid         VARCHAR2(32 CHAR),
  channel        VARCHAR2(32 CHAR),
  logindate      DATE,
  servicetype    CLOB,
  reservation    NUMBER(3),
  reservtype     VARCHAR2(32 CHAR),
  reservtime     DATE,
  email          VARCHAR2(100 CHAR),
  phonenumber    VARCHAR2(32 CHAR),
  summary        CLOB,
  agentserviceid VARCHAR2(32 CHAR),
  creater        VARCHAR2(32 CHAR),
  createtime     DATE,
  statuseventid  VARCHAR2(50 CHAR),
  contactsid     VARCHAR2(50 CHAR),
  ani            VARCHAR2(50 CHAR),
  caller         VARCHAR2(50 CHAR),
  called         VARCHAR2(50 CHAR),
  agent          VARCHAR2(50 CHAR),
  process        NUMBER(3),
  updateuser     VARCHAR2(32 CHAR),
  updatetime     DATE,
  processmemo    CLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_SERVICESUMMARY.id
  is '主键ID';
comment on column KEFU5.UK_SERVICESUMMARY.agentusername
  is '坐席用户名';
comment on column KEFU5.UK_SERVICESUMMARY.agentno
  is '坐席ID';
comment on column KEFU5.UK_SERVICESUMMARY.status
  is '状态';
comment on column KEFU5.UK_SERVICESUMMARY.times
  is '服务次数';
comment on column KEFU5.UK_SERVICESUMMARY.servicetime
  is '服务时间';
comment on column KEFU5.UK_SERVICESUMMARY.orgi
  is '租户ID';
comment on column KEFU5.UK_SERVICESUMMARY.username
  is '用户名';
comment on column KEFU5.UK_SERVICESUMMARY.userid
  is '用户ID';
comment on column KEFU5.UK_SERVICESUMMARY.channel
  is '渠道';
comment on column KEFU5.UK_SERVICESUMMARY.logindate
  is '登录时间';
comment on column KEFU5.UK_SERVICESUMMARY.servicetype
  is '服务类型';
comment on column KEFU5.UK_SERVICESUMMARY.reservation
  is '是否预约';
comment on column KEFU5.UK_SERVICESUMMARY.reservtype
  is '预约方式';
comment on column KEFU5.UK_SERVICESUMMARY.email
  is '电子邮件';
comment on column KEFU5.UK_SERVICESUMMARY.phonenumber
  is '电话号码';
comment on column KEFU5.UK_SERVICESUMMARY.summary
  is '服务记录';
comment on column KEFU5.UK_SERVICESUMMARY.agentserviceid
  is '服务ID';
comment on column KEFU5.UK_SERVICESUMMARY.creater
  is '创建人';
comment on column KEFU5.UK_SERVICESUMMARY.createtime
  is '创建时间';
comment on column KEFU5.UK_SERVICESUMMARY.statuseventid
  is '电话记录ID';
comment on column KEFU5.UK_SERVICESUMMARY.contactsid
  is '联系人ID';
comment on column KEFU5.UK_SERVICESUMMARY.ani
  is '主叫';
comment on column KEFU5.UK_SERVICESUMMARY.caller
  is '呼叫发起号码';
comment on column KEFU5.UK_SERVICESUMMARY.called
  is '被叫';
comment on column KEFU5.UK_SERVICESUMMARY.agent
  is '分机号';
alter table KEFU5.UK_SERVICESUMMARY
  add constraint PRIMARY_47 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_SESSIONCONFIG
prompt ===============================
prompt
create table KEFU5.UK_SESSIONCONFIG
(
  id                 VARCHAR2(32 CHAR) not null,
  orgi               VARCHAR2(32 CHAR),
  creater            VARCHAR2(32 CHAR),
  username           VARCHAR2(32 CHAR),
  name               VARCHAR2(32 CHAR),
  sessionmsg         VARCHAR2(255 CHAR),
  distribution       VARCHAR2(32 CHAR),
  timeoutmsg         VARCHAR2(255 CHAR),
  retimeoutmsg       VARCHAR2(255 CHAR),
  satisfaction       NUMBER(3),
  createtime         DATE,
  lastagent          NUMBER(3),
  sessiontimeout     NUMBER(3),
  resessiontimeout   NUMBER(3),
  timeout            NUMBER(10),
  retimeout          NUMBER(10),
  agenttimeout       NUMBER(10),
  agentreplaytimeout NUMBER(3),
  agenttimeoutmsg    VARCHAR2(255 CHAR),
  maxuser            NUMBER(10),
  initmaxuser        NUMBER(10),
  workinghours       CLOB,
  notinwhmsg         CLOB,
  hourcheck          NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_SESSIONCONFIG.id
  is '主键ID';
comment on column KEFU5.UK_SESSIONCONFIG.orgi
  is '租户ID';
comment on column KEFU5.UK_SESSIONCONFIG.creater
  is '创建人';
comment on column KEFU5.UK_SESSIONCONFIG.username
  is '用户名';
comment on column KEFU5.UK_SESSIONCONFIG.name
  is '名称';
comment on column KEFU5.UK_SESSIONCONFIG.sessionmsg
  is '会话消息';
comment on column KEFU5.UK_SESSIONCONFIG.distribution
  is '坐席分配策略';
comment on column KEFU5.UK_SESSIONCONFIG.timeoutmsg
  is '超时提醒消息';
comment on column KEFU5.UK_SESSIONCONFIG.retimeoutmsg
  is '再次超时提醒消息';
comment on column KEFU5.UK_SESSIONCONFIG.satisfaction
  is '启用满意度调查';
comment on column KEFU5.UK_SESSIONCONFIG.createtime
  is '创建时间';
comment on column KEFU5.UK_SESSIONCONFIG.lastagent
  is '最后服务坐席优先分配';
comment on column KEFU5.UK_SESSIONCONFIG.sessiontimeout
  is '会话超时时间';
comment on column KEFU5.UK_SESSIONCONFIG.resessiontimeout
  is '再次超时时间';
comment on column KEFU5.UK_SESSIONCONFIG.timeout
  is '超时时长';
comment on column KEFU5.UK_SESSIONCONFIG.retimeout
  is '再次超时时长';
comment on column KEFU5.UK_SESSIONCONFIG.agenttimeout
  is '坐席回复超时时长';
comment on column KEFU5.UK_SESSIONCONFIG.agentreplaytimeout
  is '坐席回复超时时长';
comment on column KEFU5.UK_SESSIONCONFIG.agenttimeoutmsg
  is '超时回复消息';
comment on column KEFU5.UK_SESSIONCONFIG.maxuser
  is '最大用户数';
comment on column KEFU5.UK_SESSIONCONFIG.initmaxuser
  is '首次就绪分配用户数';
comment on column KEFU5.UK_SESSIONCONFIG.workinghours
  is '工作时间段';
comment on column KEFU5.UK_SESSIONCONFIG.notinwhmsg
  is '非工作时间提醒消息';
comment on column KEFU5.UK_SESSIONCONFIG.hourcheck
  is '启用工作时间';
alter table KEFU5.UK_SESSIONCONFIG
  add constraint PRIMARY_48 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_SKILL
prompt =======================
prompt
create table KEFU5.UK_SKILL
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_SKILL.id
  is '主键ID';
comment on column KEFU5.UK_SKILL.name
  is '技能组名称';
comment on column KEFU5.UK_SKILL.code
  is '代码';
comment on column KEFU5.UK_SKILL.createtime
  is '创建时间';
comment on column KEFU5.UK_SKILL.creater
  is '创建人';
comment on column KEFU5.UK_SKILL.updatetime
  is '更新时间';
comment on column KEFU5.UK_SKILL.orgi
  is '租户ID';
comment on column KEFU5.UK_SKILL.username
  is '用户名';
alter table KEFU5.UK_SKILL
  add constraint PRIMARY_49 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_SNSACCOUNT
prompt ============================
prompt
create table KEFU5.UK_SNSACCOUNT
(
  authorizeurl     VARCHAR2(255 CHAR),
  accesstokenurl   VARCHAR2(255 CHAR),
  baseurl          VARCHAR2(255 CHAR),
  redirecturi      VARCHAR2(255 CHAR),
  clientsercret    VARCHAR2(192 CHAR),
  clientid         VARCHAR2(96 CHAR),
  id               VARCHAR2(96 CHAR) not null,
  states           VARCHAR2(32 CHAR),
  region           VARCHAR2(32 CHAR),
  name             VARCHAR2(255 CHAR),
  code             VARCHAR2(255 CHAR),
  username         VARCHAR2(255 CHAR),
  apipoint         VARCHAR2(255 CHAR),
  password         VARCHAR2(255 CHAR),
  snstype          VARCHAR2(255 CHAR),
  createtime       DATE,
  account          VARCHAR2(255 CHAR),
  allowremote      VARCHAR2(255 CHAR),
  email            VARCHAR2(255 CHAR),
  userno           VARCHAR2(255 CHAR),
  token            VARCHAR2(255 CHAR),
  appkey           VARCHAR2(255 CHAR),
  secret           VARCHAR2(255 CHAR),
  aeskey           VARCHAR2(255 CHAR),
  apptoken         VARCHAR2(255 CHAR),
  sessionkey       VARCHAR2(255 CHAR),
  moreparam        VARCHAR2(255 CHAR),
  orgi             VARCHAR2(255 CHAR),
  defaultaccount   NUMBER(5),
  lastatupdate     VARCHAR2(96 CHAR),
  lastprimsgupdate VARCHAR2(96 CHAR),
  acctype          VARCHAR2(32 CHAR),
  updatetime       DATE,
  creater          VARCHAR2(32 CHAR),
  create_time      DATE,
  update_username  VARCHAR2(255 CHAR),
  update_time      DATE,
  update_user      VARCHAR2(255 CHAR),
  shares           VARCHAR2(255 CHAR),
  owner            VARCHAR2(255 CHAR),
  assignedto       VARCHAR2(255 CHAR),
  wfstatus         VARCHAR2(255 CHAR),
  datadept         VARCHAR2(255 CHAR),
  batid            VARCHAR2(32 CHAR),
  alias            VARCHAR2(50 CHAR),
  authaccesstoken  VARCHAR2(255 CHAR),
  expirestime      NUMBER(10),
  headimg          VARCHAR2(255 CHAR),
  oepnscan         VARCHAR2(100 CHAR),
  opencard         VARCHAR2(100 CHAR),
  openstore        VARCHAR2(100 CHAR),
  openpay          VARCHAR2(100 CHAR),
  openshake        VARCHAR2(100 CHAR),
  qrcode           VARCHAR2(100 CHAR),
  refreshtoken     VARCHAR2(255 CHAR),
  verify           VARCHAR2(255 CHAR),
  snsid            VARCHAR2(32 CHAR),
  agent            NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_SNSACCOUNT.authorizeurl
  is '认证URL';
comment on column KEFU5.UK_SNSACCOUNT.accesstokenurl
  is '微博TokenURL';
comment on column KEFU5.UK_SNSACCOUNT.baseurl
  is '基础URL';
comment on column KEFU5.UK_SNSACCOUNT.redirecturi
  is '重定向URL';
comment on column KEFU5.UK_SNSACCOUNT.clientsercret
  is '安全码';
comment on column KEFU5.UK_SNSACCOUNT.clientid
  is '客户端ID';
comment on column KEFU5.UK_SNSACCOUNT.id
  is '主键ID';
comment on column KEFU5.UK_SNSACCOUNT.states
  is '状态';
comment on column KEFU5.UK_SNSACCOUNT.region
  is '区域';
comment on column KEFU5.UK_SNSACCOUNT.name
  is '账号名称';
comment on column KEFU5.UK_SNSACCOUNT.code
  is '编码';
comment on column KEFU5.UK_SNSACCOUNT.username
  is '用户名';
comment on column KEFU5.UK_SNSACCOUNT.apipoint
  is 'API接入点';
comment on column KEFU5.UK_SNSACCOUNT.password
  is '密码';
comment on column KEFU5.UK_SNSACCOUNT.snstype
  is '账号类型（微博/微信）';
comment on column KEFU5.UK_SNSACCOUNT.createtime
  is '创建时间';
comment on column KEFU5.UK_SNSACCOUNT.account
  is '账号';
comment on column KEFU5.UK_SNSACCOUNT.allowremote
  is '允许远程访问';
comment on column KEFU5.UK_SNSACCOUNT.email
  is '邮件';
comment on column KEFU5.UK_SNSACCOUNT.userno
  is '用户名';
comment on column KEFU5.UK_SNSACCOUNT.token
  is '微信Token';
comment on column KEFU5.UK_SNSACCOUNT.appkey
  is '微信AppKey';
comment on column KEFU5.UK_SNSACCOUNT.secret
  is '微信Secret';
comment on column KEFU5.UK_SNSACCOUNT.aeskey
  is '微信AesKey';
comment on column KEFU5.UK_SNSACCOUNT.apptoken
  is '微信AppToken';
comment on column KEFU5.UK_SNSACCOUNT.sessionkey
  is '会话Key';
comment on column KEFU5.UK_SNSACCOUNT.moreparam
  is '更多参数';
comment on column KEFU5.UK_SNSACCOUNT.orgi
  is '租户ID';
comment on column KEFU5.UK_SNSACCOUNT.defaultaccount
  is '默认账号';
comment on column KEFU5.UK_SNSACCOUNT.lastatupdate
  is '最后更新时间';
comment on column KEFU5.UK_SNSACCOUNT.acctype
  is '账号类型';
comment on column KEFU5.UK_SNSACCOUNT.updatetime
  is '更新时间';
comment on column KEFU5.UK_SNSACCOUNT.creater
  is '创建人';
comment on column KEFU5.UK_SNSACCOUNT.create_time
  is '创建时间';
comment on column KEFU5.UK_SNSACCOUNT.update_username
  is '更新用户';
comment on column KEFU5.UK_SNSACCOUNT.update_time
  is '修改时间';
comment on column KEFU5.UK_SNSACCOUNT.update_user
  is '修改人';
comment on column KEFU5.UK_SNSACCOUNT.shares
  is '分享给';
comment on column KEFU5.UK_SNSACCOUNT.owner
  is '所属人';
comment on column KEFU5.UK_SNSACCOUNT.assignedto
  is '分配目标用户';
comment on column KEFU5.UK_SNSACCOUNT.wfstatus
  is '流程状态';
comment on column KEFU5.UK_SNSACCOUNT.datadept
  is '创建人部门';
comment on column KEFU5.UK_SNSACCOUNT.batid
  is '批次ID';
comment on column KEFU5.UK_SNSACCOUNT.alias
  is '别称';
comment on column KEFU5.UK_SNSACCOUNT.authaccesstoken
  is '认证token（微信第三方平台）';
comment on column KEFU5.UK_SNSACCOUNT.expirestime
  is '过期时间（微信第三方平台）';
comment on column KEFU5.UK_SNSACCOUNT.headimg
  is '账号头像（微信第三方平台）';
alter table KEFU5.UK_SNSACCOUNT
  add constraint PRIMARY_50 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_SYSDIC
prompt ========================
prompt
create table KEFU5.UK_SYSDIC
(
  id           VARCHAR2(32 CHAR) not null,
  name         VARCHAR2(100 CHAR),
  title        VARCHAR2(100 CHAR),
  code         VARCHAR2(100 CHAR),
  orgi         VARCHAR2(32 CHAR),
  ctype        VARCHAR2(32 CHAR),
  parentid     VARCHAR2(32 CHAR),
  description  VARCHAR2(255 CHAR),
  memo         VARCHAR2(32 CHAR),
  iconstr      VARCHAR2(255 CHAR),
  iconskin     VARCHAR2(255 CHAR),
  catetype     VARCHAR2(32 CHAR),
  creater      VARCHAR2(32 CHAR),
  createtime   DATE,
  updatetime   DATE,
  haschild     NUMBER(3),
  sortindex    NUMBER(10),
  dicid        VARCHAR2(32 CHAR),
  defaultvalue NUMBER(3),
  discode      NUMBER(3),
  url          VARCHAR2(255 CHAR),
  module       VARCHAR2(32 CHAR),
  mlevel       VARCHAR2(32 CHAR),
  rules        VARCHAR2(100 CHAR),
  menutype     VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_SYSDIC.id
  is '主键ID';
comment on column KEFU5.UK_SYSDIC.name
  is '字典名称';
comment on column KEFU5.UK_SYSDIC.title
  is '标题';
comment on column KEFU5.UK_SYSDIC.code
  is '代码';
comment on column KEFU5.UK_SYSDIC.orgi
  is '租户ID';
comment on column KEFU5.UK_SYSDIC.ctype
  is '类型';
comment on column KEFU5.UK_SYSDIC.parentid
  is '父级ID';
comment on column KEFU5.UK_SYSDIC.description
  is '描述';
comment on column KEFU5.UK_SYSDIC.memo
  is '备注';
comment on column KEFU5.UK_SYSDIC.iconstr
  is '图标';
comment on column KEFU5.UK_SYSDIC.iconskin
  is '自定义样式';
comment on column KEFU5.UK_SYSDIC.catetype
  is '类型';
comment on column KEFU5.UK_SYSDIC.creater
  is '创建人';
comment on column KEFU5.UK_SYSDIC.createtime
  is '创建时间';
comment on column KEFU5.UK_SYSDIC.updatetime
  is '更新时间';
comment on column KEFU5.UK_SYSDIC.haschild
  is '是否有下级';
comment on column KEFU5.UK_SYSDIC.sortindex
  is '排序';
comment on column KEFU5.UK_SYSDIC.dicid
  is '目录ID';
comment on column KEFU5.UK_SYSDIC.defaultvalue
  is '默认值';
comment on column KEFU5.UK_SYSDIC.discode
  is '编码';
comment on column KEFU5.UK_SYSDIC.url
  is '系统权限资源的URL';
comment on column KEFU5.UK_SYSDIC.module
  is '权限资源所属模块';
comment on column KEFU5.UK_SYSDIC.mlevel
  is '菜单级别（一级/二级）';
comment on column KEFU5.UK_SYSDIC.menutype
  is '菜单类型（顶部菜单/左侧菜单）';
alter table KEFU5.UK_SYSDIC
  add constraint PRIMARY_51 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_SYSTEMCONFIG
prompt ==============================
prompt
create table KEFU5.UK_SYSTEMCONFIG
(
  id            VARCHAR2(32 CHAR) not null,
  name          VARCHAR2(100 CHAR),
  title         VARCHAR2(100 CHAR),
  code          VARCHAR2(100 CHAR),
  orgi          VARCHAR2(32 CHAR),
  ctype         VARCHAR2(32 CHAR),
  parentid      VARCHAR2(32 CHAR),
  description   VARCHAR2(255 CHAR),
  memo          VARCHAR2(32 CHAR),
  iconstr       VARCHAR2(255 CHAR),
  iconskin      VARCHAR2(255 CHAR),
  catetype      VARCHAR2(32 CHAR),
  creater       VARCHAR2(32 CHAR),
  createtime    DATE,
  updatetime    DATE,
  haschild      NUMBER(3),
  sortindex     NUMBER(10),
  dicid         VARCHAR2(32 CHAR),
  defaultvalue  NUMBER(3),
  theme         VARCHAR2(50 CHAR),
  loglevel      VARCHAR2(32 CHAR),
  enablessl     NUMBER(3),
  jksfile       VARCHAR2(255 CHAR),
  jkspassword   VARCHAR2(255 CHAR),
  mapkey        VARCHAR2(255 CHAR),
  workorders    NUMBER(3),
  callcenter    NUMBER(3),
  cc_extention  VARCHAR2(32 CHAR),
  cc_quene      VARCHAR2(32 CHAR),
  cc_router     VARCHAR2(32 CHAR),
  cc_ivr        VARCHAR2(32 CHAR),
  cc_acl        VARCHAR2(32 CHAR),
  cc_siptrunk   VARCHAR2(32 CHAR),
  cc_callcenter VARCHAR2(32 CHAR),
  callout       NUMBER(3),
  auth          NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_SYSTEMCONFIG.id
  is '主键ID';
comment on column KEFU5.UK_SYSTEMCONFIG.name
  is '名称';
comment on column KEFU5.UK_SYSTEMCONFIG.title
  is '标题';
comment on column KEFU5.UK_SYSTEMCONFIG.code
  is '编码';
comment on column KEFU5.UK_SYSTEMCONFIG.orgi
  is '租户ID';
comment on column KEFU5.UK_SYSTEMCONFIG.ctype
  is '类型';
comment on column KEFU5.UK_SYSTEMCONFIG.parentid
  is '父级ID';
comment on column KEFU5.UK_SYSTEMCONFIG.description
  is '描述';
comment on column KEFU5.UK_SYSTEMCONFIG.iconstr
  is '自定义样式';
comment on column KEFU5.UK_SYSTEMCONFIG.iconskin
  is '自定义样式';
comment on column KEFU5.UK_SYSTEMCONFIG.catetype
  is '分类';
comment on column KEFU5.UK_SYSTEMCONFIG.creater
  is '创建人';
comment on column KEFU5.UK_SYSTEMCONFIG.createtime
  is '创建时间';
comment on column KEFU5.UK_SYSTEMCONFIG.updatetime
  is '更新时间';
comment on column KEFU5.UK_SYSTEMCONFIG.haschild
  is '是否有下级';
comment on column KEFU5.UK_SYSTEMCONFIG.sortindex
  is '排序';
comment on column KEFU5.UK_SYSTEMCONFIG.dicid
  is '目录ID';
comment on column KEFU5.UK_SYSTEMCONFIG.defaultvalue
  is '默认值';
comment on column KEFU5.UK_SYSTEMCONFIG.theme
  is '皮肤';
comment on column KEFU5.UK_SYSTEMCONFIG.loglevel
  is '日志级别';
comment on column KEFU5.UK_SYSTEMCONFIG.enablessl
  is '启用SSL';
comment on column KEFU5.UK_SYSTEMCONFIG.jksfile
  is 'JKS文件路径';
comment on column KEFU5.UK_SYSTEMCONFIG.jkspassword
  is 'JKS密码';
comment on column KEFU5.UK_SYSTEMCONFIG.mapkey
  is '百度地图授权编码';
comment on column KEFU5.UK_SYSTEMCONFIG.workorders
  is '启用工单三栏布局';
comment on column KEFU5.UK_SYSTEMCONFIG.callcenter
  is '启用呼叫中心';
comment on column KEFU5.UK_SYSTEMCONFIG.cc_extention
  is '分机';
comment on column KEFU5.UK_SYSTEMCONFIG.cc_quene
  is '技能组队列';
comment on column KEFU5.UK_SYSTEMCONFIG.cc_router
  is '路由策略';
comment on column KEFU5.UK_SYSTEMCONFIG.cc_ivr
  is 'IVR模板';
comment on column KEFU5.UK_SYSTEMCONFIG.cc_acl
  is '访问列表模板';
comment on column KEFU5.UK_SYSTEMCONFIG.cc_siptrunk
  is 'SIP配置模板';
comment on column KEFU5.UK_SYSTEMCONFIG.cc_callcenter
  is '呼叫中心配置';
comment on column KEFU5.UK_SYSTEMCONFIG.callout
  is '是否允许点击号码外呼';
comment on column KEFU5.UK_SYSTEMCONFIG.auth
  is '启用权限控制';
create index KEFU5.SQL121227155532210 on KEFU5.UK_SYSTEMCONFIG (ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_TABLEPROPERTIES
prompt =================================
prompt
create table KEFU5.UK_TABLEPROPERTIES
(
  id                VARCHAR2(32 CHAR) not null,
  name              VARCHAR2(255 CHAR),
  code              VARCHAR2(255 CHAR),
  groupid           VARCHAR2(255 CHAR),
  userid            VARCHAR2(255 CHAR),
  fieldname         VARCHAR2(255 CHAR),
  datatypecode      NUMBER(10) not null,
  datatypename      VARCHAR2(255 CHAR),
  dbtableid         VARCHAR2(255 CHAR),
  indexdatatype     VARCHAR2(255 CHAR),
  pk                NUMBER(5),
  modits            NUMBER(5),
  indexfield        VARCHAR2(32 CHAR),
  plugin            VARCHAR2(32 CHAR),
  orgi              VARCHAR2(32 CHAR),
  fktable           VARCHAR2(32 CHAR),
  fkproperty        VARCHAR2(32 CHAR),
  tablename         VARCHAR2(255 CHAR),
  viewtype          VARCHAR2(255 CHAR),
  sortindex         NUMBER(10),
  systemfield       NUMBER(3),
  inx               NUMBER(3),
  token             NUMBER(3),
  length            NUMBER(10),
  fieldstatus       NUMBER(3),
  seldata           NUMBER(3),
  seldatacode       VARCHAR2(32 CHAR),
  seldatakey        VARCHAR2(32 CHAR),
  seldatavalue      VARCHAR2(32 CHAR),
  seldatatype       VARCHAR2(32 CHAR),
  reftbid           VARCHAR2(32 CHAR),
  reftpid           VARCHAR2(32 CHAR),
  reftype           VARCHAR2(32 CHAR),
  reftbname         VARCHAR2(60 CHAR),
  reftpname         VARCHAR2(60 CHAR),
  reftptitlefield   VARCHAR2(60 CHAR),
  reffk             NUMBER(3),
  defaultsort       NUMBER(3),
  defaultvalue      VARCHAR2(255 CHAR),
  defaultvaluetitle VARCHAR2(255 CHAR),
  defaultfieldvalue VARCHAR2(255 CHAR),
  multpartfile      NUMBER(3),
  uploadtype        VARCHAR2(255 CHAR),
  cascadetype       VARCHAR2(255 CHAR),
  title             NUMBER(3),
  descorder         NUMBER(3),
  impfield          NUMBER(3) default '0',
  tokentype         VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_TABLEPROPERTIES.id
  is '主键ID';
comment on column KEFU5.UK_TABLEPROPERTIES.name
  is '字段名称';
comment on column KEFU5.UK_TABLEPROPERTIES.code
  is '代码';
comment on column KEFU5.UK_TABLEPROPERTIES.groupid
  is '组ID';
comment on column KEFU5.UK_TABLEPROPERTIES.userid
  is '创建人ID';
comment on column KEFU5.UK_TABLEPROPERTIES.fieldname
  is '字段名称';
comment on column KEFU5.UK_TABLEPROPERTIES.datatypecode
  is '数据类型代码';
comment on column KEFU5.UK_TABLEPROPERTIES.datatypename
  is '字段类型名称';
comment on column KEFU5.UK_TABLEPROPERTIES.dbtableid
  is '数据表ID';
comment on column KEFU5.UK_TABLEPROPERTIES.indexdatatype
  is '字段类型';
comment on column KEFU5.UK_TABLEPROPERTIES.pk
  is '是否外键';
comment on column KEFU5.UK_TABLEPROPERTIES.indexfield
  is '是否索引';
comment on column KEFU5.UK_TABLEPROPERTIES.plugin
  is '处理插件';
comment on column KEFU5.UK_TABLEPROPERTIES.orgi
  is '租户ID';
comment on column KEFU5.UK_TABLEPROPERTIES.fktable
  is '外键表';
comment on column KEFU5.UK_TABLEPROPERTIES.fkproperty
  is '外键字段';
comment on column KEFU5.UK_TABLEPROPERTIES.tablename
  is '数据表名称';
comment on column KEFU5.UK_TABLEPROPERTIES.sortindex
  is '排序位置';
comment on column KEFU5.UK_TABLEPROPERTIES.systemfield
  is '系统字段';
comment on column KEFU5.UK_TABLEPROPERTIES.inx
  is '索引';
comment on column KEFU5.UK_TABLEPROPERTIES.token
  is '分词';
comment on column KEFU5.UK_TABLEPROPERTIES.length
  is '长度';
comment on column KEFU5.UK_TABLEPROPERTIES.fieldstatus
  is '字段状态';
comment on column KEFU5.UK_TABLEPROPERTIES.seldata
  is '关联字段数据';
comment on column KEFU5.UK_TABLEPROPERTIES.seldatacode
  is '关联字段代码';
comment on column KEFU5.UK_TABLEPROPERTIES.seldatakey
  is '关联key';
comment on column KEFU5.UK_TABLEPROPERTIES.seldatavalue
  is '关联字段值';
comment on column KEFU5.UK_TABLEPROPERTIES.seldatatype
  is '关联类型';
comment on column KEFU5.UK_TABLEPROPERTIES.reftbid
  is '引用表ID';
comment on column KEFU5.UK_TABLEPROPERTIES.reftpid
  is '引用字段ID';
comment on column KEFU5.UK_TABLEPROPERTIES.reftype
  is '引用类型';
comment on column KEFU5.UK_TABLEPROPERTIES.reftbname
  is '引用表名称';
create index KEFU5.FKF8D747811BE44FF on KEFU5.UK_TABLEPROPERTIES (FKPROPERTY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index KEFU5.FKF8D74787854BC62 on KEFU5.UK_TABLEPROPERTIES (DBTABLEID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table KEFU5.UK_TABLEPROPERTIES
  add constraint PRIMARY_52 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_TABLETASK
prompt ===========================
prompt
create table KEFU5.UK_TABLETASK
(
  id               VARCHAR2(32 CHAR) not null,
  name             VARCHAR2(255 CHAR),
  secure           VARCHAR2(255 CHAR),
  taskstatus       VARCHAR2(255 CHAR),
  tabledirid       VARCHAR2(255 CHAR),
  dbid             VARCHAR2(255 CHAR),
  code             VARCHAR2(255 CHAR),
  groupid          VARCHAR2(255 CHAR),
  creater          VARCHAR2(32 CHAR),
  creatername      VARCHAR2(255 CHAR),
  tasktype         VARCHAR2(255 CHAR),
  taskname         VARCHAR2(255 CHAR),
  taskplan         VARCHAR2(255 CHAR),
  configure        VARCHAR2(255 CHAR),
  secureconf       VARCHAR2(255 CHAR),
  userid           VARCHAR2(255 CHAR),
  previewtemplet   CLOB,
  listblocktemplet CLOB,
  tablename        VARCHAR2(255 CHAR),
  tabletype        VARCHAR2(255 CHAR),
  startindex       NUMBER(10) not null,
  updatetime       DATE,
  updatetimenumber NUMBER(10) not null,
  datasql          CLOB,
  databasetask     VARCHAR2(32 CHAR),
  driverplugin     VARCHAR2(32 CHAR),
  orgi             VARCHAR2(32 CHAR),
  workflow         NUMBER(3),
  fromdb           NUMBER(3),
  tabtype          VARCHAR2(32 CHAR),
  pid              VARCHAR2(32 CHAR),
  secmenuid        VARCHAR2(32 CHAR),
  reportid         VARCHAR2(32 CHAR),
  eventname        VARCHAR2(32 CHAR),
  tltemplet        VARCHAR2(32 CHAR),
  timeline         NUMBER(3),
  tbversion        NUMBER(10),
  lastupdate       DATE,
  createtime       DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table KEFU5.UK_TABLETASK
  add constraint PRIMARY_53 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_TAG
prompt =====================
prompt
create table KEFU5.UK_TAG
(
  id         VARCHAR2(32 CHAR) not null,
  tag        VARCHAR2(100 CHAR),
  orgi       VARCHAR2(32 CHAR),
  createtime DATE,
  times      NUMBER(10),
  creater    VARCHAR2(32 CHAR),
  tagtype    VARCHAR2(32 CHAR),
  icon       VARCHAR2(50 CHAR),
  color      VARCHAR2(10 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_TAG.id
  is '主键ID';
comment on column KEFU5.UK_TAG.tag
  is '标签';
comment on column KEFU5.UK_TAG.orgi
  is '租户ID';
comment on column KEFU5.UK_TAG.createtime
  is '创建时间';
comment on column KEFU5.UK_TAG.times
  is '引用次数';
comment on column KEFU5.UK_TAG.creater
  is '创建人';
comment on column KEFU5.UK_TAG.tagtype
  is '标签类型';
comment on column KEFU5.UK_TAG.icon
  is '图标';
comment on column KEFU5.UK_TAG.color
  is '颜色';
alter table KEFU5.UK_TAG
  add constraint PRIMARY_54 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_TAGRELATION
prompt =============================
prompt
create table KEFU5.UK_TAGRELATION
(
  id     VARCHAR2(32 CHAR) not null,
  tagid  VARCHAR2(32 CHAR),
  userid VARCHAR2(32 CHAR),
  dataid VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_TAGRELATION.id
  is '主键ID';
comment on column KEFU5.UK_TAGRELATION.tagid
  is '标签ID';
comment on column KEFU5.UK_TAGRELATION.userid
  is '创建人';
comment on column KEFU5.UK_TAGRELATION.dataid
  is '数据ID';
alter table KEFU5.UK_TAGRELATION
  add constraint PRIMARY_55 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_TEMPLET
prompt =========================
prompt
create table KEFU5.UK_TEMPLET
(
  id          VARCHAR2(32 CHAR) not null,
  name        VARCHAR2(255 CHAR),
  description CLOB,
  code        VARCHAR2(255 CHAR),
  groupid     VARCHAR2(255 CHAR),
  createtime  DATE,
  userid      VARCHAR2(255 CHAR),
  templettext CLOB,
  templettype VARCHAR2(255 CHAR),
  orgi        VARCHAR2(32 CHAR),
  iconstr     VARCHAR2(255 CHAR),
  memo        VARCHAR2(255 CHAR),
  orderindex  NUMBER(10),
  typeid      VARCHAR2(32 CHAR),
  seldata     NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_TEMPLET.id
  is '主键ID';
comment on column KEFU5.UK_TEMPLET.name
  is '模板名称';
comment on column KEFU5.UK_TEMPLET.description
  is '描述';
comment on column KEFU5.UK_TEMPLET.code
  is '代码';
comment on column KEFU5.UK_TEMPLET.groupid
  is '组ID';
comment on column KEFU5.UK_TEMPLET.createtime
  is '创建时间';
comment on column KEFU5.UK_TEMPLET.userid
  is '创建人ID';
comment on column KEFU5.UK_TEMPLET.templettext
  is '模板内容';
comment on column KEFU5.UK_TEMPLET.templettype
  is '模板类型';
comment on column KEFU5.UK_TEMPLET.orgi
  is '租户ID';
comment on column KEFU5.UK_TEMPLET.iconstr
  is '自定义样式';
comment on column KEFU5.UK_TEMPLET.memo
  is '备注';
comment on column KEFU5.UK_TEMPLET.orderindex
  is '排序位置';
comment on column KEFU5.UK_TEMPLET.typeid
  is '分类ID';
alter table KEFU5.UK_TEMPLET
  add constraint PRIMARY_56 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_USER
prompt ======================
prompt
create table KEFU5.UK_USER
(
  id               VARCHAR2(32 CHAR) not null,
  language         VARCHAR2(255 CHAR),
  username         VARCHAR2(255 CHAR),
  password         VARCHAR2(255 CHAR),
  secureconf       VARCHAR2(255 CHAR),
  email            VARCHAR2(255 CHAR),
  firstname        VARCHAR2(255 CHAR),
  midname          VARCHAR2(255 CHAR),
  lastname         VARCHAR2(255 CHAR),
  jobtitle         VARCHAR2(255 CHAR),
  department       VARCHAR2(255 CHAR),
  gender           VARCHAR2(255 CHAR),
  birthday         VARCHAR2(255 CHAR),
  nickname         VARCHAR2(255 CHAR),
  usertype         VARCHAR2(255 CHAR),
  rulename         VARCHAR2(255 CHAR),
  searchprojectid  VARCHAR2(255 CHAR),
  orgi             VARCHAR2(32 CHAR),
  creater          VARCHAR2(32 CHAR),
  createtime       DATE,
  memo             VARCHAR2(255 CHAR),
  updatetime       DATE,
  organ            VARCHAR2(32 CHAR),
  mobile           VARCHAR2(32 CHAR),
  passupdatetime   DATE,
  sign             CLOB,
  del              NUMBER(3) default '0',
  uname            VARCHAR2(100 CHAR),
  musteditpassword NUMBER(3),
  agent            NUMBER(3),
  skill            VARCHAR2(32 CHAR),
  province         VARCHAR2(50 CHAR),
  city             VARCHAR2(50 CHAR),
  fans             NUMBER(10),
  follows          NUMBER(10),
  integral         NUMBER(10),
  lastlogintime    DATE,
  status           VARCHAR2(10 CHAR),
  deactivetime     DATE,
  title            VARCHAR2(50 CHAR),
  datastatus       NUMBER(3),
  callcenter       NUMBER(3),
  superuser        NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_USER.id
  is '主键ID';
comment on column KEFU5.UK_USER.language
  is '语言';
comment on column KEFU5.UK_USER.username
  is '用户名';
comment on column KEFU5.UK_USER.password
  is '密码';
comment on column KEFU5.UK_USER.secureconf
  is '安全级别';
comment on column KEFU5.UK_USER.email
  is '邮件';
comment on column KEFU5.UK_USER.firstname
  is '姓';
comment on column KEFU5.UK_USER.midname
  is '名';
comment on column KEFU5.UK_USER.lastname
  is '名';
comment on column KEFU5.UK_USER.jobtitle
  is '职位';
comment on column KEFU5.UK_USER.department
  is '部门';
comment on column KEFU5.UK_USER.gender
  is '性别';
comment on column KEFU5.UK_USER.birthday
  is '生日';
comment on column KEFU5.UK_USER.nickname
  is '昵称';
comment on column KEFU5.UK_USER.usertype
  is '用户类型';
comment on column KEFU5.UK_USER.rulename
  is '角色';
comment on column KEFU5.UK_USER.searchprojectid
  is '备用';
comment on column KEFU5.UK_USER.orgi
  is '租户ID';
comment on column KEFU5.UK_USER.creater
  is '创建人';
comment on column KEFU5.UK_USER.createtime
  is '创建时间';
comment on column KEFU5.UK_USER.memo
  is '备注';
comment on column KEFU5.UK_USER.updatetime
  is '更新时间';
comment on column KEFU5.UK_USER.organ
  is '部门';
comment on column KEFU5.UK_USER.mobile
  is '手机号';
comment on column KEFU5.UK_USER.passupdatetime
  is '最后 一次密码修改时间';
comment on column KEFU5.UK_USER.agent
  is '工号';
comment on column KEFU5.UK_USER.skill
  is '技能组';
comment on column KEFU5.UK_USER.province
  is '省份';
comment on column KEFU5.UK_USER.city
  is '城市';
comment on column KEFU5.UK_USER.fans
  is '关注人数';
comment on column KEFU5.UK_USER.follows
  is '被关注次数';
comment on column KEFU5.UK_USER.lastlogintime
  is '最后登录时间';
comment on column KEFU5.UK_USER.status
  is '状态';
comment on column KEFU5.UK_USER.deactivetime
  is '离线时间';
comment on column KEFU5.UK_USER.title
  is '标题';
comment on column KEFU5.UK_USER.datastatus
  is '数据状态';
comment on column KEFU5.UK_USER.callcenter
  is '启用呼叫中心坐席';
comment on column KEFU5.UK_USER.superuser
  is '是否超级管理员';
alter table KEFU5.UK_USER
  add constraint PRIMARY_57 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_USEREVENT
prompt ===========================
prompt
create table KEFU5.UK_USEREVENT
(
  id         VARCHAR2(32 CHAR) not null,
  username   VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  orgi       VARCHAR2(50 CHAR),
  maintype   VARCHAR2(32 CHAR),
  subtype    VARCHAR2(32 CHAR),
  name       VARCHAR2(32 CHAR),
  admin      NUMBER(3),
  accessnum  NUMBER(3),
  ip         VARCHAR2(20 CHAR),
  hostname   VARCHAR2(50 CHAR),
  country    VARCHAR2(50 CHAR),
  region     VARCHAR2(50 CHAR),
  city       VARCHAR2(32 CHAR),
  isp        VARCHAR2(32 CHAR),
  province   VARCHAR2(32 CHAR),
  url        VARCHAR2(255 CHAR),
  sessionid  VARCHAR2(32 CHAR),
  param      CLOB,
  times      NUMBER(10),
  createtime DATE,
  updatetime DATE,
  title      VARCHAR2(255 CHAR),
  ostype     VARCHAR2(100 CHAR),
  browser    VARCHAR2(50 CHAR),
  mobile     VARCHAR2(10 CHAR),
  model      VARCHAR2(10 CHAR),
  appid      VARCHAR2(32 CHAR),
  createdate VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEFU5.UK_USEREVENT.id
  is '主键ID';
comment on column KEFU5.UK_USEREVENT.username
  is '用户名';
comment on column KEFU5.UK_USEREVENT.creater
  is '创建人ID';
comment on column KEFU5.UK_USEREVENT.orgi
  is '租户ID';
comment on column KEFU5.UK_USEREVENT.maintype
  is 'Spring MVC注释分类';
comment on column KEFU5.UK_USEREVENT.subtype
  is '注释二级分类';
comment on column KEFU5.UK_USEREVENT.name
  is '名称';
comment on column KEFU5.UK_USEREVENT.admin
  is '是否管理员';
comment on column KEFU5.UK_USEREVENT.accessnum
  is '访问次数';
comment on column KEFU5.UK_USEREVENT.ip
  is 'IP';
comment on column KEFU5.UK_USEREVENT.hostname
  is '主机名';
comment on column KEFU5.UK_USEREVENT.country
  is '国家';
comment on column KEFU5.UK_USEREVENT.region
  is '区域';
comment on column KEFU5.UK_USEREVENT.city
  is '城市';
comment on column KEFU5.UK_USEREVENT.isp
  is '运营商';
comment on column KEFU5.UK_USEREVENT.province
  is '省份';
comment on column KEFU5.UK_USEREVENT.url
  is '接入URL';
comment on column KEFU5.UK_USEREVENT.sessionid
  is '会话ID';
comment on column KEFU5.UK_USEREVENT.param
  is '请求参数';
comment on column KEFU5.UK_USEREVENT.times
  is '访问次数';
comment on column KEFU5.UK_USEREVENT.createtime
  is '访问时间';
comment on column KEFU5.UK_USEREVENT.updatetime
  is '更新时间';
comment on column KEFU5.UK_USEREVENT.title
  is '页面标题';
comment on column KEFU5.UK_USEREVENT.ostype
  is '操作系统';
comment on column KEFU5.UK_USEREVENT.browser
  is '浏览器';
comment on column KEFU5.UK_USEREVENT.mobile
  is '移动端';
comment on column KEFU5.UK_USEREVENT.model
  is '组件';
comment on column KEFU5.UK_USEREVENT.appid
  is 'SNSID';
comment on column KEFU5.UK_USEREVENT.createdate
  is '创建时间';
alter table KEFU5.UK_USEREVENT
  add constraint PRIMARY_58 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UK_USERROLE
prompt ==========================
prompt
create table KEFU5.UK_USERROLE
(
  id         VARCHAR2(32 CHAR) not null,
  user_id    VARCHAR2(32 CHAR),
  role_id    VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  orgi       VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_USERROLE.id
  is '主键ID';
comment on column KEFU5.UK_USERROLE.user_id
  is '用户ID';
comment on column KEFU5.UK_USERROLE.role_id
  is '角色ID';
comment on column KEFU5.UK_USERROLE.creater
  is '创建人';
comment on column KEFU5.UK_USERROLE.createtime
  is '创建时间';
comment on column KEFU5.UK_USERROLE.orgi
  is '租户ID';
alter table KEFU5.UK_USERROLE
  add constraint PRIMARY_59 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_WEIXINUSER
prompt ============================
prompt
create table KEFU5.UK_WEIXINUSER
(
  id            VARCHAR2(32 CHAR) not null,
  snsid         VARCHAR2(32 CHAR),
  subscribe     NUMBER(3),
  openid        VARCHAR2(100 CHAR),
  nickname      VARCHAR2(50 CHAR),
  sex           VARCHAR2(50 CHAR),
  language      VARCHAR2(50 CHAR),
  city          VARCHAR2(50 CHAR),
  province      VARCHAR2(50 CHAR),
  country       VARCHAR2(50 CHAR),
  headimgurl    VARCHAR2(255 CHAR),
  subscribetime VARCHAR2(32 CHAR),
  unionid       VARCHAR2(50 CHAR),
  sexid         VARCHAR2(50 CHAR),
  remark        VARCHAR2(100 CHAR),
  groupid       VARCHAR2(50 CHAR),
  orgi          VARCHAR2(32 CHAR),
  contactsid    VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_WEIXINUSER.id
  is '主键ID';
comment on column KEFU5.UK_WEIXINUSER.snsid
  is 'SNSID';
comment on column KEFU5.UK_WEIXINUSER.subscribe
  is '是否关注公众号';
comment on column KEFU5.UK_WEIXINUSER.openid
  is 'OPENID';
comment on column KEFU5.UK_WEIXINUSER.nickname
  is '昵称';
comment on column KEFU5.UK_WEIXINUSER.sex
  is '性别';
comment on column KEFU5.UK_WEIXINUSER.language
  is '语言';
comment on column KEFU5.UK_WEIXINUSER.city
  is '城市';
comment on column KEFU5.UK_WEIXINUSER.province
  is '省份';
comment on column KEFU5.UK_WEIXINUSER.country
  is '国家';
comment on column KEFU5.UK_WEIXINUSER.headimgurl
  is '头像';
comment on column KEFU5.UK_WEIXINUSER.subscribetime
  is '关注时间';
comment on column KEFU5.UK_WEIXINUSER.unionid
  is '唯一ID';
comment on column KEFU5.UK_WEIXINUSER.sexid
  is '性别编码';
comment on column KEFU5.UK_WEIXINUSER.remark
  is '签名';
comment on column KEFU5.UK_WEIXINUSER.groupid
  is '组ID';
comment on column KEFU5.UK_WEIXINUSER.orgi
  is '租户ID';
comment on column KEFU5.UK_WEIXINUSER.contactsid
  is '联系人ID';
alter table KEFU5.UK_WEIXINUSER
  add constraint PRIMARY_60 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_WORKORDERS
prompt ============================
prompt
create table KEFU5.UK_WORKORDERS
(
  id          VARCHAR2(32 CHAR) not null,
  name        VARCHAR2(50 CHAR),
  code        VARCHAR2(50 CHAR),
  createtime  DATE,
  creater     VARCHAR2(32 CHAR),
  updatetime  DATE,
  orgi        VARCHAR2(32 CHAR),
  username    VARCHAR2(50 CHAR),
  parent      VARCHAR2(32 CHAR),
  orderno     NUMBER(10),
  sessionid   VARCHAR2(32 CHAR),
  title       VARCHAR2(255 CHAR),
  content     CLOB,
  price       NUMBER(10),
  keyword     VARCHAR2(255 CHAR),
  summary     VARCHAR2(255 CHAR),
  anonymous   NUMBER(3),
  top         NUMBER(3),
  essence     NUMBER(3),
  accept      NUMBER(3),
  finish      NUMBER(3),
  answers     NUMBER(10),
  views       NUMBER(10),
  followers   NUMBER(10),
  collections NUMBER(10),
  comments    NUMBER(10),
  mobile      NUMBER(3),
  status      VARCHAR2(32 CHAR),
  wotype      VARCHAR2(32 CHAR),
  datastatus  NUMBER(3),
  cate        VARCHAR2(32 CHAR),
  priority    VARCHAR2(32 CHAR),
  contacts    VARCHAR2(32 CHAR),
  cusid       VARCHAR2(32 CHAR),
  initiator   CLOB,
  bpmid       VARCHAR2(32 CHAR),
  tags        VARCHAR2(255 CHAR),
  accdept     VARCHAR2(32 CHAR),
  accuser     VARCHAR2(32 CHAR),
  assigned    NUMBER(3),
  organ       VARCHAR2(32 CHAR),
  agent       VARCHAR2(32 CHAR),
  shares      CLOB,
  skill       VARCHAR2(32 CHAR),
  rowcount    NUMBER(10),
  key         VARCHAR2(32 CHAR),
  memo        VARCHAR2(100 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_WORKORDERS.id
  is 'ID';
comment on column KEFU5.UK_WORKORDERS.name
  is '名称';
comment on column KEFU5.UK_WORKORDERS.code
  is '代码';
comment on column KEFU5.UK_WORKORDERS.createtime
  is '创建时间';
comment on column KEFU5.UK_WORKORDERS.creater
  is '创建人';
comment on column KEFU5.UK_WORKORDERS.updatetime
  is '更新时间';
comment on column KEFU5.UK_WORKORDERS.orgi
  is 'ORGI';
comment on column KEFU5.UK_WORKORDERS.username
  is '创建人用户名';
comment on column KEFU5.UK_WORKORDERS.parent
  is 'PARENT';
comment on column KEFU5.UK_WORKORDERS.orderno
  is '工单编号';
comment on column KEFU5.UK_WORKORDERS.sessionid
  is '会话ID';
comment on column KEFU5.UK_WORKORDERS.title
  is '标题';
comment on column KEFU5.UK_WORKORDERS.content
  is '内容';
comment on column KEFU5.UK_WORKORDERS.price
  is 'PRICE';
comment on column KEFU5.UK_WORKORDERS.keyword
  is '关键词';
comment on column KEFU5.UK_WORKORDERS.summary
  is '摘要';
comment on column KEFU5.UK_WORKORDERS.anonymous
  is '允许匿名访问';
comment on column KEFU5.UK_WORKORDERS.top
  is '置顶';
comment on column KEFU5.UK_WORKORDERS.essence
  is '精华';
comment on column KEFU5.UK_WORKORDERS.accept
  is '已采纳答案';
comment on column KEFU5.UK_WORKORDERS.finish
  is '已结束';
comment on column KEFU5.UK_WORKORDERS.answers
  is '回复数量';
comment on column KEFU5.UK_WORKORDERS.views
  is '访问次数';
comment on column KEFU5.UK_WORKORDERS.followers
  is '关注数';
comment on column KEFU5.UK_WORKORDERS.collections
  is '收藏数';
comment on column KEFU5.UK_WORKORDERS.comments
  is '评论数';
comment on column KEFU5.UK_WORKORDERS.mobile
  is '移动端';
comment on column KEFU5.UK_WORKORDERS.status
  is '状态';
comment on column KEFU5.UK_WORKORDERS.wotype
  is '工单类型';
comment on column KEFU5.UK_WORKORDERS.datastatus
  is '数据状态';
comment on column KEFU5.UK_WORKORDERS.cate
  is '类型';
comment on column KEFU5.UK_WORKORDERS.priority
  is '优先级';
comment on column KEFU5.UK_WORKORDERS.contacts
  is '联系人';
comment on column KEFU5.UK_WORKORDERS.cusid
  is '联系人ID';
comment on column KEFU5.UK_WORKORDERS.initiator
  is '发起人';
comment on column KEFU5.UK_WORKORDERS.bpmid
  is '流程ID';
comment on column KEFU5.UK_WORKORDERS.tags
  is '标签';
comment on column KEFU5.UK_WORKORDERS.accdept
  is '受理部门';
comment on column KEFU5.UK_WORKORDERS.accuser
  is '受理人';
comment on column KEFU5.UK_WORKORDERS.assigned
  is '已受理';
comment on column KEFU5.UK_WORKORDERS.organ
  is '部门';
comment on column KEFU5.UK_WORKORDERS.agent
  is '坐席';
comment on column KEFU5.UK_WORKORDERS.shares
  is '共享';
comment on column KEFU5.UK_WORKORDERS.skill
  is '技能组';
comment on column KEFU5.UK_WORKORDERS.memo
  is '备注';
alter table KEFU5.UK_WORKORDERS
  add constraint PRIMARY_62 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_WORKORDER_TYPE
prompt ================================
prompt
create table KEFU5.UK_WORKORDER_TYPE
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR),
  bpm        NUMBER(3),
  processid  VARCHAR2(32 CHAR),
  sla        NUMBER(3),
  slaid      VARCHAR2(32 CHAR),
  parentid   VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_WORKORDER_TYPE.id
  is '主键ID';
comment on column KEFU5.UK_WORKORDER_TYPE.name
  is '名称';
comment on column KEFU5.UK_WORKORDER_TYPE.code
  is '代码';
comment on column KEFU5.UK_WORKORDER_TYPE.createtime
  is '创建时间';
comment on column KEFU5.UK_WORKORDER_TYPE.creater
  is '创建人';
comment on column KEFU5.UK_WORKORDER_TYPE.updatetime
  is '更新时间';
comment on column KEFU5.UK_WORKORDER_TYPE.orgi
  is '租户ID';
comment on column KEFU5.UK_WORKORDER_TYPE.username
  is '用户名';
comment on column KEFU5.UK_WORKORDER_TYPE.bpm
  is '启用流程';
comment on column KEFU5.UK_WORKORDER_TYPE.processid
  is '流程ID';
comment on column KEFU5.UK_WORKORDER_TYPE.sla
  is '请SLA';
comment on column KEFU5.UK_WORKORDER_TYPE.slaid
  is 'SLA指标ID';
comment on column KEFU5.UK_WORKORDER_TYPE.parentid
  is '上级分类ID';
alter table KEFU5.UK_WORKORDER_TYPE
  add constraint PRIMARY_61 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_WORKTIME
prompt ==========================
prompt
create table KEFU5.UK_WORKTIME
(
  id         VARCHAR2(32 CHAR) not null,
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  name       VARCHAR2(100 CHAR),
  orgi       VARCHAR2(100 CHAR),
  hostid     VARCHAR2(32 CHAR),
  type       VARCHAR2(32 CHAR),
  day        VARCHAR2(20 CHAR),
  begintime  VARCHAR2(20 CHAR),
  endtime    VARCHAR2(20 CHAR),
  timetype   VARCHAR2(10 CHAR),
  wfrom      NUMBER(10),
  wto        NUMBER(10),
  dfrom      NUMBER(10),
  dto        NUMBER(10),
  wbegintime VARCHAR2(20 CHAR),
  wendtime   VARCHAR2(20 CHAR),
  dbegintime VARCHAR2(20 CHAR),
  dendtime   VARCHAR2(20 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_WORKTIME.id
  is '主键ID';
comment on column KEFU5.UK_WORKTIME.creater
  is '创建人';
comment on column KEFU5.UK_WORKTIME.createtime
  is '创建时间';
comment on column KEFU5.UK_WORKTIME.updatetime
  is '更新时间';
comment on column KEFU5.UK_WORKTIME.name
  is '名称';
comment on column KEFU5.UK_WORKTIME.orgi
  is '租户ID';
comment on column KEFU5.UK_WORKTIME.hostid
  is 'PBX主机ID';
comment on column KEFU5.UK_WORKTIME.type
  is '类型';
comment on column KEFU5.UK_WORKTIME.day
  is '日期';
comment on column KEFU5.UK_WORKTIME.begintime
  is '开始时间';
comment on column KEFU5.UK_WORKTIME.endtime
  is '结束时间';
comment on column KEFU5.UK_WORKTIME.timetype
  is '时间类型';
comment on column KEFU5.UK_WORKTIME.wfrom
  is '周开始';
comment on column KEFU5.UK_WORKTIME.wto
  is '周结束';
comment on column KEFU5.UK_WORKTIME.dfrom
  is '日期开始';
comment on column KEFU5.UK_WORKTIME.dto
  is '日期结束';
comment on column KEFU5.UK_WORKTIME.wbegintime
  is '周开始时间';
comment on column KEFU5.UK_WORKTIME.wendtime
  is '周结束时间';
comment on column KEFU5.UK_WORKTIME.dbegintime
  is '日期开始时间';
comment on column KEFU5.UK_WORKTIME.dendtime
  is '日期结束时间';
alter table KEFU5.UK_WORKTIME
  add constraint PRIMARY_63 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_WXMPEVENT
prompt ===========================
prompt
create table KEFU5.UK_WXMPEVENT
(
  id         VARCHAR2(32 CHAR) not null,
  fromuser   VARCHAR2(32 CHAR),
  username   VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  orgi       VARCHAR2(50 CHAR),
  country    VARCHAR2(50 CHAR),
  city       VARCHAR2(32 CHAR),
  province   VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  event      VARCHAR2(255 CHAR),
  channel    VARCHAR2(255 CHAR),
  model      VARCHAR2(10 CHAR),
  appid      VARCHAR2(32 CHAR),
  snsid      VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_WXMPEVENT.id
  is '主键ID';
comment on column KEFU5.UK_WXMPEVENT.fromuser
  is '来源用户';
comment on column KEFU5.UK_WXMPEVENT.username
  is '用户名';
comment on column KEFU5.UK_WXMPEVENT.creater
  is '创建人';
comment on column KEFU5.UK_WXMPEVENT.orgi
  is '租户ID';
comment on column KEFU5.UK_WXMPEVENT.country
  is '国家';
comment on column KEFU5.UK_WXMPEVENT.city
  is '城市';
comment on column KEFU5.UK_WXMPEVENT.province
  is '省份';
comment on column KEFU5.UK_WXMPEVENT.createtime
  is '创建时间';
comment on column KEFU5.UK_WXMPEVENT.updatetime
  is '更新时间';
comment on column KEFU5.UK_WXMPEVENT.event
  is '事件';
comment on column KEFU5.UK_WXMPEVENT.channel
  is '渠道';
comment on column KEFU5.UK_WXMPEVENT.model
  is '组件';
comment on column KEFU5.UK_WXMPEVENT.appid
  is 'SNSID';
comment on column KEFU5.UK_WXMPEVENT.snsid
  is 'SNSID';

prompt
prompt Creating table UK_XIAOE_CONFIG
prompt ==============================
prompt
create table KEFU5.UK_XIAOE_CONFIG
(
  id            VARCHAR2(32 CHAR) not null,
  orgi          VARCHAR2(32 CHAR),
  creater       VARCHAR2(32 CHAR),
  username      VARCHAR2(32 CHAR),
  name          VARCHAR2(32 CHAR),
  createtime    DATE,
  enableask     NUMBER(3),
  askfirst      NUMBER(3),
  enablescene   NUMBER(3),
  scenefirst    NUMBER(3),
  enablekeyword NUMBER(3),
  keywordnum    NUMBER(10),
  noresultmsg   CLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_XIAOE_CONFIG.id
  is '主键ID';
comment on column KEFU5.UK_XIAOE_CONFIG.orgi
  is '租户ID';
comment on column KEFU5.UK_XIAOE_CONFIG.creater
  is '创建人';
comment on column KEFU5.UK_XIAOE_CONFIG.username
  is '创建人用户名';
comment on column KEFU5.UK_XIAOE_CONFIG.name
  is '名称';
comment on column KEFU5.UK_XIAOE_CONFIG.createtime
  is '创建时间';
comment on column KEFU5.UK_XIAOE_CONFIG.enableask
  is '允许AI主动发起问答';
comment on column KEFU5.UK_XIAOE_CONFIG.askfirst
  is 'AI优先';
comment on column KEFU5.UK_XIAOE_CONFIG.enablescene
  is '启用场景识别';
comment on column KEFU5.UK_XIAOE_CONFIG.scenefirst
  is '优先命中场景';
comment on column KEFU5.UK_XIAOE_CONFIG.enablekeyword
  is '启用关键词命中';
comment on column KEFU5.UK_XIAOE_CONFIG.keywordnum
  is '关键词数量';
comment on column KEFU5.UK_XIAOE_CONFIG.noresultmsg
  is '未命中回复消息';
alter table KEFU5.UK_XIAOE_CONFIG
  add constraint PRIMARY_64 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_XIAOE_KBS_TYPE
prompt ================================
prompt
create table KEFU5.UK_XIAOE_KBS_TYPE
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_XIAOE_KBS_TYPE.id
  is '主键ID';
comment on column KEFU5.UK_XIAOE_KBS_TYPE.name
  is '名称';
comment on column KEFU5.UK_XIAOE_KBS_TYPE.code
  is '代码';
comment on column KEFU5.UK_XIAOE_KBS_TYPE.createtime
  is '创建时间';
comment on column KEFU5.UK_XIAOE_KBS_TYPE.creater
  is '创建人';
comment on column KEFU5.UK_XIAOE_KBS_TYPE.updatetime
  is '更新时间';
comment on column KEFU5.UK_XIAOE_KBS_TYPE.orgi
  is '租户ID';
comment on column KEFU5.UK_XIAOE_KBS_TYPE.username
  is '用户名';
alter table KEFU5.UK_XIAOE_KBS_TYPE
  add constraint PRIMARY_65 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_XIAOE_SCENE
prompt =============================
prompt
create table KEFU5.UK_XIAOE_SCENE
(
  id          VARCHAR2(32 CHAR) not null,
  sessionid   VARCHAR2(32 CHAR),
  title       VARCHAR2(255 CHAR),
  content     CLOB,
  keyword     VARCHAR2(100 CHAR),
  summary     VARCHAR2(255 CHAR),
  anonymous   NUMBER(3),
  begintime   DATE,
  endtime     DATE,
  top         NUMBER(3),
  essence     NUMBER(3),
  accept      NUMBER(3),
  finish      NUMBER(3),
  answers     NUMBER(10),
  views       NUMBER(10),
  followers   NUMBER(10),
  collections NUMBER(10),
  comments    NUMBER(10),
  mobile      NUMBER(3),
  status      VARCHAR2(32 CHAR),
  tptype      VARCHAR2(32 CHAR),
  cate        VARCHAR2(32 CHAR),
  username    VARCHAR2(32 CHAR),
  orgi        VARCHAR2(32 CHAR),
  creater     VARCHAR2(32 CHAR),
  createtime  DATE,
  updatetime  DATE,
  memo        VARCHAR2(32 CHAR),
  price       NUMBER(10),
  organ       VARCHAR2(32 CHAR),
  replaytype  VARCHAR2(32 CHAR),
  allowask    NUMBER(3),
  inputcon    VARCHAR2(255 CHAR),
  outputcon   VARCHAR2(255 CHAR),
  userinput   CLOB,
  aireply     CLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_XIAOE_SCENE.id
  is '主键ID';
comment on column KEFU5.UK_XIAOE_SCENE.sessionid
  is '会话ID';
comment on column KEFU5.UK_XIAOE_SCENE.title
  is '标题';
comment on column KEFU5.UK_XIAOE_SCENE.content
  is '内容';
comment on column KEFU5.UK_XIAOE_SCENE.keyword
  is '关键词';
comment on column KEFU5.UK_XIAOE_SCENE.summary
  is '摘要';
comment on column KEFU5.UK_XIAOE_SCENE.anonymous
  is '匿名访问';
comment on column KEFU5.UK_XIAOE_SCENE.begintime
  is '有效期开始时间';
comment on column KEFU5.UK_XIAOE_SCENE.endtime
  is '有效期结束时间';
comment on column KEFU5.UK_XIAOE_SCENE.top
  is '置顶';
comment on column KEFU5.UK_XIAOE_SCENE.essence
  is '启用场景';
comment on column KEFU5.UK_XIAOE_SCENE.accept
  is '启用';
comment on column KEFU5.UK_XIAOE_SCENE.finish
  is '是否结束';
comment on column KEFU5.UK_XIAOE_SCENE.answers
  is '回答数量';
comment on column KEFU5.UK_XIAOE_SCENE.views
  is '浏览数量';
comment on column KEFU5.UK_XIAOE_SCENE.followers
  is '关注数量';
comment on column KEFU5.UK_XIAOE_SCENE.collections
  is '回复数量';
comment on column KEFU5.UK_XIAOE_SCENE.comments
  is '评论数量';
comment on column KEFU5.UK_XIAOE_SCENE.mobile
  is '移动端';
comment on column KEFU5.UK_XIAOE_SCENE.status
  is '状态';
comment on column KEFU5.UK_XIAOE_SCENE.tptype
  is '类型';
comment on column KEFU5.UK_XIAOE_SCENE.cate
  is '分类';
comment on column KEFU5.UK_XIAOE_SCENE.username
  is '用户名';
comment on column KEFU5.UK_XIAOE_SCENE.orgi
  is '租户ID';
comment on column KEFU5.UK_XIAOE_SCENE.creater
  is '创建人';
comment on column KEFU5.UK_XIAOE_SCENE.createtime
  is '创建时间';
comment on column KEFU5.UK_XIAOE_SCENE.updatetime
  is '修改时间';
comment on column KEFU5.UK_XIAOE_SCENE.memo
  is '备注';
comment on column KEFU5.UK_XIAOE_SCENE.price
  is '价格';
comment on column KEFU5.UK_XIAOE_SCENE.organ
  is '部门';
comment on column KEFU5.UK_XIAOE_SCENE.replaytype
  is '回复类型';
comment on column KEFU5.UK_XIAOE_SCENE.allowask
  is '允许提问';
comment on column KEFU5.UK_XIAOE_SCENE.inputcon
  is '输入条件';
comment on column KEFU5.UK_XIAOE_SCENE.outputcon
  is '输出条件';
comment on column KEFU5.UK_XIAOE_SCENE.userinput
  is '用户输入';
comment on column KEFU5.UK_XIAOE_SCENE.aireply
  is 'AI回复内容（首条）';
alter table KEFU5.UK_XIAOE_SCENE
  add constraint PRIMARY_66 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_XIAOE_SCENEITEM
prompt =================================
prompt
create table KEFU5.UK_XIAOE_SCENEITEM
(
  id         VARCHAR2(32 CHAR) not null,
  content    VARCHAR2(255 CHAR),
  orgi       VARCHAR2(32 CHAR),
  creater    VARCHAR2(32 CHAR),
  createtime DATE,
  updatetime DATE,
  sceneid    VARCHAR2(32 CHAR),
  inx        NUMBER(10),
  itemtype   VARCHAR2(32 CHAR),
  replaytype VARCHAR2(32 CHAR),
  allowask   NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_XIAOE_SCENEITEM.id
  is '主键ID';
comment on column KEFU5.UK_XIAOE_SCENEITEM.content
  is '回复内容';
comment on column KEFU5.UK_XIAOE_SCENEITEM.orgi
  is '租户ID';
comment on column KEFU5.UK_XIAOE_SCENEITEM.creater
  is '创建人';
comment on column KEFU5.UK_XIAOE_SCENEITEM.createtime
  is '创建时间';
comment on column KEFU5.UK_XIAOE_SCENEITEM.updatetime
  is '更新时间';
comment on column KEFU5.UK_XIAOE_SCENEITEM.sceneid
  is '场景ID';
comment on column KEFU5.UK_XIAOE_SCENEITEM.inx
  is '序号';
comment on column KEFU5.UK_XIAOE_SCENEITEM.itemtype
  is '类型';
comment on column KEFU5.UK_XIAOE_SCENEITEM.replaytype
  is '回复类型';
comment on column KEFU5.UK_XIAOE_SCENEITEM.allowask
  is '允许主动提问';
alter table KEFU5.UK_XIAOE_SCENEITEM
  add constraint PRIMARY_68 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_XIAOE_SCENE_TYPE
prompt ==================================
prompt
create table KEFU5.UK_XIAOE_SCENE_TYPE
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_XIAOE_SCENE_TYPE.id
  is '主键ID';
comment on column KEFU5.UK_XIAOE_SCENE_TYPE.name
  is '名称';
comment on column KEFU5.UK_XIAOE_SCENE_TYPE.code
  is '代码';
comment on column KEFU5.UK_XIAOE_SCENE_TYPE.createtime
  is '创建时间';
comment on column KEFU5.UK_XIAOE_SCENE_TYPE.creater
  is '创建人';
comment on column KEFU5.UK_XIAOE_SCENE_TYPE.updatetime
  is '更新时间';
comment on column KEFU5.UK_XIAOE_SCENE_TYPE.orgi
  is '租户ID';
comment on column KEFU5.UK_XIAOE_SCENE_TYPE.username
  is '用户名';
alter table KEFU5.UK_XIAOE_SCENE_TYPE
  add constraint PRIMARY_67 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_XIAOE_TOPIC
prompt =============================
prompt
create table KEFU5.UK_XIAOE_TOPIC
(
  id          VARCHAR2(32 CHAR) not null,
  sessionid   VARCHAR2(32 CHAR),
  title       VARCHAR2(255 CHAR),
  content     CLOB,
  keyword     VARCHAR2(100 CHAR),
  summary     VARCHAR2(255 CHAR),
  anonymous   NUMBER(3),
  begintime   DATE,
  endtime     DATE,
  top         NUMBER(3),
  essence     NUMBER(3),
  accept      NUMBER(3),
  finish      NUMBER(3),
  answers     NUMBER(10),
  views       NUMBER(10),
  followers   NUMBER(10),
  collections NUMBER(10),
  comments    NUMBER(10),
  mobile      NUMBER(3),
  status      VARCHAR2(32 CHAR),
  tptype      VARCHAR2(32 CHAR),
  cate        VARCHAR2(32 CHAR),
  username    VARCHAR2(32 CHAR),
  orgi        VARCHAR2(32 CHAR),
  creater     VARCHAR2(32 CHAR),
  createtime  DATE,
  updatetime  DATE,
  memo        VARCHAR2(32 CHAR),
  price       NUMBER(10),
  organ       VARCHAR2(32 CHAR),
  sms         VARCHAR2(255 CHAR),
  tts         VARCHAR2(255 CHAR),
  email       CLOB,
  weixin      CLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_XIAOE_TOPIC.id
  is '主键ID';
comment on column KEFU5.UK_XIAOE_TOPIC.sessionid
  is '会话ID';
comment on column KEFU5.UK_XIAOE_TOPIC.title
  is '主题';
comment on column KEFU5.UK_XIAOE_TOPIC.content
  is '知识库内容';
comment on column KEFU5.UK_XIAOE_TOPIC.keyword
  is '关键词';
comment on column KEFU5.UK_XIAOE_TOPIC.summary
  is '摘要';
comment on column KEFU5.UK_XIAOE_TOPIC.anonymous
  is '允许匿名访问';
comment on column KEFU5.UK_XIAOE_TOPIC.begintime
  is '有效期开始时间';
comment on column KEFU5.UK_XIAOE_TOPIC.endtime
  is '有效期结束时间';
comment on column KEFU5.UK_XIAOE_TOPIC.top
  is '是否置顶';
comment on column KEFU5.UK_XIAOE_TOPIC.essence
  is '精华';
comment on column KEFU5.UK_XIAOE_TOPIC.accept
  is '允许评论';
comment on column KEFU5.UK_XIAOE_TOPIC.finish
  is '已结束';
comment on column KEFU5.UK_XIAOE_TOPIC.answers
  is '回答数量';
comment on column KEFU5.UK_XIAOE_TOPIC.views
  is '使用次数';
comment on column KEFU5.UK_XIAOE_TOPIC.followers
  is '关注人数';
comment on column KEFU5.UK_XIAOE_TOPIC.collections
  is '引用次数';
comment on column KEFU5.UK_XIAOE_TOPIC.comments
  is '回复数';
comment on column KEFU5.UK_XIAOE_TOPIC.mobile
  is '移动端支持';
comment on column KEFU5.UK_XIAOE_TOPIC.status
  is '状态';
comment on column KEFU5.UK_XIAOE_TOPIC.tptype
  is '分类';
comment on column KEFU5.UK_XIAOE_TOPIC.cate
  is '分类ID';
comment on column KEFU5.UK_XIAOE_TOPIC.username
  is '用户名';
comment on column KEFU5.UK_XIAOE_TOPIC.orgi
  is '租户ID';
comment on column KEFU5.UK_XIAOE_TOPIC.creater
  is '创建人';
comment on column KEFU5.UK_XIAOE_TOPIC.createtime
  is '创建时间';
comment on column KEFU5.UK_XIAOE_TOPIC.updatetime
  is '修改时间';
comment on column KEFU5.UK_XIAOE_TOPIC.memo
  is '备注';
comment on column KEFU5.UK_XIAOE_TOPIC.price
  is '权重';
comment on column KEFU5.UK_XIAOE_TOPIC.organ
  is '组织机构';
comment on column KEFU5.UK_XIAOE_TOPIC.sms
  is '短信模板';
comment on column KEFU5.UK_XIAOE_TOPIC.tts
  is 'TTS模板';
comment on column KEFU5.UK_XIAOE_TOPIC.email
  is '邮件模板';
comment on column KEFU5.UK_XIAOE_TOPIC.weixin
  is '微信回复模板';
alter table KEFU5.UK_XIAOE_TOPIC
  add constraint PRIMARY_69 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_XIAOE_WORDS
prompt =============================
prompt
create table KEFU5.UK_XIAOE_WORDS
(
  id            VARCHAR2(32 CHAR) not null,
  keyword       VARCHAR2(50 CHAR),
  content       CLOB,
  createtime    DATE,
  creater       VARCHAR2(32 CHAR),
  updatetime    DATE,
  orgi          VARCHAR2(32 CHAR),
  username      VARCHAR2(50 CHAR),
  superordinate VARCHAR2(50 CHAR),
  partofspeech  VARCHAR2(50 CHAR),
  cate          VARCHAR2(32 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_XIAOE_WORDS.id
  is '主键ID';
comment on column KEFU5.UK_XIAOE_WORDS.keyword
  is '关键词';
comment on column KEFU5.UK_XIAOE_WORDS.content
  is '内容';
comment on column KEFU5.UK_XIAOE_WORDS.createtime
  is '创建时间';
comment on column KEFU5.UK_XIAOE_WORDS.creater
  is '创建人';
comment on column KEFU5.UK_XIAOE_WORDS.updatetime
  is '更新时间';
comment on column KEFU5.UK_XIAOE_WORDS.orgi
  is '租户ID';
comment on column KEFU5.UK_XIAOE_WORDS.username
  is '用户名';
comment on column KEFU5.UK_XIAOE_WORDS.superordinate
  is '上位词';
comment on column KEFU5.UK_XIAOE_WORDS.partofspeech
  is '词性';
comment on column KEFU5.UK_XIAOE_WORDS.cate
  is '分类';
alter table KEFU5.UK_XIAOE_WORDS
  add constraint PRIMARY_70 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table UK_XIAOE_WORDS_TYPE
prompt ==================================
prompt
create table KEFU5.UK_XIAOE_WORDS_TYPE
(
  id         VARCHAR2(32 CHAR) not null,
  name       VARCHAR2(50 CHAR),
  code       VARCHAR2(50 CHAR),
  createtime DATE,
  creater    VARCHAR2(32 CHAR),
  updatetime DATE,
  orgi       VARCHAR2(32 CHAR),
  username   VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.UK_XIAOE_WORDS_TYPE.id
  is '主键ID';
comment on column KEFU5.UK_XIAOE_WORDS_TYPE.name
  is '分类名称';
comment on column KEFU5.UK_XIAOE_WORDS_TYPE.code
  is '分类代码';
comment on column KEFU5.UK_XIAOE_WORDS_TYPE.createtime
  is '创建时间';
comment on column KEFU5.UK_XIAOE_WORDS_TYPE.creater
  is '创建人ID';
comment on column KEFU5.UK_XIAOE_WORDS_TYPE.updatetime
  is '更新时间';
comment on column KEFU5.UK_XIAOE_WORDS_TYPE.orgi
  is '租户ID';
comment on column KEFU5.UK_XIAOE_WORDS_TYPE.username
  is '用户名';
alter table KEFU5.UK_XIAOE_WORDS_TYPE
  add constraint PRIMARY_71 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table WF_CC_ORDER
prompt ==========================
prompt
create table KEFU5.WF_CC_ORDER
(
  order_id    VARCHAR2(32 CHAR),
  actor_id    VARCHAR2(50 CHAR),
  creator     VARCHAR2(50 CHAR),
  create_time VARCHAR2(50 CHAR),
  finish_time VARCHAR2(50 CHAR),
  status      NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.WF_CC_ORDER.order_id
  is '流程实例ID';
comment on column KEFU5.WF_CC_ORDER.actor_id
  is '参与者ID';
comment on column KEFU5.WF_CC_ORDER.creator
  is '发起人';
comment on column KEFU5.WF_CC_ORDER.create_time
  is '抄送时间';
comment on column KEFU5.WF_CC_ORDER.finish_time
  is '完成时间';
comment on column KEFU5.WF_CC_ORDER.status
  is '状态';
create index KEFU5.IDX_CCORDER_ORDER on KEFU5.WF_CC_ORDER (ORDER_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table WF_PROCESS
prompt =========================
prompt
create table KEFU5.WF_PROCESS
(
  id           VARCHAR2(32 CHAR) not null,
  name         VARCHAR2(100 CHAR),
  display_name VARCHAR2(200 CHAR),
  type         VARCHAR2(100 CHAR),
  instance_url VARCHAR2(200 CHAR),
  state        NUMBER(3),
  content      BLOB,
  version      NUMBER(10),
  create_time  VARCHAR2(50 CHAR),
  creator      VARCHAR2(50 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.WF_PROCESS.id
  is '主键ID';
comment on column KEFU5.WF_PROCESS.name
  is '流程名称';
comment on column KEFU5.WF_PROCESS.display_name
  is '流程显示名称';
comment on column KEFU5.WF_PROCESS.type
  is '流程类型';
comment on column KEFU5.WF_PROCESS.instance_url
  is '实例url';
comment on column KEFU5.WF_PROCESS.state
  is '流程是否可用';
comment on column KEFU5.WF_PROCESS.content
  is '流程模型定义';
comment on column KEFU5.WF_PROCESS.version
  is '版本';
comment on column KEFU5.WF_PROCESS.create_time
  is '创建时间';
comment on column KEFU5.WF_PROCESS.creator
  is '创建人';
create index KEFU5.IDX_PROCESS_NAME on KEFU5.WF_PROCESS (NAME)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_PROCESS
  add constraint PRIMARY_75 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table WF_HIST_ORDER
prompt ============================
prompt
create table KEFU5.WF_HIST_ORDER
(
  id          VARCHAR2(32 CHAR) not null,
  process_id  VARCHAR2(32 CHAR) not null,
  order_state NUMBER(3) not null,
  creator     VARCHAR2(50 CHAR),
  create_time VARCHAR2(50 CHAR) not null,
  end_time    VARCHAR2(50 CHAR),
  expire_time VARCHAR2(50 CHAR),
  priority    NUMBER(3),
  parent_id   VARCHAR2(32 CHAR),
  order_no    VARCHAR2(50 CHAR),
  variable    VARCHAR2(2000 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.WF_HIST_ORDER.id
  is '主键ID';
comment on column KEFU5.WF_HIST_ORDER.process_id
  is '流程定义ID';
comment on column KEFU5.WF_HIST_ORDER.order_state
  is '状态';
comment on column KEFU5.WF_HIST_ORDER.creator
  is '发起人';
comment on column KEFU5.WF_HIST_ORDER.create_time
  is '发起时间';
comment on column KEFU5.WF_HIST_ORDER.end_time
  is '完成时间';
comment on column KEFU5.WF_HIST_ORDER.expire_time
  is '期望完成时间';
comment on column KEFU5.WF_HIST_ORDER.priority
  is '优先级';
comment on column KEFU5.WF_HIST_ORDER.parent_id
  is '父流程ID';
comment on column KEFU5.WF_HIST_ORDER.order_no
  is '流程实例编号';
comment on column KEFU5.WF_HIST_ORDER.variable
  is '附属变量json存储';
create index KEFU5.FK_HIST_ORDER_PARENTID on KEFU5.WF_HIST_ORDER (PARENT_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index KEFU5.IDX_HIST_ORDER_NO on KEFU5.WF_HIST_ORDER (ORDER_NO)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index KEFU5.IDX_HIST_ORDER_PROCESSID on KEFU5.WF_HIST_ORDER (PROCESS_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_HIST_ORDER
  add constraint PRIMARY_72 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_HIST_ORDER
  add constraint WF_HIST_ORDER_IBFK_1 foreign key (PARENT_ID)
  references KEFU5.WF_HIST_ORDER (ID);
alter table KEFU5.WF_HIST_ORDER
  add constraint WF_HIST_ORDER_IBFK_2 foreign key (PROCESS_ID)
  references KEFU5.WF_PROCESS (ID);

prompt
prompt Creating table WF_HIST_TASK
prompt ===========================
prompt
create table KEFU5.WF_HIST_TASK
(
  id             VARCHAR2(32 CHAR) not null,
  order_id       VARCHAR2(32 CHAR) not null,
  task_name      VARCHAR2(100 CHAR) not null,
  display_name   VARCHAR2(200 CHAR) not null,
  task_type      NUMBER(3) not null,
  perform_type   NUMBER(3),
  task_state     NUMBER(3) not null,
  operator       VARCHAR2(50 CHAR),
  create_time    VARCHAR2(50 CHAR) not null,
  finish_time    VARCHAR2(50 CHAR),
  expire_time    VARCHAR2(50 CHAR),
  action_url     VARCHAR2(200 CHAR),
  parent_task_id VARCHAR2(32 CHAR),
  variable       VARCHAR2(2000 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.WF_HIST_TASK.id
  is '主键ID';
comment on column KEFU5.WF_HIST_TASK.order_id
  is '流程实例ID';
comment on column KEFU5.WF_HIST_TASK.task_name
  is '任务名称';
comment on column KEFU5.WF_HIST_TASK.display_name
  is '任务显示名称';
comment on column KEFU5.WF_HIST_TASK.task_type
  is '任务类型';
comment on column KEFU5.WF_HIST_TASK.perform_type
  is '参与类型';
comment on column KEFU5.WF_HIST_TASK.task_state
  is '任务状态';
comment on column KEFU5.WF_HIST_TASK.operator
  is '任务处理人';
comment on column KEFU5.WF_HIST_TASK.create_time
  is '任务创建时间';
comment on column KEFU5.WF_HIST_TASK.finish_time
  is '任务完成时间';
comment on column KEFU5.WF_HIST_TASK.expire_time
  is '任务期望完成时间';
comment on column KEFU5.WF_HIST_TASK.action_url
  is '任务处理url';
comment on column KEFU5.WF_HIST_TASK.parent_task_id
  is '父任务ID';
comment on column KEFU5.WF_HIST_TASK.variable
  is '附属变量json存储';
create index KEFU5.IDX_HIST_TASK_ORDER on KEFU5.WF_HIST_TASK (ORDER_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index KEFU5.IDX_HIST_TASK_PARENTTASK on KEFU5.WF_HIST_TASK (PARENT_TASK_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index KEFU5.IDX_HIST_TASK_TASKNAME on KEFU5.WF_HIST_TASK (TASK_NAME)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_HIST_TASK
  add constraint PRIMARY_73 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_HIST_TASK
  add constraint WF_HIST_TASK_IBFK_1 foreign key (ORDER_ID)
  references KEFU5.WF_HIST_ORDER (ID);

prompt
prompt Creating table WF_HIST_TASK_ACTOR
prompt =================================
prompt
create table KEFU5.WF_HIST_TASK_ACTOR
(
  task_id  VARCHAR2(32 CHAR) not null,
  actor_id VARCHAR2(50 CHAR) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.WF_HIST_TASK_ACTOR.task_id
  is '任务ID';
comment on column KEFU5.WF_HIST_TASK_ACTOR.actor_id
  is '参与者ID';
create index KEFU5.IDX_HIST_TASKACTOR_TASK on KEFU5.WF_HIST_TASK_ACTOR (TASK_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_HIST_TASK_ACTOR
  add constraint WF_HIST_TASK_ACTOR_IBFK_1 foreign key (TASK_ID)
  references KEFU5.WF_HIST_TASK (ID);

prompt
prompt Creating table WF_ORDER
prompt =======================
prompt
create table KEFU5.WF_ORDER
(
  id               VARCHAR2(32 CHAR) not null,
  parent_id        VARCHAR2(32 CHAR),
  process_id       VARCHAR2(32 CHAR) not null,
  creator          VARCHAR2(50 CHAR),
  create_time      VARCHAR2(50 CHAR) not null,
  expire_time      VARCHAR2(50 CHAR),
  last_update_time VARCHAR2(50 CHAR),
  last_updator     VARCHAR2(50 CHAR),
  priority         NUMBER(3),
  parent_node_name VARCHAR2(100 CHAR),
  order_no         VARCHAR2(50 CHAR),
  variable         VARCHAR2(2000 CHAR),
  version          NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.WF_ORDER.id
  is '主键ID';
comment on column KEFU5.WF_ORDER.parent_id
  is '父流程ID';
comment on column KEFU5.WF_ORDER.process_id
  is '流程定义ID';
comment on column KEFU5.WF_ORDER.creator
  is '发起人';
comment on column KEFU5.WF_ORDER.create_time
  is '发起时间';
comment on column KEFU5.WF_ORDER.expire_time
  is '期望完成时间';
comment on column KEFU5.WF_ORDER.last_update_time
  is '上次更新时间';
comment on column KEFU5.WF_ORDER.last_updator
  is '上次更新人';
comment on column KEFU5.WF_ORDER.priority
  is '优先级';
comment on column KEFU5.WF_ORDER.parent_node_name
  is '父流程依赖的节点名称';
comment on column KEFU5.WF_ORDER.order_no
  is '流程实例编号';
comment on column KEFU5.WF_ORDER.variable
  is '附属变量json存储';
comment on column KEFU5.WF_ORDER.version
  is '版本';
create index KEFU5.FK_ORDER_PARENTID on KEFU5.WF_ORDER (PARENT_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index KEFU5.IDX_ORDER_NO on KEFU5.WF_ORDER (ORDER_NO)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index KEFU5.IDX_ORDER_PROCESSID on KEFU5.WF_ORDER (PROCESS_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_ORDER
  add constraint PRIMARY_74 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_ORDER
  add constraint WF_ORDER_IBFK_1 foreign key (PARENT_ID)
  references KEFU5.WF_ORDER (ID);
alter table KEFU5.WF_ORDER
  add constraint WF_ORDER_IBFK_2 foreign key (PROCESS_ID)
  references KEFU5.WF_PROCESS (ID);

prompt
prompt Creating table WF_SURROGATE
prompt ===========================
prompt
create table KEFU5.WF_SURROGATE
(
  id           VARCHAR2(32 CHAR) not null,
  process_name VARCHAR2(100 CHAR),
  operator     VARCHAR2(50 CHAR),
  surrogate    VARCHAR2(50 CHAR),
  odate        VARCHAR2(64 CHAR),
  sdate        VARCHAR2(64 CHAR),
  edate        VARCHAR2(64 CHAR),
  state        NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.WF_SURROGATE.id
  is '主键ID';
comment on column KEFU5.WF_SURROGATE.process_name
  is '流程名称';
comment on column KEFU5.WF_SURROGATE.operator
  is '授权人';
comment on column KEFU5.WF_SURROGATE.surrogate
  is '代理人';
comment on column KEFU5.WF_SURROGATE.odate
  is '操作时间';
comment on column KEFU5.WF_SURROGATE.sdate
  is '开始时间';
comment on column KEFU5.WF_SURROGATE.edate
  is '结束时间';
comment on column KEFU5.WF_SURROGATE.state
  is '状态';
create index KEFU5.IDX_SURROGATE_OPERATOR on KEFU5.WF_SURROGATE (OPERATOR)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_SURROGATE
  add constraint PRIMARY_76 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table WF_TASK
prompt ======================
prompt
create table KEFU5.WF_TASK
(
  id             VARCHAR2(32 CHAR) not null,
  order_id       VARCHAR2(32 CHAR) not null,
  task_name      VARCHAR2(100 CHAR) not null,
  display_name   VARCHAR2(200 CHAR) not null,
  task_type      NUMBER(3) not null,
  perform_type   NUMBER(3),
  operator       VARCHAR2(50 CHAR),
  create_time    VARCHAR2(50 CHAR),
  finish_time    VARCHAR2(50 CHAR),
  expire_time    VARCHAR2(50 CHAR),
  action_url     VARCHAR2(200 CHAR),
  parent_task_id VARCHAR2(32 CHAR),
  variable       VARCHAR2(2000 CHAR),
  version        NUMBER(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.WF_TASK.id
  is '主键ID';
comment on column KEFU5.WF_TASK.order_id
  is '流程实例ID';
comment on column KEFU5.WF_TASK.task_name
  is '任务名称';
comment on column KEFU5.WF_TASK.display_name
  is '任务显示名称';
comment on column KEFU5.WF_TASK.task_type
  is '任务类型';
comment on column KEFU5.WF_TASK.perform_type
  is '参与类型';
comment on column KEFU5.WF_TASK.operator
  is '任务处理人';
comment on column KEFU5.WF_TASK.create_time
  is '任务创建时间';
comment on column KEFU5.WF_TASK.finish_time
  is '任务完成时间';
comment on column KEFU5.WF_TASK.expire_time
  is '任务期望完成时间';
comment on column KEFU5.WF_TASK.action_url
  is '任务处理的url';
comment on column KEFU5.WF_TASK.parent_task_id
  is '父任务ID';
comment on column KEFU5.WF_TASK.variable
  is '附属变量json存储';
comment on column KEFU5.WF_TASK.version
  is '版本';
create index KEFU5.IDX_TASK_ORDER on KEFU5.WF_TASK (ORDER_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index KEFU5.IDX_TASK_PARENTTASK on KEFU5.WF_TASK (PARENT_TASK_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index KEFU5.IDX_TASK_TASKNAME on KEFU5.WF_TASK (TASK_NAME)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_TASK
  add constraint PRIMARY_77 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_TASK
  add constraint WF_TASK_IBFK_1 foreign key (ORDER_ID)
  references KEFU5.WF_ORDER (ID);

prompt
prompt Creating table WF_TASK_ACTOR
prompt ============================
prompt
create table KEFU5.WF_TASK_ACTOR
(
  task_id  VARCHAR2(32 CHAR) not null,
  actor_id VARCHAR2(50 CHAR) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column KEFU5.WF_TASK_ACTOR.task_id
  is '任务ID';
comment on column KEFU5.WF_TASK_ACTOR.actor_id
  is '参与者ID';
create index KEFU5.IDX_TASKACTOR_TASK on KEFU5.WF_TASK_ACTOR (TASK_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table KEFU5.WF_TASK_ACTOR
  add constraint WF_TASK_ACTOR_IBFK_1 foreign key (TASK_ID)
  references KEFU5.WF_TASK (ID);

prompt
prompt Creating table WF_WORKITEM
prompt ==========================
prompt
create table KEFU5.WF_WORKITEM
(
  task_id           VARCHAR2(255 CHAR) not null,
  process_id        VARCHAR2(255 CHAR),
  order_id          VARCHAR2(255 CHAR),
  order_no          VARCHAR2(255 CHAR),
  process_name      VARCHAR2(255 CHAR),
  instance_url      VARCHAR2(255 CHAR),
  parent_id         VARCHAR2(255 CHAR),
  creator           VARCHAR2(255 CHAR),
  order_create_time VARCHAR2(255 CHAR),
  order_expire_time VARCHAR2(255 CHAR),
  order_variable    VARCHAR2(255 CHAR),
  task_name         VARCHAR2(255 CHAR),
  task_key          VARCHAR2(255 CHAR),
  operator          VARCHAR2(255 CHAR),
  task_create_time  VARCHAR2(255 CHAR),
  task_end_time     VARCHAR2(255 CHAR),
  task_expire_time  VARCHAR2(255 CHAR),
  action_url        VARCHAR2(255 CHAR),
  task_type         NUMBER(10),
  perform_type      NUMBER(10),
  task_variable     VARCHAR2(255 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table KEFU5.WF_WORKITEM
  add constraint PRIMARY_78 primary key (TASK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating sequence DBOBJECTID_SEQUENCE
prompt =====================================
prompt
create sequence KEFU5.DBOBJECTID_SEQUENCE
minvalue 1
maxvalue 999999999999999999999999
start with 1
increment by 50
cache 50;

prompt
prompt Creating sequence UK_FS_EVENT_SOCKET_ID_SEQ
prompt ===========================================
prompt
create sequence KEFU5.UK_FS_EVENT_SOCKET_ID_SEQ
minvalue 1
maxvalue 999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating view MGV_ALL_SCHEMA
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW KEFU5.MGV_ALL_SCHEMA AS
SELECT  md_projects.id project_id            ,
                md_projects.project_name project_name,
                md_connections.id connection_id      ,
                md_connections.host host             ,
                md_connections.port port             ,
                md_connections.username username     ,
                md_catalogs.id catalog_id            ,
                md_catalogs.catalog_name catalog_name,
                md_schemas.id schema_id              ,
                md_schemas.name schema_name
        FROM    md_connections,
                md_catalogs   ,
                md_schemas    ,
                md_projects
        WHERE   md_schemas.catalog_id_fk     = md_catalogs.id
            AND md_catalogs.connection_id_fk = md_connections.id
            AND md_connections.project_id_fk = md_projects.id WITH READ ONLY;

prompt
prompt Creating view MGV_ALL_TABLE_TRIGGERS
prompt ====================================
prompt
CREATE OR REPLACE FORCE VIEW KEFU5.MGV_ALL_TABLE_TRIGGERS AS
SELECT  md_projects.id project_id            ,
                md_projects.project_name project_name,
                md_connections.id connection_id      ,
                md_connections.host host             ,
                md_connections.port port             ,
                md_connections.username username     ,
                md_catalogs.id catalog_id            ,
                md_catalogs.catalog_name catalog_name,
                md_catalogs.dummy_flag dummy_flag    ,
                md_schemas.id schema_id              ,
                md_schemas.name schema_name          ,
                md_tables.id table_id                ,
                md_tables.TABLE_NAME TABLE_NAME      ,
                md_triggers.id trigger_id            ,
                md_triggers.trigger_name trigger_name
        FROM    md_projects   ,
                md_connections,
                md_catalogs   ,
                md_schemas    ,
                md_tables     ,
                md_triggers
        WHERE   md_triggers.table_or_view_id_fk = md_tables.id
            AND md_tables.schema_id_fk          = md_schemas.id
            AND md_schemas.catalog_id_fk        = md_catalogs.id
            AND md_catalogs.connection_id_fk    = md_connections.id
            AND md_connections.project_id_fk    = md_projects.id;

prompt
prompt Creating view MGV_ALL_VIEW_TRIGGERS
prompt ===================================
prompt
CREATE OR REPLACE FORCE VIEW KEFU5.MGV_ALL_VIEW_TRIGGERS AS
SELECT  md_projects.id project_id            ,
                md_projects.project_name project_name,
                md_connections.id connection_id      ,
                md_connections.host host             ,
                md_connections.port port             ,
                md_connections.username username     ,
                md_catalogs.id catalog_id            ,
                md_catalogs.catalog_name catalog_name,
                md_catalogs.dummy_flag dummy_flag    ,
                md_schemas.id schema_id              ,
                md_schemas.name schema_name          ,
                md_views.id view_id                  ,
                md_views.view_name view_name         ,
                md_triggers.id trigger_id            ,
                md_triggers.trigger_name trigger_name
        FROM    md_projects   ,
                md_connections,
                md_catalogs   ,
                md_schemas    ,
                md_views      ,
                md_triggers
        WHERE   md_triggers.table_or_view_id_fk = md_views.id
            AND md_views.schema_id_fk           = md_schemas.id
            AND md_schemas.catalog_id_fk        = md_catalogs.id
            AND md_catalogs.connection_id_fk    = md_connections.id
            AND md_connections.project_id_fk    = md_projects.id;

prompt
prompt Creating view MGV_ALL_CAPTURED_SQL
prompt ==================================
prompt
CREATE OR REPLACE FORCE VIEW KEFU5.MGV_ALL_CAPTURED_SQL AS
WITH
captured_schema AS
(SELECT SCHEMA_ID
   FROM mgv_all_schema
  WHERE connection_id IN
  (SELECT ID FROM md_connections WHERE NVL(type,'Captured') != 'CONVERTED')),
captured_connections AS
(SELECT ID FROM md_connections WHERE NVL(type,'Captured') != 'CONVERTED') ,
captured_view_trigger AS
(SELECT v.trigger_id vt
   FROM mgv_all_view_triggers v
  WHERE v.connection_id IN
  (SELECT * FROM captured_connections)) ,
captured_table_trigger AS
(SELECT t.trigger_id tt
   FROM mgv_all_table_triggers t
  WHERE t.connection_id IN
  (SELECT * FROM captured_connections))
SELECT ID,'md_stored_programs' ObjType, Name objectName, native_sql
 FROM md_stored_programs,
captured_schema
WHERE language = 'MSTSQL'
  AND SCHEMA_ID_FK = captured_schema.schema_id
UNION ALL
SELECT ID,'md_views' ObjType, view_Name objectName, native_sql
 FROM md_views,
captured_schema
WHERE language = 'MSTSQL'
  AND SCHEMA_ID_FK = captured_schema.schema_id
UNION ALL
SELECT ID,'md_triggers' ObjType, trigger_Name objectName, native_sql
 FROM md_triggers
WHERE language = 'MSTSQL'
  AND (md_triggers.id in (select vt from captured_view_trigger union select tt from captured_table_trigger  ));

prompt
prompt Creating view MGV_ALL_CATALOGS
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW KEFU5.MGV_ALL_CATALOGS AS
SELECT  md_projects.id project_id            ,
                md_projects.project_name project_name,
                md_connections.id connection_id      ,
                md_connections.host host             ,
                md_connections.port port             ,
                md_connections.username username     ,
                md_connections.dburl dburl           ,
                md_catalogs.id catalog_id            ,
                md_catalogs.catalog_name catalog_name
        FROM    md_projects   ,
                md_connections,
                md_catalogs
        WHERE   md_catalogs.connection_id_fk = md_connections.id
            AND md_connections.project_id_fk = md_projects.id WITH READ ONLY;

prompt
prompt Creating view MGV_ALL_CONNECTIONS
prompt =================================
prompt
CREATE OR REPLACE FORCE VIEW KEFU5.MGV_ALL_CONNECTIONS AS
SELECT  md_projects.id project_id            ,
                md_projects.project_name project_name,
                md_connections.id connection_id      ,
                md_connections.host host             ,
                md_connections.port port             ,
                md_connections.username username     ,
                md_connections.dburl dburl
        FROM    md_projects,
                md_connections
        WHERE   md_connections.project_id_fk = md_projects.id WITH READ ONLY;

prompt
prompt Creating view MGV_ALL_STORED_PROGRAMS
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW KEFU5.MGV_ALL_STORED_PROGRAMS AS
SELECT  md_projects.id project_id                  ,
                md_projects.project_name project_name      ,
                md_connections.id connection_id            ,
                md_connections.host host                   ,
                md_connections.port port                   ,
                md_connections.username username           ,
                md_catalogs.id catalog_id                  ,
                md_catalogs.catalog_name catalog_name      ,
                md_schemas.id schema_id                    ,
                md_schemas.name schema_name                ,
                md_stored_programs.id stored_program_id    ,
                md_stored_programs.programtype programtype ,
                md_stored_programs.name stored_program_name,
                md_stored_programs.package_id_fk package_id_fk
        FROM    md_projects   ,
                md_connections,
                md_catalogs   ,
                md_schemas    ,
                md_stored_programs
        WHERE   md_stored_programs.schema_id_fk = md_schemas.id
            AND md_schemas.catalog_id_fk        = md_catalogs.id
            AND md_catalogs.connection_id_fk    = md_connections.id
            AND md_connections.project_id_fk    = md_projects.id;

prompt
prompt Creating view MGV_ALL_TABLES
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW KEFU5.MGV_ALL_TABLES AS
SELECT  md_projects.id project_id            ,
                md_projects.project_name project_name,
                md_connections.id connection_id      ,
                md_connections.host host             ,
                md_connections.port port             ,
                md_connections.username username     ,
                md_connections.dburl dburl           ,
                md_catalogs.id catalog_id            ,
                md_catalogs.catalog_name catalog_name,
                md_schemas.id schema_id              ,
                md_schemas.name schema_name          ,
                md_tables.id table_id                ,
                md_tables.TABLE_NAME TABLE_NAME
        FROM    md_connections,
                md_catalogs   ,
                md_schemas    ,
                md_tables     ,
                md_projects
        WHERE   md_tables.schema_id_fk       = md_schemas.id
            AND md_schemas.catalog_id_fk     = md_catalogs.id
            AND md_catalogs.connection_id_fk = md_connections.id
            AND md_connections.project_id_fk = md_projects.id WITH READ ONLY;

prompt
prompt Creating view MGV_ALL_VIEWS
prompt ===========================
prompt
CREATE OR REPLACE FORCE VIEW KEFU5.MGV_ALL_VIEWS AS
SELECT  md_projects.id project_id            ,
                md_projects.project_name project_name,
                md_connections.id connection_id      ,
                md_connections.host host             ,
                md_connections.port port             ,
                username username                    ,
                md_catalogs.id catalog_id            ,
                md_catalogs.catalog_name catalog_name,
                md_catalogs.dummy_flag dummy_flag    ,
                md_schemas.id schema_id              ,
                md_schemas.name schema_name          ,
                md_views.id view_id                  ,
                md_views.view_name view_name
        FROM    md_projects   ,
                md_connections,
                md_catalogs   ,
                md_schemas    ,
                md_views
        WHERE   md_views.schema_id_fk        = md_schemas.id
            AND md_schemas.catalog_id_fk     = md_catalogs.id
            AND md_catalogs.connection_id_fk = md_connections.id
            AND md_connections.project_id_fk = md_projects.id WITH READ ONLY;
comment on table KEFU5.MGV_ALL_VIEWS is 'View to iterate over all views in the system';

prompt
prompt Creating package MD_META
prompt ========================
prompt
CREATE OR REPLACE PACKAGE KEFU5."MD_META"
AS
FUNCTION get_next_id RETURN NUMBER;
-- Following code taken directly from wwv_flow_random from APEX
--
-- seed random function
procedure srand( new_seed in number );

function rand return number;
pragma restrict_references( rand, WNDS  );

procedure get_rand( r OUT number );

function rand_max( n IN number ) return number;
pragma restrict_references( rand_max, WNDS);

procedure get_rand_max( r OUT number, n IN number );

END;
/

prompt
prompt Creating type NAMELIST
prompt ======================
prompt
CREATE OR REPLACE TYPE KEFU5.NAMELIST IS TABLE OF VARCHAR2(40);
/

prompt
prompt Creating type OBJECTIDLIST
prompt ==========================
prompt
CREATE OR REPLACE TYPE KEFU5.OBJECTIDLIST IS TABLE OF INTEGER;
/

prompt
prompt Creating type MIGR_FILTER
prompt =========================
prompt
CREATE OR REPLACE TYPE KEFU5.MIGR_FILTER IS OBJECT (
  FILTER_TYPE INTEGER, -- Filter Types are 0-> ALL, 1->NAMELIST, 2->WHERE CLAUSE, 3->OBJECTID LIST
  OBJTYPE VARCHAR2(40),
  OBJECTIDS OBJECTIDLIST,
  NAMES NAMELIST,
  WHERECLAUSE VARCHAR2(1000));
/

prompt
prompt Creating type MIGR_FILTER_SET
prompt =============================
prompt
CREATE OR REPLACE TYPE KEFU5.MIGR_FILTER_SET IS TABLE OF MIGR_FILTER;
/

prompt
prompt Creating type NAME_AND_COUNT_T
prompt ==============================
prompt
CREATE OR REPLACE TYPE KEFU5.name_and_count_t IS OBJECT (
  OBJECT_NAME varchar2(30),
  UPDATE_COUNT INTEGER);
/

prompt
prompt Creating type NAME_AND_COUNT_ARRAY
prompt ==================================
prompt
CREATE OR REPLACE TYPE KEFU5.name_and_count_array IS VARRAY(30) OF name_and_count_t;
/

prompt
prompt Creating package MIGRATION
prompt ==========================
prompt
CREATE OR REPLACE PACKAGE KEFU5."MIGRATION"
AS

-- Public functions
FUNCTION copy_connection_cascade(p_connectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER;
FUNCTION transform_all_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE, p_prefixName VARCHAR2) RETURN NAME_AND_COUNT_ARRAY;
FUNCTION transform_datatypes(p_connectionid MD_CONNECTIONS.ID%TYPE, p_mapid MIGR_DATATYPE_TRANSFORM_MAP.ID%TYPE, p_numbytesperchar INTEGER) RETURN NUMBER;
FUNCTION transform_identity_columns(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER;
FUNCTION transform_rewrite_trigger(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER;
FUNCTION gatherConnectionStats(p_connectionId MD_CONNECTIONS.ID%TYPE) RETURN NUMBER;
PROCEDURE transform_clashes(p_connectionid MD_CONNECTIONS.ID%TYPE);
END;
/

prompt
prompt Creating type MIGR_REPORT_DETAIL_ROW
prompt ====================================
prompt
CREATE OR REPLACE TYPE KEFU5.MIGR_REPORT_DETAIL_ROW AS OBJECT
 (CAPTURED_ID            NUMBER(38),
  CAPTURED_NAME          VARCHAR2(4000),
  CONVERTED_NAME          VARCHAR2(4000),
  CAPTURED_TYPE          VARCHAR2(4000),
  CONVERTED_TYPE          VARCHAR2(4000),
  CAPTURE_STATUS         VARCHAR2(20),
  CONVERT_STATUS         VARCHAR2(20),
  GENERATE_STATUS        VARCHAR2(20),
  LOGTEXT               VARCHAR2(4000)
 );
/

prompt
prompt Creating type MIGR_REPORT_DETAIL_TABLE
prompt ======================================
prompt
CREATE OR REPLACE TYPE KEFU5.MIGR_REPORT_DETAIL_TABLE AS TABLE OF MIGR_REPORT_DETAIL_ROW;
/

prompt
prompt Creating type MIGR_REPORT_SUM_ROW
prompt =================================
prompt
CREATE OR REPLACE TYPE KEFU5.MIGR_REPORT_SUM_ROW AS OBJECT
       (LABEL           VARCHAR2(50),
	    SCHEMA_SUM      NUMBER,
        TABLE_SUM       NUMBER,
		INDEX_SUM       NUMBER,
		CONSTRAINT_SUM  NUMBER,
		VIEW_SUM        NUMBER,
		TRIGGER_SUM     NUMBER,
		SP_SUM          NUMBER		
        );
/

prompt
prompt Creating type MIGR_REPORT_SUM_TABLE
prompt ===================================
prompt
CREATE OR REPLACE TYPE KEFU5.MIGR_REPORT_SUM_TABLE AS TABLE OF MIGR_REPORT_SUM_ROW;
/

prompt
prompt Creating package MIGRATION_REPORT
prompt =================================
prompt
CREATE OR REPLACE PACKAGE KEFU5."MIGRATION_REPORT" AS
--get status
  FUNCTION getCaptureStatus(srcid IN NUMBER)  RETURN VARCHAR2;
  FUNCTION getConvertStatus(srcid IN NUMBER,convert_conn_id IN NUMBER)  RETURN VARCHAR2;
  FUNCTION getGenerateStatus(srcid IN NUMBER,convert_conn_id IN NUMBER)  RETURN VARCHAR2;
--migration details
  FUNCTION getDetails(capture_conn_id IN NUMBER,convert_conn_id IN NUMBER) RETURN MIGR_REPORT_DETAIL_TABLE PIPELINED; 
--migration summary
   FUNCTION getSum(capture_conn_id IN NUMBER,convert_conn_id IN NUMBER) RETURN MIGR_REPORT_SUM_TABLE PIPELINED;
END MIGRATION_REPORT;
/

prompt
prompt Creating package MIGRATION_TRANSFORMER
prompt ======================================
prompt
CREATE OR REPLACE PACKAGE KEFU5."MIGRATION_TRANSFORMER" AS
FUNCTION check_identifier_length(p_ident VARCHAR2) RETURN VARCHAR2;
FUNCTION add_suffix(p_work VARCHAR2, p_suffix VARCHAR2, p_maxlen NUMBER) RETURN VARCHAR2;
FUNCTION check_reserved_word(p_work VARCHAR2) RETURN VARCHAR2;
FUNCTION sys_check(p_work VARCHAR2) RETURN VARCHAR2;
FUNCTION check_allowed_chars(p_work NVARCHAR2) RETURN NVARCHAR2;
FUNCTION transform_identifier(p_identifier NVARCHAR2)  RETURN NVARCHAR2;
END;
/

prompt
prompt Creating package MYSQL_UTILITIES
prompt ================================
prompt
CREATE OR REPLACE PACKAGE KEFU5.mysql_utilities AS
identity NUMBER(10);
END mysql_utilities;
/

prompt
prompt Creating package body MD_META
prompt =============================
prompt
CREATE OR REPLACE PACKAGE BODY KEFU5."MD_META" AS

    multiplier constant number  := 22695477;
    increment  constant number  := 1;
    "2^32"     constant number  := 2 ** 32;
    "2^16"     constant number  := 2 ** 16;
    "0x7fff"   constant number  := 32767;
    Seed       number := 1;
    g_curr_val NUMBER DEFAULT NULL;
/*
 * Get the next available id for objectids.
 * @return the next id that can be used in objectid fields
 * This code is taken from wwv_flows
 */
FUNCTION get_next_id RETURN NUMBER
IS
BEGIN
/*
	select  to_number(
                 to_char(dbobjectid_sequence.nextval) ||
                      lpad( substr( abs(rand), 1, 5 ),5, '0' ) ||
                   ltrim(to_char(mod(abs(hsecs),1000000),'000000')))
    into    g_curr_val
    from   sys.v_$timer;
*/
	select to_number(
				to_char(dbobjectid_sequence.nextval) ||
					lpad( substr( abs(rand), 1, 5 ), 5, '0') ||
				ltrim(to_char(mod(dbms_random.value(100000000000, 999999999999),1000000),'000000')))
    into    g_curr_val
	from dual;				

    return g_curr_val;
END get_next_id;
-- Following code taken from wwv_flows_random 
 procedure srand( new_seed in number ) is
 begin
  Seed := new_seed;
 end srand;
--
  function rand return number is
    s number;
  begin
    seed := mod( multiplier * seed + increment, "2^32" );
    begin
       return bitand( seed/"2^16", "0x7fff" );
    --mhichwa
    exception when others then
       select dbobjectid_sequence.nextval into s from dual;
       return s||to_char(sysdate,'HH24MISS');
    end;
  end rand;
--
  procedure get_rand( r OUT number ) is
  begin
    r := rand;
  end get_rand;
--
  function rand_max( n IN number ) return number is
  begin
    return mod( rand, n ) + 1;
  end rand_max;
--
  procedure get_rand_max( r OUT number, n IN number )  is
  begin
    r := rand_max( n );
  end get_rand_max;
--
-- One time initialisation
begin
  select to_char(sysdate,'JSSSSS')
    into seed
    from dual;
end;
/

prompt
prompt Creating package body MIGRATION
prompt ===============================
prompt
CREATE OR REPLACE PACKAGE BODY KEFU5."MIGRATION" AS
/**
 * The migration package contains all of the PL/SQL Procedures and functions required by the migration
 * system.
 * @author Barry McGillin
 * @author Dermot Daly.
 */
v_prefixName VARCHAR2(4) :=''; --text to prefix objects with ,set using transform_all_identifiers
-- Constants that are used throughout the package body.
C_CONNECTIONTYPE_CONVERTED   CONSTANT MD_CONNECTIONS.TYPE%TYPE := 'CONVERTED';
-- Supported object types.
C_OBJECTTYPE_CONNECTIONS     CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_CONNECTIONS';
C_OBJECTTYPE_CATALOGS        CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_CATALOGS';
C_OBJECTTYPE_SCHEMAS         CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_SCHEMAS';
C_OBJECTTYPE_TABLES          CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_TABLES';
C_OBJECTTYPE_COLUMNS         CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_COLUMNS';
C_OBJECTTYPE_CNSTRNT_DETAILS CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_CONSTRAINT_DETAILS';
C_OBJECTTYPE_CONSTRAINTS     CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_CONSTRAINTS';
C_OBJECTTYPE_INDEX_DETAILS   CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_INDEX_DETAILS';
C_OBJECTTYPE_INDEXES         CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_INDEXES';
C_OBJECTTYPE_TRIGGERS        CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_TRIGGERS';
C_OBJECTTYPE_VIEWS           CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_VIEWS';
C_OBJECTTYPE_USERS           CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_USERS';
C_OBJECTTYPE_GROUP_MEMBERS   CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_GROUPMEMBERS';
C_OBJECTTYPE_GROUPS          CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_GROUPS';
C_OBJECTTYPE_OTHER_OBJECTS   CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_OTHER_OBJECTS';
C_OBJECTTYPE_TABLESPACES     CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_TABLESPACES';
C_OBJECTTYPE_UDDT            CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_USER_DEFINED_DATA_TYPES';
C_OBJECTTYPE_STORED_PROGRAMS CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_STORED_PROGRAMS';
C_OBJECTTYPE_PACKAGES        CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_PACKAGES';
C_OBJECTTYPE_SYNONYMS        CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_SYNONYMS';
C_OBJECTTYPE_SEQUENCES       CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_SEQUENCES';
C_OBJECTTYPE_PRIVILEGES      CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_PRIVILEGES';
C_OBJECTTYPE_USER_PRIVILEGES CONSTANT MD_DERIVATIVES.SRC_TYPE%TYPE := 'MD_USER_PRIVILEGES';
-- Dummy flag for a dummy catalog.
C_DUMMYFLAG_TRUE             CONSTANT MD_CATALOGS.DUMMY_FLAG%TYPE := 'Y';
-- Flag in MD_DERIVATIVES to show if something has been transformed
C_TRANSFORMED_TRUE           CONSTANT MD_DERIVATIVES.TRANSFORMED%TYPE := 'Y';
-- Flag in MD_SYNONYMS.PRIVATE_VISIBILITY to highlight that a synonym is marked as private
C_SYNONYM_PRIVATE            CONSTANT MD_SYNONYMS.PRIVATE_VISIBILITY%TYPE := 'Y';
-- Flag in MD_GROUPS.GROUP_FLAG to show this is a role
C_ROLE_FLAG                  CONSTANT MD_GROUPS.GROUP_FLAG%TYPE := 'R';
-- Flag in MD_COLUMNS TO SHOW A COLUMN IS NULLABLE
C_NULLABLE_YES               CONSTANT MD_COLUMNS.NULLABLE%TYPE := 'Y';
-- Special defined additional properties.
C_PROPKEY_SEEDVALUE          CONSTANT MD_ADDITIONAL_PROPERTIES.PROP_KEY%TYPE := 'SEEDVALUE';
C_PROPKEY_INCREMENT          CONSTANT MD_ADDITIONAL_PROPERTIES.PROP_KEY%TYPE := 'INCREMENT';
C_PROPKEY_LASTVALUE          CONSTANT MD_ADDITIONAL_PROPERTIES.PROP_KEY%TYPE := 'LASTVALUE';
C_PROPKEY_EXTENDEDINDEXTYPE	 CONSTANT MD_ADDITIONAL_PROPERTIES.PROP_KEY%TYPE := 'EXTENDEDINDEXTYPE';
C_PROPKEY_SEQUENCEID	       CONSTANT MD_ADDITIONAL_PROPERTIES.PROP_KEY%TYPE := 'SEQUENCEID';
C_PROPKEY_TRIGGER_REWRITE	   CONSTANT MD_ADDITIONAL_PROPERTIES.PROP_KEY%TYPE := 'TRIGGER_REWRITE';
-- Name spaces for identifiers
C_NS_SCHEMA_OBJS             CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_SCHEMAOBJS';
C_NS_INDEXES                 CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_INDEXES';
C_NS_CONSTRAINTS             CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_CONSTRAINTS';
C_NS_CLUSTERS                CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_CLUSTERS';
C_NS_DB_TRIGGERS             CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_DB_TRIGGERS';
C_NS_PRIVATE_DBLINKS         CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_PRIVATEDBLINKS';
C_NS_DIMENSIONS              CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_DIMENSIONS';
C_NS_USER_ROLES              CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_USERROLES';
C_NS_PUBLIC_SYNONYMS         CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_PUB_SYNONYMS';
C_NS_PUBLIC_DBLINKS          CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_PUBLICDBLINKS';
C_NS_TABLESPACES             CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_TABLESPACES';
C_NS_PROFILES                CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_PROFILES';
C_NS_DATABASE                CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_DATABASE';
C_NS_USERS                   CONSTANT MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := 'NS_USERS';
-- Constants for Filter Types
 -- Filter Types are 0-> ALL, 1->NAMELIST, 2->WHERE CLAUSE, 3->OBJECTID LIST
C_FILTERTYPE_ALL	     CONSTANT INTEGER := 0;
C_FILTERTYPE_NAMELIST	     CONSTANT INTEGER := 1;
C_FILTERTYPE_WHERECLAUSE     CONSTANT INTEGER := 2;
C_FILTERTYPE_OBJECTIDLIST    CONSTANT INTEGER := 3;
-- Constatns for TEXT INDEX TYPES
-- see http://download-west.oracle.com/docs/cd/B10501_01/text.920/a96518/csql.htm#19446
-- Use this index type when there is one CLOB or BLOB column in the index only
C_INDEXTYPE_CONTEXT	CONSTANT MD_ADDITIONAL_PROPERTIES.VALUE%TYPE := 'ctxsys.context';
-- Use this index type when the index containst a CLOB or BLOB column.
C_INDEXTYPE_CTXCAT CONSTANT  MD_ADDITIONAL_PROPERTIES.VALUE%TYPE := 'ctxsys.ctxcat';
-- Constant for LANGUAGE - Used in MD_TRIGGERS, MD_PACKAGES, MD_STORED_PROGRAMS, MD_VIEWS, and MD_CONSTRAINTS
C_LANGUAGEID_ORACLE CONSTANT MD_TRIGGERS.LANGUAGE%TYPE := 'OracleSQL';
-- Type for a generic REF CURSOR
TYPE REF_CURSOR IS REF CURSOR;
/**
 * Find a filter element from a filter list
 */
FUNCTION find_filter_for_type(p_filterSet MIGR_FILTER_SET, p_objtype MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE) RETURN MIGR_FILTER
IS
BEGIN
  IF p_filterset is NULL OR p_objtype is NULL then
    return NULL;
  END IF;
  FOR indx in p_filterset.FIRST .. p_filterset.LAST
  LOOP
    if p_filterset(indx).OBJTYPE = p_objtype THEN
      return p_filterset(indx);
    end if;
  END LOOP;
  return NULL;
END find_filter_for_type;

/**
 * Convert a name list from a filter into a condition for use in a where clause.
 * @param p_nameList the set of names that form part of the filter
 * @param p_nameField the name of the field to be compared against.
 * @return A condition that can be used in a where clause.
 */
FUNCTION namelist_to_where_clause(p_nameList NAMELIST, p_nameField VARCHAR2) RETURN VARCHAR2
IS
  v_ret VARCHAR2(4000);
BEGIN
  v_ret := p_nameField || ' IN (';
  FOR indx IN p_nameList.FIRST .. p_nameList.LAST
  LOOP
    v_ret := v_ret || '''' || p_nameList(indx) || '''';
    IF  indx != p_nameList.LAST THEN
      v_ret := v_ret || ', ';
    END IF;
  END LOOP;
  v_ret := v_ret || ')';
  return v_ret;
END namelist_to_where_clause;

/**
 * Convert an object id list from a filter into a condition for use in a where clause.
 * @param p_oidList The list of object ids taken from the filter.
 * @param p_idFIeld The field to be tested against.
 * @return A condition that can be used in a where clause.
 */
FUNCTION objectIdList_to_where_clause(p_oidList OBJECTIDLIST, p_idField VARCHAR2) RETURN VARCHAR2
IS
  v_ret VARCHAR2(4000);
BEGIN
  V_RET := p_idField || ' IN (';
  FOR indx IN p_oidList.FIRST .. p_oidList.LAST
  LOOP
    v_ret := v_ret || TO_CHAR(p_oidList(indx));
    IF indx != p_oidList.LAST THEN
      v_ret := v_ret || ', ';
    END IF;
  END LOOP;
  v_ret := v_ret || ')';
  return v_ret;
END objectIdList_to_where_clause;

/**
 * Convert a filter to a condition for use in a where clause.
 * @param p_filter The filter
 * @param p_nameFileld The name field that will be used in the names list or where clause.
 * @param p_idField The id field that will be used if the filter is an objectid list.
 * @return A condition that could be used in a where clause.  NULL if no additional filtering is required.
 */
FUNCTION where_clause_from_filter(p_filter MIGR_FILTER, p_nameField VARCHAR2, p_idField VARCHAR2) RETURN VARCHAR2
IS
BEGIN
	IF p_filter.FILTER_TYPE = C_FILTERTYPE_ALL THEN
	  RETURN NULL;
    ELSIF p_filter.FILTER_TYPE = C_FILTERTYPE_NAMELIST THEN
      RETURN namelist_to_where_clause(p_filter.NAMES, p_nameField);
    ELSIF p_filter.FILTER_TYPE = C_FILTERTYPE_WHERECLAUSE THEN
	  RETURN p_nameField || ' ' || p_filter.WHERECLAUSE;
    ELSE
	  RETURN objectidlist_to_where_clause(p_filter.OBJECTIDS, p_idField);
	END IF;
END where_clause_from_filter;

/**
 * Apply a filter to an existing select statement
 * @param p_filter_set The filter set.
 * @param p_filter_type The type of the object, for finding in the filter set.
 * @param p_name_field The name field of the table being filtered
 * @param p_id_field The id field of the table being filtered.
 * @param p_select_stmt The select statment to tag the new condition on to
 * @return The select statement with the new condition added to it (or the original statement if
 *         there is no applicable filter for this object type.
 */
FUNCTION apply_filter(p_filter_set MIGR_FILTER_SET,
                      p_filter_type MD_DERIVATIVES.SRC_TYPE%TYPE,
                      p_name_field VARCHAR2,
                      p_id_field VARCHAR2,
                      p_select_stmt VARCHAR2) RETURN VARCHAR2
IS
  v_filt MIGR_FILTER;
  v_condition VARCHAR2(4000);
BEGIN
  v_filt := find_filter_for_type(p_filter_set, p_filter_type);
  --if the filter is null, then we need to set a value that will fail always so nothing is moved.
  -- ie 1=2
  IF v_filt IS NOT NULL THEN
    v_condition := where_clause_from_filter(v_filt, p_name_field, p_id_field);
    IF v_condition IS NOT NULL THEN
      RETURN p_select_stmt || ' AND ' || v_condition;
    ELSE
     RETURN p_select_stmt;
    END IF;
  END IF;
  RETURN p_select_stmt || ' AND 1=2';
END apply_filter;
                      
                      
/**
 * Find the copy of a particular object.  This function checks for a copied object of a particular
 * type by searching the MD_DERIVATIVES table.
 * @param p_objectid The id of the object to search for.
 * @param p_objecttype The type of the object to search for.
 * @return the id of the copy object if it is present, or NULL if it is not.
 */
FUNCTION find_object_copy(p_objectid md_projects.id%TYPE, p_objecttype MD_DERIVATIVES.SRC_TYPE%TYPE, p_derivedconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS 
  v_ret MD_DERIVATIVES.DERIVED_ID%TYPE;
BEGIN
  SELECT derived_id INTO v_ret FROM MD_DERIVATIVES
    WHERE src_id = p_objectid 
     AND src_type = p_objecttype
     AND derived_type = p_objecttype 
     AND derived_connection_id_fk = p_derivedconnectionid;
  RETURN v_ret;
EXCEPTION
  WHEN NO_DATA_FOUND then
    -- Should we raise an error?
    RETURN NULL;
END find_object_copy;

/**
 * Copy additional properties. function copies the additional properties for an object.
 * @param p_refobjectid The object id whose additional properties have to be copied
 * @param p_newrefobject The id of the copied object the new properties should refer to
 * @return number of additional properties copied
 */
FUNCTION copy_additional_properties(p_refobjectid MD_ADDITIONAL_PROPERTIES.REF_ID_FK%TYPE, p_newrefobject MD_PROJECTS.ID%TYPE, p_newconnectionid MD_ADDITIONAL_PROPERTIES.CONNECTION_ID_FK%TYPE) RETURN NUMBER
IS
  CURSOR ORIGINAL_RECS IS SELECT PROPERTY_ORDER, PROP_KEY, REF_TYPE, VALUE FROM MD_ADDITIONAL_PROPERTIES WHERE REF_ID_FK=p_refobjectid;
  v_numcopied NUMBER := 0;
BEGIN
  for newrec in ORIGINAL_RECS LOOP
    INSERT INTO MD_ADDITIONAL_PROPERTIES (ref_id_fk, ref_type, property_order, prop_key, value, connection_id_fk)
      VALUES (p_newrefobject, newrec.ref_type, newrec.property_order, newrec.prop_key, newrec.value, p_newconnectionid);
    v_numcopied := v_numcopied + 1;
  END LOOP;
  commit;
  return v_numcopied;
END copy_additional_properties;

FUNCTION copy_connection(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  newrec MD_CONNECTIONS%ROWTYPE;
  newid MD_CONNECTIONS.ID%TYPE;
  origName MD_CONNECTIONS.NAME%TYPE;
BEGIN
  SELECT * INTO newrec from MD_CONNECTIONS WHERE id = p_connectionid;
  newrec.TYPE :=C_CONNECTIONTYPE_CONVERTED;
  newrec.HOST := NULL;
  newrec.PORT := NULL;
  newrec.USERNAME := NULL;
  newrec.DBURL := NULL;
  -- TODO.  Need to do this in a more i18n friendly manner.
  origName := newrec.NAME;
  newrec.NAME := 'Converted:' || newrec.NAME;
  -- Let the trigger create the new ID
  newrec.ID := NULL;
  INSERT INTO MD_CONNECTIONS VALUES newrec
  	RETURNING id into newid;
  INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, derived_connection_id_fk, original_identifier, new_identifier)
    VALUES (p_connectionid, C_OBJECTTYPE_CONNECTIONS, newid, C_OBJECTTYPE_CONNECTIONS, newid, origName, newrec.NAME);
  commit;
  return newid;
END copy_connection;

FUNCTION create_dummy_catalog(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  newid MD_CATALOGS.ID%TYPE;
BEGIN
  INSERT INTO MD_CATALOGS (CONNECTION_ID_FK, CATALOG_NAME, DUMMY_FLAG, NATIVE_SQL, NATIVE_KEY)
  VALUES (p_connectionid, ' ', C_DUMMYFLAG_TRUE, NULL, NULL)
  RETURNING ID INTO newid;
  RETURN newid;
END create_dummy_catalog;

FUNCTION find_or_create_dummy_catalog(p_connectionid MD_CONNECTIONS.ID%TYPE, p_catalogid MD_CATALOGS.ID%TYPE) RETURN NUMBER
IS
  newrec MD_CATALOGS%ROWTYPE;
  newid MD_CATALOGS.ID%TYPE;
BEGIN
  SELECT * INTO newrec from MD_CATALOGS where connection_id_fk = p_connectionid;
  return newrec.id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  INSERT INTO MD_CATALOGS (CONNECTION_ID_FK, CATALOG_NAME, DUMMY_FLAG, NATIVE_SQL, NATIVE_KEY)
  VALUES (p_connectionid, ' ', C_DUMMYFLAG_TRUE, NULL, NULL)
  RETURNING ID INTO newid;
  INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, derived_connection_id_fk, DERIVED_OBJECT_NAMESPACE)
    VALUES (p_catalogid, C_OBJECTTYPE_CATALOGS, newid, C_OBJECTTYPE_CATALOGS, p_connectionid, C_NS_DATABASE);
  commit;
  return newid;
END find_or_create_dummy_catalog;

FUNCTION copy_individual_catalog(p_catalogid MD_CATALOGS.ID%TYPE) RETURN NUMBER
IS
  newrec MD_CATALOGS%ROWTYPE;
  newconnectionid MD_CATALOGS.CONNECTION_ID_FK%TYPE;
  dummycatalogid MD_CATALOGS.ID%TYPE;
  originalconnectionid MD_CATALOGS.CONNECTION_ID_FK%TYPE;
BEGIN
  -- Catalogs aren't copied as such. Instead, we make a single DUMMY catalog
  -- Within the new connection
  -- So..first see if one exists for the copied connection
  SELECT CONNECTION_ID_FK INTO originalconnectionid FROM MD_CATALOGS WHERE ID = p_catalogid;
  -- For connections, we have a special case.  We can't store the new connection, but 0 is ok.
  newconnectionid := find_object_copy(originalconnectionid, C_OBJECTTYPE_CONNECTIONS, 0);
  IF newconnectionid IS NULL THEN
    newconnectionid := copy_connection(originalconnectionid);
  END IF;
  dummycatalogid := find_or_create_dummy_catalog(newconnectionid, p_catalogid);
  RETURN dummycatalogid;  
END copy_individual_catalog;

FUNCTION copy_individual_schema(p_schemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  newid MD_SCHEMAS.ID%TYPE;
  newrec MD_SCHEMAS%ROWTYPE;
  newcatalogid MD_CATALOGS.ID%TYPE;
  originalcatalogname MD_CATALOGS.CATALOG_NAME%TYPE;
  originalcatalogid MD_SCHEMAS.CATALOG_ID_FK%TYPE;
  originalschemaname MD_SCHEMAS.NAME%TYPE;
  originalisdummy CHAR;
BEGIN
  SELECT * INTO newrec FROM md_schemas WHERE id = p_schemaid;
  newcatalogid := find_object_copy(newrec.catalog_id_fk,   C_OBJECTTYPE_CATALOGS, p_newconnectionid);
  originalcatalogid := newrec.catalog_id_fk;
  originalschemaname := newrec.NAME;
  select CATALOG_NAME, DUMMY_FLAG into originalcatalogname, originalisdummy from MD_CATALOGS WHERE ID = originalcatalogid;
  IF newcatalogid IS NULL THEN
    newcatalogid := copy_individual_catalog(newrec.catalog_id_fk);
  END IF;

  newrec.catalog_id_fk := newcatalogid;
  if originalisdummy <> C_DUMMYFLAG_TRUE THEN
    newrec.name := originalcatalogname || '_' || newrec.name;
  end if;
  -- Let the trigger work out the new id
  newrec.ID := NULL;
  INSERT INTO MD_SCHEMAS VALUES newrec RETURNING ID INTO newid;
  INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, original_identifier, new_identifier, DERIVED_OBJECT_NAMESPACE)
    VALUES (p_schemaid, C_OBJECTTYPE_SCHEMAS, newid, C_OBJECTTYPE_SCHEMAS, originalschemaname, newrec.name, C_NS_DATABASE);
  INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type)
    VALUES (originalcatalogid, C_OBJECTTYPE_CATALOGS, newid, C_OBJECTTYPE_SCHEMAS);
  COMMIT;
  return newid;
END copy_individual_schema;

FUNCTION copy_individual_table(p_tableid MD_TABLES.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  newrec MD_TABLES%rowtype;
  newid MD_TABLES.ID%TYPE;
  newschemaid MD_SCHEMAS.ID%TYPE;
BEGIN
  SELECT * INTO newrec FROM MD_tables WHERE id = p_tableid;
  newschemaid := find_object_copy(newrec.schema_id_fk,   C_OBJECTTYPE_SCHEMAS, p_newconnectionid);
  IF newschemaid IS NULL THEN
    newschemaid := copy_individual_schema(newrec.schema_id_fk, p_newconnectionid);
  END IF;

  newrec.schema_id_fk := newschemaid;
  -- Let the trigger work out the new id
  newrec.ID := NULL;
  INSERT INTO MD_TABLES VALUES newrec RETURNING ID INTO newid;
  INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, derived_connection_id_fk, original_identifier, new_identifier, DERIVED_OBJECT_NAMESPACE)
    VALUES(p_tableid,   C_OBJECTTYPE_TABLES,   newid,   C_OBJECTTYPE_TABLES, p_newconnectionid, newrec.table_name, newrec.table_name, C_NS_SCHEMA_OBJS || TO_CHAR(newschemaid));
  COMMIT;
  RETURN newid;
END copy_individual_table;

FUNCTION copy_individual_column(p_columnid MD_COLUMNS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  newid MD_COLUMNS.ID%TYPE;
  newrec MD_COLUMNS%rowtype;
  newtableid MD_TABLES.ID%TYPE;
BEGIN
  SELECT * INTO newrec FROM md_columns WHERE id = p_columnid;
  -- TODO: How do I check if this worked?
  -- OK. We need to fix up table id
  newtableid := find_object_copy(newrec.table_id_fk,   C_OBJECTTYPE_TABLES, p_newconnectionid);

  IF newtableid IS NULL THEN
    newtableid := copy_individual_table(newrec.table_id_fk, p_newconnectionid);
  END IF;

  newrec.table_id_fk := newtableid;
  -- Let the trigger work out the new id
  newrec.ID := NULL;
  INSERT INTO md_columns VALUES newrec RETURNING ID INTO newid;
  -- Columns have their own namespace.  They must be unique within the given table.  So..we'll use the table id as the namespace
  INSERT INTO md_derivatives(src_id,   src_type,   derived_id,   derived_type, derived_connection_id_fk, original_identifier, new_identifier, DERIVED_OBJECT_NAMESPACE)
    VALUES(p_columnid,   C_OBJECTTYPE_COLUMNS,   newid,   C_OBJECTTYPE_COLUMNS, p_newconnectionid, newrec.column_name, newrec.column_name, C_OBJECTTYPE_COLUMNS || TO_CHAR(newtableid));
  COMMIT;
  RETURN newid;
END copy_individual_column;

FUNCTION copy_all_tables(p_connectionid MD_CONNECTIONS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR all_tables_cursor is select table_id from mgv_all_tables where connection_id = p_connectionid;
  v_count NUMBER := 0;
  newid MD_TABLES.ID%TYPE;
BEGIN
  FOR v_tableid IN all_tables_cursor LOOP
    newid := copy_individual_table(v_tableid.table_id, p_newconnectionid);
    v_count := v_count + 1;
  END LOOP;
  RETURN v_count;
END copy_all_tables;

FUNCTION copy_all_columns(p_connectionid MD_CONNECTIONS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR all_columns_cursor is select id from MD_COLUMNS where table_id_fk in 
    (select table_id from MGV_ALL_TABLES where connection_id = p_connectionid);
  v_count NUMBER :=0;
  newid MD_COLUMNS.ID%TYPE;
BEGIN
  FOR v_columnid IN all_columns_cursor LOOP
    newid := copy_individual_column(v_columnid.id, p_newconnectionid);
    v_count := v_count + 1;
  END LOOP;
  return v_count;
END copy_all_columns;

FUNCTION copy_constraint_details(p_oldconsid MD_CONSTRAINTS.ID%TYPE, p_newconsid MD_CONSTRAINTS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR curs is SELECT * FROM MD_CONSTRAINT_DETAILS WHERE CONSTRAINT_ID_FK = p_oldconsid;
  v_newid MD_CONSTRAINT_DETAILS.ID%TYPE;
  v_count NUMBER := 0;
  v_originalid MD_CONSTRAINT_DETAILS.ID%TYPE;
  v_ret NUMBER;
BEGIN
  FOR v_row IN curs LOOP
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.COLUMN_ID_FK := find_object_copy(v_row.COLUMN_ID_FK , C_OBJECTTYPE_COLUMNS, p_newconnectionid);
    v_row.CONSTRAINT_ID_FK := p_newconsid;
    INSERT INTO MD_CONSTRAINT_DETAILS values v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
	-- Constraint details don't have an identifier, so don't need a namespace.
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK)
      VALUES(v_originalid, C_OBJECTTYPE_CNSTRNT_DETAILS, v_newid, C_OBJECTTYPE_CNSTRNT_DETAILS, p_newconnectionid);
  END LOOP;
  return v_count;
END copy_constraint_details;

FUNCTION copy_all_constraints_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
   v_selectStmt VARCHAR2(4000) :=     
  'SELECT * FROM MD_CONSTRAINTS WHERE TABLE_ID_FK IN       
    (SELECT SRC_ID FROM MD_DERIVATIVES WHERE SRC_TYPE = ''' || C_OBJECTTYPE_TABLES ||''' AND DERIVED_TYPE = '''
    || C_OBJECTTYPE_TABLES || ''' AND DERIVED_ID IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE SCHEMA_ID = ' || p_newschemaid || '))';
  v_count NUMBER := 0;
  v_newid MD_CONSTRAINTS.ID%TYPE;
  v_originalid MD_CONSTRAINTS.ID%TYPE;
  v_ret NUMBER;
  v_row MD_CONSTRAINTS%ROWTYPE;
  v_storeRefTableId MD_TABLES.ID%TYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_CONSTRAINTS, 'NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.TABLE_ID_FK := find_object_copy(v_row.TABLE_ID_FK , C_OBJECTTYPE_TABLES, p_newconnectionid);
    if v_row.REFTABLE_ID_FK IS NOT NULL THEN
      v_storeRefTableId := v_row.REFTABLE_ID_FK;
      v_row.REFTABLE_ID_FK := find_object_copy(v_row.REFTABLE_ID_FK , C_OBJECTTYPE_TABLES, p_newconnectionid);
    END IF;
    INSERT INTO MD_CONSTRAINTS values v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid, C_OBJECTTYPE_CONSTRAINTS, v_newid, C_OBJECTTYPE_CONSTRAINTS, p_newconnectionid, v_row.NAME, v_row.NAME, C_NS_CONSTRAINTS|| TO_CHAR(p_newschemaid));
    v_ret := copy_constraint_details(v_originalid, v_newid, p_newconnectionid);
  END LOOP;
  CLOSE cv_curs;
  return v_count;    
END copy_all_constraints_cascade;

FUNCTION copy_all_columns_cascade(p_oldtableid MD_TABLES.ID%TYPE, p_newtableid MD_TABLES.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_COLUMNS WHERE TABLE_ID_FK = ' || p_oldtableid;
  v_originalId MD_COLUMNS.ID%TYPE;
  v_newid MD_COLUMNS.ID%TYPE;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_COLUMNS%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_COLUMNS, 'COLUMN_NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.TABLE_ID_FK := p_newtableid;
    INSERT INTO MD_COLUMNS values  v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
	-- Columns don't need a namespace as such, they must not clash within the table.  We'll handle this
	-- As a special case.
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, original_identifier, new_identifier, DERIVED_OBJECT_NAMESPACE)
    VALUES(v_originalid, C_OBJECTTYPE_COLUMNS, v_newid, C_OBJECTTYPE_COLUMNS, p_newconnectionid, v_row.column_name, v_row.column_name, C_OBJECTTYPE_COLUMNS || TO_CHAR(p_newtableid));
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_columns_cascade;

FUNCTION copy_index_details(p_oldindexid MD_INDEXES.ID%TYPE, p_newindexid MD_INDEXES.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR curs is SELECT * FROM MD_INDEX_DETAILS WHERE MD_INDEX_DETAILS.INDEX_ID_FK = p_oldindexid;
  v_originalid MD_INDEX_DETAILS.ID%TYPE;
  v_newid MD_INDEX_DETAILS.ID%TYPE;
  v_count NUMBER := 0;
  v_ret NUMBER;
BEGIN
  FOR v_row IN CURS LOOP
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.INDEX_ID_FK := p_newindexid;
    v_row.COLUMN_ID_FK := find_object_copy(v_row.COLUMN_ID_FK, C_OBJECTTYPE_COLUMNS, p_newconnectionid);
    INSERT INTO MD_INDEX_DETAILS VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
	-- Index details don't have identifiers, so don't need a namespace.
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK)
    VALUES(v_originalid, C_OBJECTTYPE_INDEX_DETAILS, v_newid, C_OBJECTTYPE_INDEX_DETAILS, p_newconnectionid);
  END LOOP;
  RETURN v_count;
END copy_index_details;

FUNCTION copy_all_indexes(p_oldtableid MD_TABLES.ID%TYPE, p_newtableid MD_TABLES.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_filter_set MIGR_FILTER_SET) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_INDEXES WHERE MD_INDEXES.TABLE_ID_FK = ' || p_oldtableid;
  v_originalid MD_INDEXES.ID%TYPE;
  v_newid MD_INDEXES.ID%TYPE;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_INDEXES%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_INDEXES, 'INDEX_NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    
    v_row.ID := NULL;
    v_row.TABLE_ID_FK := p_newtableid;
    INSERT INTO MD_INDEXES values v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
    VALUES(v_originalid, C_OBJECTTYPE_INDEXES, v_newid, C_OBJECTTYPE_INDEXES, p_newconnectionid, v_row.INDEX_NAME, v_row.INDEX_NAME, C_NS_INDEXES || p_newschemaid);
    v_ret := copy_index_details(v_originalid, v_newid, p_newconnectionid);
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_indexes;

FUNCTION copy_all_table_triggers(p_oldtableid MD_TABLES.ID%TYPE, p_newtableid MD_TABLES.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_TRIGGERS WHERE MD_TRIGGERS.TABLE_OR_VIEW_ID_FK = ' || p_oldtableid;
  v_originalid MD_TRIGGERS.ID%TYPE;
  v_newid MD_TRIGGERS.ID%TYPE;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_TRIGGERS%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_TRIGGERS, 'TRIGGER_NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.TABLE_OR_VIEW_ID_FK := p_newtableid;
    INSERT INTO MD_TRIGGERS VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
    VALUES(v_originalid, C_OBJECTTYPE_TRIGGERS, v_newid, C_OBJECTTYPE_TRIGGERS, p_newconnectionid, v_row.TRIGGER_NAME, v_row.TRIGGER_NAME, C_NS_DB_TRIGGERS);
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_table_triggers;

FUNCTION copy_all_tables_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET :=NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  /*CURSOR curs IS SELECT * FROM MD_TABLES where SCHEMA_ID_FK = p_oldschemaid; */
  v_newid MD_TABLES.ID%TYPE := NULL;
  v_originalid MD_TABLES.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_TABLES%ROWTYPE;
  v_filt MIGR_FILTER;
  v_condition VARCHAR2(4000);
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_TABLES where SCHEMA_ID_FK = ' || p_oldschemaid;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_TABLES, 'TABLE_NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.SCHEMA_ID_FK := p_newschemaid;
    INSERT INTO MD_TABLES values v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid, C_OBJECTTYPE_TABLES, v_newid, C_OBJECTTYPE_TABLES, p_newconnectionid, v_row.TABLE_NAME, v_row.TABLE_NAME,  C_NS_SCHEMA_OBJS || TO_CHAR(p_newschemaid));
    v_ret := copy_all_columns_cascade(v_originalid, v_newid, p_newconnectionid, p_filter_set);
    v_ret := copy_all_indexes(v_originalid, v_newid, p_newconnectionid, p_newschemaid, p_filter_set);
    v_ret := copy_all_table_triggers(v_originalid, v_newid, p_newconnectionid, p_filter_set);
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_tables_cascade;

FUNCTION copy_all_view_triggers(p_oldviewid MD_VIEWS.ID%TYPE, p_newviewid MD_VIEWS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR curs IS SELECT * FROM MD_TRIGGERS WHERE MD_TRIGGERS.TABLE_OR_VIEW_ID_FK = p_oldviewid;
  v_originalid MD_TRIGGERS.ID%TYPE;
  v_newid MD_TRIGGERS.ID%TYPE;
  v_count NUMBER := 0;
  v_ret NUMBER;
BEGIN
  FOR v_row IN curs LOOP
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.TABLE_OR_VIEW_ID_FK := p_newviewid;
    INSERT INTO MD_TRIGGERS VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
    VALUES(v_originalid, C_OBJECTTYPE_TRIGGERS, v_newid, C_OBJECTTYPE_TRIGGERS, p_newconnectionid, v_row.TRIGGER_NAME, v_row.TRIGGER_NAME, C_NS_DB_TRIGGERS);
  END LOOP;
  return v_count;
END copy_all_view_triggers;

FUNCTION copy_all_views_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_VIEWS WHERE SCHEMA_ID_FK = ' || p_oldschemaid;
  v_newid MD_VIEWS.ID%TYPE := NULL;
  v_originalid MD_VIEWS.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_VIEWS%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_VIEWS, 'VIEW_NAME' ,'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs into v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.SCHEMA_ID_FK := p_newschemaid;
    INSERT INTO MD_VIEWS VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid,   C_OBJECTTYPE_VIEWS,   v_newid,   C_OBJECTTYPE_VIEWS, p_newconnectionid, v_row.VIEW_NAME, v_row.VIEW_NAME, C_NS_SCHEMA_OBJS || TO_CHAR(p_newschemaid));
    v_ret := copy_all_view_triggers(v_originalid, v_newid, p_newconnectionid);
  END LOOP;
  CLOSE cv_curs;
  RETURN v_count;
END copy_all_views_cascade;

FUNCTION copy_group_members(p_oldgroupid MD_GROUPS.ID%TYPE, p_newgroupid MD_GROUPS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR curs IS SELECT * FROM MD_GROUP_MEMBERS WHERE GROUP_ID_FK = p_oldgroupid;
  v_newid MD_GROUP_MEMBERS.ID%TYPE := NULL;
  v_originalid MD_GROUP_MEMBERS.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
BEGIN
  FOR v_row IN curs LOOP
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.GROUP_ID_FK := p_newgroupid;
    v_row.USER_ID_FK := find_object_copy(v_row.USER_ID_FK, C_OBJECTTYPE_USERS, p_newconnectionid);
    INSERT INTO MD_GROUP_MEMBERS VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
	-- Group members do not have identifiers, so don't need a namespace
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK)
      VALUES(v_originalid,   C_OBJECTTYPE_GROUP_MEMBERS,   v_newid,   C_OBJECTTYPE_GROUP_MEMBERS, p_newconnectionid);
  END LOOP;
  return v_count;
END copy_group_members;

FUNCTION copy_all_groups_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_GROUPS WHERE SCHEMA_ID_FK = ' || p_oldschemaid;
  v_newid MD_GROUPS.ID%TYPE := NULL;
  v_originalid MD_GROUPS.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_namespace MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE := NULL;
  v_row MD_GROUPS%ROWTYPE;
  v_catalogname MD_CATALOGS.CATALOG_NAME%TYPE;
  v_catalogdummy MD_CATALOGS.DUMMY_FLAG%TYPE;
  v_oldname MD_GROUPS.GROUP_NAME%TYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_GROUPS, 'GROUP_NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.SCHEMA_ID_FK := p_newschemaid;
    SELECT CATALOG_NAME, DUMMY_FLAG INTO v_catalogname, v_catalogdummy
      FROM MD_CATALOGS, MD_SCHEMAS WHERE MD_CATALOGS.ID = MD_SCHEMAS.CATALOG_ID_FK 
      AND MD_SCHEMAS.ID = p_oldschemaid;
    v_oldname := v_row.GROUP_NAME;
    if v_catalogdummy <> C_DUMMYFLAG_TRUE then
      v_row.GROUP_NAME := v_row.GROUP_NAME || '_' || v_catalogname;
    END IF;
    INSERT INTO MD_GROUPS values v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
	IF v_row.GROUP_FLAG = C_ROLE_FLAG THEN
		v_namespace := C_NS_USER_ROLES;
	ELSE
		v_namespace := C_NS_DATABASE;
	END IF;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid, C_OBJECTTYPE_GROUPS, v_newid, C_OBJECTTYPE_GROUPS, p_newconnectionid, v_oldname, v_row.GROUP_NAME, v_namespace);
    v_ret := copy_group_members(v_originalid, v_newid, p_newconnectionid);   
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_groups_cascade;

FUNCTION copy_all_users_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_USERS WHERE SCHEMA_ID_FK = ' || p_oldschemaid;
  v_newid MD_USERS.ID%TYPE := NULL;
  v_originalid MD_USERS.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_USERS%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_USERS, 'USERNAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.SCHEMA_ID_FK := p_newschemaid;
    INSERT INTO MD_USERS VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid,   C_OBJECTTYPE_USERS,   v_newid,   C_OBJECTTYPE_USERS, p_newconnectionid, v_row.USERNAME, v_row.USERNAME, C_NS_USERS);
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_users_cascade;

FUNCTION copy_all_other_objects_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_OTHER_OBJECTS WHERE SCHEMA_ID_FK = ' || p_oldschemaid;
  v_newid MD_OTHER_OBJECTS.ID%TYPE := NULL;
  v_originalid MD_OTHER_OBJECTS.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_OTHER_OBJECTS%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_OTHER_OBJECTS, 'NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.SCHEMA_ID_FK := p_newschemaid;
    INSERT INTO MD_OTHER_OBJECTS VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid,   C_OBJECTTYPE_OTHER_OBJECTS,   v_newid,   C_OBJECTTYPE_OTHER_OBJECTS, p_newconnectionid, v_row.NAME, v_row.NAME, C_NS_SCHEMA_OBJS || TO_CHAR(p_newschemaid));
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_other_objects_cascade;

FUNCTION copy_all_tablespaces_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_TABLESPACES WHERE SCHEMA_ID_FK = ' || p_oldschemaid;
  v_newid MD_TABLESPACES.ID%TYPE := NULL;
  v_originalid MD_TABLESPACES.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_TABLESPACES%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_TABLESPACES, 'TABLESPACE_NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.SCHEMA_ID_FK := p_newschemaid;
    INSERT INTO MD_TABLESPACES VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid,   C_OBJECTTYPE_TABLESPACES,   v_newid,   C_OBJECTTYPE_TABLESPACES, p_newconnectionid, v_row.TABLESPACE_NAME, v_row.TABLESPACE_NAME, C_NS_TABLESPACES);
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_tablespaces_cascade;

FUNCTION copy_all_udds_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_USER_DEFINED_DATA_TYPES WHERE SCHEMA_ID_FK = ' || p_oldschemaid;
  v_newid MD_USER_DEFINED_DATA_TYPES.ID%TYPE := NULL;
  v_originalid MD_USER_DEFINED_DATA_TYPES.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_USER_DEFINED_DATA_TYPES%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_UDDT, 'DATA_TYPE_NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.SCHEMA_ID_FK := p_newschemaid;
    INSERT INTO MD_USER_DEFINED_DATA_TYPES VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid,   C_OBJECTTYPE_UDDT,   v_newid,   C_OBJECTTYPE_UDDT, p_newconnectionid, v_row.DATA_TYPE_NAME, v_row.DATA_TYPE_NAME, C_NS_SCHEMA_OBJS || TO_CHAR(p_newschemaid));
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_udds_cascade;

FUNCTION copy_child_procedures(p_oldpackageid MD_PACKAGES.ID%TYPE, p_newpackageid MD_PACKAGES.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_STORED_PROGRAMS WHERE PACKAGE_ID_FK = ' || p_oldpackageid;
  v_newid MD_STORED_PROGRAMS.ID%TYPE := NULL;
  v_originalid MD_STORED_PROGRAMS.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_STORED_PROGRAMS%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_STORED_PROGRAMS, 'NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.PACKAGE_ID_FK := p_newpackageid;
    v_row.SCHEMA_ID_FK := p_newschemaid;
    INSERT INTO MD_STORED_PROGRAMS VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
	-- No need for namespace here, the namespace is the package itself.
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER)
      VALUES(v_originalid,   C_OBJECTTYPE_STORED_PROGRAMS,   v_newid,   C_OBJECTTYPE_STORED_PROGRAMS, p_newconnectionid, v_row.NAME, v_row.NAME);
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_child_procedures;
  
FUNCTION copy_all_packages_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_PACKAGES WHERE SCHEMA_ID_FK = ' || p_oldschemaid;
  v_newid MD_PACKAGES.ID%TYPE := NULL;
  v_originalid MD_PACKAGES.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_PACKAGES%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_PACKAGES, 'NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.SCHEMA_ID_FK := p_newschemaid;
    INSERT INTO MD_PACKAGES VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid,   C_OBJECTTYPE_PACKAGES,   v_newid,   C_OBJECTTYPE_PACKAGES, p_newconnectionid, v_row.NAME, v_row.NAME, C_NS_SCHEMA_OBJS || TO_CHAR(p_newschemaid));
    v_ret := copy_child_procedures(v_originalid, v_newid, p_newschemaid, p_newconnectionid, p_filter_set);
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_packages_cascade;

FUNCTION copy_all_unpackaged_sps(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_STORED_PROGRAMS WHERE SCHEMA_ID_FK = ' || p_oldschemaid ||' AND PACKAGE_ID_FK IS NULL';
  v_newid MD_STORED_PROGRAMS.ID%TYPE := NULL;
  v_originalid MD_STORED_PROGRAMS.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_STORED_PROGRAMS%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_STORED_PROGRAMS, 'NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.schema_id_fk := p_newschemaid;
    INSERT INTO MD_STORED_PROGRAMS VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
	-- Non-packaged procedures belong in the schema objects namespace.
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid, C_OBJECTTYPE_STORED_PROGRAMS, v_newid, C_OBJECTTYPE_STORED_PROGRAMS, p_newconnectionid, v_row.NAME, v_row.NAME, C_NS_SCHEMA_OBJS || TO_CHAR(p_newschemaid));
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_unpackaged_sps;

FUNCTION copy_all_synonyms_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_SYNONYMS WHERE SCHEMA_ID_FK = ' || p_oldschemaid;
  v_newid MD_SYNONYMS.ID%TYPE := NULL;
  v_originalid MD_SYNONYMS.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_namespace MD_DERIVATIVES.DERIVED_OBJECT_NAMESPACE%TYPE;
  v_row MD_SYNONYMS%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_SYNONYMS, 'NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.SYNONYM_FOR_ID := find_object_copy(v_row.SYNONYM_FOR_ID, v_row.FOR_OBJECT_TYPE, p_newconnectionid);
    INSERT INTO MD_SYNONYMS VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
	-- Synonyms have two potential name spaces:  Private synonyms belong in the schema objects, while public 
	-- synonyms belong in their own namespace.
	IF v_row.PRIVATE_VISIBILITY = C_SYNONYM_PRIVATE THEN
		v_namespace := C_NS_SCHEMA_OBJS || TO_CHAR(p_newschemaid);
	ELSE
		v_namespace := C_NS_PUBLIC_SYNONYMS;
        END IF;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid, C_OBJECTTYPE_SYNONYMS, v_newid, C_OBJECTTYPE_SYNONYMS, p_newconnectionid, v_row.NAME, v_row.NAME, v_namespace);
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_synonyms_cascade;

FUNCTION copy_all_sequences_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_SEQUENCES WHERE SCHEMA_ID_FK = ' || p_oldschemaid;
  v_newid MD_SEQUENCES.ID%TYPE := NULL;
  v_originalid MD_SEQUENCES.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_SEQUENCES%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_SEQUENCES, 'NAME', 'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    INSERT INTO MD_SEQUENCES VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, derived_connection_id_fk, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid, C_OBJECTTYPE_SEQUENCES, v_newid, C_OBJECTTYPE_SEQUENCES, p_newconnectionid, v_row.NAME, v_row.NAME, C_NS_SCHEMA_OBJS || TO_CHAR(p_newschemaid));
  END LOOP;
  CLOSE cv_curs;
  return v_count;
END copy_all_sequences_cascade;

FUNCTION copy_user_privileges(p_olduserid MD_PRIVILEGES.ID%TYPE, p_newuserid MD_PRIVILEGES.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR curs is SELECT * FROM MD_USER_PRIVILEGES WHERE PRIVILEGE_ID_FK = p_olduserid;
  v_newid MD_USER_PRIVILEGES.ID%TYPE;
  v_count NUMBER := 0;
  v_originalid MD_USER_PRIVILEGES.ID%TYPE;
  v_ret NUMBER;
BEGIN
  FOR v_row IN curs LOOP
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.USER_ID_FK := find_object_copy(v_row.USER_ID_FK , C_OBJECTTYPE_USERS, p_newconnectionid);
    v_row.PRIVILEGE_ID_FK := p_newuserid;
    INSERT INTO MD_USER_PRIVILEGES values v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK)
      VALUES(v_originalid, C_OBJECTTYPE_USER_PRIVILEGES, v_newid, C_OBJECTTYPE_USER_PRIVILEGES, p_newconnectionid);
  END LOOP;
  return v_count;
END copy_user_privileges;

FUNCTION copy_all_privileges_cascade(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_selectStmt VARCHAR2(4000) := 'SELECT * FROM MD_PRIVILEGES WHERE SCHEMA_ID_FK = ' || p_oldschemaid;
  v_newid MD_PRIVILEGES.ID%TYPE := NULL;
  v_originalid MD_PRIVILEGES.ID%TYPE := NULL;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_row MD_PRIVILEGES%ROWTYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_PRIVILEGES, 'PRIVILEGE_NAME' ,'ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs into v_row;
    EXIT WHEN cv_curs%NOTFOUND;
    v_originalid := v_row.ID;
    v_row.ID := NULL;
    v_row.PRIVELEGE_OBJECT_ID := find_object_copy(v_row.PRIVELEGE_OBJECT_ID , v_row.PRIVELEGEOBJECTTYPE, p_newconnectionid);
    v_row.SCHEMA_ID_FK := p_newschemaid;
    INSERT INTO MD_PRIVILEGES VALUES v_row RETURNING ID INTO v_newid;
    v_ret := copy_additional_properties(v_originalid, v_newid, p_newconnectionid);
    v_count := v_count + 1;
    -- No need to pass on the identifiers to the derivatives as no need to worry about the clashes for the same.
    INSERT INTO MD_DERIVATIVES(src_id, src_type, derived_id, derived_type, DERIVED_CONNECTION_ID_FK, DERIVED_OBJECT_NAMESPACE)
      VALUES(v_originalid,   C_OBJECTTYPE_PRIVILEGES,   v_newid,   C_OBJECTTYPE_PRIVILEGES, p_newconnectionid, C_NS_SCHEMA_OBJS || TO_CHAR(p_newschemaid));
    v_ret := copy_user_privileges(v_originalid, v_newid, p_newconnectionid);
  END LOOP;
  CLOSE cv_curs;
  RETURN v_count;
END copy_all_privileges_cascade;

FUNCTION copy_all_cross_schema_objects(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  v_ret NUMBER;
BEGIN
-- DD; Can't do this until all schema tables are done
-- There may be foreign keys between schema
  v_ret := copy_all_constraints_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  v_ret := copy_all_groups_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  v_ret := copy_all_other_objects_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  v_ret := copy_all_privileges_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  -- Do synonyms last: This way, we can be sure that the oject for which it is a synonym
  -- has already been copied.
  v_ret := copy_all_synonyms_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  return v_ret;
END copy_all_cross_schema_objects;

FUNCTION copy_all_schema_objects(p_oldschemaid MD_SCHEMAS.ID%TYPE, p_newschemaid MD_SCHEMAS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  v_ret NUMBER;
BEGIN
  v_ret := copy_all_tables_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  v_ret := copy_all_views_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  v_ret := copy_all_users_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  v_ret := copy_all_tablespaces_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  v_ret := copy_all_udds_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  v_ret := copy_all_packages_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  v_ret := copy_all_unpackaged_sps(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  v_ret := copy_all_sequences_cascade(p_oldschemaid, p_newschemaid, p_newconnectionid, p_filter_set);
  -- TODO: Roles are wrong in the model right now.  I need to fix these up.
  --v_ret := copy_all_roles_cascade(p_oldschemaid, p_newschemaid);
  return v_ret;  
END copy_all_schema_objects;

FUNCTION copy_catalogs_cascade(p_connectionid MD_CONNECTIONS.ID%TYPE, p_catalogid MD_CATALOGS.ID%TYPE, p_newconnectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET :=NULL) RETURN NUMBER
IS
  cv_curs REF_CURSOR;
  v_newid NUMBER;
  v_count NUMBER := 0;
  v_ret NUMBER;
  v_newName MD_SCHEMAS.NAME%TYPE;
  v_filt MIGR_FILTER;
  v_selectStmt VARCHAR2(4000) := 'SELECT a.id schema_id, A.name schema_name, b.id catalog_id, B.CATALOG_NAME, B.DUMMY_FLAG, A.type, A.character_set, A.version_tag 
      FROM MD_SCHEMAS A, MD_CATALOGS B
      WHERE 
      	A.CATALOG_ID_FK = B.ID
        AND
        A.catalog_id_fk in
        ( SELECT id from md_catalogs where CONNECTION_ID_FK = ' || p_connectionid || ')';
  v_schemaid MD_SCHEMAS.ID%TYPE;
  v_schemaname MD_SCHEMAS.NAME%TYPE;
  v_catalogid MD_CATALOGS.ID%TYPE;
  v_catalogname MD_CATALOGS.CATALOG_NAME%TYPE;
  v_catalogdummy MD_CATALOGS.DUMMY_FLAG%TYPE;
  v_schematype MD_SCHEMAS.TYPE%TYPE;
  v_schemacharset MD_SCHEMAS.CHARACTER_SET%TYPE;
  v_schemaversiontag MD_SCHEMAS.VERSION_TAG%TYPE;
BEGIN
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_CATALOGS, 'B.CATALOG_NAME', 'B.ID', v_selectStmt);
  -- NOTE: May need to apply a schema filter here too
  v_selectStmt := apply_filter(p_filter_set, C_OBJECTTYPE_SCHEMAS, 'A.NAME', 'A.ID', v_selectStmt);
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs INTO v_schemaid, v_schemaname, v_catalogid, v_catalogname, v_catalogdummy, v_schematype, v_schemacharset, v_schemaversiontag;
    EXIT WHEN cv_curs%NOTFOUND;
    -- TODO: Handle wrapping here.
    if v_catalogdummy <> C_DUMMYFLAG_TRUE then
      v_newName := v_schemaname|| '_' || v_catalogname;
	else
	  v_newName := v_schemaname;
	end if;
    INSERT INTO MD_SCHEMAS(CATALOG_ID_FK, NAME, TYPE, CHARACTER_SET, VERSION_TAG)
    VALUES (p_catalogid, v_newName, v_schematype, v_schemacharset, v_schemaversiontag)
    RETURNING ID INTO v_newid;
    -- Here's and interesting situation.  What will we do with the additional properties?
    -- I can coalesce them such that they are in the condensed catalog/schema pair
    -- But their order could (will) contain duplicates.....
    v_ret := copy_additional_properties(p_catalogid, v_newid, p_newconnectionid);
    v_ret := copy_additional_properties(v_schemaid, v_newid, p_newconnectionid);
	-- No Need for namespace stuff for catalogs.
    INSERT INTO MD_DERIVATIVES(SRC_ID, SRC_TYPE, DERIVED_ID, DERIVED_TYPE, DERIVED_CONNECTION_ID_FK,
      ORIGINAL_IDENTIFIER, NEW_IDENTIFIER)
    VALUES (v_schemaid, C_OBJECTTYPE_SCHEMAS, v_newid, C_OBJECTTYPE_SCHEMAS, p_newconnectionid, v_schemaname, v_newName);
    INSERT INTO MD_DERIVATIVES(SRC_ID, SRC_TYPE, DERIVED_ID, DERIVED_TYPE, DERIVED_CONNECTION_ID_FK, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER)
    VALUES (v_catalogid, C_OBJECTTYPE_CATALOGS, v_newid, C_OBJECTTYPE_SCHEMAS, p_newconnectionid, v_catalogname, v_newName);
    -- TODO: ADD THE FILTER TO THE PARAMETERS BELOW
    v_ret := copy_all_schema_objects(v_schemaid, v_newid, p_newconnectionid, p_filter_set);
    v_count := v_count + 1;
  END LOOP;
  CLOSE cv_curs;
  -- Now...Once all of the schema objects have been done, we have to copy all of those objects that could cross
  -- schema boundaries.  So we need to loop through them again
 v_selectStmt := 'SELECT SRC_ID, DERIVED_ID FROM MD_DERIVATIVES WHERE SRC_TYPE = ' 
  					|| '''' || C_OBJECTTYPE_SCHEMAS || ''' AND DERIVED_TYPE = ''' || C_OBJECTTYPE_SCHEMAS ||''''
  					|| ' AND DERIVED_CONNECTION_ID_FK = ' || p_newconnectionid;
  OPEN cv_curs FOR v_selectStmt;
  LOOP
    FETCH cv_curs into v_schemaid, v_newid;
    EXIT when cv_curs%NOTFOUND;
    v_ret := copy_all_cross_schema_objects(v_schemaid, v_newid, p_newconnectionid, p_filter_set);
  END LOOP;
  CLOSE cv_curs;  					
  return v_count;
END copy_catalogs_cascade;

FUNCTION remove_duplicate_indexes(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR v_curs IS select  index_id_fk, sum(md_index_details.column_id_fk * md_index_details.detail_order) simplehash from md_index_details 
    where index_id_fk in (select id from md_indexes where table_id_fk in (select table_id from mgv_all_tables where connection_id = p_connectionid)) 
    group by index_id_fk
    order by simplehash, index_id_fk;
  v_lasthash NUMBER :=0;
  v_currenthash NUMBER :=0;
  v_currentid MD_INDEX_DETAILS.INDEX_ID_FK%TYPE;
  v_lastid MD_INDEX_DETAILS.INDEX_ID_FK%TYPE;
  v_count NUMBER := 0;
  v_sql VARCHAR(255);
BEGIN
  OPEN v_curs;
  LOOP
    FETCH v_curs into v_currentid, v_currenthash;
    EXIT WHEN v_curs%NOTFOUND;
    if v_currenthash = v_lasthash THEN
      -- dbms_output.put_line('Index ' || TO_CHAR(v_currentid) || ' is a duplicate');
      v_sql := 'DELETE FROM MD_INDEXES WHERE ID = ' || v_currentid;
      EXECUTE IMMEDIATE v_sql;
      --dbms_output.put_line('DELETE FROM MD_INDEXES WHERE ID = ' || v_currentid);
      v_sql := 'UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = ''DUPIND'', DERIVED_ID = ' || TO_CHAR(v_lastid)  || ' WHERE DERIVED_ID = ' || TO_CHAR(v_currentid);
      EXECUTE IMMEDIATE v_sql;
      -- dbms_output.put_line('UPDATE MD_DERIVATIVES SET DERIVED_ID = ' || TO_CHAR(v_lastid)  || ' WHERE DERIVED_ID = ' || TO_CHAR(v_currentid));
      v_count := v_count + 1;
    else
      v_lasthash := v_currenthash;
      v_lastid := v_currentid;
    end if;
  END LOOP;
  CLOSE v_curs;
  return v_count;    
END remove_duplicate_indexes;

FUNCTION remove_indexes_used_elsewhere(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR v_curs IS
    select INDEX_ID_FK from 
      (select  index_id_fk, sum(md_index_details.column_id_fk * md_index_details.detail_order) simplehash from md_index_details 
       where index_id_fk in (select id from md_indexes where table_id_fk in (select table_id from mgv_all_tables where connection_id = p_connectionid)) 
       group by index_id_fk
       order by simplehash) a
    WHERE A.SIMPLEHASH 
    IN
    (
      SELECT b.simplehash FROM 
      (
        SELECT SUM(MD_CONSTRAINT_DETAILS.COLUMN_ID_FK * MD_CONSTRAINT_DETAILS.DETAIL_ORDER) simplehash from md_constraint_details
        where constraint_id_fk in (select id from md_constraints where table_id_fk in (select table_id from mgv_all_tables where connection_id = p_connectionid))
        group by constraint_id_fk
        order by simplehash
      ) b
     );
  v_currentId MD_INDEX_DETAILS.INDEX_ID_FK%TYPE;     
  v_sql VARCHAR2(255);
  v_count NUMBER := 0;
BEGIN
  OPEN v_curs;
  LOOP
    FETCH v_curs into v_currentid;
    EXIT WHEN v_curs%NOTFOUND;
      v_sql := 'DELETE FROM MD_INDEXES WHERE ID = ' || v_currentid;
      EXECUTE IMMEDIATE v_sql;
      --dbms_output.put_line('DELETE FROM MD_INDEXES WHERE ID = ' || v_currentid);
      v_sql := 'DELETE FROM MD_DERIVATIVES WHERE DERIVED_ID = ' || TO_CHAR(v_currentid);
      EXECUTE IMMEDIATE v_sql;
      -- dbms_output.put_line('UPDATE MD_DERIVATIVES SET DERIVED_ID = ' || TO_CHAR(v_lastid)  || ' WHERE DERIVED_ID = ' || TO_CHAR(v_currentid));
      v_count := v_count + 1;
  END LOOP;
  CLOSE v_curs;
  RETURN v_count;
END remove_indexes_used_elsewhere;    

PROCEDURE cut_lob_indexes_to_25(p_connectionId MD_CONNECTIONS.ID%TYPE)
IS
  CURSOR v_curs (context MD_ADDITIONAL_PROPERTIES.VALUE%TYPE, ctxcat MD_ADDITIONAL_PROPERTIES.VALUE%TYPE) is 
    SELECT * FROM MD_INDEXES WHERE 
    TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid)
    AND LENGTH(INDEX_NAME) > 25 AND  
    ( EXISTS (SELECT 1 FROM MD_ADDITIONAL_PROPERTIES WHERE ( VALUE = context 
    OR VALUE = ctxcat ) AND REF_ID_FK = MD_INDEXES.ID ) )
    FOR UPDATE OF INDEX_NAME;
  v_numIndexCount INTEGER := 1;
  v_newName MD_INDEXES.INDEX_NAME%TYPE;
  v_row MD_INDEXES%ROWTYPE;
BEGIN
-- totierne: for each lob index cut to 23 or 22 or 21 to put _XXX up to 25 chars (should be bytes)
  OPEN v_curs (C_INDEXTYPE_CONTEXT, C_INDEXTYPE_CTXCAT);
  LOOP
    FETCH v_curs INTO v_row;
    EXIT WHEN v_curs%NOTFOUND;
    v_newName := MIGRATION_TRANSFORMER.add_suffix(v_row.INDEX_NAME, '_' || TO_CHAR(v_numIndexCount), 25);
    update MD_INDEXES SET index_name = v_newName where current of v_curs;
    v_numIndexCount := v_numIndexCount + 1;
  END LOOP;
  CLOSE v_curs;
  commit;
END cut_lob_indexes_to_25;

FUNCTION fixupTextIndexes(p_connectionId MD_CONNECTIONS.ID%TYPE) return NUMBER
IS
  CURSOR v_curs is
    select index_id_fk, count(*) numcols from md_index_details where
    index_id_fk in (
      select c.id
      from md_columns a, md_index_details b, md_indexes c
      where b.column_id_fk = a.id
      and column_type in ('BLOB', 'CLOB')
      and b.index_id_fk = c.id
      and c.table_id_fk in (select table_id from mgv_all_tables where connection_id = p_connectionid)
    ) group by index_id_fk;
  v_indexId MD_INDEXES.ID%TYPE;
  v_numCols INTEGER;
  v_extendedIndexType MD_ADDITIONAL_PROPERTIES.VALUE%TYPE;
BEGIN        
  OPEN v_curs;
  LOOP
    FETCH v_curs into v_indexId, v_numCols;
    EXIT WHEN v_curs%NOTFOUND;
    IF v_numCols = 1 THEN
      v_extendedIndexType := C_INDEXTYPE_CONTEXT;
    ELSE
      v_extendedIndexType := C_INDEXTYPE_CTXCAT;
    END IF;
    INSERT INTO MD_ADDITIONAL_PROPERTIES(CONNECTION_ID_FK ,REF_ID_FK, REF_TYPE, PROP_KEY, VALUE)
    VALUES (p_connectionId, v_indexId, C_OBJECTTYPE_INDEXES, C_PROPKEY_EXTENDEDINDEXTYPE, v_extendedIndexType);
    COMMIT;
  END LOOP;
  -- NCLOBs cannot be indexed.  They aren't allowed in normal indexes, and they aren't allowed in TEXT 
  -- indexes.   The only thing to do here is to remove it.
  -- TODO: We can't just do this silently.
   -- Mark THE derivative RECORD AS DELETEd.
  UPDATE md_derivatives SET DERIVATIVE_REASON = 'NCLOBIND' WHERE DERIVED_TYPE = 'MD_INDEXES' AND DERIVED_CONNECTION_ID_FK = p_connectionid
      AND  DERIVED_ID IN 
             (SELECT C.ID   FROM MD_COLUMNS A, MD_INDEX_DETAILS B, MD_INDEXES C, MGV_ALL_TABLES D
                 WHERE B.COLUMN_ID_FK = A.ID AND COLUMN_TYPE ='NCLOB' AND B.INDEX_ID_FK = C.ID
                  AND C.TABLE_ID_FK = D.TABLE_ID AND D.CONNECTION_ID = p_connectionid);
  DELETE FROM MD_INDEXES WHERE ID IN
             (SELECT C.ID   FROM MD_COLUMNS A, MD_INDEX_DETAILS B, MD_INDEXES C, MGV_ALL_TABLES D
                 WHERE B.COLUMN_ID_FK = A.ID AND COLUMN_TYPE ='NCLOB' AND B.INDEX_ID_FK = C.ID
                  AND C.TABLE_ID_FK = D.TABLE_ID AND D.CONNECTION_ID = p_connectionid);
  -- cut blob/clob index string to 25 characters with _nn incrementing marker
  cut_lob_indexes_to_25(p_connectionId);
  CLOSE v_curs;
  return 0;
END fixupTextIndexes;

FUNCTION copy_connection_cascade(p_connectionid MD_CONNECTIONS.ID%TYPE, p_filter_set MIGR_FILTER_SET := NULL) RETURN NUMBER
IS
  v_newConnectionId MD_CONNECTIONS.ID%TYPE;
  v_numProps NUMBER;
  v_catalogId MD_CATALOGS.ID%TYPE;
  v_numCatalogs NUMBER;
  v_numDuplicateIndexes NUMBER;
BEGIN
  -- The connection doesn't use the filter, because it is called for a single connection.
  v_newConnectionId := copy_connection(p_connectionid);
  -- Don't forget its additional props
  v_numProps := copy_additional_properties(p_connectionid, v_newConnectionId, v_newConnectionId);
  -- OK - Next coalesce the schema/catalogs
  v_catalogId := create_dummy_catalog(v_newConnectionId);
  v_numCatalogs := copy_catalogs_cascade(p_connectionid, v_catalogid, v_newConnectionId, p_filter_set);
  v_numDuplicateIndexes := remove_duplicate_indexes(v_newConnectionId);
  v_numDuplicateIndexes := v_numDuplicateIndexes + remove_indexes_used_elsewhere(v_newConnectionId);
  return v_newConnectionId;
END copy_connection_cascade;

PROCEDURE update_derivative_record(p_orig VARCHAR2, p_new VARCHAR2, p_derivedid MD_DERIVATIVES.DERIVED_ID%TYPE,
p_derivedtype MD_DERIVATIVES.DERIVED_TYPE%TYPE, p_connectionid MD_DERIVATIVES.DERIVED_CONNECTION_ID_FK%TYPE)
IS	
BEGIN
    UPDATE MD_DERIVATIVES SET TRANSFORMED = C_TRANSFORMED_TRUE, ORIGINAL_IDENTIFIER = p_orig, NEW_IDENTIFIER = p_new
      WHERE DERIVED_ID = p_derivedid
      AND DERIVED_TYPE = p_derivedtype
      AND DERIVED_CONNECTION_ID_FK = p_connectionid;
END update_derivative_record;

/*
 * This procedure is like update_derivative_record except it should be used at name clash stage
 * basically, this will work the same as update_derivative_record except in those cases where
 * there is already a derivative record.  In this latter case, we want ORIGINAL_IDENTIFIER preserved
 * (this is called when there is a possiblity that we've carried out a second transformation
 */
PROCEDURE second_update_derivative(p_orig VARCHAR2, p_new VARCHAR2, p_derivedid MD_DERIVATIVES.DERIVED_ID%TYPE,
p_derivedtype MD_DERIVATIVES.DERIVED_TYPE%TYPE, p_connectionid MD_DERIVATIVES.DERIVED_CONNECTION_ID_FK%TYPE)
IS
  v_firstOriginal MD_DERIVATIVES.ORIGINAL_IDENTIFIER%TYPE;
BEGIN
  -- see if p_orig is already the new identifier
  select ORIGINAL_IDENTIFIER INTO v_firstOriginal FROM MD_DERIVATIVES
      WHERE DERIVED_ID = p_derivedid
      AND DERIVED_TYPE = p_derivedtype
      AND NEW_IDENTIFIER = p_orig
      AND DERIVED_CONNECTION_ID_FK = p_connectionid;
  if v_firstOriginal IS NULL then
    update_derivative_record(p_orig, p_new, p_derivedid, p_derivedtype, p_connectionid);
  else
    update_derivative_record(v_firstOriginal, p_new, p_derivedid, p_derivedtype, p_connectionid);
  end if;
EXCEPTION
  when NO_DATA_FOUND THEN
    update_derivative_record(p_orig, p_new, p_derivedid, p_derivedtype, p_connectionid);
  WHEN TOO_MANY_ROWS THEN
    dbms_output.put_line(TO_CHAR(p_derivedid) || ' ' || TO_CHAR(p_derivedtype) || ' '|| TO_CHAR(p_connectionid));
  
END second_update_derivative;

FUNCTION transform_column_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
    SELECT * FROM MD_COLUMNS
    WHERE TABLE_ID_FK IN
    (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = connid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(COLUMN_NAME) != COLUMN_NAME 
    FOR UPDATE OF COLUMN_NAME;
  v_rec MD_COLUMNS%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_rec.COLUMN_NAME);
    UPDATE MD_COLUMNS SET COLUMN_NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.COLUMN_NAME, v_newName, v_rec.ID, C_OBJECTTYPE_COLUMNS, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_COLUMNS, v_count);
  --return v_count;
END transform_column_identifiers;

FUNCTION transform_constraint_idents(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_CONSTRAINTS
  WHERE TABLE_ID_FK IN
    (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = connid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(NAME) != NAME
    FOR UPDATE OF NAME;
  v_rec MD_CONSTRAINTS%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_rec.NAME);
    UPDATE MD_CONSTRAINTS SET NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.NAME, v_newName, v_rec.ID, C_OBJECTTYPE_CONSTRAINTS, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_CONSTRAINTS, v_count);
END transform_constraint_idents;

FUNCTION transform_group_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_GROUPS WHERE
   SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(GROUP_NAME) != GROUP_NAME
    FOR UPDATE OF GROUP_NAME;
  v_rec MD_GROUPS%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_rec.GROUP_NAME);
    UPDATE MD_GROUPS SET GROUP_NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.GROUP_NAME, v_newName, v_rec.ID, C_OBJECTTYPE_GROUPS, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_GROUPS, v_count);
END transform_group_identifiers;

FUNCTION transform_index_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_INDEXES WHERE TABLE_ID_FK IN
    (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||INDEX_NAME) != INDEX_NAME
    FOR UPDATE OF INDEX_NAME;
  v_rec MD_INDEXES%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.INDEX_NAME);
    UPDATE MD_INDEXES SET INDEX_NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.INDEX_NAME, v_newName, v_rec.ID, C_OBJECTTYPE_INDEXES, p_connectionid);
  END LOOP;
  commit;
  CLOSE v_curs;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_INDEXES, v_count);
END transform_index_identifiers;

FUNCTION transform_othobj_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_OTHER_OBJECTS  WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||NAME) != NAME
    FOR UPDATE OF NAME;
  v_rec MD_OTHER_OBJECTS%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.NAME);
    UPDATE MD_OTHER_OBJECTS SET NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.NAME, v_newName, v_rec.ID, C_OBJECTTYPE_OTHER_OBJECTS, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_OTHER_OBJECTS, v_count);
END transform_othobj_identifiers;

FUNCTION transform_package_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_PACKAGES  WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||NAME) != NAME
    FOR UPDATE OF NAME;
  v_rec MD_PACKAGES%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.NAME);
    UPDATE MD_PACKAGES SET NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.NAME, v_newName, v_rec.ID, C_OBJECTTYPE_PACKAGES, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_PACKAGES, v_count);
END transform_package_identifiers;

FUNCTION transform_schema_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_SCHEMAS WHERE ID IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(NAME) != NAME
    FOR UPDATE OF NAME;
  v_rec MD_SCHEMAS%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName:= MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_rec.NAME);
    UPDATE MD_SCHEMAS SET NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.NAME, v_newName, v_rec.ID, C_OBJECTTYPE_SCHEMAS, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_SCHEMAS, v_count);
END transform_schema_identifiers;

FUNCTION transform_sequence_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_SEQUENCES WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||NAME) != NAME
    FOR UPDATE OF NAME;
  v_rec MD_SEQUENCES%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.NAME);
    UPDATE MD_SEQUENCES SET NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.NAME, v_newName, v_rec.ID, C_OBJECTTYPE_SEQUENCES, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_SEQUENCES, v_count);
END transform_sequence_identifiers;

FUNCTION transform_sproc_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_STORED_PROGRAMS WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||NAME) != NAME
    FOR UPDATE OF NAME;
  v_rec MD_STORED_PROGRAMS%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.NAME);
    UPDATE MD_STORED_PROGRAMS SET NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.NAME, v_newName, v_rec.ID, C_OBJECTTYPE_STORED_PROGRAMS, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_STORED_PROGRAMS, v_count);
END transform_sproc_identifiers;

FUNCTION transform_synonym_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_SYNONYMS WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||NAME) != NAME
    FOR UPDATE OF NAME;
  v_rec MD_SYNONYMS%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.NAME);
    UPDATE MD_SYNONYMS SET NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.NAME, v_newName, v_rec.ID, C_OBJECTTYPE_SYNONYMS, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_SYNONYMS, v_count);
END transform_synonym_identifiers;

FUNCTION transform_table_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_TABLES WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||TABLE_NAME) != TABLE_NAME
    FOR UPDATE OF TABLE_NAME;
  v_rec MD_TABLES%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.TABLE_NAME);
    UPDATE MD_TABLES SET TABLE_NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.TABLE_NAME, v_newName, v_rec.ID, C_OBJECTTYPE_TABLES, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_TABLES, v_count);
END transform_table_identifiers;

FUNCTION transform_view_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_VIEWS WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||VIEW_NAME) != VIEW_NAME
    FOR UPDATE OF VIEW_NAME;
  v_rec MD_VIEWS%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.VIEW_NAME);
    UPDATE MD_VIEWS SET VIEW_NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.VIEW_NAME, v_newName, v_rec.ID, C_OBJECTTYPE_VIEWS, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_VIEWS, v_count);
END transform_view_identifiers;

FUNCTION transform_tablespace_idents(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_TABLESPACES WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(TABLESPACE_NAME) != TABLESPACE_NAME
    FOR UPDATE OF TABLESPACE_NAME;
  v_rec MD_TABLESPACES%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_rec.TABLESPACE_NAME);
    UPDATE MD_TABLESPACES SET TABLESPACE_NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.TABLESPACE_NAME, v_newName, v_rec.ID, C_OBJECTTYPE_TABLESPACES, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_TABLESPACES, v_count);
END transform_tablespace_idents;

FUNCTION transform_trigger_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs IS 
  SELECT * FROM MD_TRIGGERS  WHERE TABLE_OR_VIEW_ID_FK IN
    (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||TRIGGER_NAME) != TRIGGER_NAME
    FOR UPDATE OF TRIGGER_NAME;
  CURSOR v_view_trigger_curs IS 
    SELECT * FROM MD_TRIGGERS  WHERE TABLE_OR_VIEW_ID_FK IN
    (SELECT VIEW_ID FROM MGV_ALL_VIEWS WHERE CONNECTION_ID =  p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||TRIGGER_NAME) != TRIGGER_NAME
    FOR UPDATE OF TRIGGER_NAME;
  v_rec MD_TRIGGERS%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs;
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.TRIGGER_NAME);
    UPDATE MD_TRIGGERS SET TRIGGER_NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.TRIGGER_NAME, v_newName, v_rec.ID, C_OBJECTTYPE_TRIGGERS, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  OPEN v_view_trigger_curs;
  LOOP
    FETCH v_view_trigger_curs INTO v_rec;
    EXIT WHEN v_view_trigger_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.TRIGGER_NAME);
    UPDATE MD_TRIGGERS SET TRIGGER_NAME = v_newName WHERE CURRENT OF v_view_trigger_curs;
    update_derivative_record(v_rec.TRIGGER_NAME, v_newName, v_rec.ID, C_OBJECTTYPE_TRIGGERS, p_connectionid);
  END LOOP;
  CLOSE v_view_trigger_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_TRIGGERS, v_count);
END transform_trigger_identifiers;

FUNCTION transform_uddt_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_USER_DEFINED_DATA_TYPES WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||DATA_TYPE_NAME) != DATA_TYPE_NAME
    FOR UPDATE OF DATA_TYPE_NAME;
  v_rec MD_USER_DEFINED_DATA_TYPES%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_prefixName||v_rec.DATA_TYPE_NAME);
    UPDATE MD_USER_DEFINED_DATA_TYPES SET DATA_TYPE_NAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.DATA_TYPE_NAME, v_newName, v_rec.ID, C_OBJECTTYPE_UDDT, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_UDDT, v_count);
END transform_uddt_identifiers;

FUNCTION transform_user_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_T
IS
  CURSOR v_curs(connid MD_CONNECTIONS.ID%TYPE) IS 
  SELECT * FROM MD_USERS WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(USERNAME) != USERNAME
    FOR UPDATE OF USERNAME;
  v_rec MD_USERS%ROWTYPE;
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_T;
  v_newName MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
BEGIN
  OPEN v_curs(p_connectionid);
  LOOP
    FETCH v_curs INTO v_rec;
    EXIT WHEN v_curs%NOTFOUND;
    v_count := v_count + 1;
    v_newName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_rec.USERNAME);
    UPDATE MD_USERS SET USERNAME = v_newName WHERE CURRENT OF v_curs;
    update_derivative_record(v_rec.USERNAME, v_newName, v_rec.ID, C_OBJECTTYPE_USERS, p_connectionid);
  END LOOP;
  CLOSE v_curs;
  commit;
  return NAME_AND_COUNT_T(C_OBJECTTYPE_USERS, v_count);
END transform_user_identifiers;

PROCEDURE rename_duplicate_index_names(p_connectionid MD_CONNECTIONS.ID%TYPE)
IS
  CURSOR v_curs is 
    SELECT * FROM MD_INDEXES WHERE 
    TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid)
    AND UPPER(INDEX_NAME) IN 
    ( SELECT ui FROM 
      (SELECT B.SCHEMA_ID, UPPER(INDEX_NAME) ui, COUNT(*) from md_indexes a, mgv_all_tables b where 
       a.table_id_fk = b.table_id 
       and b.connection_id = p_connectionid
       GROUP BY SCHEMA_ID, UPPER(INDEX_NAME)
       having COUNT(*) > 1
      )
    )
    ORDER BY Upper(INDEX_NAME)
    FOR UPDATE OF INDEX_NAME;
  v_row MD_INDEXES%ROWTYPE;
  v_newName MD_INDEXES.INDEX_NAME%TYPE;
  v_id MD_INDEXES.ID%TYPE;
  v_curName MD_INDEXES.INDEX_NAME%TYPE;
  v_count NUMBER := 1;
BEGIN
  v_curName := 'dsa;lkjsd;alskj;';
  OPEN v_curs;
  LOOP
    FETCH v_curs INTO v_row;
    EXIT WHEN v_curs%NOTFOUND;
    IF UPPER(v_row.INDEX_NAME) = UPPER(v_curName) THEN
      v_newName := MIGRATION_TRANSFORMER.ADD_SUFFIX(v_row.INDEX_NAME, '_' || TO_CHAR(v_count), 30);
      v_count := v_count + 1;
      update MD_INDEXES SET index_name = v_newName where current of v_curs;
      second_update_derivative(v_row.index_name, v_newName, v_row.ID, C_OBJECTTYPE_INDEXES, p_connectionid);
    else
      v_curName := v_row.INDEX_NAME;
      v_count := 1;
    END IF;
  END LOOP;
  CLOSE v_curs;
  commit;
END rename_duplicate_index_names;

PROCEDURE fixup_duplicate_identifier(p_connectionid MD_CONNECTIONS.ID%TYPE, 
                                      p_mdrec_id MD_DERIVATIVES.ID%TYPE,
                                      p_derived_type MD_DERIVATIVES.DERIVED_TYPE%TYPE,
                                      p_derived_id MD_DERIVATIVES.DERIVED_ID%TYPE,
                                      p_new_identifier MD_DERIVATIVES.NEW_IDENTIFIER%TYPE,
                                      p_suffix INTEGER)
IS
	v_transform_identifier MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
	v_did_a_transform CHAR(1) := 'Y';
	--v_underscoresuffixsize NUMBER;
	--v_underscoresuffix VARCHAR2(100);
  --v_sizebeforeprefix NUMBER;
BEGIN
  --v_underscoresuffix := '_' || TO_CHAR(p_suffix);
  --v_underscoresuffixsize := LENGTH(v_underscoresuffix);
  --v_sizebeforeprefix := 30 - v_underscoresuffixsize;
  v_transform_identifier := MIGRATION_TRANSFORMER.ADD_SUFFIX(p_new_identifier, '_' || TO_CHAR(p_suffix) ,30);
 CASE p_derived_type
	WHEN C_OBJECTTYPE_CONNECTIONS THEN
		UPDATE MD_CONNECTIONS SET NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_CATALOGS THEN
		UPDATE MD_CATALOGS SET CATALOG_NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_SCHEMAS THEN
		UPDATE MD_SCHEMAS SET NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_TABLES THEN
		UPDATE MD_TABLES SET TABLE_NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_CONSTRAINTS THEN
		UPDATE MD_CONSTRAINTS SET NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_INDEXES THEN
		UPDATE MD_INDEXES SET INDEX_NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_TRIGGERS THEN
		UPDATE MD_TRIGGERS SET TRIGGER_NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_VIEWS THEN
		UPDATE MD_VIEWS SET VIEW_NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_USERS THEN
		UPDATE MD_USERS SET USERNAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_GROUPS THEN
		UPDATE MD_GROUPS SET GROUP_NAME  = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_OTHER_OBJECTS THEN
		UPDATE MD_OTHER_OBJECTS SET NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_TABLESPACES THEN
		UPDATE MD_TABLESPACES SET TABLESPACE_NAME  = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_UDDT THEN
		UPDATE MD_USER_DEFINED_DATA_TYPES SET DATA_TYPE_NAME  = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_STORED_PROGRAMS THEN
		UPDATE MD_STORED_PROGRAMS SET NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_PACKAGES THEN
		UPDATE MD_PACKAGES SET NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_SYNONYMS THEN
		UPDATE MD_SYNONYMS SET NAME = v_transform_identifier WHERE ID = p_derived_id;
	WHEN C_OBJECTTYPE_SEQUENCES THEN
		UPDATE MD_SEQUENCES SET NAME = v_transform_identifier WHERE ID = p_derived_id;
	ELSE
		-- Handle column namespace here.
		IF SUBSTR(P_DERIVED_TYPE,1, LENGTH(C_OBJECTTYPE_COLUMNS)) = C_OBJECTTYPE_COLUMNS THEN
			UPDATE MD_COLUMNS SET COLUMN_NAME = v_transform_identifier WHERE ID = p_derived_id;
		ELSE
			v_did_a_transform := 'N';
		END IF;
	END CASE;
	IF v_did_a_transform = 'Y' THEN
	  UPDATE MD_DERIVATIVES SET NEW_IDENTIFIER = v_transform_identifier WHERE ID = p_mdrec_id;
	  commit;
    END IF;
    commit;
END fixup_duplicate_identifier;

FUNCTION getClashCount(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN INTEGER 
IS
  v_clashCount INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_clashCount FROM md_derivatives a
    where rowid > (
      select min(rowid) from md_derivatives b
      where
        b.derived_connection_id_fk = p_connectionid
        AND b.derived_connection_id_fk = a.derived_connection_id_fk
        AND UPPER(b.new_identifier) = UPPER(a.new_identifier)--  Uppercasing the name so that case sensitve names are caught (see bug 6922052)
        AND b.derived_object_namespace = a.derived_object_namespace);
  RETURN v_clashCount;
END getClashCount;

PROCEDURE transform_clashes(p_connectionid MD_CONNECTIONS.ID%TYPE)
IS
  CURSOR v_curs IS
    select id,derived_type, derived_id, UPPER(new_identifier) --  Uppercasing the name so that case sensitve names are caught (see bug 6922052)
    from md_derivatives a
    where rowid > (
      select min(rowid) from md_derivatives b
      where
        b.derived_connection_id_fk = p_connectionid
        AND b.derived_connection_id_fk = a.derived_connection_id_fk
        AND UPPER(b.new_identifier) = UPPER(a.new_identifier) --  Uppercasing the name so that case sensitve names are caught (see bug 6922052)
        AND b.derived_object_namespace = a.derived_object_namespace)
        ORDER BY new_identifier, derived_type;
  v_derived_type MD_DERIVATIVES.DERIVED_TYPE%TYPE;
  v_curr_type v_derived_type%TYPE := '~~dasdddfl;';
  v_derived_id MD_DERIVATIVES.DERIVED_ID%TYPE;
  v_new_identifier MD_DERIVATIVES.NEW_IDENTIFIER%TYPE;
  v_curr_identifier v_new_identifier%TYPE := '~~~~asdasnc';
  v_suffix INTEGER := 0;
  v_innerSuffix INTEGER;
  v_clashCount INTEGER;
  v_mdrec_id MD_DERIVATIVES.ID%TYPE;
BEGIN
  rename_duplicate_index_names(p_connectionid);
  v_clashCount := getClashCount(p_connectionid);
  WHILE v_clashCount > 0 
  LOOP
	v_suffix := v_suffix + 1;
	v_innerSuffix := v_suffix; 
    -- Now lets see if there are any identifier clashes
    OPEN v_curs;
    LOOP 
      FETCH v_curs into v_mdrec_id, v_derived_type, v_derived_id, v_new_identifier;
      EXIT WHEN v_curs%NOTFOUND;
 	  IF v_derived_type = v_curr_type AND v_new_identifier = v_curr_identifier THEN
		  v_innerSuffix := v_innerSuffix + 1;
	  else
		  v_curr_type := v_derived_type;
		  v_curr_identifier := v_new_identifier;
	  END IF;
      -- We have to fix up all of these identifiers
      fixup_duplicate_identifier(p_connectionid, v_mdrec_id, v_derived_type, v_derived_id, v_new_identifier, v_innerSuffix);
    END LOOP;
	CLOSE v_curs;
    v_clashCount := getClashCount(p_connectionid);
  END LOOP;
END transform_clashes;

FUNCTION transform_all_identifiers_x(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NAME_AND_COUNT_ARRAY
IS
  v_count INTEGER := 0;
  v_ret NAME_AND_COUNT_ARRAY;
  v_rec NAME_AND_COUNT_T;
BEGIN
  v_ret := NAME_AND_COUNT_ARRAY();
  -- We need to update identifiers on pretty much the whole schema
  -- MD_COLUMNS
  v_rec := transform_column_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  
  -- MD_CONSTRAINTS
  v_rec := transform_constraint_idents(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_GROUPS
  v_rec := transform_group_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_INDEXES
  v_rec := transform_index_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_OTHER_OBJECTS
  v_rec := transform_othobj_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_PACKAGES
  v_rec := transform_package_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_SCHEMAS
  v_rec := transform_schema_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_SEQUENCES
  v_rec := transform_sequence_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_STORED_PROGRAMS
  v_rec := transform_sproc_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_SYNONYMS
  v_rec := transform_synonym_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_TABLES
  v_rec := transform_table_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_TABLESPACES
  v_rec := transform_tablespace_idents(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_TRIGGERS
  v_rec := transform_trigger_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_USER_DEFINED_DATA_TYPES
  v_rec := transform_uddt_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  -- MD_USERS
  v_rec := transform_user_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  /*
  UPDATE MD_USERS SET USERNAME = MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(USERNAME) WHERE SCHEMA_ID_FK IN
    (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionid)
    AND MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(USERNAME) != USERNAME;
  dbms_output.put_line(SQL%ROWCOUNT || ' USER names updated');
  */
  -- MD_VIEWS
  v_rec := transform_view_identifiers(p_connectionid);
  v_ret.EXTEND;
  v_ret(v_ret.count) := v_rec;
  dbms_output.put_line(v_rec.UPDATE_COUNT || v_rec.OBJECT_NAME || ' names udpates');
  transform_clashes(p_connectionid);
  -- TODO: Something meaningful if all goes wrong
  return v_ret;
  COMMIT;
END transform_all_identifiers_x;

FUNCTION transform_all_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE, p_prefixName VARCHAR2) RETURN NAME_AND_COUNT_ARRAY
IS
BEGIN
v_prefixName := p_prefixName;
RETURN  transform_all_identifiers_x(p_connectionid);
END transform_all_identifiers;

FUNCTION rule_specificity(p_precision MIGR_DATATYPE_TRANSFORM_RULE.SOURCE_PRECISION%TYPE, p_scale MIGR_DATATYPE_TRANSFORM_RULE.SOURCE_SCALE%TYPE) RETURN INTEGER
IS
BEGIN
  IF p_precision is NULL then 
    return 1;
  END IF;
  IF p_scale is NULL then
    return 2;
  END IF;
  return 3;
END rule_specificity;

FUNCTION addToWhereClause(p_whereclause VARCHAR2, p_toAdd VARCHAR2) return VARCHAR2
IS
BEGIN
  IF p_whereclause is NULL then
    return p_toAdd;
  else
    return p_whereclause || ' AND ' || p_toAdd;
  END IF;
END addToWhereClause;

FUNCTION precision_val(p_srcPrecision MD_COLUMNS.PRECISION%TYPE, p_newDataType VARCHAR2) RETURN VARCHAR2
IS
  v_newDataType VARCHAR2(255);
  v_ret VARCHAR2(255);
BEGIN
  v_newDataType := UPPER(to_char(p_newDataType));
  -- Assume that no precision should be present
  v_ret := 'NULL';
  -- No see what the new data type is and ensure that a precision is required
  IF v_newDataType = 'VARCHAR2' OR
     v_newDataType = 'NVARCHAR2' OR
     v_newDataType = 'NUMBER' OR
     v_newDataType = 'TIMESTAMP' OR
     v_newDataType = 'INTERVAL YEAR' OR
     v_newDataType = 'INTERVAL DAY' OR
     v_newDataType = 'UROWID' OR
     v_newDataType = 'CHAR' OR
     v_newDataType = 'RAW' OR
     v_newDataType = 'NCHAR' THEN
     v_ret := p_srcPrecision;
  END IF;
  return v_ret;
END precision_val;

FUNCTION scale_val(p_srcPrecision MD_COLUMNS.SCALE%TYPE, p_newDataType VARCHAR2) RETURN VARCHAR2
IS
  v_newDataType VARCHAR2(255);
  v_ret VARCHAR2(255);
BEGIN
  v_newDataType := UPPER(to_char(p_newDataType));
  v_ret := 'NULL';
  IF v_newDataType = 'NUMBER' THEN
    v_ret := p_srcPrecision;
  END IF;
  return v_ret;
END scale_val;


FUNCTION check_for_invalid_data_types(p_connectionid MD_CONNECTIONS.ID%TYPE, p_numbytesperchar INTEGER) RETURN NUMBER
IS
BEGIN
    -- First, for char(n) columns, drop back to varchar2 - this could go up to 4k.
    -- If its even greater than this, it will be caught later on and made into a CLOB.
    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
        AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'CHAR' AND PRECISION > 2000
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET COLUMN_TYPE = 'VARCHAR2' WHERE COLUMN_TYPE = 'CHAR' AND PRECISION > 2000
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);
    -- We'll do something similar for NCHARs
    IF p_numbytesperchar = 1 THEN
        UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
          AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'NCHAR' AND PRECISION > 2000 
            AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
        UPDATE MD_COLUMNS SET COLUMN_TYPE = 'NVARCHAR2' WHERE COLUMN_TYPE = 'NCHAR' AND PRECISION > 2000 
            AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);
    ELSE   
        -- 2 bytes per char - max is actually 1k          
        UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
          AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'NCHAR' AND PRECISION > 1000 
            AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
        UPDATE MD_COLUMNS SET COLUMN_TYPE = 'NVARCHAR2' WHERE COLUMN_TYPE = 'NCHAR' AND PRECISION > 1000 
            AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);
    END IF;            
    -- VARCHAR or VARCHAR2 can't go above 4000.  If they do, they need to fallback to a CLOB
    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'VARCHAR' AND PRECISION > 4000 
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET COLUMN_TYPE = 'CLOB', PRECISION = NULL, SCALE = NULL WHERE COLUMN_TYPE = 'VARCHAR' AND PRECISION > 4000 
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);

    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS  WHERE COLUMN_TYPE = 'VARCHAR2' AND PRECISION > 4000 
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET COLUMN_TYPE = 'CLOB', PRECISION = NULL, SCALE = NULL WHERE COLUMN_TYPE = 'VARCHAR2' AND PRECISION > 4000 
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);
    -- NUMBER has a max precision of 38, and scale must be between -84 and 127
    -- We can only narrow this.  

    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'NUMBER' AND PRECISION > 38
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET PRECISION = 38 WHERE COLUMN_TYPE = 'NUMBER' AND PRECISION > 38
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);

    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'NUMBER' AND SCALE < -84
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET SCALE = -84 WHERE COLUMN_TYPE = 'NUMBER' AND SCALE < -84
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);

    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'NUMBER' AND SCALE > 127
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET SCALE = 127 WHERE COLUMN_TYPE = 'NUMBER' AND SCALE > 127
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);
    -- NVARCHAR has a max of 4000 bytes.  But its definition depends on the character set in use.
    IF  p_numbytesperchar = 1 THEN
        UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
          AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'NVARCHAR2' AND PRECISION > 4000 
            AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
        UPDATE MD_COLUMNS SET COLUMN_TYPE = 'NCLOB', PRECISION = NULL, SCALE = NULL WHERE COLUMN_TYPE = 'NVARCHAR2' AND PRECISION > 4000 
            AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);
    ELSE
        UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
          AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'NVARCHAR2' AND PRECISION > 2000 
            AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
        UPDATE MD_COLUMNS SET COLUMN_TYPE = 'NCLOB', PRECISION = NULL, SCALE = NULL WHERE COLUMN_TYPE = 'NVARCHAR2' AND PRECISION > 2000 
            AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);
    END IF;            
    -- TIMESTAMP has a max size of 9

    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'TIMESTAMP' AND PRECISION > 9
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET PRECISION = 9 WHERE COLUMN_TYPE = 'TIMESTAMP' AND PRECISION > 9
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);

    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'INTERVAL YEAR' AND PRECISION > 9
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET PRECISION = 9 WHERE COLUMN_TYPE = 'INTERVAL YEAR' AND PRECISION > 9
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);

    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'INTERVAL DAY' AND PRECISION > 9
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET PRECISION = 9 WHERE COLUMN_TYPE = 'INTERVAL DAY' AND PRECISION > 9
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);

    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'INTERVAL DAY' AND SCALE > 9
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET SCALE = 9 WHERE COLUMN_TYPE = 'INTERVAL DAY' AND SCALE > 9
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);

    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'UROWID' AND PRECISION > 4000
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET PRECISION = 4000 WHERE COLUMN_TYPE = 'UROWID' AND PRECISION > 4000
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);
    -- Too large RAW?  Make it a CLOB        

    UPDATE MD_DERIVATIVES SET DERIVATIVE_REASON = 'INVDTTYPE' WHERE DERIVED_CONNECTION_ID_FK = p_connectionid
      AND DERIVED_TYPE = 'MD_COLUMNS' AND DERIVED_ID IN (SELECT ID FROM MD_COLUMNS WHERE COLUMN_TYPE = 'RAW' AND PRECISION > 2000
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid));
    UPDATE MD_COLUMNS SET COLUMN_TYPE = 'BLOB', PRECISION = NULL WHERE COLUMN_TYPE = 'RAW' AND PRECISION > 2000
        AND TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionid);
    commit;
    RETURN 0;        
END check_for_invalid_data_types;

FUNCTION transform_datatypes(p_connectionid MD_CONNECTIONS.ID%TYPE, p_mapid MIGR_DATATYPE_TRANSFORM_MAP.ID%TYPE, p_numbytesperchar INTEGER) RETURN NUMBER
IS
  v_projectid MD_PROJECTS.ID%TYPE;
  v_mapProjectid MD_PROJECTS.ID%TYPE;
  CURSOR v_curs(mapid MIGR_DATATYPE_TRANSFORM_MAP.ID%TYPE) IS
    SELECT * FROM MIGR_DATATYPE_TRANSFORM_RULE WHERE map_ID_fk = mapid
    ORDER BY     DECODE(source_precision,
            NULL, 0,
            1) +
    DECODE(source_scale,
            NULL, 0,
            1)  DESC;
  v_rule MIGR_DATATYPE_TRANSFORM_RULE%ROWTYPE;
  v_whereClause VARCHAR2(4000);
  v_updateClause VARCHAR2(4000);
  v_count NUMBER := 0;
  v_ret NUMBER;
BEGIN
  -- We should only work with our "own" maps.  I.e. The map should be part of this project.
  SELECT project_id_fk into v_projectid from MD_CONNECTIONS where id = p_connectionid;
  SELECT project_id_fk into v_mapProjectid from MIGR_DATATYPE_TRANSFORM_MAP where id = p_mapid;
  IF v_projectid != v_mapProjectid then 
    -- TODO.  Some nice RAISE_APPLICATION_ERROR stuff here.
    return 0;
  END IF;
  -- OK We can work with our map
  OPEN v_curs(p_mapid);
  LOOP
    fetch v_curs INTO v_rule;
    EXIT WHEN v_curs%NOTFOUND;
    v_whereClause := 'UPPER(COLUMN_TYPE) = ''' || UPPER(v_rule.SOURCE_DATA_TYPE_NAME) || '''';
    if v_rule.SOURCE_PRECISION is not NULL then
      v_whereClause := addToWhereClause(v_whereClause, 'PRECISION = ' || to_char(v_rule.source_precision));
      IF v_rule.SOURCE_SCALE is not NULL then
        v_whereClause := addToWhereClause(v_whereClause, 'SCALE = ' || to_char(v_rule.source_scale));
      end IF;
    END IF;
    v_whereClause := addToWhereClause(v_whereClause, 'table_id_fk in (SELECT table_id from MGV_ALL_TABLES WHERE connection_id = ' || to_char(p_connectionid) || ')');
    v_whereClause := addTowhereclause(v_whereClause, 'DATATYPE_TRANSFORMED_FLAG IS NULL');
    v_updateClause := 'UPDATE MD_COLUMNS SET COLUMN_TYPE = ''' || v_rule.TARGET_DATA_TYPE_NAME || ''', DATATYPE_TRANSFORMED_FLAG=''Y''';
    IF v_rule.TARGET_PRECISION is not NULL then
      v_updateClause := v_updateClause || ', PRECISION = ' || precision_val(v_rule.TARGET_PRECISION, v_rule.TARGET_DATA_TYPE_NAME);
      IF v_rule.TARGET_SCALE is not NULL then
        -- The rule says change it to a specific scale, but we may override this is the data type shouldn't have a scale
        v_updateClause := v_updateClause || ', SCALE = ' || scale_val(v_rule.TARGET_SCALE, v_rule.TARGET_DATA_TYPE_NAME);
      ELSE
        -- There was no mention on the rule to touch the scale, so we should leave it alone...
        -- ..unless of course the data type forbids having it.
        IF scale_val(1, v_rule.TARGET_DATA_TYPE_NAME) = 'NULL' THEN
          v_updateClause := v_updateClause || ', SCALE = NULL';
        END IF;
      END IF;
    ELSE
      -- There was no metion on the rul to touch the precision, so we should leave it alone...
      -- ..unless of course the data type forbids having it.
      IF precision_val(1, v_rule.TARGET_DATA_TYPE_NAME) = 'NULL' THEN
        v_updateClause := v_updateClause || ', PRECISION = NULL';
      END IF;
      IF scale_val(1, v_rule.TARGET_DATA_TYPE_NAME) = 'NULL' THEN
        v_updateClause := v_updateClause || ', SCALE = NULL';
      END IF;
    END IF;
    v_updateClause := v_updateClause || ' WHERE ' || v_whereClause;
    dbms_output.put_line(v_updateClause);
    EXECUTE IMMEDIATE v_updateClause;
    v_count := v_count + SQL%ROWCOUNT;
  END LOOP;
  CLOSE v_curs;
  COMMIT;
  -- OK.  Lets see if we've made any columns invalid.
  v_ret := check_for_invalid_data_types(p_connectionid, p_numbytesperchar);  
  -- Now that we know the data types of the index columns, we may have flag some of the indexes
  -- as text indexes.
  v_ret := fixupTextIndexes(p_connectionid);

  RETURN v_count;
END transform_datatypes;

FUNCTION GET_IDENTITY_TRIGGER(v_triggerName VARCHAR2 , v_tableName VARCHAR2  , 
v_ColumnName VARCHAR2  ,v_seqName VARCHAR2 ,v_emulationPkgNamePrefix VARCHAR2 ) RETURN VARCHAR2
AS
BEGIN
return 'CREATE OR REPLACE TRIGGER ' || v_triggerName || ' BEFORE INSERT OR UPDATE ON ' || v_tableName || CHR(10) ||
       'FOR EACH ROW' || CHR(10) ||
       'DECLARE ' || CHR(10)||
       'v_newVal NUMBER(12) := 0;' ||CHR(10) ||
	   'v_incval NUMBER(12) := 0;'||CHR(10) ||
       'BEGIN' || CHR(10) ||
       '  IF INSERTING AND :new.' || v_ColumnName || ' IS NULL THEN' || CHR(10) ||
       '    SELECT  ' || v_seqName || '.NEXTVAL INTO v_newVal FROM DUAL;' || CHR(10) ||
	   '    -- If this is the first time this table have been inserted into (sequence == 1)' || CHR(10) ||
	   '    IF v_newVal = 1 THEN ' || CHR(10) ||
	   '      --get the max indentity value from the table' || CHR(10) ||
	   '      SELECT max(' || v_ColumnName || ') INTO v_newVal FROM ' || v_tableName || ';'|| CHR(10) || 
	   '      v_newVal := v_newVal + 1;' || CHR(10) || 
	   '      --set the sequence to that value'|| CHR(10) || 
	   '      LOOP'|| CHR(10) || 
	   '           EXIT WHEN v_incval>=v_newVal;'|| CHR(10) || 
	   '           SELECT ' || v_seqName || '.nextval INTO v_incval FROM dual;'|| CHR(10) || 
       '      END LOOP;'|| CHR(10) || 
       '    END IF;'|| CHR(10) ||    
       '    -- save this to emulate @@identity'|| CHR(10) || 
       '   '||v_emulationPkgNamePrefix || 'identity := v_newVal; '|| CHR(10) || 
       '   -- assign the value from the sequence to emulate the identity column'|| CHR(10) || 
       '   :new.' || v_ColumnName || ' := v_newVal;'|| CHR(10) || 
       '  END IF;' || CHR(10) ||
       'END;' || CHR(10);
END GET_IDENTITY_TRIGGER;

FUNCTION transform_identity_columns(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR v_curs IS SELECT a.schema_id_fk, a.id tableid, a.TABLE_NAME, b.id, b.column_name
                   FROM md_tables a, md_columns b WHERE b.id IN
                     (SELECT ref_id_fk FROM md_additional_properties WHERE prop_key = C_PROPKEY_SEEDVALUE)
                   AND table_id_fk IN (SELECT table_id FROM mgv_all_tables WHERE connection_id = p_connectionid)
                   AND a.id = b.table_id_fk
                   AND b.id NOT IN (SELECT SRC_ID FROM MD_DERIVATIVES WHERE SRC_TYPE = C_OBJECTTYPE_COLUMNS AND DERIVED_TYPE = C_OBJECTTYPE_SEQUENCES AND 
                                    DERIVED_CONNECTION_ID_FK = p_connectionid);
  CURSOR v_projectNameCurs 
  IS
  SELECT project_name FROM mgv_all_connections WHERE connection_id = p_connectionid;
  
  	v_schemaId MD_SCHEMAS.ID%TYPE;
	v_tableId MD_TABLES.ID%TYPE;
        v_tableName MD_TABLES.TABLE_NAME%TYPE;
	v_columnId MD_COLUMNS.ID%TYPE;
	v_columnName MD_COLUMNS.COLUMN_NAME%TYPE;
	v_row MD_ADDITIONAL_PROPERTIES%ROWTYPE;
	v_seedValue NUMBER;
	-- Default the increment to 1 if it is not supplied.
	v_increment NUMBER := 1;
	v_lastVal NUMBER := NULL;
	v_retId MD_SEQUENCES.ID%TYPE;
	v_retSeqId MD_SEQUENCES.ID%TYPE;
	v_seqName MD_SEQUENCES.NAME%TYPE;
        v_trgName MD_TRIGGERS.TRIGGER_NAME%TYPE;
	v_triggerText VARCHAR2(4000);
        v_lob CLOB;
	v_transRet NAME_AND_COUNT_T;
	v_projectName VARCHAR2(1000);
	v_emulationPkgNamePrefix VARCHAR2(100) := '';
BEGIN
  -- Auxillary, get the emulation package name
  OPEN v_projectNameCurs;
  FETCH v_projectNameCurs INTO v_projectName;
  CLOSE v_projectNameCurs;
  
  IF INSTR(LOWER(v_projectName), 'sql server') <> 0 THEN
  	v_emulationPkgNamePrefix := 'sqlserver_utilities.';
  ELSIF INSTR(LOWER(v_projectName), 'sqlserver') <> 0 THEN
  	v_emulationPkgNamePrefix := 'sqlserver_utilities.'; 	
  ELSIF INSTR(LOWER(v_projectName), 'access') <> 0 THEN
    v_emulationPkgNamePrefix := 'msaccess_utilities.';
  ELSIF INSTR(LOWER(v_projectName), 'sybase') <> 0 THEN
    v_emulationPkgNamePrefix := 'sybase_utilities.';
  ELSIF INSTR(LOWER(v_projectName), 'ase') <> 0 THEN
    v_emulationPkgNamePrefix := 'sybase_utilities.';  
  ELSIF INSTR(LOWER(v_projectName), 'mysql') <> 0 THEN
    v_emulationPkgNamePrefix := 'mysql_utilities.';  
  END IF;
  
  OPEN v_curs;
  LOOP
  	FETCH v_curs into v_schemaId, v_tableId, v_tableName, v_columnId, v_columnName;
  	EXIT WHEN v_curs%NOTFOUND;
  	-- The above query excludes already created sequences, so we should be ok.
  	-- create the sequence:
  	-- 1. Get the seedvalue, increment, lastvalue if present
  	FOR v_row in (SELECT * FROM MD_ADDITIONAL_PROPERTIES WHERE REF_ID_FK = v_columnId)
  	LOOP
  	  IF v_row.PROP_KEY = C_PROPKEY_SEEDVALUE THEN
  	    v_seedValue := TO_NUMBER(v_row.VALUE);
          END IF;
  	  IF v_row.PROP_KEY = C_PROPKEY_INCREMENT THEN
  	    v_increment := TO_NUMBER(v_row.VALUE);
          END IF;
  	  IF v_row.PROP_KEY = C_PROPKEY_LASTVALUE THEN
  	    v_lastVal := TO_NUMBER(v_row.VALUE);
  	  END IF;
  	END LOOP;
  	-- Note: We'll start our sequence where the source left off.
  	IF v_lastVal IS NOT NULL THEN
  	  v_seedValue := v_lastVal;
  	END IF;
      
  	-- 2. Create the sequence
  	-- Note: I'm adding _SEQ to the column name for now. We'll have to use the collision manager in the
  	-- future.
  	v_seqName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_tableName || '_' || v_columnName || '_SEQ');
  	INSERT INTO MD_SEQUENCES(SCHEMA_ID_FK, NAME, SEQ_START, INCR)
  	  VALUES (v_schemaId, v_seqName, v_seedValue, v_increment)
  	  RETURNING ID INTO v_retId;
  	v_retSeqId := v_retId;
  	-- And of course a new derivative record
  	INSERT INTO MD_DERIVATIVES(SRC_ID, SRC_TYPE, DERIVED_ID, DERIVED_TYPE, DERIVED_CONNECTION_ID_FK, TRANSFORMED, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
  	  VALUES(v_columnId, C_OBJECTTYPE_COLUMNS, v_retId, C_OBJECTTYPE_SEQUENCES, p_connectionId, C_TRANSFORMED_TRUE, NULL, v_seqName, C_NS_SCHEMA_OBJS || TO_CHAR(v_schemaId));
  	-- Create the trigger
        v_trgName := MIGRATION_TRANSFORMER.TRANSFORM_IDENTIFIER(v_tableName || '_' || v_columnName || '_TRG');
  	v_triggerText := GET_IDENTITY_TRIGGER(v_trgName, v_tableName , v_ColumnName ,v_seqName ,v_emulationPkgNamePrefix);
  	-- Note: I'm adding _TRG to the column name for now.We'll have to use the collsion manager in the futre.
  	INSERT INTO MD_TRIGGERS(TABLE_OR_VIEW_ID_FK, TRIGGER_ON_FLAG, TRIGGER_NAME, TRIGGER_TIMING, TRIGGER_OPERATION, NATIVE_SQL, LANGUAGE)
  	  VALUES(v_tableId, 'T', v_trgName, 'BEFORE', 'INSERT OR UPDATE', EMPTY_CLOB(), C_LANGUAGEID_ORACLE)
  	  RETURNING ID INTO v_retId;
  	INSERT INTO MD_ADDITIONAL_PROPERTIES ( CONNECTION_ID_FK, REF_ID_FK, REF_TYPE, PROP_KEY, VALUE )
       VALUES (p_connectionid, v_retId, C_OBJECTTYPE_TRIGGERS, C_PROPKEY_TRIGGER_REWRITE, '');
    INSERT INTO MD_ADDITIONAL_PROPERTIES ( CONNECTION_ID_FK, REF_ID_FK, REF_TYPE, PROP_KEY, VALUE )
       VALUES (p_connectionid, v_retId, C_OBJECTTYPE_TRIGGERS, C_PROPKEY_SEQUENCEID, TO_CHAR(v_retSeqId));	
  	INSERT INTO MD_DERIVATIVES(SRC_ID, SRC_TYPE, DERIVED_ID, DERIVED_TYPE, DERIVED_CONNECTION_ID_FK, TRANSFORMED, ORIGINAL_IDENTIFIER, NEW_IDENTIFIER, DERIVED_OBJECT_NAMESPACE)
  	  VALUES(v_columnId, C_OBJECTTYPE_COLUMNS, v_retId, C_OBJECTTYPE_TRIGGERS, p_connectionId, C_TRANSFORMED_TRUE, NULL, v_trgName, C_NS_SCHEMA_OBJS || TO_CHAR(v_schemaId));
        SELECT NATIVE_SQL INTO v_lob FROM MD_TRIGGERS WHERE ID = v_retId;          
        DBMS_LOB.OPEN(v_lob, DBMS_LOB.LOB_READWRITE);
        DBMS_LOB.WRITE(v_lob, LENGTH(v_triggerText), 1, v_triggerText);
        DBMS_LOB.CLOSE(v_lob);
  END LOOP;
  COMMIT;
  CLOSE v_curs;
  RETURN 0;
END transform_identity_columns;




FUNCTION transform_rewrite_trigger(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  CURSOR v_curs is SELECT ID, TABLE_OR_VIEW_ID_FK, TRIGGER_ON_FLAG, TRIGGER_NAME,
    TRIGGER_TIMING, TRIGGER_OPERATION, TRIGGER_EVENT, NATIVE_SQL, NATIVE_KEY,
    LANGUAGE, COMMENTS from MD_TRIGGERS where ID in
    (SELECT REF_ID_FK from MD_ADDITIONAL_PROPERTIES
    WHERE CONNECTION_ID_FK = p_connectionid and PROP_KEY = C_PROPKEY_TRIGGER_REWRITE);
  CURSOR v_projectNameCurs 
  	IS
  	SELECT project_name FROM mgv_all_connections WHERE connection_id = p_connectionid;
  
  v_rowTriggers MD_TRIGGERS%ROWTYPE;
  v_tableName MD_TABLES.TABLE_NAME%TYPE;
	v_columnName MD_COLUMNS.COLUMN_NAME%TYPE;
	v_retId MD_SEQUENCES.ID%TYPE;
  v_retSeqId MD_SEQUENCES.ID%TYPE;
	v_seqName MD_SEQUENCES.NAME%TYPE;
  v_seqName2 MD_SEQUENCES.NAME%TYPE;
	v_triggerText VARCHAR2(4000);
  v_lob CLOB;
  v_projectName VARCHAR2(100);
  v_emulationPkgNamePrefix VARCHAR2(100) := '';
BEGIN
  -- Auxillary, get the emulation package name
  OPEN v_projectNameCurs;
  FETCH v_projectNameCurs INTO v_projectName;
  CLOSE v_projectNameCurs;
  
  IF INSTR(LOWER(v_projectName), 'sql server') <> 0 THEN
  	v_emulationPkgNamePrefix := 'sqlserver_utilities.';
  ELSIF INSTR(LOWER(v_projectName), 'sqlserver') <> 0 THEN
  	v_emulationPkgNamePrefix := 'sqlserver_utilities.';
  ELSIF INSTR(LOWER(v_projectName), 'access') <> 0 THEN
    v_emulationPkgNamePrefix := 'msaccess_utilities.';
  ELSIF INSTR(LOWER(v_projectName), 'sybase') <> 0 THEN
    v_emulationPkgNamePrefix := 'sybase_utilities.';
  ELSIF INSTR(LOWER(v_projectName), 'ase') <> 0 THEN
    v_emulationPkgNamePrefix := 'sybase_utilities.';  
  ELSIF INSTR(LOWER(v_projectName), 'mysql') <> 0 THEN
    v_emulationPkgNamePrefix := 'mysql_utilities.';
  END IF;
  
  open v_curs;
  loop
    fetch v_curs into v_rowTriggers.ID, v_rowTriggers.TABLE_OR_VIEW_ID_FK, v_rowTriggers.TRIGGER_ON_FLAG, v_rowTriggers.TRIGGER_NAME,
    v_rowTriggers.TRIGGER_TIMING, v_rowTriggers.TRIGGER_OPERATION, v_rowTriggers.TRIGGER_EVENT, v_rowTriggers.NATIVE_SQL, v_rowTriggers.NATIVE_KEY,
    v_rowTriggers.LANGUAGE, v_rowTriggers.COMMENTS ;
    EXIT WHEN v_curs%NOTFOUND;
    update MD_TRIGGERS set native_sql = empty_clob() where id = v_rowTriggers.ID;

    -- get table and column name from the derivative of this trigger
    select T.TABLE_NAME, C.COLUMN_NAME into v_tableName, v_columnName from MD_TABLES T,
      MD_COLUMNS C where C.TABLE_ID_FK = T.ID and C.ID =
      (select SRC_ID from MD_DERIVATIVES where DERIVED_ID =  v_rowTriggers.ID and SRC_TYPE =
      C_OBJECTTYPE_COLUMNS and DERIVED_CONNECTION_ID_FK = p_connectionid);
    -- get sequence name from id got from additional property
    select s.NAME into v_seqName from MD_SEQUENCES s where s.ID =
      (select TO_NUMBER(VALUE) from MD_ADDITIONAL_PROPERTIES where CONNECTION_ID_FK = p_connectionid
      AND REF_ID_FK = v_rowTriggers.ID and PROP_KEY = C_PROPKEY_SEQUENCEID);
      v_triggerText := GET_IDENTITY_TRIGGER(v_rowTriggers.TRIGGER_NAME, v_tableName , v_ColumnName ,v_seqName ,v_emulationPkgNamePrefix);
    SELECT NATIVE_SQL INTO v_lob FROM MD_TRIGGERS WHERE ID = v_rowTriggers.ID;          
    DBMS_LOB.OPEN(v_lob, DBMS_LOB.LOB_READWRITE);
    DBMS_LOB.WRITE(v_lob, LENGTH(v_triggerText), 1, v_triggerText);
    DBMS_LOB.CLOSE(v_lob);
  END LOOP;
  COMMIT;
  CLOSE v_curs;
  return 0;
END transform_rewrite_trigger;

FUNCTION gatherConnectionStats(p_connectionId MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
	v_numCatalogs INTEGER := 0;
	v_numColumns INTEGER := 0;
	v_numConstraints INTEGER := 0;
	v_numGroups INTEGER := 0;
	v_numRoles INTEGER := 0;
	v_numIndexes INTEGER := 0;
	v_numOtherObjects INTEGER := 0;
	v_numPackages INTEGER := 0;
	v_numPrivileges INTEGER := 0;
	v_numSchemas INTEGER := 0;
	v_numSequences INTEGER := 0;
	v_numStoredPrograms INTEGER := 0;
	v_numSynonyms INTEGER := 0;
	v_numTables INTEGER := 0;
	v_numTableSpaces INTEGER := 0;
	v_numTriggers INTEGER := 0;
	v_numUserDefinedDataTypes INTEGER := 0;
	v_numUsers INTEGER := 0;
	v_numViews INTEGER := 0;
BEGIN
	SELECT COUNT(*) INTO v_numCatalogs FROM MD_CATALOGS  WHERE CONNECTION_ID_FK = p_connectionId;
	SELECT COUNT(*) INTO v_numColumns FROM MD_COLUMNS WHERE TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numConstraints FROM MD_CONSTRAINTS WHERE  TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numGroups FROM MD_GROUPS WHERE GROUP_FLAG = 'G' AND SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId); 
	SELECT COUNT(*) INTO v_numRoles FROM MD_GROUPS WHERE GROUP_FLAG = 'R' AND SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numIndexes FROM MD_INDEXES  WHERE TABLE_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numOtherObjects FROM MD_OTHER_OBJECTS WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numPackages FROM MD_PACKAGES WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);  
	SELECT COUNT(*) INTO v_numPrivileges FROM MD_PRIVILEGES WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numSchemas FROM MD_SCHEMAS WHERE CATALOG_ID_FK IN (SELECT CATALOG_ID FROM MGV_ALL_CATALOGS WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numSequences FROM MD_SEQUENCES WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numStoredPrograms FROM MD_STORED_PROGRAMS WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numSynonyms FROM MD_SYNONYMS WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numTables FROM MD_TABLES WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numTableSpaces FROM MD_TABLESPACES WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numTriggers FROM MD_TRIGGERS WHERE TABLE_OR_VIEW_ID_FK IN (SELECT TABLE_ID FROM MGV_ALL_TABLES WHERE CONNECTION_ID = p_connectionId
                                                                                          UNION SELECT VIEW_ID FROM MGV_ALL_VIEWS WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numUserDefinedDataTypes FROM MD_USER_DEFINED_DATA_TYPES WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numUsers FROM MD_USERS WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
	SELECT COUNT(*) INTO v_numViews FROM MD_VIEWS WHERE SCHEMA_ID_FK IN (SELECT SCHEMA_ID FROM MGV_ALL_SCHEMA WHERE CONNECTION_ID = p_connectionId);
  	UPDATE MD_CONNECTIONS SET  
		NUM_CATALOGS = v_numCatalogs,
		NUM_COLUMNS = v_numColumns,
		NUM_CONSTRAINTS = v_numConstraints,
		NUM_GROUPS = v_numGroups,
		NUM_ROLES = v_numRoles,
		NUM_INDEXES = v_numIndexes,
		NUM_OTHER_OBJECTS = v_numOtherObjects,
		NUM_PACKAGES = v_numPackages,
		NUM_PRIVILEGES = v_numPrivileges,
		NUM_SCHEMAS = v_numSchemas,
		NUM_SEQUENCES = v_numSequences,
		NUM_STORED_PROGRAMS = v_numStoredPrograms,
		NUM_SYNONYMS = v_numSynonyms,
		NUM_TABLES = v_numTables,
		NUM_TABLESPACES = v_numTableSpaces,
		NUM_TRIGGERS = v_numTriggers,
		NUM_USER_DEFINED_DATA_TYPES = v_numUserDefinedDataTypes,
		NUM_USERS = v_numUsers,
        	NUM_VIEWS = v_numViews
	WHERE ID = p_connectionId;
	COMMIT;
	RETURN 0;
END gatherConnectionStats;

-- One time initialisation
begin
NULL;
end;
/

prompt
prompt Creating package body MIGRATION_REPORT
prompt ======================================
prompt
CREATE OR REPLACE PACKAGE BODY KEFU5."MIGRATION_REPORT" AS
--Function getCaptureStatus
FUNCTION getCaptureStatus(srcid IN NUMBER)  RETURN VARCHAR2 IS
status VARCHAR(20) default ' ';
BEGIN
  select decode((select count(*) from migrlog where ref_object_id=srcid and severity>800),0,'Passed','Failed') into status from dual;
  return status;
END getCaptureStatus;
--Function getConvertStatus
FUNCTION getConvertStatus(srcid IN NUMBER,convert_conn_id IN NUMBER)  RETURN VARCHAR2 IS
status VARCHAR(20) default ' ';
ifconvert NUMBER default 0;
BEGIN
  SELECT count(*) into ifconvert FROM md_derivatives WHERE src_id=srcid and derived_connection_id_fk=convert_conn_id;
  IF ifconvert=0 THEN
      RETURN 'NotConverted';
  ELSIF getCaptureStatus(srcid)='Failed' THEN
     RETURN 'Failed';
  ELSE
   BEGIN
    SELECT 
   decode((SELECT DISTINCT severity from migrlog 
                  WHERE  ref_object_id IN (SELECT derived_id FROM md_derivatives WHERE src_id=srcid and derived_connection_id_fk= convert_conn_id) 
                         and severity=1000
           UNION
           SELECT DISTINCT severity from migrlog 
                  WHERE ref_object_id IN (SELECT derived_id FROM md_derivatives where src_id=srcid and derived_connection_id_fk=convert_conn_id)
                  AND severity=900 
                  AND logtext like '%limitation%'),
                  null,'Passed',1000,'Failed',900,'Limitation',' ') 
  into status from dual;
  return status;
  END;
  END IF;
END getConvertStatus;
--Function getGenerateStatus
FUNCTION getGenerateStatus(srcid IN number,convert_conn_id IN NUMBER)  RETURN VARCHAR2 IS
status VARCHAR(20) default ' ';

BEGIN
   status:=getConvertStatus(srcid,convert_conn_id);   
   IF status='NotConverted' THEN
      RETURN 'NotGenerated';
   ELSIF  status='Failed'  THEN
      RETURN 'Failed';      
   ELSE
     BEGIN
        SELECT 
           decode((SELECT count(*) FROM migrlog 
                   WHERE ref_object_id IN (SELECT derived_id FROM md_derivatives WHERE src_id=srcid and derived_connection_id_fk=convert_conn_id) 
                         AND phase='Generate'
                         AND severity>800),
                    0,'Passed','Failed')
             INTO status FROM dual;
        RETURN status;
    END;
   END IF;
END getGenerateStatus;
--migration details for each objects
FUNCTION getDetails(capture_conn_id IN NUMBER,convert_conn_id IN NUMBER) RETURN migr_report_detail_table PIPELINED IS
BEGIN
FOR cur IN (
    select allobjs.ObjID captured_id,
           allobjs.ObjName captured_name,
           md.new_identifier converted_name,
           allobjs.ObjType captured_type,
           decode(md.derived_type,'MD_INDEXES', substr(md.derived_type,4, length(md.derived_type)-5),substr(md.derived_type,4, length(md.derived_type)-4)) converted_type,
           allobjs.CaptureStatus capture_status,
           allobjs.ConvertStatus convert_status,
           allobjs.GenerateStatus generate_status,
           decode(mlog.logtext,null,' ',mlog.logtext) logtext from (
 --schema
     SELECT md_schemas.id ObjID,md_schemas.name ObjName,'SCHEMA' ObjType,
          MIGRATION_REPORT.getCaptureStatus(md_schemas.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_schemas.id,convert_conn_id) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_schemas.id,convert_conn_id) GenerateStatus
       FROM md_schemas,md_catalogs
       WHERE md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=capture_conn_id
--table
UNION ALL
      SELECT md_tables.id ObjID,md_tables.table_name ObjName,'TABLE' ObjType,
          MIGRATION_REPORT.getCaptureStatus(md_tables.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_tables.id,convert_conn_id) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_tables.id,convert_conn_id) GenerateStatus
       FROM md_tables,md_schemas,md_catalogs
       WHERE md_tables.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=capture_conn_id
--view
UNION ALL
      SELECT md_views.id ObjID,md_views.view_name ObjName,'View' ObjType,
          MIGRATION_REPORT.getCaptureStatus(md_views.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_views.id,convert_conn_id) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_views.id,convert_conn_id) GenerateStatus
       FROM md_views,md_schemas,md_catalogs
       WHERE md_views.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=capture_conn_id
--storedprogram
UNION ALL
      SELECT md_stored_programs.id ObjID,md_stored_programs.name ObjName,'STORED_PROGRAM' ObjType,
          MIGRATION_REPORT.getCaptureStatus(md_stored_programs.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_stored_programs.id,convert_conn_id) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_stored_programs.id,convert_conn_id) GenerateStatus
       FROM md_stored_programs,md_schemas,md_catalogs
       WHERE md_stored_programs.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=capture_conn_id
--index
UNION ALL
      SELECT md_indexes.id ObjID,md_indexes.index_name ObjName,'INDEX' ObjType,
          MIGRATION_REPORT.getCaptureStatus(md_indexes.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_indexes.id,convert_conn_id) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_indexes.id,convert_conn_id) GenerateStatus
       FROM md_indexes, md_tables,md_schemas,md_catalogs
       WHERE md_indexes.table_id_fk= md_tables.id
            AND md_tables.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=capture_conn_id
UNION ALL
      SELECT md_constraints.id ObjID,md_constraints.name ObjName,'CONSTRAINT' ObjType,
          MIGRATION_REPORT.getCaptureStatus(md_constraints.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_constraints.id,convert_conn_id) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_constraints.id,convert_conn_id) GenerateStatus
       FROM md_constraints, md_tables,md_schemas,md_catalogs
       WHERE md_constraints.table_id_fk= md_tables.id
            AND md_tables.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=capture_conn_id  
UNION ALL
      SELECT md_triggers.id ObjID,md_triggers.trigger_name ObjName,'TRIGGER' ObjType,
          MIGRATION_REPORT.getCaptureStatus(md_triggers.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_triggers.id,convert_conn_id) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_triggers.id,convert_conn_id) GenerateStatus
       FROM md_triggers, md_tables,md_schemas,md_catalogs
       WHERE md_triggers.table_or_view_id_fk=md_tables.id
            AND md_tables.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=capture_conn_id 
UNION ALL
       SELECT md_triggers.id ObjID,md_triggers.trigger_name ObjName,'TRIGGER' ObjType,
          MIGRATION_REPORT.getCaptureStatus(md_triggers.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_triggers.id,convert_conn_id) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_triggers.id,convert_conn_id) GenerateStatus
       FROM md_triggers, md_views,md_schemas,md_catalogs
       WHERE md_triggers.table_or_view_id_fk=md_views.id
            AND md_views.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=capture_conn_id
  ) allobjs left join (select md_derivatives.src_id,migrlog.logtext 
                        from migrlog,md_derivatives 
                        where migrlog.ref_object_id = md_derivatives.derived_id or migrlog.ref_object_id=md_derivatives.src_id) mlog 
                                on allobjs.objid=mlog.src_id  left join md_derivatives md on allobjs.objid=md.src_id
    ) 
  LOOP
     PIPE ROW(MIGR_REPORT_DETAIL_ROW(cur.captured_id,
                              cur.captured_name,
                              cur.converted_name,
                              cur.captured_type,
                              cur.converted_type,
                              cur.capture_status,
                              cur.convert_status,
                              cur.generate_status,
                              cur.logtext
                              ));       
    
  END LOOP;  
  RETURN;
 END getDetails; 

--migration summary
FUNCTION getSum(capture_conn_id IN NUMBER,convert_conn_id IN NUMBER) RETURN migr_report_sum_table PIPELINED IS
--
capture_passed_schema number default 0;
capture_passed_table number default 0;
capture_passed_view number default 0;
capture_passed_sp number default 0;
capture_passed_index number default 0;
capture_passed_constraint number default 0;
capture_passed_trigger number default 0;
--
capture_failed_schema number default 0;
capture_failed_table number default 0;
capture_failed_view number default 0;
capture_failed_sp number default 0;
capture_failed_index number default 0;
capture_failed_constraint number default 0;
capture_failed_trigger number default 0;
--
convert_passed_schema number default 0;
convert_passed_table number default 0;
convert_passed_view number default 0;
convert_passed_sp number default 0;
convert_passed_index number default 0;
convert_passed_constraint number default 0;
convert_passed_trigger number default 0;
--
convert_limit_schema number default 0;
convert_limit_table number default 0;
convert_limit_view number default 0;
convert_limit_sp number default 0;
convert_limit_index number default 0;
convert_limit_constraint number default 0;
convert_limit_trigger number default 0;
--
convert_failed_schema number default 0;
convert_failed_table number default 0;
convert_failed_view number default 0;
convert_failed_sp number default 0;
convert_failed_index number default 0;
convert_failed_constraint number default 0;
convert_failed_trigger number default 0;
--
convert_not_schema number default 0;
convert_not_table number default 0;
convert_not_view number default 0;
convert_not_sp number default 0;
convert_not_index number default 0;
convert_not_constraint number default 0;
convert_not_trigger number default 0;
--
generate_passed_schema number default 0;
generate_passed_table number default 0;
generate_passed_view number default 0;
generate_passed_sp number default 0;
generate_passed_index number default 0;
generate_passed_constraint number default 0;
generate_passed_trigger number default 0;
--
generate_failed_schema number default 0;
generate_failed_table number default 0;
generate_failed_view number default 0;
generate_failed_sp number default 0;
generate_failed_index number default 0;
generate_failed_constraint number default 0;
generate_failed_trigger number default 0;
--
generate_not_schema number default 0;
generate_not_table number default 0;
generate_not_view number default 0;
generate_not_sp number default 0;
generate_not_index number default 0;
generate_not_constraint number default 0;
generate_not_trigger number default 0;
--CURSORS
--SCHEMAS CURSOR
CURSOR schema_status(cid IN NUMBER,did IN NUMBER) IS
      SELECT 
          MIGRATION_REPORT.getCaptureStatus(md_schemas.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_schemas.id,did) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_schemas.id,did) GenerateStatus
       FROM md_schemas,md_catalogs
       WHERE md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=cid;
--TABLES CURSOR
CURSOR table_status(cid IN NUMBER,did IN NUMBER) IS
      SELECT 
          MIGRATION_REPORT.getCaptureStatus(md_tables.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_tables.id,did) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_tables.id,did) GenerateStatus
       FROM md_tables,md_schemas,md_catalogs
       WHERE md_tables.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=cid;
--VIEWS CURSOR
CURSOR view_status(cid IN NUMBER,did IN NUMBER) IS
      SELECT 
          MIGRATION_REPORT.getCaptureStatus(md_views.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_views.id,did) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_views.id,did) GenerateStatus
       FROM md_views,md_schemas,md_catalogs
       WHERE md_views.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=cid;
--STORED_PROGRAMS CURSOR
CURSOR sp_status(cid IN NUMBER,did IN NUMBER) IS
      SELECT 
          MIGRATION_REPORT.getCaptureStatus(md_stored_programs.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_stored_programs.id,did) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_stored_programs.id,did) GenerateStatus
       FROM md_stored_programs,md_schemas,md_catalogs
       WHERE md_stored_programs.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=cid;
--INDEXES CURSOR
CURSOR index_status(cid IN NUMBER,did IN NUMBER) IS
      SELECT 
          MIGRATION_REPORT.getCaptureStatus(md_indexes.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_indexes.id,did) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_indexes.id,did) GenerateStatus
       FROM md_indexes, md_tables,md_schemas,md_catalogs
       WHERE md_indexes.table_id_fk= md_tables.id
            AND md_tables.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=cid;
--CONSTRAINTS CURSOR
CURSOR constraint_status(cid IN NUMBER,did IN NUMBER) IS
      SELECT 
          MIGRATION_REPORT.getCaptureStatus(md_constraints.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_constraints.id,did) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_constraints.id,did) GenerateStatus
       FROM md_constraints, md_tables,md_schemas,md_catalogs
       WHERE md_constraints.table_id_fk= md_tables.id
            AND md_tables.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=cid;  
--TRIGGERS CURSOR
CURSOR trigger_status(cid IN NUMBER,did IN NUMBER) IS
      SELECT 
          MIGRATION_REPORT.getCaptureStatus(md_triggers.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_triggers.id,did) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_triggers.id,did) GenerateStatus
       FROM md_triggers, md_tables,md_schemas,md_catalogs
       WHERE md_triggers.table_or_view_id_fk=md_tables.id
            AND md_tables.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=cid 
       UNION ALL
       SELECT 
          MIGRATION_REPORT.getCaptureStatus(md_triggers.id) CaptureStatus,
          MIGRATION_REPORT.getConvertStatus(md_triggers.id,did) ConvertStatus,
          MIGRATION_REPORT.getGenerateStatus(md_triggers.id,did) GenerateStatus
       FROM md_triggers, md_views,md_schemas,md_catalogs
       WHERE md_triggers.table_or_view_id_fk=md_views.id
            AND md_views.schema_id_fk=md_schemas.id
            AND md_schemas.catalog_id_fk= md_catalogs.id
            AND md_catalogs.connection_id_fk=cid;
BEGIN
 --count
 --schemas
 FOR cur IN schema_status(capture_conn_id,convert_conn_id)
 LOOP
                IF cur.capturestatus='Failed' 
                 THEN capture_failed_schema:=capture_failed_schema+1;
                ELSE capture_passed_schema:=capture_passed_schema+1;
                END IF;
                
                 IF cur.convertstatus='Failed' 
                    THEN convert_failed_schema:=convert_failed_schema+1;
                 ELSIF cur.convertstatus='Limitation' 
                    THEN convert_limit_schema:=convert_limit_schema+1;
                 ELSIF cur.convertstatus='Passed'
                    THEN  convert_passed_schema:=convert_passed_schema+1;
                 ELSE   convert_not_schema:=convert_not_schema+1;
                 END IF;
                
                IF cur.generatestatus='Failed' 
                 THEN generate_failed_schema:=generate_failed_schema+1;
                ELSIF cur.generatestatus='Passed' 
                 THEN generate_passed_schema:=generate_passed_schema+1;
                ELSE  generate_not_schema:=generate_not_schema+1;
                END IF;            
 END LOOP;
 --tables
 FOR cur IN table_status(capture_conn_id,convert_conn_id)
 LOOP
                IF cur.capturestatus='Failed' 
                 THEN capture_failed_table:=capture_failed_table+1;
                ELSE capture_passed_table:=capture_passed_table+1;
                END IF;
                
                 IF cur.convertstatus='Failed' 
                    THEN convert_failed_table:=convert_failed_table+1;
                 ELSIF cur.convertstatus='Limitation' 
                    THEN convert_limit_table:=convert_limit_table+1;
                 ELSIF cur.convertstatus='Passed'
                    THEN  convert_passed_table:=convert_passed_table+1;
                 ELSE   convert_not_table:=convert_not_table+1;
                 END IF;
                
                IF cur.generatestatus='Failed' 
                 THEN generate_failed_table:=generate_failed_table+1;
                ELSIF cur.generatestatus='Passed' 
                 THEN generate_passed_table:=generate_passed_table+1;
                ELSE  generate_not_table:=generate_not_table+1;
                END IF;            
 END LOOP;
 --views
 FOR cur IN view_status(capture_conn_id,convert_conn_id)
 LOOP
                IF cur.capturestatus='Failed' 
                 THEN capture_failed_view:=capture_failed_view+1;
                ELSE capture_passed_view:=capture_passed_view+1;
                END IF;
                
                 IF cur.convertstatus='Failed' 
                    THEN convert_failed_view:=convert_failed_view+1;
                 ELSIF cur.convertstatus='Limitation' 
                    THEN convert_limit_view:=convert_limit_view+1;
                 ELSIF cur.convertstatus='Passed'
                    THEN  convert_passed_view:=convert_passed_view+1;
                 ELSE   convert_not_view:=convert_not_view+1;
                 END IF;
                
                IF cur.generatestatus='Failed' 
                 THEN generate_failed_view:=generate_failed_view+1;
                ELSIF cur.generatestatus='Passed' 
                 THEN generate_passed_view:=generate_passed_view+1;
                ELSE  generate_not_view:=generate_not_view+1;
                END IF;            
 END LOOP;
 --stored programs
 FOR cur IN sp_status(capture_conn_id,convert_conn_id)
 LOOP
                IF cur.capturestatus='Failed' 
                 THEN capture_failed_sp:=capture_failed_sp+1;
                ELSE capture_passed_sp:=capture_passed_sp+1;
                END IF;
                
                 IF cur.convertstatus='Failed' 
                    THEN convert_failed_sp:=convert_failed_sp+1;
                 ELSIF cur.convertstatus='Limitation' 
                    THEN convert_limit_sp:=convert_limit_sp+1;
                 ELSIF cur.convertstatus='Passed'
                    THEN  convert_passed_sp:=convert_passed_sp+1;
                 ELSE   convert_not_sp:=convert_not_sp+1;
                 END IF;
                
                IF cur.generatestatus='Failed' 
                 THEN generate_failed_sp:=generate_failed_sp+1;
                ELSIF cur.generatestatus='Passed' 
                 THEN generate_passed_sp:=generate_passed_sp+1;
                ELSE  generate_not_sp:=generate_not_sp+1;
                END IF;            
 END LOOP;
 --index
 FOR cur IN index_status(capture_conn_id,convert_conn_id)
 LOOP
                IF cur.capturestatus='Failed' 
                 THEN capture_failed_index:=capture_failed_index+1;
                ELSE capture_passed_index:=capture_passed_index+1;
                END IF;
                
                 IF cur.convertstatus='Failed' 
                    THEN convert_failed_index:=convert_failed_index+1;
                 ELSIF cur.convertstatus='Limitation' 
                    THEN convert_limit_index:=convert_limit_index+1;
                 ELSIF cur.convertstatus='Passed'
                    THEN  convert_passed_index:=convert_passed_index+1;
                 ELSE   convert_not_index:=convert_not_index+1;
                 END IF;
                
                IF cur.generatestatus='Failed' 
                 THEN generate_failed_index:=generate_failed_index+1;
                ELSIF cur.generatestatus='Passed' 
                 THEN generate_passed_index:=generate_passed_index+1;
                ELSE  generate_not_index:=generate_not_index+1;
                END IF;            
 END LOOP;
 --constraints
 FOR cur IN constraint_status(capture_conn_id,convert_conn_id)
 LOOP
                IF cur.capturestatus='Failed' 
                 THEN capture_failed_constraint:=capture_failed_constraint+1;
                ELSE capture_passed_constraint:=capture_passed_constraint+1;
                END IF;
                
                 IF cur.convertstatus='Failed' 
                    THEN convert_failed_constraint:=convert_failed_constraint+1;
                 ELSIF cur.convertstatus='Limitation' 
                    THEN convert_limit_constraint:=convert_limit_constraint+1;
                 ELSIF cur.convertstatus='Passed'
                    THEN  convert_passed_constraint:=convert_passed_constraint+1;
                 ELSE   convert_not_constraint:=convert_not_constraint+1;
                 END IF;
                
                IF cur.generatestatus='Failed' 
                 THEN generate_failed_constraint:=generate_failed_constraint+1;
                ELSIF cur.generatestatus='Passed' 
                 THEN generate_passed_constraint:=generate_passed_constraint+1;
                ELSE  generate_not_constraint:=generate_not_constraint+1;
                END IF;            
 END LOOP;
 --triggers
 FOR cur IN trigger_status(capture_conn_id,convert_conn_id)
 LOOP
                IF cur.capturestatus='Failed' 
                 THEN capture_failed_trigger:=capture_failed_trigger+1;
                ELSE capture_passed_trigger:=capture_passed_trigger+1;
                END IF;
                
                 IF cur.convertstatus='Failed' 
                    THEN convert_failed_trigger:=convert_failed_trigger+1;
                 ELSIF cur.convertstatus='Limitation' 
                    THEN convert_limit_trigger:=convert_limit_trigger+1;
                 ELSIF cur.convertstatus='Passed'
                    THEN  convert_passed_trigger:=convert_passed_trigger+1;
                 ELSE   convert_not_trigger:=convert_not_trigger+1;
                 END IF;
                
                IF cur.generatestatus='Failed' 
                 THEN generate_failed_trigger:=generate_failed_trigger+1;
                ELSIF cur.generatestatus='Passed' 
                 THEN generate_passed_trigger:=generate_passed_trigger+1;
                ELSE  generate_not_trigger:=generate_not_trigger+1;
                END IF;            
 END LOOP; 
 --source exists row
  FOR cur IN (  
      SELECT 
        'Source Exists' Label,
         num_schemas,
         num_tables,
         num_indexes,
         num_constraints,
         num_views,
         num_stored_programs,        
         num_triggers
         FROM  md_connections
         WHERE type IS NULL and id=capture_conn_id
 )
 LOOP
   PIPE ROW(MIGR_REPORT_SUM_ROW(
           cur.Label, 
           cur.num_schemas,
           cur.num_tables,
           cur.num_indexes,
           cur.num_constraints,
           cur.num_views,
           cur.num_triggers,
           cur.num_stored_programs
             ));
 END LOOP; 
   PIPE ROW(MIGR_REPORT_SUM_ROW(
           'Capture Passed', 
           capture_passed_schema,
           capture_passed_table,
           capture_passed_index,
           capture_passed_constraint,
           capture_passed_view,
           capture_passed_trigger,
           capture_passed_sp
             ));
  PIPE ROW(MIGR_REPORT_SUM_ROW(
           'Capture Failed', 
           capture_failed_schema,
           capture_failed_table,
           capture_failed_index,
           capture_failed_constraint,
           capture_failed_view,
           capture_failed_trigger,
           capture_failed_sp
             ));
             
  PIPE ROW(MIGR_REPORT_SUM_ROW(
           'Convert Passed', 
           convert_passed_schema,
           convert_passed_table,
           convert_passed_index,
           convert_passed_constraint,
           convert_passed_view,
           convert_passed_trigger,
           convert_passed_sp
             ));
  PIPE ROW(MIGR_REPORT_SUM_ROW(
           'Convert Limitation', 
           convert_limit_schema,
           convert_limit_table,
           convert_limit_index,
           convert_limit_constraint,
           convert_limit_view,
           convert_limit_trigger,
           convert_limit_sp
             ));
  PIPE ROW(MIGR_REPORT_SUM_ROW(
           'Convert Failed', 
           convert_failed_schema,
           convert_failed_table,
           convert_failed_index,
           convert_failed_constraint,
           convert_failed_view,
           convert_failed_trigger,
           convert_failed_sp
             ));
             
  PIPE ROW(MIGR_REPORT_SUM_ROW(
           'Generate Passed', 
           generate_passed_schema,
           generate_passed_table,
           generate_passed_index,
           generate_passed_constraint,
           generate_passed_view,
           generate_passed_trigger,
           generate_passed_sp
             ));
  PIPE ROW(MIGR_REPORT_SUM_ROW(
           'Generate Failed', 
           generate_failed_schema,
           generate_failed_table,
           generate_failed_index,
           generate_failed_constraint,
           generate_failed_view,
           generate_failed_trigger,
           generate_failed_sp
             )); 
  RETURN;
END getSum;
END MIGRATION_REPORT;
/

prompt
prompt Creating package body MIGRATION_TRANSFORMER
prompt ===========================================
prompt
CREATE OR REPLACE PACKAGE BODY KEFU5."MIGRATION_TRANSFORMER" AS
  -- Maximum length of an identifier
  MAX_IDENTIFIER_LEN NUMBER:=30;
C_DISALLOWED_CHARS   CONSTANT NVARCHAR2(100) := ' .@`!"%^&*()-+=[]{};:,.<>?/~'''||UNISTR('\00A3');

--PRIVATE FUNCTION
FUNCTION truncateStringByteSize(p_work VARCHAR2, p_bsize NUMBER) RETURN VARCHAR2
IS
v_work VARCHAR2(4000);
v_bsize NUMBER(10);
BEGIN
 IF LENGTHB(p_work) <= p_bsize THEN
    return p_work;
  END IF;
  v_work := p_work;
  v_work := SUBSTRB(v_work, 1, p_bsize);
  WHILE INSTRC(p_work, v_work , 1, 1) <> 1 LOOP -- a character has been cut in half or in 2/3 or 3/4 by substrb (multibyte can have up to 4 bytes) 
  --note each left over corrupt byte can be a single character
   BEGIN
     v_bsize := LENGTHB(v_work);
  	 v_work := SUBSTRB(v_work, 1, v_bsize-1);
   END;
  END LOOP; 
  return v_work;
END;

FUNCTION add_suffix(p_work VARCHAR2, p_suffix VARCHAR2, p_maxlen NUMBER) RETURN VARCHAR2
IS
  v_suflen NUMBER := LENGTHB(p_suffix);
  v_truncamount NUMBER;
BEGIN
  IF LENGTHB(p_work) < p_maxlen - v_suflen THEN
    RETURN p_work || p_suffix;
  END IF;
  v_truncamount := LENGTHB(p_work) + v_suflen - p_maxlen;
  RETURN truncateStringByteSize(p_work, LENGTHB(p_work)-v_truncamount) || p_suffix;
END add_suffix;
  

FUNCTION check_identifier_length(p_ident VARCHAR2) RETURN VARCHAR2
IS
  v_work VARCHAR2(4000);
BEGIN
  return truncateStringByteSize(p_ident,  MAX_IDENTIFIER_LEN);
END;

FUNCTION check_reserved_word(p_work VARCHAR2) RETURN VARCHAR2
IS
  v_count NUMBER := 0;
BEGIN
  SELECT COUNT(*) INTO v_count FROM MIGRATION_RESERVED_WORDS WHERE KEYWORD = UPPER(p_work);
  IF v_count > 0 THEN
    -- It is a reserved word
    RETURN add_suffix(p_work, '_', MAX_IDENTIFIER_LEN);
  END IF;
  RETURN p_work;
END check_reserved_word;

FUNCTION sys_check(p_work VARCHAR2) RETURN VARCHAR2
IS
BEGIN
  IF LENGTH(p_work) < 4 THEN
    return p_work;
  END IF;
  IF SUBSTR(p_work, 1, 4) <> 'SYS_' THEN
    return p_work;
  END IF;
  RETURN 'SIS_' || SUBSTR(p_work, 5);
END sys_check;

FUNCTION first_char_check(p_work NVARCHAR2) RETURN NVARCHAR2
/**
 * Never want to start with anything but AlphaNumeri
 */
IS
  v_firstChar NCHAR(1);
  v_allowed NCHAR(200);
BEGIN
  v_allowed := C_DISALLOWED_CHARS || '0123456789_$#';
  v_firstChar := SUBSTR(p_work,1,1);
  if INSTR(v_allowed, v_firstChar) > 0 THEN
    return 'A' ||p_work;
  END IF;
  return p_work;
END first_char_check;



FUNCTION lTrimNonAlphaNumeric(p_work NVARCHAR2) RETURN NVARCHAR2
/**
 *Remove all non alphanumeric characters from the start 
 */
IS
  v_testChar VARCHAR2(2000);
  v_index NUMBER;
  v_work NVARCHAR2(4000):=p_work;
  v_forbiddenChars VARCHAR2(100);
  v_firstgoodchar NUMBER;
BEGIN
  v_forbiddenChars := C_DISALLOWED_CHARS ||'_$#';
   FOR v_index in 1..LENGTH(v_work) LOOP
    v_testChar := SUBSTR(p_work, v_index, 1);
    IF INSTR(v_forbiddenChars, v_testChar) <= 0 THEN
      v_firstgoodchar := v_index;
      EXIT;--make sure to leave loop now as first real char reached
    END IF;
  END LOOP;
  return substr(p_work,v_firstgoodchar);
END lTrimNonAlphaNumeric;

FUNCTION removeQuotes(p_work NVARCHAR2) RETURN NVARCHAR2
/**
 * Removed Quotes around a identifier name
 */
IS
  v_firstChar NCHAR(1);
  v_lastChar NCHAR(1);
  v_quote NCHAR(200):= '"[]'; -- strip these from start and end;
  v_work NVARCHAR2(4000) := p_work;
BEGIN
  v_firstChar := SUBSTR(v_work,1,1);
  v_lastChar  := SUBSTR(v_work,LENGTH(v_work),1);
  if INSTR(v_quote, v_firstChar) > 0 THEN
  	v_work := SUBSTR(v_work, 2);
  	if INSTR(v_quote, v_lastChar) > 0 THEN
  	  v_work := SUBSTR(v_work,0,LENGTH(v_work)-1);
      return v_work;
    END IF;
      return v_work;
  END IF;
  return v_work;
END removeQuotes;


FUNCTION check_allowed_chars(p_work NVARCHAR2) RETURN NVARCHAR2
/* The documentation states 
 * "Nonquoted identifiers can contain only alphanumeric characters from your database character set and the
 *  underscore (_), dollar sign ($), and pound sign (#). Database links can also contain periods (.) and "at" signs (@).
 *  Oracle strongly discourages you from using $ and # in nonquoted identifiers."
 *  Heres a couple of gotchas
 *  1) We don't know where we will be generated to, so dunno what that database character set will be
 *  2) We've now way of knowing if a character is alphanumeric on the character set.
 * So... Here's what we'll do
 *  1) given that its come from a database, we'll assume with was alphanumeric
 *  2) We'll remove any "regular" symbol characters (i.e. one's on my keyboard!)
 *  3) We'll be storing in NVARCHAR2 in the hope that this will preserve everything.
 * 
 */
IS
  v_testChar VARCHAR2(2000);
  v_index NUMBER;
  -- Folowing syntax is a workaround for a problem with wrap.  Do not change it.
  v_forbiddenChars NVARCHAR2(100) := C_DISALLOWED_CHARS;
  v_work VARCHAR2(4000) := p_work;
  v_endswithunderscore boolean := FALSE;
BEGIN
  IF INSTR('_',SUBSTR(p_work, LENGTH(p_work))) >0 THEN
    v_endswithunderscore := TRUE;
  END IF;
  FOR v_index in 1..LENGTH(v_work) LOOP
    v_testChar := SUBSTR(p_work, v_index, 1);
    IF INSTR(v_forbiddenChars, v_testChar) > 0 THEN
      v_work := SUBSTR(v_work, 1, v_index-1) || '_' || SUBSTR(v_work, v_index+1);
    END IF;
  END LOOP;
  --NOW REMOVE DOUBLE UNDERSCORES see bug 6647397
  v_work := replace(replace (replace (v_work,'__','_'),'__','_'),'__','_');--replace 2 underscores with 1 underscore
  --REMOVE THE LT CHAR IF IT IS AN UNDERSCORE
  IF v_endswithunderscore=false AND INSTR('_',SUBSTR(v_Work,LENGTH(v_work))) > 0 THEN
    v_work := SUBSTR(v_work,0,LENGTH(v_work)-1);
  END IF;
  return v_work;
END check_allowed_chars;

FUNCTION transform_identifier(p_identifier NVARCHAR2)  RETURN NVARCHAR2
IS
  v_work VARCHAR2(4000);
BEGIN
  v_work := p_identifier;
  
  -- There are 10 rules defined for identifier naming:
  -- See http://st-doc.us.oracle.com/10/102/server.102/b14200/sql_elements008.htm#i27570
 
  v_work := removeQuotes(v_work);
  v_work := lTrimNonAlphaNumeric(v_work);
  --moving this to first as we can shrink the size of the name if they have more than 1 invalid char in a row.
  --see bug 6647397
   -- 5. Must begin withan alpha character from your character set
  v_work := first_char_check(v_work);
   -- 6. Alphanumeric characters from your database charset plus '_', '$', '#' only
  v_work := check_allowed_chars(v_work);
  -- 1. Length
  v_work := check_identifier_length(v_work);
  -- 2. Reserved words
  v_work := check_reserved_word(v_work);
  -- 3. "Special words" -I've handled these in reserved words, but still have to check if it starts with SYS
  v_work := sys_check(v_work);
  -- 4. "You should use ASCII characters in database names, global database names, and database link names,
  --    because ASCII characters provide optimal compatibility across different platforms and operating systems."
  -- This doesn't apply as we are not doing anything with DB names
  -- 7. Name collisions; we'll handle this at a higher level.
  -- 8. Nonquoted identifiers are case insensitive.  This is a doubl edged sword: If we use quoted, we can possible
  --    Keep it similar to the source platform.  However this is not how it is typically done in Oracle.
  -- 9. Columns in the same table.  See point 7. above.
  -- 10. All about overloading for functions and parameters.  We don't have to handle this here either, at this
  --     Should all be done by parsing technology.
  return v_work;
END transform_identifier;
FUNCTION fix_all_schema_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  v_ret NUMBER;
BEGIN
  v_ret := 0;
  -- First, we transform all identifiers to meet our rules
  -- Then, we need to see if we've caused any collisions in the process
  -- And if so, fix them
  -- Right now, this is a dummy stub.
  return v_ret;
END fix_all_schema_identifiers;

FUNCTION fix_all_identifiers(p_connectionid MD_CONNECTIONS.ID%TYPE) RETURN NUMBER
IS
  v_ret NUMBER;
BEGIN
  v_ret := fix_all_schema_identifiers(p_connectionid);
  return v_ret;
END fix_all_identifiers;  

END;
/

prompt
prompt Creating trigger DEL_MD_TRIGGERS_T_TRG
prompt ======================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."DEL_MD_TRIGGERS_T_TRG" AFTER DELETE ON MD_TABLES
FOR EACH ROW 
BEGIN
  DELETE FROM MD_TRIGGERS WHERE MD_TRIGGERS.TABLE_OR_VIEW_ID_FK = :OLD.ID AND MD_TRIGGERS.TRIGGER_ON_FLAG = 'T';
END;
/

prompt
prompt Creating trigger DEL_MD_TRIGGERS_V_TRG
prompt ======================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."DEL_MD_TRIGGERS_V_TRG" AFTER DELETE ON MD_VIEWS
FOR EACH ROW 
BEGIN
  DELETE FROM MD_TRIGGERS WHERE MD_TRIGGERS.TABLE_OR_VIEW_ID_FK = :OLD.ID AND MD_TRIGGERS.TRIGGER_ON_FLAG = 'V';
END;
/

prompt
prompt Creating trigger MD_ADDITIONAL_PROPERTY_TRG
prompt ===========================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_ADDITIONAL_PROPERTY_TRG" BEFORE INSERT OR UPDATE ON MD_ADDITIONAL_PROPERTIES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_CATALOGS_TRG
prompt ================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_CATALOGS_TRG" BEFORE INSERT OR UPDATE ON MD_CATALOGS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_COLUMNS_TRG
prompt ===============================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_COLUMNS_TRG" BEFORE INSERT OR UPDATE ON MD_COLUMNS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_CONNECTIONS_TRG
prompt ===================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_CONNECTIONS_TRG" BEFORE INSERT OR UPDATE ON MD_CONNECTIONS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_CONSTRAINTS_TRG
prompt ===================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_CONSTRAINTS_TRG" BEFORE INSERT OR UPDATE ON MD_CONSTRAINTS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_CONSTRAINT_DETAILS_TRG
prompt ==========================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_CONSTRAINT_DETAILS_TRG" BEFORE INSERT OR UPDATE ON MD_CONSTRAINT_DETAILS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_DERIVATIVES_TRG
prompt ===================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_DERIVATIVES_TRG" BEFORE INSERT OR UPDATE ON MD_DERIVATIVES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_GROUPS_TRG
prompt ==============================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_GROUPS_TRG" BEFORE INSERT OR UPDATE ON MD_GROUPS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_GROUP_MEMBERS_TRG
prompt =====================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_GROUP_MEMBERS_TRG" BEFORE INSERT OR UPDATE ON MD_GROUP_MEMBERS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_GROUP_PRIVILEGES_TRG
prompt ========================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_GROUP_PRIVILEGES_TRG" BEFORE INSERT OR UPDATE ON MD_GROUP_PRIVILEGES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_INDEXES_TRG
prompt ===============================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_INDEXES_TRG" BEFORE INSERT OR UPDATE ON MD_INDEXES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_INDEX_DETAILS_TRG
prompt =====================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_INDEX_DETAILS_TRG" BEFORE INSERT OR UPDATE ON MD_INDEX_DETAILS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_MIGR_DEPENDENCY_TRG
prompt =======================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_MIGR_DEPENDENCY_TRG" BEFORE INSERT OR UPDATE ON MD_MIGR_DEPENDENCY
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_MIGR_PARAMETER_TRG
prompt ======================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_MIGR_PARAMETER_TRG" BEFORE INSERT OR UPDATE ON MD_MIGR_PARAMETER
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_MIGR_WEAKDEP_TRG
prompt ====================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_MIGR_WEAKDEP_TRG" BEFORE INSERT OR UPDATE ON MD_MIGR_WEAKDEP
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_OTHER_OBJECTS_TRG
prompt =====================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_OTHER_OBJECTS_TRG" BEFORE INSERT OR UPDATE ON MD_OTHER_OBJECTS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_PACKAGES_TRG
prompt ================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_PACKAGES_TRG" BEFORE INSERT OR UPDATE ON MD_PACKAGES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_PRIVILEGES_TRG
prompt ==================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_PRIVILEGES_TRG" BEFORE INSERT OR UPDATE ON MD_PRIVILEGES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_PROJECTS_TRG
prompt ================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_PROJECTS_TRG" BEFORE INSERT OR UPDATE ON MD_PROJECTS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_SCHEMAS_TRG
prompt ===============================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_SCHEMAS_TRG" BEFORE INSERT OR UPDATE ON MD_SCHEMAS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_SEQUENCES_TRG
prompt =================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_SEQUENCES_TRG" BEFORE INSERT OR UPDATE ON MD_SEQUENCES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_STORED_PROGRAMS_TRG
prompt =======================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_STORED_PROGRAMS_TRG" BEFORE INSERT OR UPDATE ON MD_STORED_PROGRAMS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_SYNONYMS_TRG
prompt ================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_SYNONYMS_TRG" BEFORE INSERT OR UPDATE ON MD_SYNONYMS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_TABLESPACES_TRG
prompt ===================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_TABLESPACES_TRG" BEFORE INSERT OR UPDATE ON MD_TABLESPACES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_TABLES_TRG
prompt ==============================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_TABLES_TRG" BEFORE INSERT OR UPDATE ON MD_TABLES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_TRIGGERS_TRG
prompt ================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_TRIGGERS_TRG" BEFORE INSERT OR UPDATE ON MD_TRIGGERS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_USERS_TRG
prompt =============================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_USERS_TRG" BEFORE INSERT OR UPDATE ON MD_USERS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_USER_DEFINED_DATA_TYPES_TRG
prompt ===============================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_USER_DEFINED_DATA_TYPES_TRG" BEFORE INSERT OR UPDATE ON MD_USER_DEFINED_DATA_TYPES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_USER_PRIVILEGES_TRG
prompt =======================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_USER_PRIVILEGES_TRG" BEFORE INSERT OR UPDATE ON MD_USER_PRIVILEGES
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MD_VIEWS_TRG
prompt =============================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MD_VIEWS_TRG" BEFORE INSERT OR UPDATE ON MD_VIEWS
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MIGRLOG_TRG
prompt ============================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MIGRLOG_TRG" BEFORE INSERT OR UPDATE ON MIGRLOG
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MIGR_DATATYPE_MAP_TRG
prompt ======================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MIGR_DATATYPE_MAP_TRG" BEFORE INSERT OR UPDATE ON MIGR_DATATYPE_TRANSFORM_MAP
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MIGR_DATATYPE_RULE_TRG
prompt =======================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MIGR_DATATYPE_RULE_TRG" BEFORE INSERT OR UPDATE ON MIGR_DATATYPE_TRANSFORM_RULE
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger MIGR_GENERATION_ORDER_TRG
prompt ==========================================
prompt
CREATE OR REPLACE TRIGGER KEFU5."MIGR_GENERATION_ORDER_TRG" BEFORE INSERT OR UPDATE ON MIGR_GENERATION_ORDER
FOR EACH ROW
BEGIN
  if inserting and :new.id is null then
        :new.id := MD_META.get_next_id;
    end if;
END;
/

prompt
prompt Creating trigger UK_FS_EVENT_SOCKET_ID_TRG
prompt ==========================================
prompt
CREATE OR REPLACE TRIGGER KEFU5.uk_fs_event_socket_id_TRG BEFORE INSERT OR UPDATE ON uk_fs_event_socket
FOR EACH ROW
DECLARE 
v_newVal NUMBER(12) := 0;
v_incval NUMBER(12) := 0;
BEGIN
  IF INSERTING AND :new.id IS NULL THEN
    SELECT  uk_fs_event_socket_id_SEQ.NEXTVAL INTO v_newVal FROM DUAL;
    -- If this is the first time this table have been inserted into (sequence == 1)
    IF v_newVal = 1 THEN 
      --get the max indentity value from the table
      SELECT max(id) INTO v_newVal FROM uk_fs_event_socket;
      v_newVal := v_newVal + 1;
      --set the sequence to that value
      LOOP
           EXIT WHEN v_incval>=v_newVal;
           SELECT uk_fs_event_socket_id_SEQ.nextval INTO v_incval FROM dual;
      END LOOP;
    END IF;
    -- save this to emulate @@identity
   mysql_utilities.identity := v_newVal; 
   -- assign the value from the sequence to emulate the identity column
   :new.id := v_newVal;
  END IF;
END;
/

