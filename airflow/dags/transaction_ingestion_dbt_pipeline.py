from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.postgres_operator import PostgresOperator
from datetime import datetime
from airflow.providers.docker.operators.docker import DockerOperator
print(">> Using DockerOperator from:", DockerOperator.__module__)

default_args = {
    "owner": "airflow",
    "start_date": datetime(2025, 10, 4),
    "retries": 1,
}

with DAG(
    dag_id="transaction_ingestion_dbt_pipeline",
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
    tags=["postgres", "dbt", "etl"],
) as dag:

    # Optional: test Postgres connection
    test_pg_connection = PostgresOperator(
        task_id="test_pg_connection",
        postgres_conn_id="AIRFLOW_CONN_DATA_DB",
        sql="""
            CREATE TABLE IF NOT EXISTS trusted.dim_customer_transactions (
                	transaction_id varchar(50) NULL,
                    customer_id float4 NULL,
	                transaction_date varchar(50) NULL,
	                product_id varchar(50) NULL,
	                product_name varchar(50) NULL
                 );
            """
    )


    run_dbt_model = BashOperator(
        task_id='run_dbt_model',
        bash_command='cd /usr/app && dbt run --select dim_customer_transactions',
    )

    test_pg_connection >> run_dbt_model
