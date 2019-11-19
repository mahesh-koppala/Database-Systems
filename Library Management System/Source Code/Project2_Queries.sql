CREATE TABLE Book (
 ISBN int NOT NULL PRIMARY KEY,
 TITLE varchar(255) ,
 SUBJECT_AREA varchar(255),
 AUTHOR varchar(255),
 QUANTITY int,
 BINDING  varchar(255),
 TYPE varchar(255),
 RARE_OUTOFPRINT int
);

CREATE TABLE MEMBERS (
 CARD_NO int NOT NULL,
 SSN int NOT NULL PRIMARY KEY,
 TYPE varchar(100),
 NAME varchar(255),
 Campus varchar(100),
 PHONE int,
 ADDRESS varchar(255),
 JOINED_DATE Date,
 EXPIRY_DATE Date
);

CREATE TABLE BORROWS(
 ISBN int,
 SSN int,
 CHECK_OUT_DATE Date,
 DUE_DATE Date,
 CONSTRAINT BORROWS_SSN_FK
 FOREIGN KEY(SSN)
 REFERENCES MEMBERS(SSN),
CONSTRAINT BORROWS_ISBN_FK FOREIGN KEY(ISBN)
REFERENCES Book(ISBN),
PRIMARY KEY(ISBN,SSN)
);

CREATE TABLE RETURNS(
 ISBN int,
 SSN int,
 FINE int,
 RETURN_DATE DATE,
 CONSTRAINT RETURNS_SSN_FK
    FOREIGN KEY (SSN)
    REFERENCES MEMBERS(SSN),
CONSTRAINT RETURNS_ISBN_FK
    FOREIGN KEY(ISBN)
    REFERENCES BOOK(ISBN),
    PRIMARY KEY(ISBN,SSN)
);

CREATE TABLE STAFF (
 SSN int NOT NULL PRIMARY KEY,
 NAME varchar(255),
 PHONE int,
 DESIGNATION varchar(255),
 ADDRESS varchar(255)
);

CREATE TABLE CATALOG(
ISBN INT NOT NULL,
TITLE VARCHAR(255),
DESCRIPTION VARCHAR(1255),
SSN INT,
CONSTRAINT catalog_pk PRIMARY KEY(ISBN),
CONSTRAINT catalog_fk FOREIGN KEY(SSN) REFERENCES STAFF(SSN)
);

CREATE TABLE TRIG (
 SSN int,
 ISBN int,
 ISOVERDUE varchar(255),
 ISMEMBEREXPIRE varchar(255),
 FNAME varchar(255)
)

CREATE SEQUENCE card_seq START WITH 1;

CREATE TRIGGER mem_trig BEFORE INSERT ON MEMBERS
FOR EACH ROW
BEGIN
SELECT card_seq.NEXTVAL INTO :new.id
FROM dual;
END;

