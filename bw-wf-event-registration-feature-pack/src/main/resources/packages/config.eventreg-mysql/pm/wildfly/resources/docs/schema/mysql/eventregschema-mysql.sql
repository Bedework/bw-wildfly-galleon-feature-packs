create table bwevchg_chgs (
                              bwevchg_id bigint not null auto_increment,
                              bwevchg_seq integer not null,
                              bwevchg_regid bigint not null,
                              bwevchg_authid varchar(500) not null,
                              bwevchg_lastmod varchar(30),
                              bwevchg_type varchar(20),
                              bwevchg_name varchar(250),
                              bwevchg_value varchar(2000),
                              primary key (bwevchg_id)
) ENGINE=InnoDB;

create table bwevchg_regids (
                                bwevchg_id bigint not null auto_increment,
                                bwevchg_seq integer not null,
                                bwevchg_nxtregid bigint not null,
                                primary key (bwevchg_id)
) ENGINE=InnoDB;

create table bwevreg_regs (
                              bwevreg_id bigint not null auto_increment,
                              bwevreg_seq integer not null,
                              bwevreg_regid bigint not null,
                              bwevreg_authid varchar(500) not null,
                              bwevreg_href varchar(1000) not null,
                              bwevreg_tktreq integer,
                              bwevreg_type varchar(10),
                              bwevreg_created varchar(30),
                              bwevreg_lastmod varchar(30),
                              bwevreg_waitqdate varchar(30),
                              bwevreg_comment varchar(250),
                              bwevreg_message varchar(2000),
                              bwevreg_formName varchar(100),
                              bwevreg_formOwner varchar(500),
                              bwevreg_evsummary varchar(250),
                              bwevreg_evdate varchar(30),
                              bwevreg_evtime varchar(30),
                              bwevreg_evloc varchar(250),
                              bwevreg_notified varchar(30),
                              bwevreg_props longtext,
                              primary key (bwevreg_id)
) ENGINE=InnoDB;

create table bwevreg_tickets (
                                 bwregid bigint not null,
                                 bw_tktid bigint not null,
                                 primary key (bwregid, bw_tktid)
) ENGINE=InnoDB;

create table bwevreg_tkts (
                              bwevreg_id bigint not null auto_increment,
                              bwevreg_seq integer not null,
                              bwevreg_regid bigint not null,
                              bwevreg_authid varchar(500) not null,
                              bwevreg_href varchar(1000) not null,
                              bwevreg_uuid varchar(40) not null,
                              bwevreg_created varchar(30),
                              primary key (bwevreg_id)
) ENGINE=InnoDB;

create table bwfdef_fields (
                               bwdef_id bigint not null,
                               bw_fdid bigint not null,
                               primary key (bwdef_id, bw_fdid)
) ENGINE=InnoDB;

create table bwfdef_flds (
                             bwfdef_id bigint not null auto_increment,
                             bwfdef_seq integer not null,
                             bwfdef_formname varchar(255) not null,
                             bwfdef_owner varchar(500) not null,
                             bwfdef_name varchar(100) not null,
                             bwfdef_type varchar(20) not null,
                             bwfdef_label varchar(100),
                             bwfdef_value varchar(500),
                             bwfdef_desc varchar(1000),
                             bwfdef_group varchar(100),
                             bwfdef_req char(1),
                             bwfdef_order integer,
                             bwfdef_def char(1),
                             bwfdef_multi char(1),
                             bwfdef_props longtext,
                             bwfdef_width varchar(20),
                             bwfdef_height varchar(20),
                             primary key (bwfdef_id)
) ENGINE=InnoDB;

create table bwfdef_forms (
                              bwfdef_id bigint not null auto_increment,
                              bwfdef_seq integer not null,
                              bwfdef_formname varchar(100) not null,
                              bwfdef_owner varchar(500) not null,
                              bwfdef_created varchar(30),
                              bwfdef_lastmod varchar(30),
                              bwfdef_committed char(1),
                              bwfdef_disabled char(1),
                              bwfdef_comment varchar(250),
                              bwfdef_props longtext,
                              primary key (bwfdef_id)
) ENGINE=InnoDB;
create index bwevchgidx_regid on bwevchg_chgs (bwevchg_regid);
create index bwevchgidx_authid on bwevchg_chgs (bwevchg_authid);
create index bwevregidx_regid on bwevreg_regs (bwevreg_regid);
create index bwevregidx_authid on bwevreg_regs (bwevreg_authid);
create index bwevregidx_href on bwevreg_regs (bwevreg_href);

alter table bwevreg_regs
    add constraint UK_gmi85artoc0ioyx5s06o8tjbw unique (bwevreg_regid);

alter table bwevreg_tickets
    add constraint UK_ahm30oqqy3iji1eotrx7cc28n unique (bw_tktid);
create index bwevregidx_tktregid on bwevreg_tkts (bwevreg_regid);
create index bwevregidx_tktauthid on bwevreg_tkts (bwevreg_authid);
create index bwevregidx_tkthref on bwevreg_tkts (bwevreg_href);
create index bwevregidx_tktuuid on bwevreg_tkts (bwevreg_uuid);

alter table bwevreg_tkts
    add constraint UK_dcpc66qtkc6vj8bvd12lvo6bo unique (bwevreg_uuid);

alter table bwfdef_fields
    add constraint UK_qibsg5w5svogc8ob5by8m3r0r unique (bw_fdid);
create index bwfld_frmid on bwfdef_flds (bwfdef_formname);
create index bwfld_frmowner on bwfdef_flds (bwfdef_owner);
create index bwfld_frmname on bwfdef_flds (bwfdef_name);
create index bwfdefidx_frmid on bwfdef_forms (bwfdef_formname);
create index bwfdef_frmowner on bwfdef_forms (bwfdef_owner);

alter table bwevreg_tickets
    add constraint bwevreg_tkt_fk
        foreign key (bw_tktid)
            references bwevreg_tkts (bwevreg_id);

alter table bwevreg_tickets
    add constraint bw_regtkt_regid_fk
        foreign key (bwregid)
            references bwevreg_regs (bwevreg_id);

alter table bwfdef_fields
    add constraint bwfdef_fld_fk
        foreign key (bw_fdid)
            references bwfdef_flds (bwfdef_id);

alter table bwfdef_fields
    add constraint bwfdef_form_fk
        foreign key (bwdef_id)
            references bwfdef_forms (bwfdef_id);
