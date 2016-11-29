CREATE TABLE authors
  (
  au_id    CHAR(3)     NOT NULL,
  au_fname VARCHAR(15) NOT NULL,
  au_lname VARCHAR(15) NOT NULL,
  phone    VARCHAR(12)         ,
  address  VARCHAR(20)         ,
  city     VARCHAR(15)         ,
  state    CHAR(2)             ,
  zip      CHAR(5)             ,
  CONSTRAINT pk_authors PRIMARY KEY (au_id)
  );


CREATE TABLE publishers
  (
  pub_id   CHAR(3)     NOT NULL,
  pub_name VARCHAR(20) NOT NULL,
  city     VARCHAR(15) NOT NULL,
  state    CHAR(2)             ,
  country  VARCHAR(15) NOT NULL,
  CONSTRAINT pk_publishers PRIMARY KEY (pub_id)
  );


CREATE TABLE titles
  (
  title_id   CHAR(3)      NOT NULL,
  title_name VARCHAR(40)  NOT NULL,
  type       VARCHAR(10)          ,
  pub_id     CHAR(3)      NOT NULL,
  pages      INTEGER              ,
  price      DECIMAL(5,2)         ,
  sales      INTEGER              ,
  pubdate    DATE                 ,
  contract   SMALLINT     NOT NULL,
  CONSTRAINT pk_titles PRIMARY KEY (title_id)
  );


CREATE TABLE title_authors
  (
  title_id      CHAR(3)      NOT NULL,
  au_id         CHAR(3)      NOT NULL,
  au_order      SMALLINT     NOT NULL,
  royalty_share DECIMAL(5,2) NOT NULL,
  CONSTRAINT pk_title_authors PRIMARY KEY (title_id, au_id)
  );


CREATE TABLE royalties
  (
  title_id     CHAR(3)      NOT NULL,
  advance      DECIMAL(9,2)         ,
  royalty_rate DECIMAL(5,2)         ,
  CONSTRAINT pk_royalties PRIMARY KEY (title_id)
  );
  
ALTER TABLE titles
          ADD CONSTRAINT titles_publishers_fk
          FOREIGN KEY (pub_id)
          REFERENCES publishers (pub_id);


ALTER TABLE title_authors
          ADD CONSTRAINT title_authors_titles_fk
          FOREIGN KEY (title_id)
          REFERENCES titles (title_id);


ALTER TABLE title_authors
          ADD CONSTRAINT title_authors_authors_fk
          FOREIGN KEY (au_id)
          REFERENCES authors (au_id);
          
ALTER TABLE royalties
          ADD CONSTRAINT royalties_titles_fk
          FOREIGN KEY (title_id)
          REFERENCES titles (title_id);


INSERT INTO authors VALUES('A01','Sarah','Buchman','718-496-7223',
  '75 West 205 St','Bronx','NY','10468');
INSERT INTO authors VALUES('A02','Wendy','Heydemark','303-986-7020',
  '2922 Baseline Rd','Boulder','CO','80303');
INSERT INTO authors VALUES('A03','Hallie','Hull','415-549-4278',
  '3800 Waldo Ave, #14F','San Francisco','CA','94123');
INSERT INTO authors VALUES('A04','Klee','Hull','415-549-4278',
  '3800 Waldo Ave, #14F','San Francisco','CA','94123');
INSERT INTO authors VALUES('A05','Christian','Kells','212-771-4680',
  '114 Horatio St','New York','NY','10014');
INSERT INTO authors VALUES('A06','','Kellsey','650-836-7128',
  '390 Serra Mall','Palo Alto','CA','94305');
INSERT INTO authors VALUES('A07','Paddy','O''Furniture','941-925-0752',
  '1442 Main St','Sarasota','FL','34236');


INSERT INTO publishers VALUES('P01','Abatis Publishers','New York','NY','USA');
INSERT INTO publishers VALUES('P02','Core Dump Books','San Francisco','CA','USA');
INSERT INTO publishers VALUES('P03','Schadenfreude Press','Hamburg',NULL,'Germany');
INSERT INTO publishers VALUES('P04','Tenterhooks Press','Berkeley','CA','USA');


INSERT INTO titles VALUES('T01','1977!','history','P01',
  107,21.99,566,'2014-08-01',1);
INSERT INTO titles VALUES('T02','200 Years of German Humor','history','P03',
  14,19.95,9566,'2012-04-01',1);
INSERT INTO titles VALUES('T03','Ask Your System Administrator','computer','P02',
  1226,39.95,25667,'2014-09-01',1);
INSERT INTO titles VALUES('T04','But I Did It Unconsciously','psychology','P04',
  510,12.99,13001,'2013-05-31',1);
INSERT INTO titles VALUES('T05','Exchange of Platitudes','psychology','P04',
  201,6.95,201440,'2015-01-01',1);
INSERT INTO titles VALUES('T06','How About Never?','biography','P01',
  473,19.95,11320,'2014-07-31',1);
