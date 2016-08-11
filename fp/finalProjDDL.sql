-- ******************************************************
-- finalProjDDL.sql
--
-- Loader for Final Project
--
-- Description:	This script contains the DDL to load
--              the tables of the INVENTORY database
--
--
-- Student:  Frank O'Connor
-- Email: fjo.con@gmail.com
--
-- Modified:   November, 2012
--
-- ******************************************************

-- ******************************************************
--    SPOOL SESSION
-- ******************************************************

spool foconnorSpoolFP.lst

-- ******************************************************
--    DROP TABLES
-- Note:  Issue the appropiate commands to drop tables
-- ******************************************************


DROP table tblogin PURGE;
DROP table tbsourcekeyassociation PURGE;
DROP table tbkeyword PURGE;
DROP table tbusage PURGE;
DROP table tbsource PURGE;
DROP table tbproject PURGE;
DROP table tbpublication PURGE;
DROP table tbemployee PURGE;

-- ******************************************************
--    DROP SEQUENCES
-- Note:  Issue the appropiate commands to drop sequences
-- ******************************************************

DROP sequence seqsrckey;
DROP sequence seqkeyword;
DROP sequence sequsage;
DROP sequence seqsource;
DROP sequence seqproj;
DROP sequence seqpub;
DROP sequence seqemp;

-- ******************************************************
--    CREATE TABLES
-- ******************************************************

CREATE table tbemployee (
        empid      		char(3)                 not null
			constraint rg_empid check (empid between '100' and '999')
			constraint pk_employee primary key,
        empfirstname    varchar2(40)            not null,
		emplastname    	varchar2(40)            not null,
		empemailemail   varchar2(50)            null,	
        empphone   		varchar2(20)            null
);


CREATE table tbpublication (
        pubid       	char(4)                 not null
			constraint rg_pubid check (pubid between '1000' and '4999')
			constraint pk_publication primary key,
        pubname     	varchar2(50)            not null,
        pubtype	     	varchar2(30)  	  		null
);

CREATE table tbproject (
        projid        	char(4)                 not null
			constraint rg_projid check (projid between '1000' and '4999')
			constraint pk_project primary key,
        projtitle      	varchar2(50)            not null,
        projtype   		varchar2(20)            null,
		estdays			number(3,0)  default 1	null
			constraint rg_estDays check (estdays > 0 and estdays < 400 ),
		projdate       	date    default sysdate     null,
        projowner      	char(3)            		null
			constraint rg_projowner check (projowner between '100' and '999')
			constraint fk_projowner_tbproject references tbemployee (empid) ON DELETE SET NULL
);


CREATE table tbsource (
        sourceid       	char(4)                 not null
			constraint rg_sourceid check (sourceid between '1000' and '9999')
			constraint pk_source primary key,
        sourcetitle     varchar2(50)            not null,
		sourcecontent   varchar2(250)           not null,
		sourceauthor    varchar2(40)            null,
		datepublished	date    default sysdate     null,
		enteredbyemp      	char(3)            	null
			constraint rg_enteredbyemp check (enteredbyemp between '100' and '999')
			constraint fk_enteredbyemp_tbsource references tbemployee (empid) ON DELETE SET NULL,
		sourcetopic     varchar2(20)            null,
		sourceurl     	varchar2(150)           not null,
        pubid     		char(4)            		null
			constraint rg_pubid_tbsource check (pubid between '1000' and '4999')
			constraint fk_pubid_tbsource references tbpublication (pubid) ON DELETE SET NULL
);


CREATE table tbusage (
        useid       	char(4)                 not null
			constraint rg_useid check (useid between '1000' and '9999')
			constraint pk_usage primary key,
		sourceid       	char(4)                 not null
			constraint rg_sourceid_tbusage check (sourceid between '1000' and '9999')
			constraint fk_sourceid_tbusage references tbsource (sourceid) ON DELETE CASCADE,
		projid        	char(4)                 not null
			constraint rg_projid_tbusage check (projid between '1000' and '4999')
			constraint fk_projid_tbusage references tbproject (projid) ON DELETE CASCADE,
		howused   varchar2(20)           		not null,
        dateused       	date    default sysdate     not null
);

