CREATE SCHEMA hirid_derived;

SET search_path TO hirid_derived,hirid;

\i gcs.sql
\i vitals.sql
\i cmp.sql
\i cbc.sql
-- \i vasoactive.sql
