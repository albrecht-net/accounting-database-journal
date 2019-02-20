-- Datenbank View für die Benutzer-Zieldatenbank
-- Gültig ab: Accounting v2.0.0-beta
-- 

-- --------------------------------------------------------

--
-- Auflistung aller Konten und dazugehörige Kategorien, Klassen
--

CREATE
  ALGORITHM = UNDEFINED
  SQL SECURITY INVOKER
  VIEW viewAccount
AS SELECT
  accountClass.classID,
  accountClass.label AS classLabel,
  accountCategory.categoryID,
  accountCategory.label AS categoryLabel,
  account.accountID,
  account.label AS accountLabel,
  accountClass.sign AS classSign
FROM account
  LEFT JOIN accountCategory
    ON account.category = accountCategory.categoryID
  LEFT JOIN accountClass
    ON accountCategory.class = accountClass.classID