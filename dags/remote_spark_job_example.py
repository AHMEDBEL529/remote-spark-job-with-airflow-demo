from airflow.decorators import dag
from datetime import datetime
from airflow.providers.ssh.operators.ssh import SSHOperator



@dag(
    dag_id="remote_spark_job_example",
    schedule_interval=None,
    start_date=datetime(2023, 1, 1),
    catchup=False,
)
def remote_spark_job_example():

    # Define SSHOperator task to execute the job remotely
    run_job_task = SSHOperator(
        task_id='run_job',
        ssh_conn_id='spark_default',  # Specify your Spark cluster SSH connection ID
        command = 'export JAVA_HOME=/opt/bitnami/java; export SPARK_HOME=/opt/bitnami/spark; export PYSPARK_PYTHON=/opt/bitnami/python/bin/python3; /opt/bitnami/spark/bin/spark-submit --master spark://spark-service:7077 /opt/bitnami/spark/examples/src/main/python/pi.py'
    )

# Instantiate the DAG
remote_spark_job_example_dag = remote_spark_job_example()
