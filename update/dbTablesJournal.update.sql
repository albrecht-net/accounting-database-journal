-- Datenbank Tabellen Updates für die Journal Datenbank
-- Achtung: Die Updates sind nur für die angegebene Versionserhöhung gültig und sollten nach aufsteigener Versionsnummer ausgeführt werden!
-- Die hier verwendeten Versionsnummern beziehen sich auf die Journal Datenbank. Die Kompabilität zu Accounting muss mithilfe der Versionsübersicht sichergestellt werden.
--

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
INSERT INTO `version` (`versionID`, `major`, `minor`, `patch`, `identifier`, `versionString`) VALUES (NULL, '1', '6', '0', NULL, NULL);
