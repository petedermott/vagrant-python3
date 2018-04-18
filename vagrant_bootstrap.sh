#!/bin/bash

# Install git for version control, pip for install python packages
echo 'Installing git, Python 3, and pip...'
# libfreetype6-dev ziblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get -y update
sudo apt-get install python3.6
sudo apt-get -qq install git build-essential python3 python-dev python3.6-dev libjpeg-dev libtiff5-dev zlib1g-dev libssl-dev libffi-dev python-dev > /dev/null 2>&1
sudo apt-get python3-dev python3-pip python3-cffi libcairo2 libpango-1.0-0 libpangocairo-1.0-0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info > /dev/null 2>&1
curl -s https://bootstrap.pypa.io/get-pip.py | python3.6 > /dev/null 2>&1
sudo apt-get install linux-headers-$(uname -r) build-essential dkms

echo 'Installing heroku CLI...'
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

echo 'Installing Redis...'
sudo apt-get install redis-server
sudo systemctl enable redis

echo 'Installing node...'
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

echo 'Installing memcached...'
sudo apt-get install memcached libmemcached-dev zlib1g-dev > /dev/null 2>&1

echo 'Installing and configuring virtualenv and virtualenvwrapper...'
pip install --quiet virtualenvwrapper Pygments
pip install --upgrade wheel
mkdir ~vagrant/virtualenvs
chown vagrant:vagrant ~vagrant/virtualenvs
printf "\n\n# Virtualenv settings\n" >> ~vagrant/.bashrc
printf "export PYTHONPATH=/usr/lib/python3.6" >> ~vagrant/.bashrc
printf "export WORKON_HOME=~vagrant/virtualenvs\n" >> ~vagrant/.bashrc
printf "export PROJECT_HOME=/vagrant\n" >> ~vagrant/.bashrc
printf "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.6\n" >> ~vagrant/.bashrc
printf "source /usr/local/bin/virtualenvwrapper.sh\n" >> ~vagrant/.bashrc
mkdir /vagrant/projects

# Some useful aliases for getting started, MotD
echo 'Setting up message of the day, and some aliases...'
sudo cp /vagrant/examples/motd.txt /etc/motd
printf "\nUseful Aliases:\n" >> ~vagrant/.bashrc
printf "alias menu='cat /etc/motd'\n" >> ~vagrant/.bashrc
printf "alias runserver='python manage.py runserver 0.0.0.0:8000'\n" >> ~vagrant/.bashrc
printf "alias ccat='pygmentize -O style=monokai -f terminal -g'\n" >> ~vagrant/.bashrc

# Set up Postgres last to make sure we set a user password
echo 'Setting up Postgres...'
sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-9.6 postgresql-contrib > /dev/null 2>&1
sudo -u postgres psql -c "\password"
sudo update-rc.d postgresql-9.5 enable
export PGUSER=postgres
echo 'Postgres set up... use PGPASSWORD=$Password to use it with Heroku'