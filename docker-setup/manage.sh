#!/bin/bash
set -e

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
  logs)
    docker compose logs -f orders-db
    ;;
  mysql)
    docker exec -it orders-db mysql -u "${MYSQL_USER:-orders_user}" -p"${MYSQL_PASSWORD:-orders_pass}" orders
    ;;
  *)
    echo "Usage: $0 {start|stop|reset|logs|mysql}"
    exit 1
    ;;
esac
