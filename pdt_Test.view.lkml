view: test_publish_pls {
  derived_table: {
    publish_as_db_view: yes
    sql_trigger_value: SELECT DATE_PART('hour', GETDATE());;
    create_process: {
      sql_step: CREATE TABLE ${SQL_TABLE_NAME} (
        aircraft_engine_type_id int,
        city varchar(100)
        );;
  sql_step:
  CREATE TABLE ${SQL_TABLE_NAME}(aircraft_engine_type_id, city)
  SELECT
  aircraft_engine_type_id  AS "aircrafts.aircraft_engine_type_id",
  city  AS "aircrafts.city"
FROM faa.accidents  AS accidents
LEFT JOIN faa.aircrafts  AS aircrafts ON accidents.aircraft_id = aircrafts.id

GROUP BY 1,2
ORDER BY 1
LIMIT 500
       ;;
  }
  }


  dimension: aircrafts_ngine_type {
    type: string
    sql: ${TABLE}."aircraft_engine_type_id";;
  }

  dimension: aircrafts_city {
    type: string
    sql: ${TABLE}."city";;
  }


}
