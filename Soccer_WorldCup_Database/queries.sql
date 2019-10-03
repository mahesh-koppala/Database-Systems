DROP TABLE COUNTRY CASCADE CONSTRAINTS;

DROP TABLE PLAYERS CASCADE CONSTRAINTS;

DROP TABLE MATCH_RESULTS CASCADE CONSTRAINTS;

DROP TABLE PLAYER_CARDS CASCADE CONSTRAINTS;

DROP TABLE PLAYER_ASSISTS_GOALS CASCADE CONSTRAINTS;

CREATE TABLE COUNTRY(
Country_Name varchar(20), Population decimal(10,2), No_of_Worldcup_won NUMBER, Manager varchar(20), CONSTRAINT COUNTRY_PK PRIMARY KEY(Country_Name)
);

CREATE TABLE PLAYERS(Player_id Number, Name varchar(40), Fname varchar(20), Lname varchar(35), DOB varchar(35), Country varchar(20), Height Number, Club varchar(30), Position varchar(10), Caps_for_Country Number, IS_CAPTAIN varchar(5), CONSTRAINT PLAYERS_PK PRIMARY KEY(Player_id), FOREIGN KEY(Country) REFERENCES COUNTRY(Country_Name));

CREATE TABLE MATCH_RESULTS(
Match_id Number, Date_of_Match varchar(35), Start_Time_of_Match varchar(35), 
Team1 varchar(25), Team2 varchar(25), Team1_Score Number, Team2_Score Number, Stadium_Name varchar(35),Host_City varchar(20), CONSTRAINT MATCH_RESULTS_PK PRIMARY KEY(Match_id), CONSTRAINT MATCH_RESULTS_FK FOREIGN KEY(Team1) REFERENCES COUNTRY(Country_Name), FOREIGN KEY(Team2) REFERENCES COUNTRY(Country_Name)
);


CREATE TABLE PLAYER_CARDS(
Player_id Number, Yellow_Cards Number, Red_Cards Number, CONSTRAINT PLAYER_CARDS_PK PRIMARY KEY(Player_id), CONSTRAINT PLAYER_CARDS_FK FOREIGN KEY(Player_id) REFERENCES PLAYERS(Player_id)
);

CREATE TABLE PLAYER_ASSISTS_GOALS(
Player_id Number,
No_of_Matches Number,
Goals Number,
Assists Number,
Minutes_Played Number,
CONSTRAINT PLAYER_ASSISTS_GOALS_PK PRIMARY KEY(Player_id), CONSTRAINT PLAYER_ASSISTS_GOALS_FK FOREIGN KEY(Player_id) REFERENCES PLAYERS(Player_id)
);

3.1 select Name,Club,Country from Players where country='USA' and Position='Midfielder';
3.2 select Name,Country,Club,(months_between(sysdate,DOB)/12) as AGE FROM PLAYERS WHERE IS_CAPTAIN='TRUE';
3.3 select Country_Name FROM COUNTRY WHERE (No_of_Worldcup_won)>2;
3.4 select Country_Name FROM COUNTRY WHERE (No_of_Worldcup_won)=0;
3.5 select PLAYERS.Name,PLAYERS.Country FROM PLAYERS,PLAYER_CARDS WHERE PLAYERS.Player_id=PLAYER_CARDS.Player_id AND Yellow_cards=0 AND PLAYER_CARDS.Red_cards=0;
3.6 select PLAYERS.Name,PLAYERS.Country FROM PLAYERS,PLAYER_CARDS WHERE PLAYERS.Player_id=PLAYER_CARDS.Player_id AND Red_Cards = (select MAX(Red_Cards) FROM PLAYER_CARDS);
3.7 select Host_City,count(*) as total FROM MATCH_RESULTS GROUP BY Host_City;
3.8 select Host_City FROM MATCH_RESULTS GROUP BY Host_City HAVING count(*) = (select MAX(count(*))  FROM MATCH_RESULTS GROUP BY Host_City);
3.9 select Country_Name,count(*) as number_of_games,sum(Team1_Score) as total_goals_scored,sum(Team2_Score) as total_goals_against from COUNTRY,MATCH_RESULTS where country_name = Team1 GROUP BY Country_Name;
3.10 select Country_Name,count(*) as number_of_games,sum(Team2_Score) as total_goals_scored, sum(Team1_Score) as total_goals_against from COUNTRY,MATCH_RESULTS where country_name = Team2 GROUP BY Country_Name;
3.11 CREATE VIEW TEAM_SUMMARY AS select q1.Team1 as CountryName, sum(q1_match_count + q2_match_count) as NoOfGames, sum(q1_t1_team_score + q2_t2_team_score) as TotalGoalsFor, sum(q1_t2_team_score + q2_t1_team_score) as TotalGoalsAgainst from ((select m.Team1, count(m.Match_id) as q1_match_count, sum(m.Team1_Score) as q1_t1_team_score, sum(m.Team2_Score) as q1_t2_team_score from MATCH_RESULTS m  join COUNTRY c on m.Team1 = c.Country_Name group by m.Team1) q1 join (select m.Team2, count(m.Match_id) as q2_match_count, sum(m.Team2_Score) as q2_t2_team_score, sum(m.Team1_Score) as q2_t1_team_score from MATCH_RESULTS m join Country c on m.Team1 = c.Country_Name group by m.Team2) q2 on q1.Team1 = q2.Team2) group by q1.Team1;
3.12 select Date_of_Match, Team1, Team2, CASE
    WHEN Team1_Score > Team2_Score THEN Team1
    WHEN Team2_Score > Team1_Score THEN Team2
	END AS Winner, ABS(Team1_Score-Team2_Score) as GD from MATCH_RESULTS; 
