-- Data check 
SELECT cst_id, COUNT(*) FROM
  (SELECT
    ci.cst_id,
    ci.cst_key,
    ci.cst_firstname,
    ci.cst_lastname,
    ci.cst_marital_status,
    ci.cst_gndr,
    ci.cst_create_date,
    ca.bdate,
    ca.gen,
    la.cntry
  FROM silver.crm_cust_info ci
  LEFT JOIN silver.erp_cust_az12 ca
    ON ci.cst_key = ca.cid
  LEFT JOIN silver.erp_loc_a101 la
    ON ci.cst_key = la.cid
)t GROUP BY cst_id
HAVING COUNT(*) > 1;

SELECT DISTINCT
  ci.cst_gndr,
  ca.gen,
  CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the Master for gender Info
    ELSE COALESCE(ca.gen, 'n/a')
  END AS new_gen
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
  ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
  ON ci.cst_key = la.cid;

SELECT
  pn.prd_id,
  pn.cat_id,
  pn.prd_key,
  pn.prd_nm,
  pn.prd_cost,
  pn.prd_line,
  pn.prd_start_dt,
  pn.prd_end_dt,
  pc.cat,
  pc.subcat,
  pc.maintenance
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL; -- filter out all historical data

SELECT prd_key, COUNT(*) FROM (
SELECT
  pn.prd_id,
  pn.cat_id,
  pn.prd_key,
  pn.prd_nm,
  pn.prd_cost,
  pn.prd_line,
  pn.prd_start_dt,
  pn.prd_end_dt,
  pc.cat,
  pc.subcat,
  pc.maintenance
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL -- filter out all historical data
)t GROUP BY prd_key
HAVING COUNT(*) > 1;

SELECT
  sd.sls_ord_num,
  sd.sls_prd_key,
  sd.sls_cust_id,
  sd.sls_order_dt,
  sd.sls_ship_dt,
  sd.sls_due_dt,
  sd.sls_sales,
  sd.sls_quantity,
  sd.sls_price
FROM silver.crm_sales_details sd
