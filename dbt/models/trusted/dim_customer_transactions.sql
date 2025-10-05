SELECT
    transaction_id,
    customer_id,
    transaction_date,
    product_id,
    product_name
FROM raw.customer_transactions
GROUP BY transaction_id, customer_id, transaction_date, product_id, product_name