#!/bin/bash

# Huawei Cloud auto-update script
# Run this script on Huawei Cloud server

set -e

echo "Starting auto-update from GitHub..."

# Check if in project directory
if [ ! -f "manage.py" ]; then
    echo "ERROR: Please run this script in autoDemo directory"
    exit 1
fi

# Pull latest code
echo "Pulling latest code..."
git pull origin main

if [ $? -eq 0 ]; then
    echo "Code updated successfully"
    
    # Update dependencies
    echo "Updating dependencies..."
    pip3 install -r requirements.txt --upgrade
    
    # Database migrations
    echo "Running database migrations..."
    python3 manage.py makemigrations
    python3 manage.py migrate
    
    # Collect static files
    echo "Collecting static files..."
    python3 manage.py collectstatic --noinput
    
    echo "Update completed!"
    echo ""
    echo "To restart service:"
    echo "1. Development: python3 manage.py runserver 0.0.0.0:8000"
    echo "2. Production: gunicorn autoDemo.wsgi:application --bind 0.0.0.0:8000"
    echo ""
    echo "Access: http://your-server-ip:8000"
    
else
    echo "ERROR: Failed to pull code - check network and Git config"
    exit 1
fi