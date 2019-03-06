view: flights {
  sql_table_name: faa.flights ;;

  dimension: aircraft_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.aircraft_id ;;
  }

  dimension: arr_delay {
    type: number
    sql: ${TABLE}.arr_delay ;;
  }

  dimension_group: arr {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.arr_time ;;
  }

  dimension: cancelled {
    type: string
    sql: ${TABLE}.cancelled ;;
  }

  dimension: carrier_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.carrier_id ;;
  }

  dimension: dep_delay {
    type: number
    sql: ${TABLE}.dep_delay ;;
  }

  dimension_group: dep {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.dep_time ;;
  }

dimension: between {
  type: duration_second
  sql_end: ${aircrafts.cert_issue_raw} ;;
  sql_start: ${dep_raw} ;;
}
  dimension: betweend {
    type: duration_day
    sql_end: ${aircrafts.cert_issue_raw} ;;
    sql_start: ${dep_raw} ;;
  }

  dimension: betweenf {
    type: string
    sql: CONVERT(varchar, ${between}  / 86400) ||' days '
  ||':'||
  CONVERT(varchar, mod(${between}, 86400)/3600 ) || ' hours ' ;;
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
  }

  dimension: distance {
    type: number
    sql: ${TABLE}.distance ;;
  }

  dimension: diverted {
    type: string
    sql: ${TABLE}.diverted ;;
  }

  dimension: flight_num {
    type: string
    sql: ${TABLE}.flight_num ;;
  }

  dimension: flight_time {
    type: number
    sql: ${TABLE}.flight_time ;;
  }

  dimension: id2 {
    type: number
    sql: ${TABLE}.id2 ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: taxi_in {
    type: number
    sql: ${TABLE}.taxi_in ;;
  }

  dimension: taxi_out {
    type: number
    sql: ${TABLE}.taxi_out ;;
  }

  measure: count {
    type: count
    drill_fields: [carriers.id, carriers.nickname, carriers.name, aircrafts.id, aircrafts.name]
  }
}
