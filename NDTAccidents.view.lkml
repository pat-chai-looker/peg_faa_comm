include: "accidents.explore.lkml"
view: ndtaccidents {
  derived_table: {
 explore_source: accidents{
   column: air_carrier {}
#sql: select air_carrierb from ${accidents.SQL_TABLE_NAME} ;;
}
}
dimension: air_carrier {}

}