-- Make many to many !!!!
CREATE table tbkeyword (
        keywordid       char(4)                 not null
			constraint rg_keywordid check (keywordid between '1000' and '9999')
			constraint pk_tbkeyword primary key,
        keyword       	varchar2(40)            not null
);

-- keyword association table
CREATE table tbsourcekeyassociation (
        keywordid       char(4)                 not null
			constraint rg_keywordid_tbsrckeyassoc check (keywordid between '1000' and '9999')
			constraint fk_keywordid_tbsrckeyassoc references tbkeyword (keywordid) ON DELETE CASCADE,
        sourceid       	char(4)                 not null
			constraint rg_sourceid_tbsrckeyassoc check (sourceid between '1000' and '9999')
			constraint fk_sourceid_tbsrckeyassoc references tbsource (sourceid) ON DELETE CASCADE,
			constraint pk_sourcekeyassociation primary key (keywordid, sourceid)
);


-- create security login table
CREATE table tblogin (
        uname varchar2(20) not null
			constraint pk_tblogin primary key,
		pwd varchar2(20) not null,
		fname varchar2(20) not null,
		userview varchar2(20) null
);

-- ******************************************************
--    CREATE SEQUENCES
-- ******************************************************

CREATE sequence seqemp
	MINVALUE 100
	MAXVALUE 999
	START WITH 100
	INCREMENT BY 1;
CREATE sequence seqpub
	MINVALUE 1000
	MAXVALUE 4999
	START WITH 1000
	INCREMENT BY 1;
CREATE sequence seqproj
	MINVALUE 1000
	MAXVALUE 4999
	START WITH 1000
	INCREMENT BY 1;
CREATE sequence seqsource
	MINVALUE 1000
	MAXVALUE 9999
	START WITH 1000
	INCREMENT BY 1;
CREATE sequence sequsage
	MINVALUE 1000
	MAXVALUE 9999
	START WITH 1000
	INCREMENT BY 1;
CREATE sequence seqkeyword
	MINVALUE 1000
	MAXVALUE 9999
	START WITH 1000
	INCREMENT BY 1;
CREATE sequence seqsrckey
	MINVALUE 1000
	MAXVALUE 9999
	START WITH 1000
	INCREMENT BY 1;
    
-- ******************************************************
--    POPULATE TABLES
--
-- Note:  Follow instructions and data provided on PS-3
--        to populate the tables
-- ******************************************************

/* table tbemployee */
INSERT into tbemployee values (seqemp.nextval, 'Sam', 'Smith', 'sam@spi.org', '(555)444-5551');
INSERT into tbemployee values (seqemp.nextval, 'Kate', 'Brown', 'kate@spi.org', '(555)444-5552');
INSERT into tbemployee values (seqemp.nextval, 'Jane', 'Green', 'jane@spi.org', '(555)444-5553');
INSERT into tbemployee values (seqemp.nextval, 'Jack', 'Black', 'jack@spi.org', '(555)444-5554');


/* table tbpublication */
INSERT into tbpublication values (seqpub.nextval, 'Earth Open Source', 'report');
INSERT into tbpublication values (seqpub.nextval, 'The New York Times', 'newspaper');
INSERT into tbpublication values (seqpub.nextval, 'US Energy Information Administration', 'report');
INSERT into tbpublication values (seqpub.nextval, 'UN Food and Agriculture Organization', 'report');
INSERT into tbpublication values (seqpub.nextval, 'The World Future Council', 'article');
INSERT into tbpublication values (seqpub.nextval, 'The Organic Center', 'article');


