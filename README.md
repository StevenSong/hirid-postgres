# HiRID-Postgres
This is a fork of [Ti-Yao/Add-HiRID-dataset-to-Postgres](https://github.com/Ti-Yao/Add-HiRID-dataset-to-Postgres) to load HiRID v1.1.1 into a PostgreSQL database. We improve data loading and additionally add "concepts" in the style of the eICU and MIMIC datasets. Specifically, we create concepts using merged meta-variables defined by the original HiRID authors in their [circEWS repo](https://github.com/ratschlab/circEWS/tree/master/preprocessing/resource).

Using this repo requires downloading and extracting the HiRID `CSV` data partitions. Data paths are hardcoded in [`1_load_data.sql`](1_load_data.sql) and should be altered before running. Assuming a postgres server is running, the database is prepared as follows:

```sql
psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f 0_create_tables.sql
psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f 1_load_data.sql
psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f 2_postgres_check.sql
psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f 3_create_indices.sql
psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f concepts/0_create_concepts.sql
```
