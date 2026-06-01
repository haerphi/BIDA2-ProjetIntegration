#!/bin/bash

open_url() {
    if command -v xdg-open > /dev/null; then 
        xdg-open "$1"
    elif command -v open > /dev/null; then 
        open "$1"
    else 
        start "$1"
    fi
}

# $1: env var name,  $2: value, $3: .env file name,
env_place() {
    if grep -q "^$1=" "$3"; then
        sed -i "s|^$1=.*|$1=$2|" "$3"
    else
        if [ -n "$(tail -c1 "$3")" ]; then
            echo "" >> "$3"
        fi
        echo "$1=$2" >> "$3"
    fi  
}

# $1: var name, $2: prompt, $3: file, $4: value
env_check_or_ask() {
    SECRET=$4

    if [ -z "$SECRET" ]; then
        read -p "$2" SECRET
    fi
    
    # Check if user actually entered something
    if [ -z "$SECRET" ]; then
        return 1 # Return failure code if empty
    fi

    env_place "$1" "$SECRET" "$3"
    return 0 # Return success code
}

# Clone repos
if [ ! -d "BIDA2-ProjetIntegration-API" ]; then
    git clone https://github.com/haerphi/BIDA2-ProjetIntegration-API.git
fi

if [ ! -d "BIDA2-ProjetIntegration-Client" ]; then
    git clone https://github.com/haerphi/BIDA2-ProjetIntegration-Client.git
fi

while [ ! -d "BIDA2-ProjetIntegration-API" ] || [ ! -d "BIDA2-ProjetIntegration-Client" ]; do
    sleep 1
done

backend_env="BIDA2-ProjetIntegration-API/.env"
frontend_env="BIDA2-ProjetIntegration-Client/.env"
STRIPE_WEBHOOK_SECRET_SET="true"

if [ ! -f "$backend_env" ]; then
    cp "$backend_env.example" "$backend_env"
    
    env_check_or_ask "GOOGLE_CLIENT_ID" "Enter the Google Client ID: " "$backend_env"
    env_check_or_ask "STRIPE_API_KEY" "Enter the Stripe API Key: " "$backend_env"
    
    STRIPE_WEBHOOK_SECRET_SET="true"
    if ! env_check_or_ask "STRIPE_WEBHOOK_SECRET" "Enter the Stripe Webhook Secret (or press enter to extract from logs): " "$backend_env"; then
        STRIPE_WEBHOOK_SECRET_SET="false"
    fi
else
    if ! grep -q "STRIPE_WEBHOOK_SECRET=whsec_" "$backend_env"; then
        STRIPE_WEBHOOK_SECRET_SET="false"
    fi
fi

if [ ! -f "$frontend_env" ]; then
    cp "$frontend_env.example" "$frontend_env"
    API_GOOGLE_CLIENT_ID=$(grep "GOOGLE_CLIENT_ID" "$backend_env" | cut -d '=' -f2)
    sed -i "s|VITE_GOOGLE_CLIENT_ID=.*|VITE_GOOGLE_CLIENT_ID=$API_GOOGLE_CLIENT_ID|" "$frontend_env"
fi

# check if the containers are running
if ! docker compose -p tennis-club ps | grep -q "Up"; then
    echo "Starting containers..."
    docker compose -p tennis-club up --build -d --force-recreate
    while ! docker compose -p tennis-club ps | grep -q "Up"; do
        sleep 1
    done

    # wait for 5s to be sure everything is ready
    sleep 5
    echo "Containers started!"
fi

# Extract webhook secret from logs if not set manually
if [ "$STRIPE_WEBHOOK_SECRET_SET" = "false" ]; then
    echo "Waiting for Stripe container logs to get the webhook secret..."
    for i in {1..30}; do
        # On essaie de récupérer le secret (vérifie bien le nom du container 'bida2_stripe')
        STRIPE_WEBHOOK_SECRET=$(docker logs bida2_stripe 2>&1 | grep -o 'whsec_[a-zA-Z0-9]*' | head -n 1)
        
        if [ -n "$STRIPE_WEBHOOK_SECRET" ]; then
            echo "Webhook secret found: $STRIPE_WEBHOOK_SECRET"
            env_place "STRIPE_WEBHOOK_SECRET" "$STRIPE_WEBHOOK_SECRET" "$backend_env"
            break
        fi
        sleep 1
    done
fi

# Connect to pg database and check if the admin user exists
echo "Checking if admin user already exists..."
admin_exists=$(docker compose -p tennis-club exec -T db psql -U postgres -d tennis_db -t -c "SELECT EXISTS(SELECT 1 FROM members WHERE affiliation_number = 'admin');" 2>/dev/null | tr -d '[:space:]')

if [ "$admin_exists" = "t" ]; then
    echo "Admin user already exists in the database. Skipping creation."
else
    # Propose to create the admin user
    read -p "Do you want to create an admin user? (y/N) " create_admin
    if [ "$create_admin" = "y" ]; then
        #Get the password
        read -p "Enter the admin password: " admin_password
        
        #Use the command with 
        docker compose -p tennis-club exec -e DJANGO_SUPERUSER_PASSWORD="$admin_password" api python src/manage.py createsuperuser --affiliation_number admin --email admin@example.com --first_name Admin --last_name Admin --noinput

        echo "Admin user created!"
        echo "Login with:
            - email: admin@example.com
            - affiliation_number: admin
            - password: $admin_password"
    fi
fi

# Connect to pg database and check if there is already basics data if not ask if the user wants to use the script (./scripts/seed.sql)
member_count=$(docker compose -p tennis-club exec -T db psql -U postgres -d tennis_db -t -c "SELECT COUNT(*) FROM members;" 2>/dev/null | tr -d '[:space:]')

if [[ "$member_count" =~ ^[0-9]+$ ]] && [ "$member_count" -le 3 ]; then
    read -p "The members table has $member_count records (3 or less). Do you want to run the seed script? (y/N) " run_seed
    if [ "$run_seed" = "y" ]; then
        echo "Running seed script..."
        docker compose -p tennis-club exec -T db psql -U postgres -d tennis_db < ./scripts/seed.sql >/dev/null
        echo "Seeding completed successfully!"
    fi
fi

# Open urls
echo "Opening urls..."
open_url "http://localhost:5173"
open_url "http://localhost:8000/api/docs/"

echo "Everything should be running! Have fun with the application!"