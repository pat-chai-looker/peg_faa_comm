connection: "faa_redshift"

# include all the views
include: "*.view"
include: "accidents.explore.lkml"
include: "QueryTZEmbedTest.dashboard.lookml"
datagroup: peg_redshift_faa_default_datagroup {
   #sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 minute"
}


explore: test_publish_pls {}
persist_with: peg_redshift_faa_default_datagroup

label: "A Label to Make them Disappear"

explore: aircraft_models {
  sql_always_where: {% if aircraft_models.turn_on_filter._parameter_value == "true" %} ${model} LIKE '%'||${manufacturer}||'%'
  {% else %} 1=1
  {% endif %};;
}

explore: aircrafts {
  join: aircraft_models {
    type: left_outer
    sql_on: ${aircrafts.aircraft_model_id} = ${aircraft_models.id} ;;
    relationship: many_to_one
  }
}

explore: carriers {}

explore: flights {
  join: carriers {
    type: left_outer
    sql_on: ${flights.carrier_id} = ${carriers.id} ;;
    relationship: many_to_one
  }

  join: aircrafts {
    type: left_outer
    sql_on: ${flights.aircraft_id} = ${aircrafts.id} ;;
    relationship: many_to_one
  }

  join: aircraft_models {
    type: left_outer
    sql_on: ${aircrafts.aircraft_model_id} = ${aircraft_models.id} ;;
    relationship: many_to_one
  }
}
explore: last_crashes {}
