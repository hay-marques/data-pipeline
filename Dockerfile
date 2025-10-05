FROM apache/airflow:2.8.1-python3.10
# Install required Airflow extras
RUN pip install \
    apache-airflow[postgres,celery,auth,async,statsd]

USER airflow
# Install dbt and any dependencies
#RUN pip install 'apache-airflow-providers-postgres'
#RUN pip install 'apache-airflow-providers-docker'
RUN pip install --no-cache-dir dbt-postgres

# Force specific protobuf version
RUN pip uninstall protobuf -y

# 🛠️ Pin problematic packages
RUN pip install \
    "protobuf==3.20.3" \
    "apache-airflow[postgres,auth,celery,async,statsd]" \
    "apache-airflow-providers-postgres" \
    "apache-airflow-providers-google"