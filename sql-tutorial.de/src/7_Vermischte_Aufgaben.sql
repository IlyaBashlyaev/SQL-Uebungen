/**
 * Übungen zur Lektion 7: Vermischtes zur Nordwind-Datenbank
 * https://sql-tutorial.de/home/uebungen.php?lektion=7
 */

/* 1. Zeige alle Artikel, deren Einzelpreis mindestens 50 beträgt. */
SELECT Artikelname
FROM Artikel
WHERE Einzelpreis >= 50;

/* 2. Wie viele Bestellungen gab es im Jahr 1996? */
SELECT COUNT(*) AS Bestellungsanzahl
FROM Bestellung
WHERE YEAR(Bestelldatum) = 1996;

/* 3. Welche Artikel müssen nachbestellt werden? */
SELECT a.Artikelname
FROM Artikel a
WHERE a.Lagerbestand + a.BestellteEinheiten < a.Mindestbestand;

/* 4. Berechne den Gesamtumsatz für das Jahr 1997. Der Rabatt soll berücksichtigt werden. */
SELECT SUM(bd.Einzelpreis * bd.Anzahl * (1 - bd.Rabatt)) AS Umsatz
FROM Bestelldetails bd
JOIN Bestellung b ON b.BestellNr = bd.BestellNr
WHERE YEAR(b.Bestelldatum) = 1997;

/* 5. Wie Aufgabe 4, nur soll jetzt eine Liste mit allen Jahresumsätzen erstellt werden. */
SELECT YEAR(b.Bestelldatum) AS Jahr, SUM(bd.Einzelpreis * bd.Anzahl * (1 - bd.Rabatt)) AS Umsatz
FROM Bestelldetails bd
JOIN Bestellung b ON b.BestellNr = bd.BestellNr
GROUP BY YEAR(b.Bestelldatum);

/* 6. Welche Produktkategorien werden von der Firma 'Eastern Connection' geordert? Gib eine sortierte Liste aus. */
SELECT ka.Kategoriename
FROM Kunde ku
JOIN Bestellung b ON b.KundenCode = ku.KundenCode
JOIN Bestelldetails bd ON bd.BestellNr = b.BestellNr
JOIN Artikel a ON a.ArtikelNr = bd.ArtikelNr
JOIN Kategorie ka ON ka.KategorieNr = a.KategorieNr
WHERE ku.Firma = 'Eastern Connection'
GROUP BY ka.Kategoriename
ORDER BY ka.Kategoriename;

/* 7. Erstelle eine Liste mit den 20 Artikeln, die am häufigsten verkauft wurden. */
SELECT a.Artikelname
FROM Artikel a
JOIN Bestelldetails bd ON bd.ArtikelNr = a.ArtikelNr
JOIN Bestellung b ON b.BestellNr = bd.BestellNr
GROUP BY a.Artikelname
ORDER BY SUM(bd.Anzahl) DESC
LIMIT 20;

/* 8. Erstelle eine sortierte Liste der Bestellungen mit Kundenfirma, BestellNr und Rechnungssumme. Zur Rechungssumme gehören auch die Frachtkosten. */
SELECT b.BestellNr, k.Firma, SUM(bd.Einzelpreis * bd.Anzahl * (1 - bd.Rabatt)) + b.Frachtkosten AS Rechnungssumme
FROM Bestellung b
JOIN Kunde k ON k.KundenCode = b.KundenCode
JOIN Bestelldetails bd ON bd.BestellNr = b.BestellNr
GROUP BY b.BestellNr, k.Firma, b.Frachtkosten
ORDER BY b.BestellNr;

/* 9. Ermittle für das Jahr 1997 den Umsatz in den Kategorien Getränke, Gewürze und Getreideprodukte. */
SELECT SUM(bd.Einzelpreis * bd.Anzahl * (1 - bd.Rabatt)) AS Umsatz
FROM Bestellung b
JOIN Bestelldetails bd ON bd.BestellNr = b.BestellNr
JOIN Artikel a ON a.ArtikelNr = bd.ArtikelNr
JOIN Kategorie k ON k.KategorieNr = a.KategorieNr
WHERE YEAR(b.Bestelldatum) = 1997
AND k.Kategoriename IN ('Getränke', 'Gewürze', 'Getreideprodukte');

/* 10. Der Lieferant 'Exotic Liquids' möchte eine Werbe-Aktion für sein Getränkesortiment machen. Erstelle für ihn eine Liste der Kunden, die schon Getränke seiner Firma mit einem Mindestumsatz von 1000 bestellt haben. */
SELECT k.Firma
FROM Kunde k
JOIN Bestellung b ON b.KundenCode = k.KundenCode
JOIN Bestelldetails bd ON bd.BestellNr = b.BestellNr
JOIN Artikel a ON a.ArtikelNr = bd.ArtikelNr
JOIN Lieferant l ON l.LieferantenNr = a.LieferantenNr
WHERE l.Firma = 'Exotic Liquids'
GROUP BY k.Firma
HAVING SUM(bd.Einzelpreis * bd.Anzahl * (1 - bd.Rabatt)) >= 1000
ORDER BY k.Firma;