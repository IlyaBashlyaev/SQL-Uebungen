/**
 * Übungen zur Lektion 6: DML - Data Manipulation Language mit der Datenbank Schule
 * https://sql-tutorial.de/home/uebungen.php?lektion=6
 */

/* 1. Lösche die Datensätze in der Tabelle schueler. */
DELETE FROM schueler;

/* 2. Füge deine Adressdaten in die schueler-Tabelle ein.
Die Daten sind öffentlich einsehbar. Verwende also nicht deine echte Adresse */
INSERT INTO schueler VALUES (
    1,
    'Mustermann',
    'Max',
    '2010-01-01',
    'Musterstraße 1',
    '12345',
    'Musterstadt'
);
INSERT INTO schueler VALUES (
    2,
    'Müller',
    'Heinz',
    '2010-01-01',
    'Musterstraße 2',
    '12345',
    'Musterstadt'
);

/* 3. Lasse Dir alle Kurse anzeigen. Belege dann einen Kurs.
Falls kein Kurs vorhanden ist, so füge einen Kurs in die Tabelle Kurse ein. */
INSERT INTO Kurs VALUES (
    1,
    'Mathe',
    'Analysis',
    'LK',
    'Q1.1',
    5
);
INSERT INTO Kurs VALUES (
    2,
    'Deut.',
    'Infromationstext',
    'GK',
    'Q1.1',
    2
);

/* 4. Setze die Stundenzahlen der 2-stündigen Kurse auf 3 Stunden. */
UPDATE Kurs
SET Stunden = 3
WHERE Stunden = 2;

/* 5. Erniedrige in allen Deutsch-Kursen die Stundenzahl um 1 Stunde. */
UPDATE Kurs
SET Stunden = Stunden - 1
WHERE Fach = 'Deut.';

/* 6. Lösche alle Kursbelegungen von Heinz Müller mit weniger als 5 Punkten. */
INSERT INTO belegt VALUES (
    2,
    1,
    4
);
DELETE FROM belegt
WHERE SNr = (
    SELECT SNr
    FROM schueler
    WHERE Vorname = 'Heinz'
    AND Nachname = 'Müller'
);