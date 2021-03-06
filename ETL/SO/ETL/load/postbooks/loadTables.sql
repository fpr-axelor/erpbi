COPY "ERPI"."SO_FACTS_BY_PERIOD" FROM 'C:/erp-intell/ETL/SO/ETL/load/postbooks/periodTableData_SO.dat' DELIMITER ';' CSV;
CREATE TABLE "ERPI"."SO_FACTS_BY_PERIOD_TEMP" AS (SELECT * FROM "ERPI"."SO_FACTS_BY_PERIOD" ORDER BY "FISCAL_VARIANT_K", "COMPANY_K", "CUSTOMER_K");
DROP TABLE "ERPI"."SO_FACTS_BY_PERIOD";
ALTER TABLE "ERPI"."SO_FACTS_BY_PERIOD_TEMP" RENAME TO "SO_FACTS_BY_PERIOD";
DELETE FROM "ERPI"."GENPERIOD_THRESHOLD" WHERE "MART_NAME"='SO';
INSERT INTO "ERPI"."GENPERIOD_THRESHOLD" ("MART_NAME","THRESHOLD_AMT","INC_UPD_COUNT") SELECT 'SO',(COUNT(*)*.1),0 FROM "ERPI"."SO_FACTS_BY_PERIOD";
