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
  pid            int not null,
  haircolor      text,
  eyecolor       text,
  height_inches  int,
  weight	     int,
  favcolor       text,
  sgdavDate    	 date,
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
  pid            int not null references people(pid),
  filmschool     text,
  dganvdate      date,
  favlmaker      text,
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
pid				char(10) not null,
MPAA_num		char(10) references movies(MPAA_num),
primary key(pid, MPAA_num)
);

CREATE TABLE directorof(
pid 			char(10) not null,
MPAA_num		char(10) not null refences movies(MPAA_num),
primary key(pid,MPAA_num)
);

-- Functional Depencencies --

--Actors

-- aid->pid, haircolor, eyecolor, height_inches, weight,favcolor, sgdavDate

--People

-- pid->fname,lname, address, birthday, spouse_fname, spouse_lname


-- Directors
--pid> filmschool, dganvdate, favlmaker

--Movies
-- Mpaa_num->name, yearreleased, domboxoffice_usd, forboxoffice_usd, dvdsales_usd

--appearsin
--pid, Mpaa_num ->

--directorof
--pid, mpaa_num -->


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










