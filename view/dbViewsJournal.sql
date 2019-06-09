-- Datenbank View für die Journal Datenbank
--

-- --------------------------------------------------------


--
-- viewAccount
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
  accountClass.sign AS classSign,
  account.active AS accountIsActive
FROM account
  LEFT JOIN accountCategory
    ON account.category = accountCategory.categoryID
  LEFT JOIN accountClass
    ON accountCategory.class = accountClass.classID;

-- --------------------------------------------------------

--
-- viewBalanceAL
-- Aktueller Saldo der Aktiven, Passiven (Assets / Liabilities)
--

CREATE
  ALGORITHM = UNDEFINED
  SQL SECURITY INVOKER
  VIEW viewBalanceAL
AS SELECT
  a.classID,
  a.classLabel,
  a.categoryID,
  a.categoryLabel,
  a.accountID,
  a.accountLabel,
  SUM(e.grandTotal) AS balance,
  a.accountIsActive
FROM viewAccount a
  LEFT JOIN viewEntries e
    ON e.accountID = a.accountID
WHERE a.classID IN (1, 2)
GROUP BY a.accountID
ORDER BY a.accountID ASC;

-- --------------------------------------------------------

--
-- viewEntries
-- Auflistung aller Buchungen in einer Spalte
--

CREATE
  ALGORITHM = UNDEFINED
  SQL SECURITY INVOKER
  VIEW viewEntries
AS SELECT
  *
FROM (SELECT
    j.entryID,
    j.date,
    j.recipient,
    j.entryText,
    j.grandTotal,
    j.debitAccount AS accountID,
    j.period,
    'debit' AS EntrySide
  FROM journal j

  UNION ALL

  SELECT
    j.entryID,
    j.date,
    j.recipient,
    j.entryText,
    -j.grandTotal,
    j.creditAccount AS accountID,
    j.period,
    'credit' AS EntrySide
  FROM journal j) e
ORDER BY e.date ASC,
  e.entryID ASC;

-- --------------------------------------------------------

--
-- viewJournal
-- Auflistung aller Einträge im Journal
--

CREATE
  ALGORITHM = UNDEFINED
  SQL SECURITY INVOKER
  VIEW viewJournal
AS SELECT
  j.entryID,
  j.created,
  j.date,
  recipient.label AS recipient,
  j.invoiceNo,
  j.entryText,
  j.grandTotal,
  debitAccount.accountID AS debitAccountID,
  debitAccount.label AS debitAccount,
  creditAccount.accountID AS creditAccountID,
  creditAccount.label AS creditAccount,
  period.label AS period,
  classification1.label AS classification1,
  classification2.label AS classification2,
  classification3.label AS classification3,
  j.entryReference,
  j.reconcilation
FROM journal j
  LEFT JOIN recipient
    ON j.recipient = recipient.recipientID
  LEFT JOIN account AS debitAccount
    ON j.debitAccount = debitAccount.accountID
  LEFT JOIN account AS creditAccount
    ON j.creditAccount = creditAccount.accountID
  LEFT JOIN period
    ON j.period = period.periodID
  LEFT JOIN classification AS classification1
    ON j.classification1 = classification1.classificationID
  LEFT JOIN classification AS classification2
    ON j.classification2 = classification2.classificationID
  LEFT JOIN classification AS classification3
    ON j.classification3 = classification3.classificationID;