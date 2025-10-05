# data-pipeline

# 🧬 Data Pipeline with Airflow, dbt, and PostgreSQL (Docker Compose)

This project sets up a local data pipeline using:

- **Apache Airflow**: Orchestrates the pipeline
- **dbt (Data Build Tool)**: Transforms data in the data warehouse
- **PostgreSQL**: Stores raw and transformed data

All services run via **Docker Compose** for easy local development and reproducibility.

---

## 📦 Stack Overview

| Service     | Purpose                                 | URL / Port         |
|-------------|------------------------------------------|--------------------|
| Airflow Webserver | UI for managing DAGs               | http://localhost:8080 |
| Airflow Scheduler | Triggers DAG tasks                  | -                  |
| PostgreSQL  | Raw and transformed data store           | localhost:5433     |
| dbt         | Data transformations (runs via container) | -                 |

---

## 🚀 Getting Started

### 1. Clone the Repository

```
https://github.com/hay-marques/data-pipeline.git
cd data-pipeline
```

### 2. Project Structure
```
.
├── airflow/
│   ├── dags/
│   └── logs/
│   └── plugins/
├── dbt/
│   ├── dbt_project.yml
│   ├── models/
│   └── profiles.yml
├── docker-compose.yml
├── Dockerfile.dbt
├── Dockerfile
└── README.md
```

### 3. Build and Start All Services
````
docker compose up --build -d
````

### 4. Airflow
Access the Airflow UI: http://localhost:8080
Default credentials:
    Username: admin
    Password: admin
Trigger a DAG
    Once your DAG is added to the airflow/dags/ folder and the container is restarted, you can trigger it from the UI or via CLI:
    ```
    docker compose exec airflow-webserver airflow dags list
    docker compose exec airflow-webserver airflow dags trigger <dag_id>
    ```

### 5. Postgres
PostgreSQL stores both raw data and transformed data.
````
Host (inside Docker network): postgres
Host (from host machine): localhost
Port: 5433
User: data_user
Password: data_pass
Database: data_ingestion
```
