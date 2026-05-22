/**
 * Übungen zur Lektion 2: Aggregatfunktionen mit der cia-Datenbank
 * https://sql-tutorial.de/home/uebungen.php?lektion=2
 */

/* 1. Wie viele Länder enthält die cia-Datenbank? */
SELECT COUNT(Name) as Länderanzahl
FROM cia;

/* 2. Ermittle die Weltbevölkerung. */
SELECT SUM(Einwohner) as Weltbevölkerung
FROM cia;

/* 3. Gib das Durchschnitts-Bruttoinlandsprodukt an. */
SELECT AVG(BIP) as Durchschnitt_BIP
FROM cia;

/* 4. Wie groß sind Bevölkerung und Bruttoinlandsprodukt für ganz Europa? */
SELECT SUM(Einwohner) as Gesamtbevölkerung, SUM(BIP) as Gesamt_BIP
FROM cia
WHERE Region = 'Europa';

/* 5. Ermittle die Flächen des kleinsten und größten Landes. */
SELECT Name, Fläche
FROM cia
WHERE Fläche = (SELECT MIN(Fläche) FROM cia);

SELECT Name, Fläche
FROM cia
WHERE Fläche = (SELECT MAX(Fläche) FROM cia);

/* 6. Wie viele Regionen gibt es? */
SELECT COUNT(*) AS Regionenanzahl
FROM (SELECT DISTINCT Region FROM cia) AS _;