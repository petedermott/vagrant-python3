#!/bin/bash

# Install git for version control, pip for install python packages
echo 'Installing git, Python 3, and pip...'
# libfreetype6-dev ziblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
sudo apt-get -y update
sudo apt-get install curl
sudo apt-get install git build-essential python3 python-dev python3-apt libjpeg-dev libtiff5-dev zlib1g-dev libssl-dev libffi-dev python-dev
sudo apt-get install python3-dev python3-pip python3-cffi libcairo2 libpango-1.0-0 libpangocairo-1.0-0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info 
curl -s https://bootstrap.pypa.io/get-pip.py | python3.6
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
sudo apt-get install memcached libmemcached-dev zlib1g-dev

echo 'Installing Elasticsearch...'
sudo apt-get install default-jre
wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.4.6/elasticsearch-2.4.6.deb
sudo dpkg -i elasticsearch-2.4.6.deb
old="#cluster.name: my-application"
new="cluster.name: my-application"
sudo systemctl enable elasticsearch.service

echo 'Installing and configuring virtualenv and virtualenvwrapper...'
pip3 install --quiet virtualenvwrapper Pygments virtualenv
pip3 install --upgrade wheel
mkdir ~/virtualenvs
printf "\n\n# Virtualenv settings\n" >> ~/.bashrc
printf "export PYTHONPATH=/usr/bin/python3\n" >> ~/.bashrc
printf "export WORKON_HOME=~/virtualenvs\n" >> ~/.bashrc
printf "export PROJECT_HOME=/mnt/c/Users/peterdermott/Documents/django-python-bento\n" >> ~/.bashrc
printf "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3\n" >> ~/.bashrc
printf "source /usr/local/bin/virtualenvwrapper.sh\n" >> ~/.bashrc
mkdir ~/projects

#echo 'Installing PyCharm'
#sudo snap install pycharm-professional --classic
# Some useful aliases for getting started, MotD
echo 'Setting up some aliases...'
printf "\nUseful Aliases:\n" >> ~/.bashrc
printf "alias runserver='python manage.py runserver 0.0.0.0:8000'\n" >> ~/.bashrc
printf "alias ccat='pygmentize -O style=monokai -f terminal -g'\n" >> ~/.bashrc


# Set up Postgres last to make sure we set a user password
echo 'Setting up Postgres...'
sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-10 postgresql-contrib 
sudo service postgresql restart 
sudo -u postgres psql -c "\password"
sudo update-rc.d postgresql-10 enable
export PGUSER=postgres
echo 'Postgres set up... use PGPASSWORD=$Password to use it with Heroku'

sudo apt-get install openssh-server
sudo ufw allow ssh
sudo ufw allow 5432
sudo ufw allow 9200

echo 'All done. You will need to edit /etc/elasticsearch/elasticsearch.yml in accordance to Step 2 of '
echo 'https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-elasticsearch-on-ubuntu-16-04' 
echo 'and then start elasticsearch via sudo systemctl restart elasticsearch'
