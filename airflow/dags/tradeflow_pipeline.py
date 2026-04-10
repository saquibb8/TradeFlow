from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
        dag_id="tradeflow_pipeline",
    start_date=datetime(2024, 1, 1),
    schedule_interval="@daily",
    catchup=False,
    default_args={
        "email": ["saqsb8@gmail.com"],
        "email_on_failure": True,
        "email_on_retry": False,
        "retries": 1,
    }
) as dag:

    extract = BashOperator(
        task_id="extract",
        bash_command="python /opt/airflow/ingestion/extract.py",
    )

    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command="dbt run --project-dir /opt/airflow/dbt --profiles-dir /opt/airflow/dbt",
    )

    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command="dbt test --project-dir /opt/airflow/dbt --profiles-dir /opt/airflow/dbt",
    )

    extract >> dbt_run >> dbt_test