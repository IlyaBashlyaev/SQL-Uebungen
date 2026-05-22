/**
 * Übungen zur Lektion 4: Gruppierung mit der cia- und WMTitel-Datenbank
 * https://sql-tutorial.de/home/uebungen.php?lektion=4
 */

/* 1. Zeige von jeder Region den Namen und die Anzahl der Länder an. */
SELECT Region, COUNT(*) AS Länderanzahl
FROM cia
GROUP BY Region;

/* 2. Zeige für alle Regionen den Namen und die Anzahl der Länder mit mehr als 10 Millionen Einwohnern an. */
SELECT Region, COUNT(*) AS Länderanzahl
FROM cia
WHERE Einwohner > 1E07
GROUP BY Region;

/* 3. Welche Regionen haben eine Gesamtbevölkerung von mindestens 100 Millionen? */
SELECT Region, SUM(Einwohner) AS Gesamtbevölkerung
FROM cia
GROUP BY Region
HAVING Gesamtbevölkerung >= 1E08;

/* 4. Stelle die Regionen der Erde mit Einwohnerzahl und Gesamtfläche dar, geordnet nach der Einwohnerzahl. */
SELECT Region, SUM(Einwohner) AS Einwohnerzahl, SUM(Fläche) AS Gesamtfläche
FROM cia
GROUP BY Region
ORDER BY Einwohnerzahl DESC;

/* 5. Wie Aufgabe 4 aber nur die Regionen von Amerika. */
SELECT Region, SUM(Einwohner) AS Einwohnerzahl, SUM(Fläche) AS Gesamtfläche
FROM cia
WHERE Region LIKE '%Amerika%'
GROUP BY Region
ORDER BY Einwohnerzahl DESC;

/* 6. Ermittle die von jedem Weltmeister erreichte Gesamtzahl von WM-Punkten und stelle dAS Ergebnis nach WM-Punkten geordnet dar. */
SELECT Fahrerweltmeister, SUM(WM_Punkte) AS WM_Gesamtpunktzahl
FROM WMTitel
GROUP BY Fahrerweltmeister
ORDER BY WM_Gesamtpunktzahl DESC;

/* 7. Welche Gesamtpunktzahlen der Konstrukteursweltmeisterschaft haben die Teams in den neunziger Jahren erreicht? */
SELECT KonstrukteursWM, SUM(Team_Punkte) AS Team_Gesamtpunktzahl
FROM WMTitel
WHERE Saison BETWEEN 1990 AND 1999
GROUP BY KonstrukteursWM;

/* 8. Wie vorherige Aufgabe, allerdings sollen nur Teams mit mindestens 200 Punkten ausgegeben werden. */
SELECT KonstrukteursWM, SUM(Team_Punkte) AS Team_Gesamtpunktzahl
FROM WMTitel
WHERE Saison BETWEEN 1990 AND 1999
GROUP BY KonstrukteursWM
HAVING Team_Gesamtpunktzahl >= 200;

/* 9. Ermittle für die Jahre, in denen Michael Schumacher Weltmeister wurde, die durchschnittliche Zahl der erreichten Team-Punkte des Konstrukteursweltmeisters und stelle die Liste geordnet dar. */
SELECT Saison, AVG(Team_Punkte) AS Team_Durchschnittspunktzahl
FROM WMTitel
WHERE Fahrerweltmeister = 'Michael Schumacher'
GROUP BY Saison
ORDER BY Saison;

/* 10. 
Ermittle ab 1995 in geordneter Reihenfolge die Gesamtzahl der Team-Punkte für Teams mit mindestens 200 Punkten. */
SELECT KonstrukteursWM, SUM(Team_Punkte) AS Team_Gesamtpunktzahl
FROM WMTitel
WHERE Saison >= 1995 AND Team_Punkte >= 200
GROUP BY KonstrukteursWM
ORDER BY Team_Gesamtpunktzahl;