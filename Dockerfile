FROM apache/airflow:2.8.1-python3.10
# Install required Airflow extras
RUN pip install \
    apache-airflow[postgres,celery,auth,async,statsd]

USER airflow
# Install dbt and any dependencies
#RUN pip install 'apache-airflow-providers-postgres'
#RUN pip install 'apache-airflow-providers-docker'
RUN pip install --no-cache-dir dbt-postgres

# 🛠️ Pin problematic packages
RUN pip install \
    "protobuf<4.24.0" \
    "apache-airflow[postgres,auth,celery,async,statsd]" \
    "apache-airflow-providers-postgres" \
    "apache-airflow-providers-google"