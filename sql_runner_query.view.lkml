
view: sql_runner_query {
  derived_table: {
    sql: SELECT AVG(derived_table.orders_count)
      FROM 
      (SELECT
          users.city AS users_city,
          COUNT(DISTINCT orders.id ) AS orders_count
      FROM
          demo_db.order_items AS order_items
          LEFT JOIN demo_db.orders AS orders ON order_items.order_id = orders.id
          LEFT JOIN demo_db.users AS users ON orders.user_id = users.id
      GROUP BY
          users_city
      ORDER BY
          orders_count DESC) AS derived_table ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: avgderived_table_orders_count {
    type: number
    sql: ${TABLE}.`AVG(derived_table.orders_count)` ;;
  }

  set: detail {
    fields: [
        avgderived_table_orders_count
    ]
  }
}
