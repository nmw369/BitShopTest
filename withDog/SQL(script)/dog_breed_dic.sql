	
DROP TABLE dog_breed_dic;
DROP TABLE dog_info;
DROP TABLE recommend_info;
DROP TABLE healing_dog;
DROP TABLE ash_reservation;
DROP TABLE after_ash;
DROP TABLE chat_bot;

DROP SEQUENCE seq_dog_breed_dic_dog_no;
DROP SEQUENCE seq_dog_info_dog_info_no;
DROP SEQUENCE seq_healing_dog_healing_dog_no;
DROP SEQUENCE seq_ash_ash_no;
DROP SEQUENCE seq_after_ash_after_ash_no;
DROP SEQUENCE seq_chat_bot_question_no;

CREATE SEQUENCE seq_dog_breed_dic_dog_no		 	 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_dog_info_dog_info_no	 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_healing_dog_healing_dog_no			 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_ash_ash_no		 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_after_ash_after_ash_no			 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_chat_bot_question_no			 INCREMENT BY 1 START WITH 10000;

seq_dog_breed_dic_dog_no.nextval
seq_dog_info_dog_info_no.nextval
seq_healing_dog_healing_dog_no.nextval
seq_ash_ash_no.nextval
seq_after_ash_after_ash_no.nextval
seq_chat_bot_question_no.nextval

CREATE TABLE dog_breed_dic (
dog_no NUMBER(10) NOT NULL,
dog_breed_en VARCHAR2(50) NOT NULL,
dog_breed_ko VARCHAR2(100) NOT NULL,
dog_height VARCHAR2(200),
dog_weight VARCHAR2(200),
dog_place VARCHAR2(200),
dog_color VARCHAR2(200),
dog_personality VARCHAR2(300),
dog_lifespan VARCHAR2(200),
dog_link VARCHAR2(50),
PRIMARY KEY (dog_no)
);

CREATE TABLE dog_info (
dog_info_no NUMBER(10) NOT NULL,
user_id VARCHAR2(20) NOT NULL REFERENCES users(user_id),
dog_info_image VARCHAR2(300) UNIQUE,
dog_info_content CLOB,
dog_info_title VARCHAR2(200) NOT NULL,
dog_info_topic VARCHAR2(20),
dog_info_view_count VARCHAR2(10) DEFAULT '0',
dog_info_recommend VARCHAR2(10) DEFAULT '0',
dog_info_not_recommend VARCHAR2(10) DEFAULT '0',
reg_date DATE,
delete_flag VARCHAR2(3) DEFAULT '0',
PRIMARY KEY (dog_info_no)
);

CREATE TABLE recommend_info(
user_id VARCHAR2(20) NOT NULL REFERENCES users(user_id),
dog_info_no NUMBER(10) NOT NULL REFERENCES dog_info(dog_info_no),
recommend_condition VARCHAR2(3),
PRIMARY KEY (user_id,dog_info_no)
);

CREATE TABLE healing_dog(
healing_dog_no NUMBER(10) NOT NULL,
dog_no NUMBER(10) NOT NULL REFERENCES dog_breed_dic(dog_no),
healing_dog_name VARCHAR2(20),
healing_dog_birth VARCHAR2(100),
healing_dog_image VARCHAR2(20) UNIQUE,
healing_dog_char VARCHAR2(100),
healing_dog_gender VARCHAR2(3),
healing_dog_healer VARCHAR2(20),
PRIMARY KEY (healing_dog_no)
);

CREATE TABLE ash_reservation(
ash_reservation_no NUMBER(10) NOT NULL,
healing_dog_no NUMBER(10) NOT NULL REFERENCES healing_dog(healing_dog_no),
user_id VARCHAR2(20) NOT NULL REFERENCES users(user_id),
ash_reservation_name VARCHAR2(20),
ash_reservation_date VARCHAR2(30),
ash_reservation_time VARCHAR2(20),
ash_reservation_address1 VARCHAR2(200),
ash_reservation_address2 VARCHAR2(200),
ash_reservation_phone VARCHAR2(20),
ash_reservation_price NUMBER(20),
ash_reservation_etc VARCHAR2(200),
ash_reservation_condition VARCHAR2(3) DEFAULT 0,
purchase_date DATE,
payment_option VARCHAR2(3) DEFAULT 0,
PRIMARY KEY (ash_reservation_no)
);

CREATE TABLE after_ash(
after_ash_no NUMBER(10) NOT NULL,
healing_dog_no NUMBER(10) NOT NULL REFERENCES healing_dog(healing_dog_no),
user_id VARCHAR2(20) NOT NULL REFERENCES users(user_id),
after_ash_title VARCHAR2(200),
after_ash_content VARCHAR2(4000),
after_ash_date VARCHAR2(30),
after_ash_time VARCHAR2(20),
after_ash_image VARCHAR2(300) UNIQUE,
after_ash_view_count VARCHAR2(10) DEFAULT '0',
reg_date DATE,
delete_flag VARCHAR2(3) DEFAULT 0,
PRIMARY KEY (after_ash_no)
);

CREATE TABLE chat_bot(
question_no NUMBER(10) NOT NULL,
question VARCHAR2(100),
answer VARCHAR2(500),
question_count NUMBER(10),
delete_flag VARCHAR2(3) DEFAULT 0,
PRIMARY KEY (question_no)
);

user_id VARCHAR2(20) NOT NULL REFERENCES users(user_id), //�ϴܖM