/* table tbproject */
INSERT into tbproject values (seqproj.nextval, 'Controversies in Science', 'chapter', '23', to_date('20120201','YYYYMMDD'), '101');
INSERT into tbproject values (seqproj.nextval, 'EcoMind', 'book', '270', to_date('20110306','YYYYMMDD'), '103');
INSERT into tbproject values (seqproj.nextval, 'Rethinking the Scarcity Discourse', 'journal', '140', to_date('20120112','YYYYMMDD'), '103');
INSERT into tbproject values (seqproj.nextval, 'Corporations Cant Pledge Allegiance', 'blog', '3', to_date('20120416','YYYYMMDD'), '101');
INSERT into tbproject values (seqproj.nextval, 'Diet for a Small Planet', 'book', '340', to_date('19780705','YYYYMMDD'), '104');


/* table tbsource */
INSERT into tbsource values (seqsource.nextval, 'GMO Myths and Truths', 'Glyphosate causes or exacerbates plant disease', 'Michael Antoniou', to_date('20120611','YYYYMMDD'), '101', 'Food', 'http://earthopensource.org/index.php/reports/58', '1001');
INSERT into tbsource values (seqsource.nextval, 'A Sad Green Story', 'Leonnig reports that 14 green tech firms that Gore invested in received or directly benefited from more than $2.5 billion in federal loans, grants and tax breaks', 'David Brooks', to_date('20121018','YYYYMMDD'), '101', 'Environment', 'http://www.nytimes.com/2012/10/19/opinion/brooks-a-sad-green-story.html', '1001');
INSERT into tbsource values (seqsource.nextval, 'Annual Energy Outlook 2012', 'The California Low Carbon Fuel Standard (LCFS) was removed from the final Reference case, given the Federal court ruling in December 2011 that found some aspects of it to be unconstitutional', 'US EIA', to_date('20120621','YYYYMMDD'), '104', 'Environment', 'http://www.eia.gov/forecasts/aeo/', '1002');
INSERT into tbsource values (seqsource.nextval, 'The State of Food Insecurity in the World', 'Agricultural growth is particularly effective in reducing hunger and malnutrition. Most of the extreme poor depend on agriculture and related activities for a significant part of their livelihoods', 'UN FAO', to_date('20120514','YYYYMMDD'), '102', 'Hunger', 'http://www.fao.org/docrep/016/i2845e/i2845e00.pdf', '1003');
INSERT into tbsource values (seqsource.nextval, 'Findings on Accessibility of the Zero Project', 'The Zero Project advocates the rights of persons with disabilities internationally by monitoring the national implementation of the UN Convention on the Rights of Persons with Disabilities and by highlighting good policies and practices', 'The WFC', to_date('20100211','YYYYMMDD'), '101', 'Human Rights', 'http://www.worldfuturecouncil.org/publications.html', '1004');
INSERT into tbsource values (seqsource.nextval, 'Simplifying the Pesticide Risk Equation', 'Today, organic fresh produce sales account for close to 9% of retail sales, and are substantially reducing presticide exposure for million of Americans', 'Charles Benbrook', to_date('20080322','YYYYMMDD'), '102', 'Food', 'http://www.organic-center.org/science.tocreports.html', '1005');
INSERT into tbsource values (seqsource.nextval, 'The Cacophony of Money', 'This is only the first presidential election in the Citizens United era of unlimited spending, and the first since 1976 in which both presidential candidates spurned the public finance system', 'NY Times Editors', to_date('20120710','YYYYMMDD'), '101', 'Politics', 'http://www.nytimes.com/2012/10/08/opinion/the-cacophony-of-money.html?_r=0', '1001');

/* table tbusage */