3.13 select DISTINCT(Match_id) from MATCH_RESULTS,COUNTRY where team1='Brazil' or team2 = 'Brazil';
3.14 select PLAYERS.Name,PLAYER_ASSISTS_GOALS.Goals,PLAYERS.Country from PLAYERS,PLAYER_ASSISTS_GOALS where PLAYERS.Player_id=PLAYER_ASSISTS_GOALS.Player_id and PLAYER_ASSISTS_GOALS.Goals > 0 ORDER BY PLAYER_ASSISTS_GOALS.Goals DESC;
3.15 select PLAYERS.Name,PLAYER_ASSISTS_GOALS.Goals,PLAYERS.Country from PLAYERS,PLAYER_ASSISTS_GOALS where PLAYERS.Player_id=PLAYER_ASSISTS_GOALS.Player_id and PLAYER_ASSISTS_GOALS.Goals > 2 ORDER BY PLAYER_ASSISTS_GOALS.Goals DESC;
3.16 select Country_Name,Population from country order by Population DESC;


4) insert operation : (violating constraints)
		a) domain constraint 			: INSERT INTO COUNTRY VALUES('INDIA','TEN MILLION',3,'MAHESH Koppala');	// population is of the type decimal, so when ten million is entered, we get an error.
		b) key constraint    			: INSERT INTO COUNTRY VALUES('Australia',96325.14,4,'John Smith');		// country_name is a primary key and Australia already exists, when we try to insert a record with the country name Australia(same value as that of primary key), an error occurs.
		c) Referential constraint 		: INSERT INTO PLAYER_CARDS VALUES('376545',1,2);		// player id is a foreign key for match_results table and a player id value is inserted in match_results table which not even exists in the players_table.
		d) entity integrity constraint	: INSERT INTO COUNTRY VALUES(NULL,96325.98,'RAJ KIRAN');	// country name is a primary key in the table and it should not be null.
		
5)	delete operation :
		a) referential constraint : DELETE FROM PLAYERS WHERE Player_id = 354875;		// player_id cant be deleted because it is a primary key in players table and it has to be deleted first in players table.
	
6)	insert operation : 	( not violating constraints)
		a) domain 						:  INSERT INTO COUNTRY VALUES('INDIA',12365.32,3,'MAHESH Koppala');		// correct format for population is entered
		b) key 	  						:  INSERT INTO COUNTRY VALUES('libya',96325.14,4,'John Smith');			// libya is entered as the country name(primary key) which does not exist previously in the database
		c) entity integrity constraint  :  INSERT INTO COUNTRY VALUES('PAK',96325.21,2,'RAHUL KANE');		// PAK - a primary key value(country_name) is inserted which is not a null value.