from datetime import timedelta, datetime
from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator

default_args = {
		'owner': 'neeru',
		'start_date': datetime(2023, 3, 9),
		'retries': 3,
		'retry_delay': timedelta(minutes=5)
}

hello_world_dag = DAG('hello_world_dag',
		default_args=default_args,
		description='Hello World DAG',
		schedule_interval='0 * * * *', 
		catchup=False,
		tags=['example, helloworld']
)

def print_hello():
		return 'Hello World!'

start_task = DummyOperator(task_id='start_task', dag=hello_world_dag)
hello_world_task = PythonOperator(task_id='hello_world_task', python_callable=print_hello, dag=hello_world_dag)
end_task = DummyOperator(task_id='end_task', dag=hello_world_dag)
 
start_task >> hello_world_task >> end_task
