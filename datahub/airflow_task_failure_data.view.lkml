view: airflow_task_failure_data {
  sql_table_name: `fulfillment-dwh-staging.cl_datahub_services.task_final_state` ;;
  
                dimension: project_id        { type: string sql: ${TABLE}.project_id ;; }
  dimension: dag_id            { type: string sql: ${TABLE}.dag_id ;; }
  dimension: task_id           { type: string sql: ${TABLE}.task_id ;; }
  dimension: run_id            { type: string sql: ${TABLE}.run_id ;; }
  dimension: is_dag_critical   { type: yesno sql: ${TABLE}.is_dag_critical ;; }
  dimension: try_number        { type: number sql: ${TABLE}.try_number ;; }
  dimension: created_date      { type: date sql: ${TABLE}.created_date ;; }
  dimension: timestamp         { type: date sql: ${TABLE}.timestamp ;; }
              dimension: airflow_link      { type: string sql: ${TABLE}.airflow_link ;; }
  dimension: failure_root      { type: string sql: ${TABLE}.failure_root ;; }
  dimension: failure_reason    { type: string sql: ${TABLE}.failure_reason ;; }
  dimension: execution_number  { type: number sql: ${TABLE}.execution_number ;; }
  dimension: is_success        { type: yesno sql: ${TABLE}.is_success ;; }
  dimension: is_dhub_failure   { type: yesno sql: ${TABLE}.is_dhub_failure ;; }
  dimension: execution_dag_id  { type: string sql: ${TABLE}.execution_dag_id ;; }
  dimension: is_dag_success    { type: yesno sql: ${TABLE}.is_dag_success ;; }
  
  filter: created_date_filter {
    type: date
    sql: ${TABLE}.timestamp ;;
  }
}

