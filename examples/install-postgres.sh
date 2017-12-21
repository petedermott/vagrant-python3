#!/bin/bash

# Install pre-requesite packages
sudo apt-get install postgresql postgresql-contrib
echo "ALTER USER postgres PASSWORD 'password';"
echo "\q"

printf "export PGUSER=postgres\n" >> ~vagrant/.bashrc
printf "export PGPASSWORD=password\n" >> ~vagrant/.bashrc

# Copy example files
sudo cp /vagrant/examples/pg_hba.conf /etc/postgres/9.6/main/pg_hba.conf
sudo cp /vagrant/examples/postgresql.conf /etc/postgres/9.6/main/postgresql.conf