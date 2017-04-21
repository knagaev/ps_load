SELECT DocumentNode, Title, DocumentSummary
FROM Production.Document AS DocTable 
INNER JOIN CONTAINSTABLE(Production.Document, Document,
  'NEAR(bracket, reflector)' ) AS KEY_TBL
  ON DocTable.DocumentNode = KEY_TBL.[KEY]
WHERE KEY_TBL.RANK > 50
ORDER BY KEY_TBL.RANK DESC
GO