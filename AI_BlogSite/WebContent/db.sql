create table ihwac_msg(
	im_no number(7) primary key,
	im_from varchar2(10 char) not null,
	im_to varchar2(10 char) not null,
	im_txt varchar2(350 char) not null,
	im_date date not null
);
create sequence ihwac_msg_seq;

select * from ihwac_msg;
--------------------------------------------------
create table ihwac_sns(
	is_no number(5) primary key,			-- �� ��ȣ
	is_owner varchar2(10 char) not null,	-- �۾��� id
	is_txt varchar2(350 char) not null,
	is_date date not null
);
create sequence ihwac_sns_seq;
select * from ihwac_sns;
--------------------------------------------------
create table ihwac_sns_repl(
	isr_no number(7) primary key,			-- ��� ��ȣ
	isr_is_no number(5) not null,			-- �Ҽ� �� ��ȣ
	isr_owner varchar2(10 char) not null,	-- ��� �� ���
	isr_txt varchar2(150 char) not null,	-- ��� ����
	isr_date date not null
);
select * from ihwac_sns_repl;
create sequence ihwac_sns_repl_seq;
--------------------------------------------------
create table ihwac_member(
	im_id varchar2(10 char) primary key, 	-- id
	im_pw varchar2(10 char) not null, 		-- pw
	im_name varchar2(10 char) not null,		-- �̸�
	im_addr varchar2(10 char) not null,		-- ������
	im_birthday date not null,				-- �������
	im_img varchar2(100 char) not null		-- ����
);
select * from ihwac_member;
select *
from ihwac_sns, ihwac_member
where is_owner = im_id
order by is_date;
--------------------------------------------------

create table member(
	id varchar2(10 char) primary key, 	-- id
	pw varchar2(10 char) not null, 		-- pw
	name varchar2(20 char) not null,		-- �̸�
	sex varchar2(2 char) not null,		-- ������
	birthday date not null,				-- �������
	img varchar2(100 char) not null		-- ����
);

select * from member;

insert into MEMBER values('user1','User2','������','��','19920620','���� ����.png');

update MEMBER SET id = 'user2';

--------------------------------------------------

create table sns(
	num number(5) primary key,			-- �� ��ȣ
	owner varchar2(10 char) not null,	-- �۾��� id
	title varchar2(50 char) not null,
	txt varchar2(350 char) not null,
	write_date date not null
);

drop table sns;
create sequence sns_seq;
select * from sns;









