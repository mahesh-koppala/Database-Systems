DROP TABLE Book CASCADE CONSTRAINTS;

DROP TABLE MEMBERS CASCADE CONSTRAINTS;

DROP TABLE BORROWS CASCADE CONSTRAINTS;

DROP TABLE RETURNS CASCADE CONSTRAINTS;

DROP TABLE STAFF CASCADE CONSTRAINTS;

DROP TABLE CATALOG CASCADE CONSTRAINTS;




CREATE TABLE Book (
 ISBN int NOT NULL,
 TITLE varchar(255) ,
 SUBJECT_AREA varchar(255),
 AUTHOR varchar(255),
 QUANTITY int,
 BINDING  varchar(255),
 TYPE varchar(255),
 RARE_OUTOFPRINT int,
 Remaining_Quantity INT,
 Lent_Status VARCHAR(5),
 Interest_Take VARCHAR(5),
 Reason_Take VARCHAR(255),
 PRIMARY KEY(ISBN) 
);

CREATE TABLE MEMBERS (
 CARD_NO int NOT NULL,
 SSN int NOT NULL,
 TYPE varchar(100),
 NAME varchar(255),
 PHONE int,
 ADDRESS varchar(255),
 JOINED_DATE Date,
 EXPIRY_DATE Date,
 No_Of_Books INT,
 Is_Active VARCHAR(5),
 Grace_Period INT,
 Image VARCHAR(255),
 Campus_Address varchar(255),
 Is_Renewal VARCHAR(5),
 PRIMARY KEY(SSN),
 UNIQUE(CARD_NO)
);

CREATE TABLE BORROWS(
 SSN int,
 ISBN int,
 CHECK_OUT_DATE Date,
 DUE_DATE Date,
 Notice_Sent VARCHAR(5),
 CONSTRAINT BORROWS_SSN_FK FOREIGN KEY(SSN)
 REFERENCES MEMBERS(SSN),
CONSTRAINT BORROWS_ISBN_FK FOREIGN KEY(ISBN)
REFERENCES Book(ISBN ) ,
PRIMARY KEY(SSN,ISBN)
);

