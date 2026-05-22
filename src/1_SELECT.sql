/**
 * Übungen zur Lektion 1: SELECT-Anweisungen mit der cia-Datenbank
 * https://sql-tutorial.de/home/uebungen.php?lektion=1
 */

/* 1. Gib alle Daten der Tabelle 'cia' aus. */
SELECT *
FROM cia;

/* 2. Gib die Namen aller Länder aus. */
SELECT Name
FROM cia;

/* 3. Gib alle Länder an, die mehr als 100 Millionen (1E08) Einwohner haben. */
SELECT Name
FROM cia
WHERE Einwohner > 1E08;

/* 4. Gib die Länder an, die ein Bruttosozialprodukt (BIP) zwischen 1 und 100 Milliarden haben und in Asien liegen. */
SELECT Name
FROM cia
WHERE BIP BETWEEN 1E09 AND 1E11 AND Region = 'Asien';

/* 5. Gib die Einwohnerzahlen für Frankreich, Deutschland und Polen aus. */
SELECT Einwohner
FROM cia
WHERE Name = 'Frankreich' OR Name = 'Deutschland' OR Name = 'Polen';

/* 6. Zeige Name und Einwohnerzahl in Millionen für die Länder Südamerikas. */
SELECT Name, Einwohner / 1E06 AS Einwohner_Million
FROM cia
WHERE Region = 'Südamerika';

/* 7. Gib die Namen und das pro Kopf-Jahreseinkommen der Länder mit mehr als 200 Millionen Einwohnern aus. */
SELECT Name, BIP / Einwohner AS Pro_Kopf_Jahreseinkommen
FROM cia
WHERE Einwohner > 2*1E08;

/* 8. Wie vorherige Aufgabe, allerdings sollen die Ergebnisse absteigend nach dem pro Kopf Jahreseinkommen sortiert werden. */
SELECT Name, BIP / Einwohner AS Pro_Kopf_Jahreseinkommen
FROM cia
WHERE Einwohner > 2*1E08
ORDER BY Pro_Kopf_Jahreseinkommen DESC;

/* 9. In welchen Ländernamen kommt das Wort 'Vereinigte' vor? */
SELECT Name
FROM cia
WHERE Name LIKE '%Vereinigte%';

/* 10. Lasse Dir in alphabetischer Reihenfolge alle verschiedenen Regionen anzeigen. */
SELECT Region
FROM cia
GROUP BY Region
ORDER BY Region;

/* 11. Zeige alle Länder, bei denen das Bruttoinlandsprodukt unbekannt ist. */
SELECT Name
FROM cia
WHERE BIP IS NULL;