INSERT INTO titles VALUES('T07','I Blame My Mother','biography','P03',
  333,23.95,1500200,'2013-10-01',1);
INSERT INTO titles VALUES('T08','Just Wait Until After School','children','P04',
  86,10.00,4095,'2015-06-01',1);
INSERT INTO titles VALUES('T09','Kiss My Boo-Boo','children','P04',
  22,13.95,5000,'2016-05-31',1);
INSERT INTO titles VALUES('T10','Not Without My Faberge Egg','biography','P01',
  NULL,NULL,NULL,NULL,0);
INSERT INTO titles VALUES('T11','Perhaps It''s a Glandular Problem','psychology','P04',
  826,7.99,94123,'2014-11-30',1);
INSERT INTO titles VALUES('T12','Spontaneous, Not Annoying','biography','P01',
  507,12.99,100001,'2014-08-31',1);
INSERT INTO titles VALUES('T13','What Are The Civilian Applications?','history','P03',
  802,29.99,10467,'2013-05-31',1);


INSERT INTO title_authors VALUES('T01','A01',1,1.0);
INSERT INTO title_authors VALUES('T02','A01',1,1.0);
INSERT INTO title_authors VALUES('T03','A05',1,1.0);
INSERT INTO title_authors VALUES('T04','A03',1,0.6);
INSERT INTO title_authors VALUES('T04','A04',2,0.4);
INSERT INTO title_authors VALUES('T05','A04',1,1.0);
INSERT INTO title_authors VALUES('T06','A02',1,1.0);
INSERT INTO title_authors VALUES('T07','A02',1,0.5);
INSERT INTO title_authors VALUES('T07','A04',2,0.5);
INSERT INTO title_authors VALUES('T08','A06',1,1.0);
INSERT INTO title_authors VALUES('T09','A06',1,1.0);
INSERT INTO title_authors VALUES('T10','A02',1,1.0);
INSERT INTO title_authors VALUES('T11','A03',2,0.3);
INSERT INTO title_authors VALUES('T11','A04',3,0.3);
INSERT INTO title_authors VALUES('T11','A06',1,0.4);
INSERT INTO title_authors VALUES('T12','A02',1,1.0);
INSERT INTO title_authors VALUES('T13','A01',1,1.0);


INSERT INTO royalties VALUES('T01',10000,0.05);
INSERT INTO royalties VALUES('T02',1000,0.06);
INSERT INTO royalties VALUES('T03',15000,0.07);
INSERT INTO royalties VALUES('T04',20140,0.08);
INSERT INTO royalties VALUES('T05',100000,0.09);
INSERT INTO royalties VALUES('T06',20140,0.08);
INSERT INTO royalties VALUES('T07',1000000,0.11);
INSERT INTO royalties VALUES('T08',0,0.04);
INSERT INTO royalties VALUES('T09',0,0.05);
INSERT INTO royalties VALUES('T10',NULL,NULL);
INSERT INTO royalties VALUES('T11',100000,0.07);
INSERT INTO royalties VALUES('T12',50000,0.09);
INSERT INTO royalties VALUES('T13',20140,0.06);






/*1**************************************************************/
SELECT * from authors;


SELECT * from titles;


SELECT * from publishers;


SELECT * from title_authors;


SELECT * from royalties;


/*2***********************************************************/
SELECT au_lname FROM authors WHERE au_lname LIKE 'H%';


/*3**********************************************************/
SELECT title_name, type, price, pubdate FROM titles WHERE pubdate BETWEEN
 '2014-07-15' AND '2014-08-15';


/*4***********************************************************/
SELECT * FROM titles WHERE title_id = 'T01' OR title_id = 'T04' OR title_id = 'T07';
SELECT * FROM titles WHERE title_id IN ('T01','T04','T07');


/*5*************************************************************/
SELECT au_lname, au_fname, address, city, state FROM authors
ORDER BY state, city;


/*6*************************************************************/
SELECT title_name, price from titles where price > 20.00;


/*7**************************************************************/
SELECT title_name, pages FROM titles WHERE sales < 5000;


/*8****************************************************************/
SELECT title_name from titles natural join publishers
where pub_name = 'Core Dump Books';


/*9****************************************************************/
SELECT title_name from titles natural join publishers
where pub_name != 'Core Dump Books';


/*10****************************************************************/
SELECT distinct type from titles;


/*11******************************************************************/
select distinct pub_name from publishers natural join titles where month(pubdate) = 8 
AND year(pubdate) = 2014;


/*12*********************************************************************/
select distinct authors.AU_FNAME, authors.AU_LNAME from 
(authors inner join title_authors on authors.AU_ID = title_authors.AU_ID 
inner join titles on title_authors.TITLE_ID = titles.TITLE_ID inner join publishers 
on titles.PUB_ID = publishers.PUB_ID) where authors.state = publishers.state;


select distinct authors.AU_FNAME, authors.AU_LNAME from 
(authors inner join title_authors on authors.AU_ID = title_authors.AU_ID 
inner join titles on title_authors.TITLE_ID = titles.TITLE_ID inner join publishers 
on titles.PUB_ID = publishers.PUB_ID) where authors.state != publishers.state;