view: task_final_state_production {
  sql_table_name: `fulfillment-dwh-production.cl_datahub_services.task_final_state` ;;
  
  dimension: project_id        { type: string sql: ${TABLE}.project_id ;; }
  dimension: dag_id            { type: string sql: ${TABLE}.dag_id ;; }
  dimension: task_id           { type: string sql: ${TABLE}.task_id ;; }
  dimension: run_id            { type: string sql: ${TABLE}.run_id ;; }
  dimension: is_dag_critical   { type: yesno sql: ${TABLE}.is_dag_critical ;; }
  dimension: try_number        { type: number sql: ${TABLE}.try_number ;; }
  dimension: created_date      { type: date sql: ${TABLE}.created_date ;; }
  dimension: timestamp         { type: date sql: ${TABLE}.timestamp ;; }
  dimension: airflow_link      { type: string sql: ${TABLE}.airflow_link ;; }
  dimension: failure_root      { type: string sql: ${TABLE}.failure_root ;; }
  dimension: failure_reason    { type: string sql: ${TABLE}.failure_reason ;; }
  dimension: execution_number  { type: number sql: ${TABLE}.execution_number ;; }
  dimension: is_success        { type: yesno sql: ${TABLE}.is_success ;; }
  dimension: is_dhub_failure   { type: yesno sql: ${TABLE}.is_dhub_failure ;; }
  dimension: execution_dag_id  { type: string sql: ${TABLE}.execution_dag_id ;; }
  dimension: is_dag_success    { type: yesno sql: ${TABLE}.is_dag_success ;; }
  
  filter: created_date_filter {
    type: date
    sql: ${TABLE}.timestamp ;;
  }
}
view: task_slo_breaches {
  sql_table_name: `fulfillment-dwh-production.cl_datahub_services.task_slo_breaches` ;;
  
  dimension: created_date     { type: date sql: ${TABLE}.created_date ;; }
  dimension: created_hour     { type: date sql: ${TABLE}.created_hour ;; }
  dimension: tot_dhub_failures { type: number sql: ${TABLE}.tot_dhub_failures ;; }
  dimension: tot_tasks        { type: number sql: ${TABLE}.tot_tasks ;; }
  dimension: is_breach        { type: yesno sql: ${TABLE}.is_breach ;; }
  
  filter: created_date_filter {
    type: date
    sql: ${TABLE}.created_hour ;;
  }
}
view: task_slo_breaches_per_project {
  sql_table_name: `fulfillment-dwh-production.cl_datahub_services.task_slo_breaches_per_project` ;;
  
  dimension: created_date     { type: date sql: ${TABLE}.created_date ;; }
  dimension: created_hour     { type: date sql: ${TABLE}.created_hour ;; }
  dimension: project_id       { type: string sql: ${TABLE}.project_id ;; }
  dimension: tot_dhub_failures { type: number sql: ${TABLE}.tot_dhub_failures ;; }
  dimension: tot_tasks        { type: number sql: ${TABLE}.tot_tasks ;; }
  dimension: is_breach        { type: yesno sql: ${TABLE}.is_breach ;; }
  
  filter: created_date_filter {
    type: date
    sql: ${TABLE}.created_hour ;;
  }
}
view: dag_execution_metrics {
  sql_table_name: `fulfillment-dwh-staging.cl_datahub_services.dag_execution_time_metrics` ;;
  
  dimension: run_type            { type: string sql: ${TABLE}.run_type ;; }
  dimension: dag_schedule_delay  { type: number sql: ${TABLE}.dag_schedule_delay ;; }
  dimension: dag_execution_delay { type: number sql: ${TABLE}.dag_execution_delay ;; }
  dimension: dagrun_duration     { type: number sql: ${TABLE}.dagrun_duration ;; }
  dimension: task_id             { type: string sql: ${TABLE}.task_id ;; }
  dimension: dag_id              { type: string sql: ${TABLE}.dag_id ;; }
  dimension: run_id              { type: string sql: ${TABLE}.run_id ;; }
  dimension: start_date          { type: date sql: ${TABLE}.start_date ;; }
  dimension: end_date            { type: date sql: ${TABLE}.end_date ;; }
  dimension: duration            { type: number sql: ${TABLE}.duration ;; }
  dimension: state               { type: string sql: ${TABLE}.state ;; }
  dimension: try_number          { type: number sql: ${TABLE}.try_number ;; }
  dimension: pool                { type: string sql: ${TABLE}.pool ;; }
  dimension: pool_slots          { type: number sql: ${TABLE}.pool_slots ;; }
  dimension: queue               { type: string sql: ${TABLE}.queue ;; }
  dimension: operator            { type: string sql: ${TABLE}.operator ;; }
  dimension: queued_dttm        { type: date sql: ${TABLE}.queued_dttm ;; }
  dimension: task_schedule_delay { type: number sql: ${TABLE}.task_schedule_delay ;; }
  dimension: task_execution_delay { type: number sql: ${TABLE}.task_execution_delay ;; }
  dimension: project_id          { type: string sql: ${TABLE}.project_id ;; }
  dimension: pool_size           { type: number sql: ${TABLE}.pool_size ;; }
  
  filter: start_date_filter {
    type: date
    sql: DATE(${TABLE}.start_date) ;;
  }
}

view: webserver_metrics {
  sql_table_name: `fulfillment-dwh-production.cl_datahub_services.webserver_metrics` ;;
  
  dimension: dt                    { type: date sql: ${TABLE}.dt ;; }
  dimension: project_id            { type: string sql: ${TABLE}.project_id ;; }
  dimension: env                   { type: string sql: ${TABLE}.env ;; }
  dimension: avg_startup_time_seconds { type: number sql: ${TABLE}.avg_startup_time_seconds ;; }
  dimension: max_startup_time_seconds { type: number sql: ${TABLE}.max_startup_time_seconds ;; }
  dimension: restarts              { type: number sql: ${TABLE}.restarts ;; }
  dimension: failures              { type: number sql: ${TABLE}.failures ;; }
  
  filter: dt_filter {
    type: date
    sql: DATE(${TABLE}.dt) ;;
  }
}