CREATE TABLE RETURNS(
 ISBN int,
 SSN int,
 FINE int,
 RETURN_DATE DATE,
 CONSTRAINT RETURNS_SSN_FK
    FOREIGN KEY (SSN)
    REFERENCES MEMBERS(SSN),
    FOREIGN KEY(ISBN)
    REFERENCES Book(ISBN),
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

insert into book values(6753473837873,'Let us C','Programming','rahul',10,'Hardcover','general',0,'This book breifly explians the C language and its nuances');
insert into book values(6853473837873,'Let us Java','Programming','rahul',10,'Hardcover','general',0,'This book breifly explians the java language and its nuances');
insert into book values(6853473837873,'Let us Java II','Programming','rahul',10,'Hardcover','general',0,'This book breifly explians the java  advance language and its nuances');
insert into book values(6653473837873,'Let us C++','Programming','rahul',10,'Hardcover','general',0,'This book breifly explians the C++ language and its nuances');
insert into book values(6753473837874,'Programming in Java','Programming','mahesh',8,'Hardcover','general',0,'This book breifly explians the controls and elements of Java');
insert into book values(6753473837875,'Programming in C','Programming','mahesh',8,'Hardcover','general',0,'This book breifly explians the controls and elements of C');
insert into book values(6753473837876,'Programming in C++','Programming','mahesh',8,'Hardcover','general',0,'This book breifly explians the controls and elements of C++');
insert into book values(6753473837875,'Datastructures and Algorithms in Java','Programming','Narasimha',7,'Hardcover','general',0,'This book breifly explians the programming in datastructures with Java');
insert into book values(6753473837885,'Datastructures and Algorithms in C','Programming','Narasimha',7,'Hardcover','general',0,'This book breifly explians the programming in datastructures with C');
insert into book values(6753473837895,'Datastructures and Algorithms in C++','Programming','Narasimha',7,'Hardcover','general',0,'This book breifly explians the programming in datastructures with C++');
insert into book values(7753473837875,'ISC Physics','Science','D Rao',7,'Hardcover','general',0,'This book breifly explians about Physics');
insert into book values(7753473737875,'ISC Chemistry','Science','D Rao',7,'Hardcover','general',0,'This book breifly explians about Chemistry');
insert into book values(7753473637875,'ISC Mathematics','Science','D Rao',7,'Hardcover','general',0,'This book breifly explians about Mathematics');
insert into book values(7853473837875,'NCERT Physics','Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about physics in class 12');
insert into book values(7853473737875,'NCERT Physics','Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about physics in class 11');
insert into book values(7853473637875,'NCERT Physics','Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about physics in class 10');
insert into book values(7953473837875,'NCERT Maths','Science','CBSE',10,'Hardcover','general',0,'This book breifly explians about Maths in class 12');
insert into book values(7953473737875,'NCERT Maths','Science','CBSE',10,'Hardcover','general',0,'This book breifly explians about Maths in class 11');
insert into book values(7953473637875,'NCERT Maths','Science','CBSE',10,'Hardcover','general',0,'This book breifly explians about Maths in class 10');
insert into book values(7493473837875,'NCERT Chemistry','Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Chemistry in class 12');
insert into book values(7493473737875,'NCERT Chemistry','Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Chemistry in class 11');
insert into book values(7493473637875,'NCERT Chemistry','Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Chemistry in class 10');
insert into book values(7393473837875,'NCERT Biology','Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Biology in class 12');
insert into book values(7393473737875,'NCERT Biology','Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Biology in class 11');
insert into book values(7393473637875,'NCERT Biology','Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Biology in class 10');
insert into book values(7293473837875,'NCERT History','Political Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Biology in class 12');
insert into book values(7293473737875,'NCERT History','Political Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Biology in class 11');
insert into book values(7293473637875,'NCERT History','Political Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Biology in class 10');
insert into book values(7193473837875,'NCERT Geography','Political Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Biology in class 12');
insert into book values(7193473737875,'NCERT Geography','Political Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Biology in class 11');
insert into book values(7193473637875,'NCERT Geography','Political Science','CBSE',7,'Hardcover','general',0,'This book breifly explians about Biology in class 10');
insert into book values(7193473837876,'NCERT English','Literature','CBSE',7,'Hardcover','general',0,'This book breifly explians about English in class 12');
insert into book values(7193473737876,'NCERT English','Literature','CBSE',7,'Hardcover','general',0,'This book breifly explians about English in class 11');
insert into book values(7193473637876,'NCERT English','Literature','CBSE',7,'Hardcover','general',0,'This book breifly explians about English in class 10');
insert into book values(7193473837877,'NCERT Hindi','Literature','CBSE',7,'Hardcover','general',0,'This book breifly explians about Hindi in class 12');
insert into book values(7193473737877,'NCERT Hindi','Literature','CBSE',7,'Hardcover','general',0,'This book breifly explians about Hindi in class 11');
insert into book values(7193473637877,'NCERT Hindi','Literature','CBSE',7,'Hardcover','general',0,'This book breifly explians about Hindi in class 10');

INSERT INTO STAFF VALUES(333333333,'GOUTHAM',6823132983,'CHIEF LIBRARIAN','NVR LAYOUT');
INSERT INTO STAFF VALUES(233333333,'GOURAV',6823132883,'DEPT ASS LIBRARIAN','RRN COLONY');
INSERT INTO STAFF VALUES(323333333,'GOUTHAMI',6723132983,'LIBRARY ASSISTANT','NVR LAYOUT');
INSERT INTO STAFF VALUES(333333332,'SATISH',6822132983,'CHECKOUT STAFF','DEVILS COLONY');
INSERT INTO STAFF VALUES(333332333,'NEDD STARK',6823131983,'ASSOCIATE LIBRARIAN','CHIMPU COLONY');




