-- Sample Seed Data for immediate testing
INSERT INTO dim_geography (state_code, state_name, city_tier, rbi_banking_region) VALUES
('MH', 'Maharashtra', 'Tier-1', 'West'),
('KA', 'Karnataka', 'Tier-1', 'South'),
('DL', 'Delhi NCR', 'Tier-1', 'North'),
('TN', 'Tamil Nadu', 'Tier-1', 'South'),
('GJ', 'Gujarat', 'Tier-2', 'West'),
('UP', 'Uttar Pradesh', 'Tier-2', 'North');

INSERT INTO dim_merchant_category (entity_type, mcc_category, requires_cin_verification, requires_board_resolution) VALUES
('Proprietorship', 'Retail / D2C', FALSE, FALSE),
('Private Limited', 'SaaS / B2B Tech', TRUE, TRUE),
('Partnership', 'F&B / Hospitality', FALSE, FALSE),
('LLP', 'Logistics / Services', TRUE, FALSE);

-- Note: In production / GitHub setup, load the CSV using:
-- \copy fact_merchant_onboarding FROM 'data/synthetic_indian_merchant_onboarding_1000.csv' WITH (FORMAT csv, HEADER true);
