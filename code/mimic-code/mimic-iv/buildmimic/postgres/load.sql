-----------------------------------------
-- Load data into the MIMIC-IV schemas --
-----------------------------------------

-- To run from a terminal:
--  psql "dbname=<DBNAME> user=<USER>" -v mimic_data_dir=<PATH TO DATA DIR> -f load.sql
-- The script assumes the files are in the hosp and icu subfolders of mimic_data_dir
\cd :mimic_data_dir

-- making sure correct encoding is defined as -utf8- 
SET CLIENT_ENCODING TO 'utf8';

-- hosp schema
\cd hosp

\COPY mimiciv_hosp.admissions FROM admissions.csv DELIMITER ',' CSV HEADER NULL ''; 
\COPY mimiciv_hosp.diagnoses_icd FROM diagnoses_icd.csv DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.labevents FROM labevents.csv DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.patients FROM patients.csv DELIMITER ',' CSV HEADER NULL ''; 
