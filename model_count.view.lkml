view: model_count {
  derived_table: {
    sql: SELECT manufacturer, count(*) as model_count,case when model_count > 50 then true else false end as is_alot FROM faa.aircraft_models group by 1 order by 2 desc
      ;;
 #     persist_for: "1 hour"
  }

  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
  }

  dimension: model_count {
    type: number
    sql: ${TABLE}.model_count ;;
  }

  dimension: is_alot {
    type: yesno
    sql: ${TABLE}.is_alot ;;
  }

  dimension: is_alot2 {
    type: yesno
    sql:  model_count > 50  ;;
  }

  set: detail {
    fields: [manufacturer, model_count]
  }
}
