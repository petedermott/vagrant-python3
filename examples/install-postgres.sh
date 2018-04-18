#!/bin/bash

# I'm probably missing some stuff here, also none of this has been tested

# Install pre-requesite packages
sudo apt-get install postgresql postgresql-contrib

# Set password
echo "ALTER USER postgres PASSWORD 'password';"
echo "\q"

# Create aliases for Heroku
printf "export PGUSER=postgres\n" >> ~vagrant/.bashrc
printf "export PGPASSWORD=password\n" >> ~vagrant/.bashrc

# Copy config files
sudo cp /vagrant/examples/pg_hba.conf /etc/postgres/9.6/main/pg_hba.conf
sudo cp /vagrant/examples/postgresql.conf /etc/postgres/9.6/main/postgresql.conf