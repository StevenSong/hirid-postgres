CREATE INDEX observations_idx01 ON hirid.observations (patient_id, obs_time);

CREATE INDEX pharma_idx01 ON hirid.pharma (patient_id, given_time);