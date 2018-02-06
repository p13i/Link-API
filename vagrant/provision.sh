#!/bin/bash

# Provisioning scripts for Vagrant VM

# Get the first command line argument and set it as the project name variable
PROJECT_NAME=$1
DB_NAME=$PROJECT_NAME
VIRTUALENV_NAME=$PROJECT_NAME
PROJECT_DIR=/vagrant/$PROJECT_NAME
VIRTUALENV_DIR="$PROJECT_DIR""/venv"

echo "*** UPDATING UBUNTU REQUIREMENTS"
sudo apt-get update -y

# Install pip for Python 3.5
if ! command -v pip3; then
    echo "*** INSTALLING PIP"
    sudo apt-get install python3-pip -y
fi

# PostgreSQL
if ! command -v psql; then
    echo "*** INSTALLING POSTGRESQL"
    sudo apt-get install -y postgresql libpq-dev
fi

# Create database
DB_USERNAME=$PROJECT_NAME
DB_PASSWORD=$PROJECT_NAME
DB_NAME="${PROJECT_NAME}_db"
DB_HOST="127.0.0.1"
DB_PORT=5432

# Construct a DATABASE_URL so it can be used in the settings.py file
DATABASE_URL="postgres://$DB_USERNAME:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME"

# Setup
sudo su - postgres -c "psql -c \"create user $DB_USERNAME with password '$DB_PASSWORD';\"";
sudo su - postgres -c "psql -c \"create database $DB_NAME with owner $DB_USERNAME;\"";
sudo su - postgres -c "psql -c \"alter user $DB_USERNAME with superuser;\""

pip3 install --upgrade pip
# Install the virtualenv
if [[ ! -f /usr/local/bin/virtualenv ]]; then
    sudo pip3 install virtualenv
fi

# Setup the project's virtualenv
sudo virtualenv --python=/usr/bin/python3 --always-copy "$VIRTUALENV_DIR"
source "$VIRTUALENV_DIR/bin/activate"
# Install the requirements
echo "*** INSTALLING REQUIREMENTS"
pip install -r "/vagrant/requirements.txt"

echo "*** SETTING DATABASE_URL=$DATABASE_URL in $PROJECT_DIR/$PROJECT_NAME/.env"
# Set the database URL variable in the .env (picked up by dotenv package)
echo DATABASE_URL=\"$DATABASE_URL\" >> "$PROJECT_DIR/$PROJECT_NAME/.env"

MANAGE_PY="$PROJECT_DIR/manage.py"

# Migrate the newly set up database
python "$MANAGE_PY" migrate
