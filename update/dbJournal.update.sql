-- Datenbank Updates für die Journal Datenbank
-- Achtung: Die Updates sind nur für die angegebene Versionserhöhung gültig und sollten nach aufsteigener Versionsnummer ausgeführt werden!
-- Die hier verwendeten Versionsnummern beziehen sich auf die Journal Datenbank. Die Kompabilität zu Accounting muss mithilfe der Versionsübersicht sichergestellt werden.
--

-- --------------------------------------------------------

--
-- Update von v1.9.2 zu v1.10.0
--

-- Update viewEntries
CREATE OR REPLACE ALGORITHM = UNDEFINED SQL SECURITY INVOKER VIEW viewEntries AS SELECT * FROM (SELECT j.entryID, j.created, j.date, j.recipient AS recipientID, recipient.label AS recipient, j.invoiceNo, j.entryText, j.grandTotal, 'debit' AS EntrySide, j.debitAccount AS accountID, debitAccount.label AS account, j.creditAccount AS oppAccountID, creditAccount.label AS oppAccount, j.period AS periodID, period.label AS period, j.classification1 AS classification1ID, classification1.label AS classification1, j.classification2 AS classification2ID, classification2.label AS classification2, j.classification3 AS classification3ID, classification3.label AS classification3, j.entryReference, j.reconcilation FROM journal j LEFT JOIN recipient ON j.recipient = recipient.recipientID LEFT JOIN account AS creditAccount ON j.creditAccount = creditAccount.accountID LEFT JOIN account AS debitAccount ON j.debitAccount = debitAccount.accountID LEFT JOIN period ON j.period = period.periodID LEFT JOIN classification AS classification1 ON j.classification1 = classification1.classificationID LEFT JOIN classification AS classification2 ON j.classification2 = classification2.classificationID LEFT JOIN classification AS classification3 ON j.classification3 = classification3.classificationID UNION ALL SELECT j.entryID, j.created, j.date, j.recipient AS recipientID, recipient.label AS recipient, j.invoiceNo, j.entryText, -j.grandTotal, 'credit' AS EntrySide, j.creditAccount AS accountID, creditAccount.label AS account, j.debitAccount AS oppAccountID, debitAccount.label AS oppAccount, j.period AS periodID, period.label AS period, j.classification1 AS classification1ID, classification1.label AS classification1, j.classification2 AS classification2ID, classification2.label AS classification2, j.classification3 AS classification3ID, classification3.label AS classification3, j.entryReference, j.reconcilation FROM journal j LEFT JOIN recipient ON j.recipient = recipient.recipientID LEFT JOIN account AS creditAccount ON j.creditAccount = creditAccount.accountID LEFT JOIN account AS debitAccount ON j.debitAccount = debitAccount.accountID LEFT JOIN period ON j.period = period.periodID LEFT JOIN classification AS classification1 ON j.classification1 = classification1.classificationID LEFT JOIN classification AS classification2 ON j.classification2 = classification2.classificationID LEFT JOIN classification AS classification3 ON j.classification3 = classification3.classificationID) e ORDER BY e.date ASC, e.entryID ASC;

-- Versionsinformation
INSERT INTO `version` (`versionID`, `major`, `minor`, `patch`, `identifier`, `versionString`) VALUES (1, 1, 10, 0, NULL, NULL) ON DUPLICATE KEY UPDATE `major` = 1, `minor` = 10, `patch` = 0, `identifier` = NULL, `versionString` = NULL;

-- --------------------------------------------------------

--
-- Update von v1.9.1 zu v1.9.2
--

-- Datentyp von template.grandTotal zu Decimal(15,3) ändern
ALTER TABLE `template` CHANGE `grandTotal` `grandTotal` DECIMAL(12,2) NOT NULL DEFAULT '0.00';
ALTER TABLE `template` CHANGE `grandTotal` `grandTotal` DECIMAL(15,3) NOT NULL DEFAULT '0.000';

-- Versionsinformation
INSERT INTO `version` (`versionID`, `major`, `minor`, `patch`, `identifier`, `versionString`) VALUES (1, 1, 9, 2, NULL, NULL) ON DUPLICATE KEY UPDATE `major` = 1, `minor` = 9, `patch` = 2, `identifier` = NULL, `versionString` = NULL;

-- --------------------------------------------------------

--
-- Update von v1.9.0 zu v1.9.1
--

-- Datentyp von journal.grandTotal zu Decimal(15,3) ändern
ALTER TABLE `journal` CHANGE `grandTotal` `grandTotal` DECIMAL(12,2) NOT NULL DEFAULT '0.00';
ALTER TABLE `journal` CHANGE `grandTotal` `grandTotal` DECIMAL(15,3) NOT NULL DEFAULT '0.000';

