#!/usr/bin/env bash
set -e

export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y postgresql postgresql-contrib

PGUSER="vagrant"
PGPASS="vagrant"
PGDB="tallerdb"

# crear usuario y base
sudo -u postgres psql -tc "SELECT 1 FROM pg_roles WHERE rolname='${PGUSER}'" | grep -q 1 || sudo -u postgres psql -c "CREATE USER ${PGUSER} WITH PASSWORD '${PGPASS}';"
sudo -u postgres psql -tc "SELECT 1 FROM pg_database WHERE datname='${PGDB}'" | grep -q 1 || sudo -u postgres psql -c "CREATE DATABASE ${PGDB} OWNER ${PGUSER};"

# crear tabla y datos si no existen
sudo -u postgres psql -d ${PGDB} <<SQL
CREATE TABLE IF NOT EXISTS productos (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100),
  precio NUMERIC(10,2)
);
INSERT INTO productos (nombre, precio)
  SELECT 'Pan', 1200.00
  WHERE NOT EXISTS (SELECT 1 FROM productos WHERE nombre='Pan');
INSERT INTO productos (nombre, precio)
  SELECT 'Arepa', 800.00
  WHERE NOT EXISTS (SELECT 1 FROM productos WHERE nombre='Arepa');
SQL

# permitir conexiones desde la red privada (192.168.56.0/24)
PG_VER=$(psql -V | awk '{print $3}' | cut -d'.' -f1)
PG_CONF="/etc/postgresql/${PG_VER}/main/postgresql.conf"
PG_HBA="/etc/postgresql/${PG_VER}/main/pg_hba.conf"
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" "${PG_CONF}"
echo "host    all             all             192.168.56.0/24            md5" >> "${PG_HBA}"
systemctl restart postgresql
