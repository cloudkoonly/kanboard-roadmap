#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored messages
print_message() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    print_error "Please run as root"
    exit 1
fi

# Require
print_message "Installing requirements..."
print_message "1. docker"
print_message "2. docker-compose"
print_message "3. lite-lnmp (github.com/cloudkoonly/lite-lnmp)"
print_message "4. kanboard-roadmap (put this folder in lite-lnmp/app/)"
read -p "Press y/n to continue or exit: " response && [ "$response" = "y" ] || exit 1 && echo "..."


# Step 1: check lite-lnmp repository if exists
print_message "Checking for lite-lnmp repository..."
if [ ! -d "../lite-lnmp" ]; then
    print_error "Not found lite-lnmp repository, please clone lite-lnmp repository first..."
    exit 1
fi
print_success "Found lite-lnmp repository"

# Step 2: Copy SQL file to mysql directory
print_message "Copying SQL file..."
cp kanboard-roadmap/db.sql ../mysql8/sql/
if [ $? -ne 0 ]; then
    print_error "Failed to copy SQL file"
    exit 1
fi
print_success "SQL file copied successfully"

# Step 3: Create database and import SQL
print_message "Setting up database..."
docker exec -i mysql8 mysql -uroot -p123456 <<EOF
CREATE DATABASE IF NOT EXISTS roadmap;
USE roadmap;
source /tmp/sql/db.sql;
EOF

if [ $? -ne 0 ]; then
    print_error "Failed to set up database"
    exit 1
fi
print_success "Database setup completed"

# Step 4: Configure nginx
print_message "Configuring nginx..."
if [ -f "/etc/nginx/conf.d/roadmap.conf" ]; then
    print_message "Backing up existing nginx config..."
    mv /etc/nginx/conf.d/roadmap.conf /etc/nginx/conf.d/roadmap.conf.bak
fi

cp kanboard-roadmap/nginx.conf /etc/nginx/conf.d/roadmap.conf
if [ $? -ne 0 ]; then
    print_error "Failed to configure nginx"
    exit 1
fi
print_success "Nginx configured successfully"


# Step 5: Restart docker containers
print_message "Restarting docker containers..."
docker-compose up -d
if [ $? -ne 0 ]; then
    print_error "Failed to restart docker containers"
    exit 1
fi
print_success "Docker containers restarted successfully"

print_success "Installation completed!"
echo -e "${GREEN}You can now access:${NC}"
echo -e "Frontend: ${BLUE}http://roadmap.dev/roadmap/${NC}"
echo -e "Admin: ${BLUE}http://roadmap.dev/${NC}"
echo -e "${RED}Important:${NC} Default admin credentials are:"
echo -e "Username: ${BLUE}admin${NC}"
echo -e "Password: ${BLUE}123456${NC}"
echo -e "${RED}Please change the admin password after first login!${NC}"