view: scheduler_metrics {
  sql_table_name: `fulfillment-dwh-production.cl_datahub_services.scheduler_metrics` ;;
  
  dimension: dt {
    type: date
    sql: ${TABLE}.dt ;;
  }
  
  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }
  
  dimension: env {
    type: string
    sql: ${TABLE}.env ;;
  }
  
  dimension: avg_startup_time_seconds {
    type: number
    sql: ${TABLE}.avg_startup_time_seconds ;;
  }
  
  dimension: max_startup_time_seconds {
    type: number
    sql: ${TABLE}.max_startup_time_seconds ;;
  }
  
  dimension: restarts {
    type: number
    sql: ${TABLE}.restarts ;;
  }
  
  dimension: failures {
    type: number
    sql: ${TABLE}.failures ;;
  }
  
  dimension: uptime {
    type: number
    sql: ${TABLE}.uptime ;;
  }
  
  filter: dt_filter {
    type: date
    sql: DATE(${TABLE}.dt) ;;
  }
}
view: task_slo_breaches_stddev {
  sql_table_name: `fulfillment-dwh-production.cl_datahub_services.task_slo_breaches_stddev` ;;
  
  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }
  
  dimension: hour {
    type: number
    sql: ${TABLE}.hour ;;
  }
  
  dimension: failure_reason {
    type: string
    sql: ${TABLE}.failure_reason ;;
  }
  
  dimension: total_failures {
    type: number
    sql: ${TABLE}.total_failures ;;
  }
  
  dimension: avg_failures_last_x_days {
    type: number
    sql: ${TABLE}.avg_failures_last_x_days ;;
  }
  
  dimension: stddev_failures_last_x_days {
    type: number
    sql: ${TABLE}.stddev_failures_last_x_days ;;
  }
  
  dimension: is_breach {
    type: yesno
    sql: ${TABLE}.is_breach ;;
  }
  
  filter: created_date_filter {
    type: date
    sql: ${TABLE}.created_date ;;
  }
}

view: logging_cloud {
  sql_table_name: `fulfillment-dwh-production.cl_datahub_services.logging_cloud` ;;
  
  dimension: timestamp {
    type: date
    sql: ${TABLE}.timestamp ;;
  }
  
  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }
  
  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }
  
  dimension: insert_id {
    type: string
    sql: ${TABLE}.insert_id ;;
  }
  
  dimension: dag_id {
    type: string
    sql: ${TABLE}.dag_id ;;
  }
  
  dimension: task_id {
    type: string
    sql: ${TABLE}.task_id ;;
  }
  
  dimension: pod_name {
    type: string
    sql: ${TABLE}.pod_name ;;
  }
  
  # Calculated field: last 8 characters of pod_name
  dimension: pod_name_short {
    type: string
    sql: RIGHT(${TABLE}.pod_name, 8) ;;
  }
  
  dimension: try_number {
    type: string
    sql: ${TABLE}.try_number ;;
  }
  
  dimension: max_tries {
    type: string
    sql: ${TABLE}.max_tries ;;
  }
  
  dimension: task_state {
    type: string
    sql: ${TABLE}.task_state ;;
  }
  
  dimension: executor_state {
    type: string
    sql: ${TABLE}.executor_state ;;
  }
  
  dimension: job_id {
    type: string
    sql: ${TABLE}.job_id ;;
  }
  
  dimension: scheduler {
    type: string
    sql: ${TABLE}.scheduler ;;
  }
  
  # Calculated field: replace 'datahub-airflow-scheduler-' with empty string
  dimension: scheduler_short {
    type: string
    sql: REPLACE(${TABLE}.scheduler, 'datahub-airflow-scheduler-', '') ;;
  }
  
  dimension: text_payload {
    type: string
    sql: ${TABLE}.text_payload ;;
  }
  
  dimension: created_date {
    type: date
    sql: ${TABLE}.created_date ;;
  }
  
  dimension: is_final_state {
    type: yesno
    sql: ${TABLE}.is_final_state ;;
  }
  
  dimension: is_task_log {
    type: yesno
    sql: ${TABLE}.is_task_log ;;
  }
  
  dimension: failure_root {
    type: string
    sql: ${TABLE}.failure_root ;;
  }
  
  dimension: error_type {
    type: string
    sql: ${TABLE}.error_type ;;
  }
  
  dimension: run_id {
    type: string
    sql: ${TABLE}.run_id ;;
  }
  
  dimension: run_id_from_task {
    type: string
    sql: ${TABLE}.run_id_from_task ;;
  }
  
  dimension: airflow_link {
    type: string
    sql: ${TABLE}.airflow_link ;;
  }
  
  dimension: is_dag_critical {
    type: yesno
    sql: ${TABLE}.is_dag_critical ;;
  }
  
  filter: created_date_filter {
    type: date
    sql: ${TABLE}.created_date ;;
  }
}
