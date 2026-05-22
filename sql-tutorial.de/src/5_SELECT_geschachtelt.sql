/**
 * Übungen zur Lektion 5: Geschachtelte SELECT-Anweisungen mit der cia-Datenbank
 * https://sql-tutorial.de/home/uebungen.php?lektion=5
 */

/* 1. Welche Länder haben mehr Einwohner als das bevölkerungsreichste Land Südamerikas? */
SELECT Name
FROM cia
WHERE Einwohner > (
    SELECT MAX(Einwohner)
    FROM cia
    WHERE Region = 'Südamerika'
);

/* 2. Welche Länder haben eine größere Bevölkerung als Europa? */
SELECT Name
FROM cia
WHERE Einwohner > (
    SELECT SUM(Einwohner)
    FROM cia
    WHERE Region = 'Europa'
);

/* 3. Zeige die Länder Europas, die ein größeres pro Kopf Bruttoinlandsprodukt als Groß-Britannien haben. */
SELECT Name
FROM cia
WHERE Region = 'Europa'
AND BIP / Einwohner > (
    SELECT BIP / Einwohner
    FROM cia
    WHERE Name = 'Groß-Britannien'
);

/* 4. Zeige die Daten der Ländern an, die den selben Regionen wie Armenien und Iran angehören. */
SELECT *
FROM cia
WHERE Region IN (
    SELECT Region
    FROM cia
    WHERE Name IN ('Armenien', 'Iran')
);

/* 5. Welche Länder Südostasiens haben eine überdurchschnittliche Bevölkerungsdichte (Einwohner pro Fläche)? */
SELECT Name
FROM cia
WHERE Region = 'Südostasien'
AND Einwohner / Fläche > (
    SELECT AVG(Einwohner / Fläche)
    FROM cia
    WHERE Region = 'Südostasien'
);

/* 6. Welche Länder haben eine Einwohnerzahl die größer als die von Kenia und kleiner als die von Kanada ist? */
SELECT Name
FROM cia
WHERE Einwohner > (
    SELECT Einwohner
    FROM cia
    WHERE Name = 'Kenia'
) AND Einwohner < (
    SELECT Einwohner
    FROM cia
    WHERE Name = 'Kanada'
);