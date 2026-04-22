#!/bin/bash
set -e

source .env 2>/dev/null || true

case "$1" in
  start)
    docker compose up -d
    ;;
  stop)
    docker compose down
    ;;
  reset)
    docker compose down -v
    docker compose up -d
    ;;
  reload)
    echo "Reloading data..."
    docker exec -i orders-db mysql \
      -u "${MYSQL_USER:-orders_user}" \
      -p"${MYSQL_PASSWORD:-orders_pass}" \
      orders < ./init/02_load_data.sql
    echo "Done."
    ;;
  logs)
    docker compose logs -f orders-db
    ;;
  mysql)
    docker exec -it orders-db mysql \
      -u "${MYSQL_USER:-orders_user}" \
      -p"${MYSQL_PASSWORD:-orders_pass}" \
      orders
    ;;
  verify)
    docker exec -i orders-db mysql \
      -u "${MYSQL_USER:-orders_user}" \
      -p"${MYSQL_PASSWORD:-orders_pass}" \
      orders -e "
SELECT 'orders'        AS tbl, COUNT(*) AS rows FROM orders
UNION ALL
SELECT 'order_details',         COUNT(*) FROM order_details
UNION ALL
SELECT 'sales_targets',         COUNT(*) FROM sales_targets;"
    ;;
  *)
    echo "Usage: $0 {start|stop|reset|reload|logs|mysql|verify}"
    exit 1
    ;;
esac
