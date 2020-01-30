view: last_crashes {
  derived_table: {
    sql: SELECT
        accidents.airport_name  AS "airport_name",
#        id as "crash_id",
        max(accidents.event_date ) AS "lastCrash"
      FROM faa.accidents  AS accidents

      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

#   dimension: crashid {
#     type: number
#     primary_key:  yes
#     sql: ${TABLE}.crash_id ;;
#   }

  dimension: airport_name {
    type: string
    sql: ${TABLE}.airport_name ;;
  }

  dimension_group: lastcrash {
    type: time
    timeframes: [date,raw,time]
    sql: ${TABLE}.lastcrash ;;
  }

  set: detail {
    fields: [airport_name, lastcrash_time]
  }
}
