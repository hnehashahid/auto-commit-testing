view: alfred_corporate_wallet_topups {
  sql_table_name: `fulfillment-dwh-production.curated_data_shared_fintech.alfred_corporate_wallet_topups` ;;

  dimension_group: _ingested {
    hidden: yes
    type: time
    description: "Timestamp when the record was loaded"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}._ingested_at ;;
  }
  dimension: alfred_balance_transfer_id {
    type: number
    description: "Unique identifier of the corporate topup"
    sql: ${TABLE}.alfred_balance_transfer_id ;;
    group_label: "Identifiers"
  }
  dimension: company_wallet_id {
    type: number
    description: "Unique identifier of the company wallet id of the corporate topup"
    sql: ${TABLE}.company_wallet_id ;;
    group_label: "Identifiers"
  }
  dimension: customer_wallet_id {
    type: number
    description: "Unique identifier of the customer wallet id of the corporate topup"
    sql: ${TABLE}.customer_wallet_id ;;
    group_label: "Identifiers"
  }
  dimension: destination_wallet_account_id {
    type: number
    description: "Unique identifier of the destination wallet account id of the corporate topup"
    sql: ${TABLE}.destination_wallet_account_id ;;
    group_label: "Identifiers"
  }
  dimension: source_wallet_account_id {
    type: number
    description: "Unique identifier of the source wallet account id of the corporate topup"
    sql: ${TABLE}.source_wallet_account_id ;;
    group_label: "Identifiers"
  }
  dimension: company_code {
    type: string
    description: "Unique identifier of the company customer code of the corporate topup"
    sql: ${TABLE}.company_code ;;
  }

  dimension: customer_code {
    type: string
    description: "Unique identifier of the customer code of the corporate topup"
    sql: ${TABLE}.customer_code ;;
  }


  dimension_group: expiration_datetime {
    type: time
    description: "Date of the expiry for the corporate topup in UTC"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.expiration_datetime ;;
  }
  dimension: global_entity_id {
    type: string
    description: "Unique identifier to identify the entity"
    sql: ${TABLE}.global_entity_id ;;
  }

  dimension: status {
    type: string
    description: "the current status of the corporate topup"
    sql: ${TABLE}.status ;;
    group_label: "Topup details"
  }
  dimension: topup_amount_currency {
    type: string
    description: "Currency of the corporate topup"
    sql: ${TABLE}.topup_amount_currency ;;
    group_label: "Topup details"
  }
  dimension: topup_amount_eur {
    type: number
    description: "Corporate top-up amount in euro"
    sql: ${TABLE}.topup_amount_eur ;;
    group_label: "Topup details"
  }
  dimension: topup_amount_lc {
    type: number
    description: "Corporate top-up amount in local currency"
    sql: ${TABLE}.topup_amount_lc ;;
    group_label: "Topup details"
  }
  dimension_group: topup {
    type: time
    description: "Date of the corporate topup in UTC"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.topup_date ;;
  }
  dimension: compound_primary_key {
    type: string
    description: ""
    primary_key: yes
    hidden: yes
    sql: ${global_entity_id} || '_' || ${alfred_balance_transfer_id} ;;
  }
  ## Measures
  measure: total_topup_amount_eur {
    label: "Total Topup Amt (EUR)"
    type: sum
    sql: ${topup_amount_eur} ;;
    value_format_name: eur
  }
  measure: total_topup_amount_lc {
    label: "Total Topup Amt (LC)"
    type: sum
    sql: ${topup_amount_lc} ;;
    value_format_name: decimal_2
  }
  measure: unique_count_customers {
    label: "Unique Users"
    type: count_distinct
    description: "Count of unique customer_code"
    sql: ${customer_code} ;;
  }
  measure: unique_count_transactions {
    label: "# of Topups"
    type: count_distinct
    description: "Count of total corporate wallet top-ups."
    sql: ${compound_primary_key} ;;
  }
  measure: amount_per_customer {
    label: "Avg. Topup Amt (EUR) per User"
    type: number
    sql: ${total_topup_amount_eur}/${unique_count_customers} ;;
    value_format_name: eur
  }
  measure: topups_per_customer {
    label: "Avg. Topups per User"
    type: number
    sql: ${unique_count_transactions}/${unique_count_customers} ;;
    value_format_name: decimal_2
  }
}
