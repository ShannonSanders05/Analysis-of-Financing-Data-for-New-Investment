--CREATING TABLE

CREATE TABLE IF NOT EXISTS investment_subset
(
	market TEXT,
	funding_total_usd NUMERIC,
	status TEXT,
	country_code TEXT,
	founded_year INTEGER,
	seed NUMERIC,
	venture NUMERIC,
	equity_crowdfunding NUMERIC,
	undisclosed NUMERIC,
	convertable_note NUMERIC,
	debt_fincing NUMERIC,
	private_equity NUMERIC
);

SELECT * FROM investment_subset

--CHECKING MARKETS COLUMN

SELECT * FROM investment_subset;

SELECT DISTINCT market FROM investment_subset
ORDER BY market

--CREATING SEPARATE TABLE FOR FINANCIAL SERVICES

DROP TABLE IF EXISTS financial_services

CREATE TABLE fincial_services AS
SELECT * FROM investment_subset
WHERE market = 'FincialServices'

SELECT * FROM fincial_services

--DESCRIPTIVE ANALYTICS
--Number of Financial Services companies and average, minimum and maximum seed funding

SELECT COUNT(market) AS count_fincialservices_company,
ROUND(AVG(seed),2) AS avg_seed, 
MAX(seed) AS max_seed, 
MIN(seed) AS min_seed
FROM fincial_services
WHERE funding_total_usd IS NOT NULL

--EQUITY CROWD-SOURCING
--Determine whether or not there has been a previous instance where a startup offering financial services received equity crowdfunding.

SELECT country_code,
founded_year,status,
equity_crowdfunding 
FROM fincial_services
WHERE equity_crowdfunding > 0

--DETERMINING AND REMOVING OUTLIER

SELECT * FROM fincial_services
ORDER BY funding_total_usd 

SELECT country_code,
founded_year,status,
funding_total_usd 
FROM fincial_services
WHERE funding_total_usd = 725000000

--REMOVING OUTLIER

DELETE FROM fincial_services
WHERE funding_total_usd = 725000000

--FINAL CLEANED DATA FOR VISUALIZATION

SELECT * FROM fincial_services
WHERE funding_total_usd IS NOT NULL
ORDER BY funding_total_usd