insert into book values(6753473837873,'Let us C','Programming','rahul',10,'Hardcover','general',0);
insert into book values(6853473837873,'Let us Java','Programming','rahul',10,'Hardcover','general',0);
insert into book values(6853473835873,'Let us Java II','Programming','rahul',10,'Hardcover','general',0);
insert into book values(6653473837873,'Let us C++','Programming','rahul',10,'Hardcover','general',0);
insert into book values(6753473837874,'Programming in Java','Programming','mahesh',8,'Hardcover','general',0);
insert into book values(6753473837875,'Programming in C','Programming','mahesh',8,'Hardcover','general',0);
insert into book values(6753473837876,'Programming in C++','Programming','mahesh',8,'Hardcover','general',0);
insert into book values(6753473837875,'Datastructures and Algorithms in Java','Programming','Narasimha',7,'Hardcover','general',0);
insert into book values(6753473837885,'Datastructures and Algorithms in C','Programming','Narasimha',7,'Hardcover','general',0);
insert into book values(6753473837895,'Datastructures and Algorithms in C++','Programming','Narasimha',7,'Hardcover','general',0);
insert into book values(7753473837875,'ISC Physics','Science','D Rao',7,'Hardcover','general',0);
insert into book values(7753473737875,'ISC Chemistry','Science','D Rao',7,'Hardcover','general',0);
insert into book values(7753473637875,'ISC Mathematics','Science','D Rao',7,'Hardcover','general',0);
insert into book values(7853473837875,'NCERT Physics','Science','CBSE',7,'Hardcover','general',0);
insert into book values(7853473737875,'NCERT Physics','Science','CBSE',7,'Hardcover','general',0);
insert into book values(7853473637875,'NCERT Physics','Science','CBSE',7,'Hardcover','general',0);
insert into book values(7953473837875,'NCERT Maths','Science','CBSE',10,'Hardcover','general',0);
insert into book values(7953473737875,'NCERT Maths','Science','CBSE',10,'Hardcover','general',0);
insert into book values(7953473637875,'NCERT Maths','Science','CBSE',10,'Hardcover','general',0);
insert into book values(7493473837875,'NCERT Chemistry','Science','CBSE',7,'Hardcover','general',0);
insert into book values(7493473737875,'NCERT Chemistry','Science','CBSE',7,'Hardcover','general',0);
insert into book values(7493473637875,'NCERT Chemistry','Science','CBSE',7,'Hardcover','general',0);
insert into book values(7393473837875,'NCERT Biology','Science','CBSE',7,'Hardcover','general',0);
insert into book values(7393473737875,'NCERT Biology','Science','CBSE',7,'Hardcover','general',0);
insert into book values(7393473637875,'NCERT Biology','Science','CBSE',7,'Hardcover','general',0);
insert into book values(7293473837875,'NCERT History','Political Science','CBSE',7,'Hardcover','general',0);
insert into book values(7293473737875,'NCERT History','Political Science','CBSE',7,'Hardcover','general',0);
insert into book values(7293473637875,'NCERT History','Political Science','CBSE',7,'Hardcover','general',0);
insert into book values(7193473837875,'NCERT Geography','Political Science','CBSE',7,'Hardcover','general',0);
insert into book values(7193473737875,'NCERT Geography','Political Science','CBSE',7,'Hardcover','general',0);
insert into book values(7193473637875,'NCERT Geography','Political Science','CBSE',7,'Hardcover','general',0);
insert into book values(7193473837876,'NCERT English','Literature','CBSE',7,'Hardcover','general',0);
insert into book values(7193473737876,'NCERT English','Literature','CBSE',7,'Hardcover','general',0);
insert into book values(7193473637876,'NCERT English','Literature','CBSE',7,'Hardcover','general',0);
insert into book values(7193473837877,'NCERT Hindi','Literature','CBSE',7,'Hardcover','general',0);
insert into book values(7193473737877,'NCERT Hindi','Literature','CBSE',7,'Hardcover','general',0);
insert into book values(7193473637877,'NCERT Hindi','Literature','CBSE',7,'Hardcover','reference',1);

INSERT INTO STAFF VALUES(333333333,'GOUTHAM',6823132983,'CHIEF LIBRARIAN','NVR LAYOUT');
INSERT INTO STAFF VALUES(233333333,'GOURAV',6823132883,'DEPT ASS LIBRARIAN','RRN COLONY');
INSERT INTO STAFF VALUES(323333333,'GOUTHAMI',6723132983,'LIBRARY ASSISTANT','NVR LAYOUT');
INSERT INTO STAFF VALUES(333333332,'SATISH',6822132983,'CHECKOUT STAFF','DEVILS COLONY');
INSERT INTO STAFF VALUES(333332333,'NEDD STARK',6823131983,'REFERENCE LIBRARIAN','CHIMPU COLONY');

