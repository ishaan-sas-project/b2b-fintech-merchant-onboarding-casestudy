-- DDL for Indian Merchant Onboarding Data Model
-- Target DB: PostgreSQL 14+

DROP TABLE IF EXISTS fact_merchant_onboarding CASCADE;
DROP TABLE IF EXISTS dim_merchant_category CASCADE;
DROP TABLE IF EXISTS dim_geography CASCADE;

-- 1. Dimension: Geography & Tiers
CREATE TABLE dim_geography (
    state_code VARCHAR(10) PRIMARY KEY,
    state_name VARCHAR(100) NOT NULL,
    city_tier VARCHAR(10) CHECK (city_tier IN ('Tier-1', 'Tier-2', 'Tier-3')),
    rbi_banking_region VARCHAR(50)
);

-- 2. Dimension: Merchant Categories & Regulatory Compliance
CREATE TABLE dim_merchant_category (
    category_id SERIAL PRIMARY KEY,
    entity_type VARCHAR(50) NOT NULL, -- Proprietorship, Pvt Ltd, LLP, Partnership
    mcc_category VARCHAR(100) NOT NULL, -- Retail, SaaS, F&B, etc.
    requires_cin_verification BOOLEAN DEFAULT FALSE,
    requires_board_resolution BOOLEAN DEFAULT FALSE
);

-- 3. Fact Table: Merchant Funnel Lifecycle
CREATE TABLE fact_merchant_onboarding (
    merchant_id VARCHAR(30) PRIMARY KEY,
    signup_datetime TIMESTAMP NOT NULL,
    cohort VARCHAR(50) NOT NULL, -- 'Control (Legacy Flow)' OR 'Variant (Smart KYC + Instant Dev Sandbox)'
    entity_type VARCHAR(50) NOT NULL,
    mcc_category VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    city_tier VARCHAR(10) NOT NULL,
    step1_otp_verified BOOLEAN DEFAULT TRUE,
    step2_business_kyc_completed BOOLEAN DEFAULT FALSE,
    step3_penny_drop_success BOOLEAN DEFAULT FALSE,
    step4_esign_completed BOOLEAN DEFAULT FALSE,
    step5_sandbox_tested BOOLEAN DEFAULT FALSE,
    is_activated_7d BOOLEAN DEFAULT FALSE,
    activation_datetime TIMESTAMP,
    ttft_hours NUMERIC(8, 2),
    kyc_failure_reason VARCHAR(150),
    estimated_monthly_gmv_inr NUMERIC(14, 2)
);

-- Indexing for performance in Power BI DirectQuery / Analytics
CREATE INDEX idx_merchant_signup_date ON fact_merchant_onboarding(signup_datetime);
CREATE INDEX idx_merchant_cohort ON fact_merchant_onboarding(cohort);
CREATE INDEX idx_merchant_activated ON fact_merchant_onboarding(is_activated_7d);
