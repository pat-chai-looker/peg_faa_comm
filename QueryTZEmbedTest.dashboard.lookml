- dashboard: querytzembedtest
  title: QueryTZEmbedTest
  layout: newspaper
  elements:
  - title: New Tile
    name: New Tile
    model: mysql_model
    explore: mysql_users
    type: looker_grid
    fields: [mysql_orders.created_time]
    filters:
      mysql_orders.created_date: after 2019/04/26
    sorts: [mysql_orders.created_time desc]
    limit: 500
    query_timezone: user_timezone
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    series_cell_visualizations:
      mysql_orders.count:
        is_active: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '20'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: []
    y_axes: []
    row: 0
    col: 0
    width: 8
    height: 6
  - title: shows time saved as view time zone
    name: shows time saved as view time zone
    model: peg_redshift_faa
    explore: accidents
    type: table
    fields: [accidents.event_time]
    sorts: [accidents.event_time desc]
    limit: 500
    query_timezone: user_timezone
    hidden_fields: []
    y_axes: []
    row: 0
    col: 8
    width: 8
    height: 6
  - title: today's tile with viewer timezone
    name: today's tile with viewer timezone
    model: peg_redshift_faa
    explore: accidents
    type: table
    fields: [accidents.event_time]
    sorts: [accidents.event_time desc]
    limit: 500
    query_timezone: user_timezone
    hidden_fields: []
    y_axes: []
    row: 0
    col: 16
    width: 8
    height: 6
  filters:
  - name: testdate
    title: testdate
    type: field_filter
    default_value: 7 days
    allow_multiple_values: true
    required: false
    model: peg_redshift_faa
    explore: accidents
    listens_to_filters: []
    field: accidents.event_date
