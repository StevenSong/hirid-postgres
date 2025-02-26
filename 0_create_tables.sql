DROP SCHEMA IF EXISTS hirid CASCADE;
CREATE SCHEMA hirid;


SET search_path TO hirid;


DROP TABLE IF EXISTS variables CASCADE;
CREATE TABLE variables
(
	source_table VARCHAR(20) NOT NULL,
	var_id INT NOT NULL,
	var_name VARCHAR(100) NOT NULL,
	var_unit VARCHAR(250),
	additional_information VARCHAR(20)
);


DROP TABLE IF EXISTS var_meta CASCADE;
CREATE TABLE var_meta
(
	meta_var_id INT NOT NULL,
	meta_var_name VARCHAR(30),
	meta_var_unit VARCHAR(175),
	var_id INT NOT NULL,
	var_type VARCHAR(15)
);


DROP TABLE IF EXISTS lab_meta CASCADE;
CREATE TABLE lab_meta
(
	meta_var_id INT NOT NULL,
	meta_var_name VARCHAR(30),
	var_id INT NOT NULL
);


DROP TABLE IF EXISTS patients CASCADE;
CREATE TABLE patients
(
	patient_id INTEGER NOT NULL,
	admit_time TIMESTAMP NOT NULL,
	sex CHARACTER(1) NOT NULL,
	age INTEGER NOT NULL,
	discharge_status VARCHAR(10),
	CONSTRAINT patient_pkey PRIMARY KEY(patient_id)
);


DROP TABLE IF EXISTS observations CASCADE;
CREATE TABLE observations
(
	obs_time TIMESTAMP NOT NULL,
	entry_time TIMESTAMP NOT NULL,
	patient_id INT NOT NULL,
	record_status INT,
	obs_value_str VARCHAR(200),
	obs_type VARCHAR(200),
	obs_value DOUBLE PRECISION,
	var_id INT
) PARTITION BY RANGE (patient_id);


-- 33905 patients
CREATE TABLE observations_0 PARTITION OF observations FOR VALUES FROM (0) TO (3000);
CREATE TABLE observations_1 PARTITION OF observations FOR VALUES FROM (3000) TO (6000);
CREATE TABLE observations_2 PARTITION OF observations FOR VALUES FROM (6000) TO (9000);
CREATE TABLE observations_3 PARTITION OF observations FOR VALUES FROM (9000) TO (12000);
CREATE TABLE observations_4 PARTITION OF observations FOR VALUES FROM (12000) TO (15000);
CREATE TABLE observations_5 PARTITION OF observations FOR VALUES FROM (15000) TO (18000);
CREATE TABLE observations_6 PARTITION OF observations FOR VALUES FROM (18000) TO (21000);
CREATE TABLE observations_7 PARTITION OF observations FOR VALUES FROM (21000) TO (24000);
CREATE TABLE observations_8 PARTITION OF observations FOR VALUES FROM (24000) TO (27000);
CREATE TABLE observations_9 PARTITION OF observations FOR VALUES FROM (27000) TO (30000);
CREATE TABLE observations_10 PARTITION OF observations FOR VALUES FROM (30000) TO (33000);
CREATE TABLE observations_11 PARTITION OF observations FOR VALUES FROM (33000) TO (36000);


CREATE INDEX ON observations (patient_id);


DROP TABLE IF EXISTS pharma CASCADE;
CREATE TABLE pharma
(
	patient_id INT NOT NULL,
	var_id INT NOT NULL,
	given_time TIMESTAMP,
	entry_time TIMESTAMP,
	dose DOUBLE PRECISION,
	cumulative_dose DOUBLE PRECISION,
	fluid_amt DOUBLE PRECISION,
	cumulative_fluid_amt DOUBLE PRECISION,
	dose_unit VARCHAR(30),
	dose_route VARCHAR(20),
	infusion_id INT,
	type_id INT,
	subtype_id DOUBLE PRECISION,
	record_status INT
);
