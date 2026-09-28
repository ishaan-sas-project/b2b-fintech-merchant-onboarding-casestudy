-- Query used to isolate onboarding drop-off by stage and business category
SELECT 
    b.entity_type,
    COUNT(m.id) AS total_signups,
    COUNT(CASE WHEN k.pan_verified = TRUE THEN 1 END) AS step1_pan_success,
    COUNT(CASE WHEN k.gstin_verified = TRUE THEN 1 END) AS step2_gstin_success,
    COUNT(CASE WHEN k.penny_drop_status = 'SUCCESS' THEN 1 END) AS step3_bank_success,
    COUNT(CASE WHEN m.first_webhook_fired = TRUE THEN 1 END) AS step4_sandbox_integration,
    COUNT(CASE WHEN m.live_payment_count >= 1 THEN 1 END) AS activated_merchants
FROM merchants m
LEFT JOIN merchant_business_profiles b ON m.id = b.merchant_id
LEFT JOIN merchant_kyc k ON m.id = k.merchant_id
WHERE m.created_at >= '2025-10-01' AND m.created_at < '2026-01-01'
GROUP BY b.entity_type;