insert into MEMBERS VALUES(965272541,111111111,'student','mahesh','central',5214789632,'nedderman',TO_DATE('01/01/2018','DD/MM/YYYY'),TO_DATE('01/01/2020','DD/MM/YYYY'));
insert into MEMBERS VALUES(965285204,111111112,'student','rahul','central',5214789631,'nedderman',TO_DATE('01/01/2018','DD/MM/YYYY'),TO_DATE('01/01/2022','DD/MM/YYYY'));
insert into MEMBERS VALUES(965298547,111111113,'student','varsha','central',5214789630,'pickard',TO_DATE('01/01/2018','DD/MM/YYYY'),TO_DATE('01/01/2020','DD/MM/YYYY'));
insert into MEMBERS VALUES(965267490,111111114,'student','ram','central',5214789633,'nedderman',TO_DATE('01/01/2018','DD/MM/YYYY'),TO_DATE('01/01/2020','DD/MM/YYYY'));
insert into MEMBERS VALUES(965255201,111111115,'student','sathish','central',5214789634,'nedderman',TO_DATE('01/01/2018','DD/MM/YYYY'),TO_DATE('01/01/2018','DD/MM/YYYY'));
insert into MEMBERS VALUES(965247832,111111116,'student','nitin','central',5214789635,'davis',TO_DATE('01/01/2018','DD/MM/YYYY'),TO_DATE('01/01/2020','DD/MM/YYYY'));
insert into MEMBERS VALUES(965230124,111111117,'student','kalyan','central',5214789636,'nedderman',TO_DATE('01/01/2018','DD/MM/YYYY'),TO_DATE('01/01/2020','DD/MM/YYYY'));
insert into MEMBERS VALUES(965229632,111111118,'student','gupta','central',5214789637,'nedderman',TO_DATE('01/01/2018','DD/MM/YYYY'),TO_DATE('01/01/2020','DD/MM/YYYY'));
insert into MEMBERS VALUES(965217410,111111119,'PROFESSOR','sachin','central',5214789638,'nedderman',TO_DATE('01/01/2018','DD/MM/YYYY'),TO_DATE('01/01/2020','DD/MM/YYYY'));
insert into MEMBERS VALUES(965206381,111111110,'PROFESSOR','dhoni','central',5214789639,'nedderman',TO_DATE('01/01/2018','DD/MM/YYYY'),TO_DATE('01/01/2022','DD/MM/YYYY'));

insert into borrows values(6753473837873,111111111,TO_DATE('01/02/2019','DD/MM/YYYY'),TO_DATE('22/02/2019','DD/MM/YYYY'));
insert into borrows values(6853473835873,111111112,TO_DATE('02/02/2019','DD/MM/YYYY'),TO_DATE('23/02/2019','DD/MM/YYYY'));
insert into borrows values(6653473837873,111111113,TO_DATE('03/02/2019','DD/MM/YYYY'),TO_DATE('24/02/2019','DD/MM/YYYY'));
insert into borrows values(6753473837874,111111114,TO_DATE('04/02/2019','DD/MM/YYYY'),TO_DATE('25/02/2019','DD/MM/YYYY'));
insert into borrows values(6753473837875,111111115,TO_DATE('05/02/2019','DD/MM/YYYY'),TO_DATE('26/02/2019','DD/MM/YYYY'));
insert into borrows values(6753473837876,111111116,TO_DATE('06/02/2019','DD/MM/YYYY'),TO_DATE('27/02/2019','DD/MM/YYYY'));
insert into borrows values(6753473837885,111111117,TO_DATE('07/02/2019','DD/MM/YYYY'),TO_DATE('28/02/2019','DD/MM/YYYY'));
insert into borrows values(6753473837895,111111118,TO_DATE('08/02/2019','DD/MM/YYYY'),TO_DATE('01/03/2019','DD/MM/YYYY'));
insert into borrows values(7753473837875,111111119,TO_DATE('09/02/2019','DD/MM/YYYY'),TO_DATE('02/03/2019','DD/MM/YYYY'));
insert into borrows values(7753473737875,111111110,TO_DATE('10/02/2019','DD/MM/YYYY'),TO_DATE('03/03/2019','DD/MM/YYYY'));

insert into returns values(6753473837873,111111111,0,TO_DATE('15/02/2019','DD/MM/YYYY'));
insert into returns values(6853473835873,111111112,0,TO_DATE('16/02/2019','DD/MM/YYYY'));
insert into returns values(6653473837873,111111113,0,TO_DATE('17/02/2019','DD/MM/YYYY'));
insert into returns values(6753473837874,111111114,0,TO_DATE('18/02/2019','DD/MM/YYYY'));
insert into returns values(6753473837875,111111115,0,TO_DATE('19/02/2019','DD/MM/YYYY'));
insert into returns values(6753473837876,111111116,0,TO_DATE('20/02/2019','DD/MM/YYYY'));
insert into returns values(6753473837885,111111117,0,TO_DATE('20/02/2019','DD/MM/YYYY'));
insert into returns values(6753473837895,111111118,1,TO_DATE('20/02/2019','DD/MM/YYYY'));
insert into returns values(7753473837875,111111119,1,TO_DATE('20/02/2019','DD/MM/YYYY'));
insert into returns values(7753473737875,111111110,1,TO_DATE('20/02/2019','DD/MM/YYYY'));

