\echo ''
\echo '==='
\echo 'Beginning to create materialized views for MIMIC database.'
\echo 'Any notices of the form  "NOTICE: materialized view "XXXXXX" does not exist" can be ignored.'
\echo 'The scripts drop views before creating them, and these notices indicate nothing existed prior to creating the view.'
\echo '==='
\echo ''

-- Set the search_path, i.e. the location at which we generate tables.
-- postgres looks at schemas sequentially, so this will generate tables on the mimiciv_derived schema

-- NOTE: many scripts *require* you to use mimiciv_derived as the schema for outputting concepts
-- change the search path at your peril!
SET search_path TO mimiciv_derived, mimiciv_hosp, mimiciv_icu, mimiciv_ed;



-- demographics
\i demographics/age.sql

-- measurement
\i measurement/bg2.sql
\i measurement/blood_differential2.sql
\i measurement/cardiac_marker2.sql
\i measurement/chemistry2.sql
\i measurement/coagulation2.sql
\i measurement/complete_blood_count2.sql
\i measurement/creatinine_baseline.sql
\i measurement/enzyme2.sql
\i measurement/inflammation2.sql

-- comorbidity
\i comorbidity/charlson.sql
\i comorbidity/r_hosp_dataset.sql
