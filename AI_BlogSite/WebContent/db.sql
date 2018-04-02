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
	is_no number(5) primary key,			-- 글 번호
	is_owner varchar2(10 char) not null,	-- 글쓴이 id
	is_txt varchar2(350 char) not null,
	is_date date not null
);
create sequence ihwac_sns_seq;
select * from ihwac_sns;
--------------------------------------------------
create table ihwac_sns_repl(
	isr_no number(7) primary key,			-- 댓글 번호
	isr_is_no number(5) not null,			-- 소속 글 번호
	isr_owner varchar2(10 char) not null,	-- 댓글 쓴 사람
	isr_txt varchar2(150 char) not null,	-- 댓글 내용
	isr_date date not null
);
select * from ihwac_sns_repl;
create sequence ihwac_sns_repl_seq;
--------------------------------------------------
create table ihwac_member(
	im_id varchar2(10 char) primary key, 	-- id
	im_pw varchar2(10 char) not null, 		-- pw
	im_name varchar2(10 char) not null,		-- 이름
	im_addr varchar2(10 char) not null,		-- 거주지
	im_birthday date not null,				-- 생년월일
	im_img varchar2(100 char) not null		-- 사진
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
	name varchar2(20 char) not null,		-- 이름
	sex varchar2(2 char) not null,		-- 거주지
	birthday date not null,				-- 생년월일
	img varchar2(100 char) not null		-- 사진
);

select * from member;

insert into MEMBER values('user1','User2','장현우','남','19920620','ㅋㅋ ㅎㅎ.png');

update MEMBER SET id = 'user2';

--------------------------------------------------

create table sns(
	num number(5) primary key,			-- 글 번호
	owner varchar2(10 char) not null,	-- 글쓴이 id
	title varchar2(50 char) not null,
	txt varchar2(350 char) not null,
	write_date date not null
);

drop table sns;
create sequence sns_seq;
select * from sns;