insert into catalog values(6753473837873,'Let us C','This book breifly explians the C language and its nuances',333332333);
insert into catalog values(6853473837873,'Let us Java','This book breifly explians the java language and its nuances',333332333);
insert into catalog values(6853473835873,'Let us Java II','This book breifly explians the java  advance language and its nuances',333332333);
insert into catalog values(6653473837873,'Let us C++','This book breifly explians the C++ language and its nuances',333332333);
insert into catalog values(6753473837874,'Programming in Java','This book breifly explians the controls and elements of Java',333332333);
insert into catalog values(6753473837875,'Programming in C','This book breifly explians the controls and elements of C',333332333);
insert into catalog values(6753473837876,'Programming in C++','This book breifly explians the controls and elements of C++',333332333);
insert into catalog values(6753473837875,'Datastructures and Algorithms in Java','This book breifly explians the programming in datastructures with Java',333332333);
insert into catalog values(6753473837885,'Datastructures and Algorithms in C','This book breifly explians the programming in datastructures with C',333332333);
insert into catalog values(6753473837895,'Datastructures and Algorithms in C++','This book breifly explians the programming in datastructures with C++',333332333);
insert into catalog values(7753473837875,'ISC Physics','This book breifly explians about Physics',333332333);
insert into catalog values(7753473737875,'ISC Chemistry','This book breifly explians about Chemistry',333332333);
insert into catalog values(7753473637875,'ISC Mathematics','This book breifly explians about Mathematics',333332333);
insert into catalog values(7853473837875,'NCERT Physics','This book breifly explians about physics in class 12',333332333);
insert into catalog values(7853473737875,'NCERT Physics','This book breifly explians about physics in class 11',333332333);
insert into catalog values(7853473637875,'NCERT Physics','This book breifly explians about physics in class 10',333332333);
insert into catalog values(7953473837875,'NCERT Maths','This book breifly explians about Maths in class 12',333332333);
insert into catalog values(7953473737875,'NCERT Maths','This book breifly explians about Maths in class 11',333332333);
insert into catalog values(7953473637875,'NCERT Maths','This book breifly explians about Maths in class 10',333332333);
insert into catalog values(7493473837875,'NCERT Chemistry','This book breifly explians about Chemistry in class 12',333332333);
insert into catalog values(7493473737875,'NCERT Chemistry','This book breifly explians about Chemistry in class 11',333332333);
insert into catalog values(7493473637875,'NCERT Chemistry','This book breifly explians about Chemistry in class 10',333332333);
insert into catalog values(7393473837875,'NCERT Biology','This book breifly explians about Biology in class 12',333332333);
insert into catalog values(7393473737875,'NCERT Biology','This book breifly explians about Biology in class 11',333332333);
insert into catalog values(7393473637875,'NCERT Biology','This book breifly explians about Biology in class 10',333332333);
insert into catalog values(7293473837875,'NCERT History','This book breifly explians about Biology in class 12',333332333);
insert into catalog values(7293473737875,'NCERT History','This book breifly explians about Biology in class 11',333332333);
insert into catalog values(7293473637875,'NCERT History','This book breifly explians about Biology in class 10',333332333);
insert into catalog values(7193473837875,'NCERT Geography','This book breifly explians about Biology in class 12',333332333);
insert into catalog values(7193473737875,'NCERT Geography','This book breifly explians about Biology in class 11',333332333);
insert into catalog values(7193473637875,'NCERT Geography','This book breifly explians about Biology in class 10',333332333);
insert into catalog values(7193473837876,'NCERT English','This book breifly explians about English in class 12',333332333);
insert into catalog values(7193473737876,'NCERT English','This book breifly explians about English in class 11',333332333);
insert into catalog values(7193473637876,'NCERT English','This book breifly explians about English in class 10',333332333);
insert into catalog values(7193473837877,'NCERT Hindi','This book breifly explians about Hindi in class 12',333332333);
insert into catalog values(7193473737877,'NCERT Hindi','This book breifly explians about Hindi in class 11',333332333);
insert into catalog values(7193473637877,'NCERT Hindi','This book breifly explians about Hindi in class 10',333332333);


