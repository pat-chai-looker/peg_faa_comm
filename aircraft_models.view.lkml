view: aircraft_models {
  sql_table_name: faa.aircraft_models ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

#dimension:fieldref {
#  sql: ${accidents.id} ;;
#}

  dimension: aircraft_category_id {
    type: number
    sql: ${TABLE}.aircraft_category_id ;;
  }

  dimension: aircraft_engine_type_id {
    type: number
    sql: ${TABLE}.aircraft_engine_type_id ;;
  }

  dimension: aircraft_type_id {
    type: number
    sql: ${TABLE}.aircraft_type_id ;;
  }

  dimension: amateur {
    type: number
    sql: ${TABLE}.amateur ;;
  }

  dimension: engines {
    type: number
    sql: ${TABLE}.engines ;;
  }

  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }

 dimension: model_contains_manu_d {
   type: yesno
   sql:  ${model} LIKE '%'||${manufacturer}||'%'  ;;
 }

filter: model_contains_manu_y {
  type: yesno
  sql: {% if turn_on_filter._parameter_value == "true" %} ${model} LIKE '%'||${manufacturer}||'%'
  {% else %} 1=1
    {% endif %};;
}

  filter: model_contains_manu_f {
    suggestions: ["yes"]
    sql:  ${model} LIKE '%'||${manufacturer}||'%'  ;;
  }

parameter: turn_on_filter{
  type: yesno
}

  dimension: seats {
    type: number
    sql: ${TABLE}.seats ;;
  }

  dimension: speed {
    type: number
    sql: ${TABLE}.speed ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  measure: count {
    type: count
    drill_fields: [id, aircrafts.count]
  }

  measure: seat_total {
    type: sum
    sql: ${seats} ;;
  }
}
