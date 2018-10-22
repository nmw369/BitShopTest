drop table fund;
drop table fund_info;
drop table point;
-펀드테이블

====================================================================

CREATE SEQUENCE seq_fund_fund_no INCREMENT BY 1 START WITH 10000;

CREATE TABLE fund(
fund_no    NUMBER(10)    NOT NULL,
fund_title    VARCHAR2(200)    NOT NULL,
fund_image    VARCHAR2(20),  
fund_center    VARCHAR2(200)    NOT NULL,
fund_phone    VARCHAR2(20)    NOT NULL,
fund_term    VARCHAR2(80)    NOT NULL,
fund_raising    NUMBER(10)     NOT NULL,
fund_personnel    NUMBER(10)    NOT NULL,
fund_state    VARCHAR2(3)   NOT NULL,
fund_result_price    NUMBER(10),
fund_content    VARCHAR2(4000),
reg_date    DATE  NOT NULL,
delete_flag     VARCHAR2(3),
PRIMARY KEY(fund_no)
);
====================================================================
-펀드후원내역


CREATE SEQUENCE seq_fund_info_fund_my_price_no INCREMENT BY 1 START WITH 10000;

///////////이거 무결성나옴
CREATE TABLE fund_info(
fund_my_price_no    NUMBER(10)    NOT NULL,
fund_no    NUMBER(10)    NOT NULL REFERENCES fund(fund_no),
user_id    VARCHAR2(20) REFERENCES users(user_id),  
payment_option    VARCHAR2(3)    DEFAULT 0,
fund_my_price    NUMBER(10)    NOT NULL,
purchase_date   DATE    DEFAULT SYSDATE,
PRIMARY KEY(fund_my_price_no)
);
///////////////////

CREATE TABLE fund_info(
fund_my_price_no    NUMBER(10)    NOT NULL,
fund_no    NUMBER(10)    NOT NULL ,
user_id    VARCHAR2(20) ,  
payment_option    VARCHAR2(3)    DEFAULT 0,
fund_my_price    NUMBER(10)    NOT NULL,
purchase_date   DATE    DEFAULT SYSDATE,
PRIMARY KEY(fund_my_price_no)
);
====================================================================

-포인트 


CREATE SEQUENCE seq_point_no INCREMENT BY 1 START WITH 1;
DROP SEQUENCE seq_point_no;

CREATE TABLE point(
point_no    NUMBER(10)    NOT NULL,
user_id    VARCHAR2(20) NOT NULL REFERENCES users(user_id),
fund_my_price_no    NUMBER(10) REFERENCES fund_info(fund_my_price_no),
purchase_no    NUMBER(10) REFERENCES purchase(purchase_no),
ash_reservation_no    NUMBER(10) REFERENCES ash_reservation(ash_reservation_no),
reg_date   DATE    DEFAULT SYSDATE,
use_point  NUMBER(10),
point  NUMBER(10),
current_point NUMBER(10),
PRIMARY KEY(point_no)
);

CREATE TABLE point(
point_no    NUMBER(10)    NOT NULL,
user_id    VARCHAR2(20) NOT NULL,
fund_my_price_no    NUMBER(10) ,
purchase_no    NUMBER(10) ,
ash_reservation_no    NUMBER(10) ,
reg_date   DATE    DEFAULT SYSDATE,
use_point  NUMBER(10),
point  NUMBER(10),
current_point NUMBER(10),
PRIMARY KEY(point_no)
);

==========================================================================
-채팅방입장정보

CREATE TABLE chat_info(
chat_in_no    NUMBER(10)    NOT NULL,
chat_room_no    NUMBER(10)  NOT NULL REFERENCES chat_room(chat_room_no),
user_id    VARCHAR2(20) NOT NULL REFERENCES users(user_id),
PRIMARY KEY(chat_in_no)
);
====================================================================

-채팅방

CREATE TABLE chat_room(
chat_room_no    NUMBER(10)  NOT NULL,
chat_in_no    NUMBER(10) NOT NULL,
user_id    VARCHAR2(20) NOT NULL REFERENCES users(user_id),
chat_title    VARCHAR2(20) ,
chat_personnel    NUMBER(10),
chat_war   NUMBER(2),
chat_image  VARCHAR2(40) UNIQUE,
PRIMARY KEY(chat_room_no)
);
