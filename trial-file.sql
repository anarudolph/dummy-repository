SELECT deal_id, deal_source, deal_name, deal_type, bdr_owner_name,deal_owner_name, deal_amount_in_home_currency_usd, deal_amount_in_home_currency_eur, deal_stage_name, close_date, deal_closed_won, revops_tier, ae_multi_year_contract, ae_contract_type, revops_how_many_years_, revops_how_long_in_advance_is_it_paid_, revops_advanced_payment, revops_onboarding_package, revops_onboarding_package_amount,  
CONCAT('Q', EXTRACT(QUARTER FROM close_date), ' - ', EXTRACT(YEAR FROM close_date)) AS close_quarter_year,
CONCAT(EXTRACT(MONTH FROM close_date), '-', EXTRACT(YEAR FROM close_date)) AS close_month_year,
CONCAT('Q', EXTRACT(QUARTER FROM deal_creation_date), ' - ', EXTRACT(YEAR FROM deal_creation_date)) AS create_quarter_year,
CASE 
 WHEN bdr_owner_name = 'Prats, Laura' AND deal_creation_date < '2023-10-01' THEN NULL 
 WHEN bdr_owner_name = 'Lallemand, Andre' AND deal_creation_date <'2024-01-01' THEN NULL ELSE bdr_owner_name
 END AS bdr_owner_column2,
CASE
  WHEN revops_advanced_payment = 'Yes' THEN deal_amount_in_home_currency_eur * (revops_how_long_in_advance_is_it_paid_ - 1)
  ELSE NULL -- or any other default value if needed
  END AS advanced_payment_amount
FROM `deskbird-bbe72.dbt_financial.dim_hubspot_deals` 
WHERE deal_closed_won = true