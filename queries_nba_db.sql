/* Name: Guillem Escriba Molto (NIA: 242123) */
/* Name: Clàudia Quera Madrenas (NIA: 231197) */

/*1. Create a report with all the players who aren’t born in the US. Include their complete
personal information.*/
SELECT *	/*returns all the fields of the table person*/
FROM person
WHERE person.nationality <> 'united states';

/*2. Is there any Franchise sharing its Arena with other Franchise? Try to find their details:
Name, City, Budget and Arena name.*/

SELECT f.franchise_name, f.city, f.budget, f.arena_name
FROM franchises f
GROUP BY arena_name
HAVING count(*)>1;	/*selects the arenas that appear more than once (and so, are shared among several teams)*/

/*3. Show a report with name, surname, and birthdate of all the head coaches who have a
victory percentage bigger than 30%. Sort the result by victory percentage descending.*/

SELECT p.name, p.surname, p.age
FROM person p
JOIN headcoaches hc
ON p.id = hc.id
WHERE hc.victory_percentage > 30;
/*4. We want to know how many franchises teams are there for each conference. Show all
the data related to conference plus a new field with the count.*/

SELECT count(*), c.*
FROM franchises f
JOIN conferences c
ON f.conference_name = c.conference_name 
GROUP BY conference_name
HAVING count(*) > 0;

/*5. Knowing that many players have been drafted at some point, return all the players that
have been drafted on 2019. Include IDCard, Name, Surname, Nationality, Draft Year, the
Franchise Name that have drafted the player and the position on the draft.*/

SELECT d.player_id, p.name, p.surname, p.nationality, d.year, d.franchise_name, d.drafted_rank
FROM drafted d
JOIN person p
ON d.player_id = p.id
WHERE d.year = 2019;

/*6. Choose a franchise of your taste and select the name, surname and PRODebutYear of all
the players who have been defending your team’s jersey at some point.*/

SELECT p.name, p.surname, pl.PRO_year
FROM franchise_players fp
	JOIN players pl
		ON fp.player_id = pl.id
	JOIN person p
		ON fp.player_id = p.id
WHERE fp.franchise_name = 'Chicago Bulls';

/*7. Find all the players who have been playing with its national team at certain point. Show
the Name, Surname of the player and the Country they player for.*/

SELECT p.name, p.surname, ntp.country
FROM national_team_players ntp
JOIN person p
ON ntp.player_id = p.id;

/*8. Find all the assistant coach bosses. Those are the ones who do not have any informed
boss. Return all their personal information plus the speciality.*/

SELECT p.*, ac.speciality
FROM assistant_coaches ac
JOIN person p
ON ac.id = p.id
WHERE ac.boss_id = '\N';

/*9. Is there any repeated person (same name and surname with a different IDCard)?*/

SELECT p.id, p.name, p.surname
FROM person p,
(select name, surname from person group by name, surname having count(*) > 1) p1
WHERE p.name = p1.name AND p.surname = p1.surname;

/*10. Find the head coaches who is or have been training a franchise team and a national
team at the same time.*/

SELECT p.id, p.name, p.surname
FROM person p
	JOIN national_teams nt
		ON p.id = nt.hcoach_id
	JOIN franchises f
		ON p.id = f.hcoach_id;

/*11. Due to the financial crisis, the states have approved a new tax to professional players.
Deliver a report with the name and surname of every player born in the U.S., their salary
and their new salary reduced by 12%*/

SELECT p.name, p.surname, fp.salary, (0.88*fp.salary) as reduced_salary
FROM franchise_players fp
JOIN person p
ON fp.player_id = p.id
WHERE p.nationality = 'united states';

/*12. For all rookie players (those who turned PRO in the last 2 years or less) that we do not
have their University of Origin or they never played for their national team, return their
personal data.*/

SELECT p.*
FROM person p
	JOIN players pl
		ON p.id = pl.id
	LEFT JOIN national_team_players ntp
		ON p.id = ntp.player_id
	WHERE ntp.player_id = NULL 		/*we select all rows from table1 and for each row we attempt 
									to find a row in table2 with the same value for the name column. 
									If there is no such row, we just leave the table2 portion of our result empty for that row. 
									Then we constrain our selection by picking only those rows in the result where the matching 
                                    row does not exist.*/
    
    AND pl.PRO_year>2020 AND pl.university='\N';

/*13. Fill the column NBARings of the Franchise table. This field can be calculated via
Franchise_Season table and its IsWinner column. Use an UPDATE statement.*/


    

