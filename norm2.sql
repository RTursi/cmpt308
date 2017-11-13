-- Joe Tursi
-- Professor Labouseur
-- CMPT308
-- Normalization #2


drop table if exists actors;
drop table if exists people;
drop table if exists directors;
drop table if exists movies;
drop table if exists appearsin:
drop table if exists directorof;


-- Actors --
CREATE TABLE actors (
  pid            int not null references people(pid),
  aid            int not null,
  haircolor      text,
  eyecolor       text,
  height_inches  int,
  weight	     int,
  favcolor       text,
  sgdavDate    	 date,
 primary key(aid)
);    

-- People --
CREATE TABLE people (
  pid           int not null,
  birthday		date,
  fname         text,
  lname         text, 
  address        text,
  spouse_fname  text,
  spouse_lname  text,
 primary key(pid)
);

-- Directors --
CREATE TABLE directors (
  did            int not null,
  pid            int not null references people(pid),
  filmschool     text,
  dganvdate      date,
  favlmaker      text,
 primary key(did)
);

-- Movies -- 
CREATE TABLE movies (
  MPAA_num         char(10) not null,
  name             text,
  yearreleased     date,
  domboxoffice_usd int,
  forboxoffice_usd int,
  dvdsales_usd     int,
 primary key(MPAA_num)
);

CREATE TABLE appearsin(
aid				char(10) not null references actors(aid),
MPAA_num		char(10) references movies(MPAA_num),
primary key(aid, MPAA_num)
);

CREATE TABLE directorof(
did 			char(10) not null references directors(did),
MPAA_num		char(10) not null refences movies(MPAA_num),
primary key(did,MPAA_num)
);

-- Functional Depencencies --

--Actors

-- aid->pid, haircolor, eyecolor, height_inches, weight,favcolor, sgdavDate

--People

-- pid->fname,lname, address, birthday, spouse_fname, spouse_lname


-- Directors
-- did -> pid, filmschool, dganvdate, favlmaker

--Movies
-- Mpaa_num->name, yearreleased, domboxoffice_usd, forboxoffice_usd, dvdsales_usd

--appearsin
--aid, Mpaa_num ->

--directorof
--did, mpaa_num -->


-----

-- #4 THE QUERY OF DOOM.............. AKA ROGER MOORE QUERY aka 67% chance this successfully runs..xD   
select people
from people,movies, directors, directorof
where people.pid = directorof.did
and directors.did = directof.did in
(
	select movies.mid
	from actors, people, movies, appearsin
	where people.fname ="Roger"
	and people.lname = "Moore"
)










