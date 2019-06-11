# Changelog (accounting database journal)
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## v1.6.0 (xxx.xx.xx)
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