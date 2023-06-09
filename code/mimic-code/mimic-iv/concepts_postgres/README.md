# PostgreSQL concepts

This folder contains scripts to generate useful abstractions of raw MIMIC-IV data ("concepts"). The
scripts are intended to be run against the MIMIC-IV data in a PostgreSQL database.

**These scripts are automatically generated by a shell script in the concepts folder.**
If you would like to contribute a correction, please look at the conversion shell script to ensure you edit the right script!

To generate concepts, change to this directory and run `psql`. Then within psql, run:

```sql
\i postgres-functions.sql -- only needs to be run once
\i postgres-make-concepts.sql
```

... or, execute the SQL files in your GUI of choice.

```
C:\Users\snksh\OneDrive\Desktop\Research\demo datasets\mimic-iv-clinical-database-demo-2.2\mycode\mimic-code>psql -d mimiciv -U mimic -f mimic-iv\concepts_postgres\comorbidity\r_hops_dataset.sql

mimiciv=> \copy (select * from r_hosp_dataset) TO 'C:\Users\snksh\OneDrive\Desktop\Research\dataset\r_hosp_demo_dataset.csv' (FORMAT csv, HEADER);
COPY 275
mimiciv=>
```
