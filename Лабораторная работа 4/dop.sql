declare @TestTable as table (A int)
insert into @TestTable(A) values (1), (1), (1), (3), (3), (5), (5)
 
select * from @TestTable;
 
WITH dop(a, rn) AS
(
SELECT A, row_number() over (PARTITION BY A order by A) rn
from @TestTable
)
 
DELETE FROM dop where rn>1
 
select * from @TestTable;