INSERT into tbusage values (sequsage.nextval, '1003', '1001', 'background', to_date('20120310','YYYYMMDD'));
INSERT into tbusage values (sequsage.nextval, '1001', '1001', 'background', to_date('20120410','YYYYMMDD'));
INSERT into tbusage values (sequsage.nextval, '1001', '1003', 'tweet', to_date('20120504','YYYYMMDD'));
INSERT into tbusage values (sequsage.nextval, '1003', '1001', 'background', to_date('20110312','YYYYMMDD'));
INSERT into tbusage values (sequsage.nextval, '1002', '1001', 'background', to_date('20110210','YYYYMMDD'));
INSERT into tbusage values (sequsage.nextval, '1005', '1001', 'fact', to_date('20110220','YYYYMMDD'));
INSERT into tbusage values (sequsage.nextval, '1006', '1003', 'fact', to_date('20120910','YYYYMMDD'));

/* table tbkeyword */
INSERT into tbkeyword values (seqkeyword.nextval, 'roundup ready corn');
INSERT into tbkeyword values (seqkeyword.nextval, 'plant disease');
INSERT into tbkeyword values (seqkeyword.nextval, 'reneable energy');
INSERT into tbkeyword values (seqkeyword.nextval, 'clean tech');
INSERT into tbkeyword values (seqkeyword.nextval, 'income inequality');
INSERT into tbkeyword values (seqkeyword.nextval, 'pesticides');

/* table tbsourcekeyassociation */
INSERT into tbsourcekeyassociation values ('1001', '1001');
INSERT into tbsourcekeyassociation values ('1001', '1002');
INSERT into tbsourcekeyassociation values ('1002', '1001');
INSERT into tbsourcekeyassociation values ('1003', '1002');
INSERT into tbsourcekeyassociation values ('1004', '1003');
INSERT into tbsourcekeyassociation values ('1005', '1005');


/* table tblogin */
INSERT into tblogin values ('admin', '253admin','admin','all');
INSERT into tblogin values ('user', '253user','staff','restrict');

-- ******************************************************
--    VIEW TABLES
--
-- Note:  Issue the appropiate commands to show your data
-- ******************************************************

SELECT * FROM tbemployee;
SELECT * FROM tbpublication;
SELECT * FROM tbproject;
SELECT * FROM tbsource;
SELECT * FROM tbusage;
SELECT * FROM tbkeyword;
SELECT * FROM tbsourcekeyassociation;
SELECT * FROM tblogin;

-- ******************************************************
--    QUALITY CONTROLS
--
-- Note:  Test the following constraints:
--        *) Entity integrity
--        *) Referential integrity
--        *) Column constraints
-- ******************************************************





-- ****************************************************************
-- STORED PROCEDURES
-- ****************************************************************

-- ****************************************************************
-- delete_employee
-- purpose: Using a procedure to delete an employee and in the process
-- assign another arbitrary employee to temporarily take over their owned 
-- projects until a new full-time owner is assigned
-- ****************************************************************

CREATE or REPLACE procedure delete_employee
   (   DEL_EMPID   in      tbemployee.empid%TYPE,
       NEW_OWNER   out     tbproject.projowner%TYPE
   )	
is
	newowner char(3);
	tmpcnt integer;
begin
	/* get arbitrary new employee to temporarily own project */
	select count(1) into tmpcnt
	from tbemployee 
		where empid <> DEL_EMPID 
		and rownum < 2;
	
	/* account for when deleting the last employee -- and no data error */
	if tmpcnt > 0 then
		select empid
		into newowner
		from tbemployee 
			where empid <> DEL_EMPID 
			and rownum < 2;
	
		if newowner IS NOT NULL then
			update tbproject
			set projowner=newowner
			where projowner=DEL_EMPID;
		end if;	
	end if;
	
	delete from tbemployee 
		where empid = DEL_EMPID;
	
	/* new project owner is returned */
	NEW_OWNER := newowner;

end delete_employee;
/

show errors

-- ******************************************************
--    END SESSION
-- ******************************************************
commit;
spool off
-- add commit -- transactions !!!