-- Versionsinformation
INSERT INTO `version` (`versionID`, `major`, `minor`, `patch`, `identifier`, `versionString`) VALUES (1, 1, 9, 1, NULL, NULL) ON DUPLICATE KEY UPDATE `major` = 1, `minor` = 9, `patch` = 1, `identifier` = NULL, `versionString` = NULL;

-- --------------------------------------------------------

--
-- Update von v1.6.0 zu v1.9.0
--

-- Update viewEntries
CREATE OR REPLACE ALGORITHM = UNDEFINED SQL SECURITY INVOKER VIEW viewEntries AS SELECT * FROM (SELECT j.entryID, j.date, j.recipient AS recipientID, recipient.label AS recipient, j.entryText, j.grandTotal, 'debit' AS EntrySide, j.debitAccount AS accountID, debitAccount.label AS account, j.creditAccount AS oppAccountID, creditAccount.label AS oppAccount, period.label AS period FROM journal j LEFT JOIN recipient ON j.recipient = recipient.recipientID LEFT JOIN account AS creditAccount ON j.creditAccount = creditAccount.accountID LEFT JOIN account AS debitAccount ON j.debitAccount = debitAccount.accountID LEFT JOIN period ON j.period = period.periodID UNION ALL SELECT j.entryID, j.date, j.recipient AS recipientID, recipient.label AS recipient, j.entryText, -j.grandTotal, 'credit' AS EntrySide, j.creditAccount AS accountID, creditAccount.label AS account, j.debitAccount AS oppAccountID, debitAccount.label AS oppAccount, period.label AS period FROM journal j LEFT JOIN recipient ON j.recipient = recipient.recipientID LEFT JOIN account AS creditAccount ON j.creditAccount = creditAccount.accountID LEFT JOIN account AS debitAccount ON j.debitAccount = debitAccount.accountID LEFT JOIN period ON j.period = period.periodID) e ORDER BY e.date ASC, e.entryID ASC;

-- Versionsinformation
INSERT INTO `version` (`versionID`, `major`, `minor`, `patch`, `identifier`, `versionString`) VALUES (1, 1, 9, 0, NULL, NULL) ON DUPLICATE KEY UPDATE `major` = 1, `minor` = 9, `patch` = 0, `identifier` = NULL, `versionString` = NULL;

-- --------------------------------------------------------

--
-- Update von v1.1.0 zu v1.6.0
--

-- Tabelle erstellen
CREATE TABLE `version` ( `versionID` INT(11) NOT NULL AUTO_INCREMENT, `major` INT(11) NOT NULL, `minor` INT(11) NOT NULL, `patch` INT(11) NOT NULL, `identifier` VARCHAR(16) NULL DEFAULT NULL, `versionString` VARCHAR(64) NULL DEFAULT NULL, PRIMARY KEY(`versionID`) ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = 'Version';

-- Trigger (insert)
CREATE TRIGGER `generate_versionString_insert` BEFORE INSERT ON `version` FOR EACH ROW SET NEW.versionString = CONCAT('v', NEW.major, '.', NEW.minor, '.', NEW.patch, IF(ISNULL(NEW.identifier), '', '-'), IFNULL(NEW.identifier, ''));

-- Trigger (update)
CREATE TRIGGER `generate_versionString_update` BEFORE UPDATE ON `version` FOR EACH ROW SET NEW.versionString = CONCAT('v', NEW.major, '.', NEW.minor, '.', NEW.patch, IF(ISNULL(NEW.identifier), '', '-'), IFNULL(NEW.identifier, ''));

-- Versionsinformation einfügen
INSERT INTO `version` (`versionID`, `major`, `minor`, `patch`, `identifier`, `versionString`) VALUES (NULL, 1, 6, 0, NULL, NULL);

-- Update viewAccount
CREATE OR REPLACE ALGORITHM = UNDEFINED SQL SECURITY INVOKER VIEW viewAccount AS SELECT accountClass.classID, accountClass.label AS classLabel, accountCategory.categoryID, accountCategory.label AS categoryLabel, account.accountID, account.label AS accountLabel, accountClass.sign AS classSign, account.active AS accountIsActive FROM account LEFT JOIN accountCategory ON account.category = accountCategory.categoryID LEFT JOIN accountClass ON accountCategory.class = accountClass.classID;

-- Update viewBalanceAL
CREATE OR REPLACE ALGORITHM = UNDEFINED SQL SECURITY INVOKER VIEW viewBalanceAL AS SELECT a.classID, a.classLabel, a.categoryID, a.categoryLabel, a.accountID, a.accountLabel, SUM(e.grandTotal) AS balance, a.accountIsActive FROM viewAccount a LEFT JOIN viewEntries e ON e.accountID = a.accountID WHERE a.classID IN (1, 2) GROUP BY a.accountID ORDER BY a.accountID ASC;
