/**
 * Übungen zur Lektion 3: Joins mit der Nordwind-Datenbank
 * https://sql-tutorial.de/home/uebungen.php?lektion=3
 */

/* 1. Zu welcher Kategorie gehören die 'Teatime Chocolate Biscuits'? */
SELECT a.Artikelname, a.KategorieNr AS KategorieNr
FROM Artikel a
JOIN Kategorie k ON a.KategorieNr = k.KategorieNr
WHERE a.Artikelname = 'Teatime Chocolate Biscuits';

/* 2. Erstelle eine Abfrage mit den Attributen ArtikelNr, Artikelname und Lieferantenfirma */
SELECT a.ArtikelNr, a.Artikelname AS Artikelname, l.Firma AS Lieferantenfirma
FROM Artikel a
JOIN Lieferant l ON a.LieferantenNr = l.LieferantenNr;

/* 3. Über welche Versandfirma wurde die Bestellung 10266 ausgeliefert? */
SELECT b.BestellNr AS Bestellung, vf.Firma AS Versandfirma
FROM Bestellung b
JOIN Versandfirma vf ON b.FirmenNr = vf.FirmenNr
WHERE b.BestellNr = 10266;

/* 4. Welcher Mitarbeiter ist für die Bestellung mit der Nummer 10266 zuständig? */
SELECT b.BestellNr AS Bestellung, p.Nachname AS Mitarbeiter
FROM Bestellung b
JOIN Personal p ON b.PersonalNr = p.PersonalNr
WHERE b.BestellNr = 10266;

/* 5. Erstelle eine Abfrage mit ArtikelNr, Artikelname, Lieferantenfirma und Kategorienname. */
SELECT a.ArtikelNr, a.Artikelname, l.Firma AS Lieferantenfirma, k.Kategoriename
FROM Artikel a
JOIN Lieferant l ON a.LieferantenNr = l.LieferantenNr
JOIN Kategorie k ON a.KategorieNr = k.KategorieNr;

/* 6. Gib die Artikelliste für die Bestellung 11031 mit Einzelpreis und Gesamtpreis aus, wobei sich der Gesamtpreis aus der Anzahl und dem Einzelpreis ergibt. */
SELECT a.Artikelname, bd.Einzelpreis, bd.Anzahl, ROUND(bd.Einzelpreis * bd.Anzahl, 2) AS Gesamtpreis
FROM Bestellung b
JOIN Bestelldetails bd ON b.BestellNr = bd.BestellNr
JOIN Artikel a ON bd.ArtikelNr = a.ArtikelNr
WHERE b.BestellNr = 11031;

/* 7. Für wie viele Kunden hat der Mitarbeiter Buchanan schon Bestellungen abgewickelt? */
SELECT p.Nachname AS Mitarbeiter, COUNT(k.KundenCode) AS Kundenanzahl
FROM Bestellung b
JOIN Personal p ON b.PersonalNr = p.PersonalNr
JOIN Kunde k ON b.KundenCode = k.KundenCode
WHERE p.Nachname = 'Buchanan';

/* 8. Sind alle Artikel der Bestellung der Rattlesnake Canyon Grocery vom 1998-05-06 in ausreichender Anzahl auf Lager? */
SELECT b.BestellNr, CASE 
    WHEN MIN(a.Lagerbestand - d.Anzahl) >= 0 THEN 'JA'
    ELSE 'NEIN'
END AS Ausreichend_im_Lager FROM Kunde k
JOIN Bestellung b ON b.KundenCode = k.KundenCode
JOIN Bestellposition bp ON bp.BestellNr = b.BestellNr
JOIN Artikel a ON a.ArtikelNr = d.ArtikelNr
WHERE k.Firma = 'Rattlesnake Canyon Grocery' AND b.Bestelldatum = '1998-05-06'
GROUP BY b.BestellNr;

/* 9. Welche Artikel hat der Kunde 'Richter Supermarkt' schon bestellt? */
SELECT k.Firma AS Kunde, a.Artikelname
FROM Bestellung b
JOIN Kunde k ON k.KundenCode = b.KundenCode
JOIN Bestelldetails bd ON bd.BestellNr = b.BestellNr
JOIN Artikel a ON a.ArtikelNr = bd.ArtikelNr
WHERE k.Firma = 'Richter Supermarkt';

/* 10. Welche Kunden haben schon Artikel der Firma 'Escargots Nouveaux' gekauft?  */
SELECT k.Firma AS Kunde, l.Firma AS Lieferant
FROM Bestellung b
JOIN Kunde k ON k.KundenCode = b.KundenCode
JOIN Bestelldetails bd ON bd.BestellNr = b.BestellNr
JOIN Artikel a ON a.ArtikelNr = bd.ArtikelNr
JOIN Lieferant l ON l.LieferantenNr = a.LieferantenNr
WHERE l.Firma = 'Escargots Nouveaux';