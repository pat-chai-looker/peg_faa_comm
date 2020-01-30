view: carriers {
  sql_table_name: faa.carriers ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: nickname {
    type: string
    sql: ${TABLE}.nickname ;;
  }

  filter: nick_filter {
    suggest_dimension: nickname
  }

  dimension: testfilter {
    sql: (select * from flights where {% condition nick_filter %} airline {% endcondition %}) ;;
  }

  measure: count {
    type: count
    drill_fields: [id, nickname, name, flights.count]
  }
}