/*13********************************************************************/
select distinct authors.AU_FNAME, authors.AU_LNAME from 
(authors inner join title_authors on authors.AU_ID = title_authors.AU_ID 
inner join titles on title_authors.TITLE_ID = titles.TITLE_ID)
where titles.type = 'history';


/*14********************************************************************/
select pub_name from (publishers inner join titles on
publishers.PUB_ID = titles.PUB_ID) where title_name like 'E%';


/*15******************************************************************/
select titles.TITLE_NAME, authors.AU_FNAME, authors.AU_LNAME from
(authors inner join title_authors on authors.AU_ID = title_authors.AU_ID 
inner join titles on title_authors.TITLE_ID = titles.TITLE_ID inner join 
publishers on titles.PUB_ID = publishers.PUB_ID) where 
publishers.pub_name = 'Schadenfreude Press'; 


/*16******************************************************************/
select authors.AU_FNAME, authors.AU_LNAME, titles.TITLE_NAME,
sum(royalties.ADVANCE * ROYALTIES.ROYALTY_RATE) as total_paid FROM (authors 
inner join title_authors on authors.AU_ID = title_authors.AU_ID 
inner join titles on title_authors.TITLE_ID = titles.TITLE_ID 
inner join royalties on titles.TITLE_ID = royalties.TITLE_ID )
group by authors.AU_FNAME, authors.AU_LNAME, titles.TITLE_Name;


/*17*********************************************************************/
select publishers.PUB_NAME, count(titles.TITLE_NAME) as book_quantity from 
(publishers inner join titles on publishers.PUB_ID = titles.PUB_ID)
group by publishers.PUB_NAME; 


/*18********************************************************************/
select publishers.PUB_NAME, count(titles.TITLE_NAME) as book_quantity from 
(publishers inner join titles on publishers.PUB_ID = titles.PUB_ID)
group by publishers.PUB_NAME having count(titles.TITLE_NAME) > 2;


/*19*********************************************************************/
select max(ADVANCE) from royalties;


/*20**********************************************************************/
select avg(royalty_rate) from royalties;


/*21********************************************************************/
select titles.TITLE_NAME, royalties.ROYALTY_RATE * titles.PRICE * titles.SALES 
as total_royalties_book from (titles inner join royalties on titles.TITLE_ID =
royalties.TITLE_ID);


/*22******************************************************************/
select authors.AU_FNAME, authors.AU_LNAME, sum(royalties.ROYALTY_RATE*(royalties.ADVANCE +
(titles.price * titles.SALES))) as total_profit from ( authors 
left outer join title_authors on authors.AU_ID = title_authors.AU_ID 
left outer join titles on title_authors.TITLE_ID = titles.TITLE_ID 
left outer join royalties on titles.TITLE_ID = royalties.TITLE_ID)
group by authors.AU_FNAME, authors.AU_LNAME;


/*23********************************************************************/
select authors.state, count(authors.state) from authors
group by authors.state;


/*24********************************************************************/
select authors.AU_FNAME, authors.AU_LNAME, count(titles.TITLE_NAME) as total_books
from (authors 
left outer join (title_authors inner join titles 
on title_authors.TITLE_ID = titles.TITLE_ID) on authors.AU_ID = title_authors.AU_ID)
group by authors.AU_FNAME, authors.AU_LNAME
order by total_books DESC;





/*QUESTION 1*****************************************************************/
select titles.TITLE_NAME from (titles inner join publishers on titles.PUB_ID = 
publishers.PUB_ID) where publishers.pub_name != 'Schadenfreude Press';


/*QUESTION 2*****************************************************************/
SELECT distinct type from titles;

/*QUESTION 3******************************************************************/
select max(ADVANCE) from royalties;

/*QUESTION 4*****************************************************************/

select authors.AU_LNAME,authors.AU_FNAME, titles.TITLE_NAME from
(authors inner join title_authors on authors.AU_ID = title_authors.AU_ID
inner join titles on title_authors.TITLE_ID = titles.TITLE_ID) order by
authors.AU_LNAME,authors.AU_FNAME;

/*QUESTION 5*****************************************************************/
select publishers.PUB_NAME, count(titles.TITLE_NAME) as book_quantity from 
(publishers inner join titles on publishers.PUB_ID = titles.PUB_ID)
group by publishers.PUB_NAME having count(titles.TITLE_NAME) > 2;  



/*
ALTER TABLE titles
    DROP CONSTRAINT titles_publishers_fk;


ALTER TABLE title_authors
    DROP CONSTRAINT title_authors_titles_fk;


ALTER TABLE title_authors
    DROP CONSTRAINT title_authors_authors_fk;


ALTER TABLE royalties
    DROP CONSTRAINT royalties_titles_fk;


DROP TABLE authors;


DROP TABLE titles;


DROP TABLE publishers;


DROP TABLE title_authors;


DROP TABLE royalties;
*/


