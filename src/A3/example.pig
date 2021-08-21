-- This script reports the first date when Quebec reported a covid case.

--load the data from HDFS and define the schema
coviddata = LOAD '/data/Covid19Canada.csv' USING PigStorage(',') AS (prname:CHARARRAY, idate:CHARARRAY, newcases:INT, newdeaths:INT, tests:INT, recoveries:INT);

-- Find the days in which there were cases reported by Quebec
QuebecCases = FILTER coviddata BY prname == 'Quebec' AND newcases > 0;

-- Read the attributes we are interested in.
idates = FOREACH QuebecCases GENERATE idate;

-- Order that by the date
orderidates = ORDER idates BY idate;

-- we only need the first date.
results = LIMIT orderidates 1;

-- output
DUMP results;
