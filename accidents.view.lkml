view: accidents {
  sql_table_name: faa.accidents ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: accident_number {
    type: string
    sql: ${TABLE}.accident_number ;;
  }

  dimension: air_carrier {
    type: string
    sql: ${TABLE}.air_carrier ;;
  }

  dimension: aircraft_category {
    type: string
    sql: ${TABLE}.aircraft_category ;;
  }

  dimension: aircraft_damage {
    type: string
    sql: ${TABLE}.aircraft_damage ;;
  }

  dimension: aircraft_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.aircraft_id ;;
  }

  dimension: airport_code {
    type: string
    sql: ${TABLE}.airport_code ;;
  }

  dimension: airport_name {
    type: string
    sql: ${TABLE}.airport_name ;;
  }

  dimension: amateur_built {
    type: string
    sql: ${TABLE}.amateur_built ;;
  }

  dimension: broad_phase_of_flight {
    type: string
    sql: ${TABLE}.broad_phase_of_flight ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: engine_type {
    type: string
    sql: ${TABLE}.engine_type ;;
  }

  dimension_group: event {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      week_of_year,
      month_name,
      hour_of_day,
      hour12,
      day_of_year,
      day_of_month,
      month_num,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.event_date ;;
  }
  dimension_group: event_hide {
    type: time
    timeframes: [
      raw,
   #   time,
      date,
      day_of_week,
      week,
      week_of_year,
      month_name,
      hour_of_day,
      hour12,
      day_of_year,
      day_of_month,
      month_num,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.event_date ;;
  }
  measure: most_recent_event{
    type: date
    sql:  max(${event_raw}) ;;
  }

  dimension: hour_12 {
    type: number
    sql: case when ${event_hour_of_day} <13 then ${event_hour_of_day} else ${event_hour_of_day}-12 end;;
  }

 dimension: monthweek {
   type: string
   sql: ${event_month_name}|| '-' || cast(${event_week_of_year} as varchar) ;;
 }

  dimension: event_id {
    type: string
    sql: ${TABLE}.event_id ;;
  }

  dimension: far_description {
    type: string
    sql: ${TABLE}.far_description ;;
  }

  dimension: injury_severity {
    type: string
    sql: ${TABLE}.injury_severity ;;
  }

  dimension: investigation_type {
    type: string
    sql: ${TABLE}.investigation_type ;;
  }

  dimension: latitude {
    type: string
    sql: ${TABLE}.latitude ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: longitude {
    type: string
    sql: ${TABLE}.longitude ;;
  }

  dimension: make {
    type: string
    sql: ${TABLE}.make ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }

  dimension: number_of_engines {
    type: number
    sql: ${TABLE}.number_of_engines ;;
  }

  dimension: number_of_fatalities {
    type: number
    sql: ${TABLE}.number_of_fatalities ;;
  }

  dimension: higher_fa  {
    type: number
    sql: case when {% parameter threshhold | times 5 %} < ${number_of_fatalities} then ${number_of_fatalities} else {% parameter threshhold | times 5 %} end ;;
  }

  dimension: testTimes {
    type: number
    sql: {% assign var=accidents.threshhold._parameter_value | times: 5.0 %}{{var}} ;;
  }
  dimension: showParm {
    type: number
    sql: {% parameter threshhold %} ;;
  }

  dimension: number_of_minor_injuries {
    type: number
    sql: ${TABLE}.number_of_minor_injuries ;;
  }

  dimension: number_of_serious_injuries {
    type: number
    sql: ${TABLE}.number_of_serious_injuries ;;
  }

  dimension: number_of_uninjured {
    type: number
    sql: ${TABLE}.number_of_uninjured ;;
  }

dimension: firstDateLastQ {
  type: date
  sql: date(date_trunc('quarter',(date_add('quarter',-1,current_date)))) ;;
}

  dimension_group: publication {
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
    sql: ${TABLE}.publication_date ;;
  }

  dimension: purpose_of_flight {
    type: string
    sql: ${TABLE}.purpose_of_flight ;;
  }

  dimension: report_status {
    type: string
    sql: ${TABLE}.report_status ;;
  }

  dimension: schedule {
    type: string
    sql: ${TABLE}.schedule ;;
  }

  dimension: weather_condition {
    type: string
    sql: ${TABLE}.weather_condition ;;
  }

  parameter: threshhold {
    type: number
    default_value: "5"
  }

  measure: higher  {
    type: number
    sql: case when {% parameter threshhold | times 5 %} < ${count} then ${count} else {% parameter threshhold | times 5 %} end ;;
  }

  measure: count {
    type: count
    drill_fields: [id, airport_name, aircrafts.id, aircrafts.name]
  }

  measure: count_pop{
    type: percent_of_previous
    sql: ${count} ;;
  }

  measure: count_pop_f {
    type: percent_of_previous
    sql: ${count} ;;
    value_format_name: percent_2
  }
  measure: count_not_null{
    type: yesno
#    sql: ${count} is not null AND (${broad_phase_of_flight}='APPROACH');;
    sql:  ${count} is not null ;;
 }
}
