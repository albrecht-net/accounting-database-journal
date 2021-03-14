# Changelog (accounting database journal)
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## v1.11.0 (2021.03.14)
### Changed
- Die Ansicht "viewEntries" wird nun neu nach dem 1. Buchungsdatum (date) und 2. Erstelldatum (created) absteigend sortiert.
- Der Ansicht "viewJournal" wurden folgende Felder hinzugefügt oder angepasst: Empfänger ID (recipientID), Periode ID (periodID), Klassifikation 1 ID (classification1ID), Klassifikation 2 ID (classification2ID), Klassifikation 3 ID (classification3ID).
- Die Ansicht "viewJournal" wird nun neu nach dem 1. Buchungsdatum (date) und 2. Erstelldatum (created) absteigend sortiert.

---

## v1.10.0 (2019.11.06)
### Changed
- Der Ansicht "viewEntries" wurden folgende Felder hinzugefügt oder angepasst: Erstelldatum (created), Rechnungsnummer (invoiceNo), Periode ID (periodID), Periode Bezeichnung (period), Klassifikation 1 ID (classification1ID), Klassifikation 1 Bezeichnung (classification1), Klassifikation 2 ID (classification2ID), Klassifikation 2 Bezeichnung (classification2), Klassifikation 3 ID (classification3ID), Klassifikation 3 Bezeichnung (classification3), Buchungsreferenz (entryReference), Abgleich (reconcilation)

---

## v1.9.2 (2019.08.02)
### Fixed
- Der Datentyp der Spalte "template.grandTotal" wurde von FLOAT(12,2) zu DECIMAL(15,3) geändert, da der Datentyp FLOAT nicht für die hier genutze Anwendung geignet ist [IS #47](https://github.com/albrecht-net/accounting/issues/47).

---

## v1.9.1 (2019.07.28)
### Fixed
- Der Datentyp der Spalte "journal.grandTotal" wurde von FLOAT(12,2) zu DECIMAL(15,3) geändert, da der Datentyp FLOAT nicht für die hier genutze Anwendung geignet ist [IS #47](https://github.com/albrecht-net/accounting/issues/47).

---

## v1.9.0 (2019.07.27)
### Changed
- Der Ansicht "viewEntries" wurden folgende Felder hinzugefügt oder angepasst: Empfänger Bezeichnung (recipient), Konto Bezeichnung (account), Gegenkonto ID (oppAccountID), Gegenkonto Bezeichnung (oppAccount), Periode Bezeichnung (vorher ID) (period).
- Neuanordnung Spaltenreihenfolge.
- Alle Updateanweisungen zu Tabellen oder Ansichten (Views) sind in einer Datei (dbJournal.update.sql) zusammengefasst, um Updatefehler zu verhindern.

---

## v1.6.0 (2019.06.11)
### Added
- In der Ansicht "viewAccount" wird der Status eines Konto mittels dem Feld "accountIsActive" angezeigt.
- In der Ansicht "viewBalanceAL" wird der Status eines Konto mittels dem Feld "accountIsActive" angezeigt.
- In der Tabelle "version" ist die Versionsinformation der Datenbank hinterlegt. Diese werden bei der Ersterstellung oder bei einem Datenbank-Update automatisch eingefügt.
### Changed
- Alle Vorlagen für die Ansichten wurden in eine Datei zusammengefasst.
### Removed
- Updateanweisungen (dbTablesJournal.update.sql) wurden bereinigt, da diese noch Versionsnummerierung der Accounting Repository beinhalteten. Das sofortige Entfernen dieser Anweisungen hat keinen Nachteil für den Benutzer!
### Note
- Alle erwähnten Versionsnummern (ausser ausdrücklich erwähnt) beziehen sich auf diese Repository. Die Kompabilität zu Accounting muss mithilfe der Versionsübersicht ([versionOverview.xlsx](https://github.com/albrecht-net/accounting/blob/master/versionOverview.xlsx)) sichergestellt werden.

---

## v1.1.0 (2019.04.10)
### Changed
- Datenbank-Vorlagen für die Applikations-Datenbank in eigene Repository ([albrecht-net/accounting-database](https://github.com/albrecht-net/accounting-database-application)) verschoben.

---

## v1.0.0 (2019.02.20)
### Added
- Datenbank-Vorlagen (/sources) in eigene Repository verschoben sowie deren Dateistruktur angepasst.
- View für Kontoübersicht (dbViewAccount) hinzugefügt.
- View für Saldo von Aktiven und Passiven (dbViewBalanceAP) hinzugefügt.
- View für Buchungen (dbViewEntries) hinzugefügt.
### Changed
- View für Journaleinträge (dbViewJournal) überarbeitet.