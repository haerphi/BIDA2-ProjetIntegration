#!/bin/bash

# --help or -h will print the usage
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Usage: $0 [-r] [-d]"
    echo "-r : Remove repositories (will check for uncommited changes and won't remove them)"
    echo "-d : Force remove repositories (will check for uncommited changes and ask confirmation before removing them)"
    echo ""
    echo "This script will remove the containers, volumes, and images of the tennis-club project."
    echo "It will also remove the repositories if -r or -d is used."
    exit 0
fi

REMOVE_REPOSITORIES=false
FORCE_REMOVE_REPOSITORIES=false

# Parse arguments
for arg in "$@"; do
    case $arg in
        -r)
            REMOVE_REPOSITORIES=true
            shift
            ;;
        -d)
            FORCE_REMOVE_REPOSITORIES=true
            shift
            ;;
        *)
            echo "Usage: $0 [-r] [-d]"
            exit 1
            ;;
    esac
done

# shut down the containers
docker compose -p tennis-club down

# remove the volumes
docker volume rm tennis-club_postgres_data
docker volume rm tennis-club_client_node_modules
docker volume rm tennis-club_stripe_config

# remove images
docker rmi tennis-club-api
docker rmi tennis-club-client

if [ "$REMOVE_REPOSITORIES" = true ]; then

    # check if -d is present
    if [ "$FORCE_REMOVE_REPOSITORIES" = true ]; then
        echo "Force removing folders..."
        echo "Warning: This will remove the folders and all their contents."
        echo "Are you sure you want to continue? (y/N)"
        read -r response
        if [ "$response" != "y" ]; then
            echo "Aborting..."
            exit 0
        fi
        rm -rf BIDA2-ProjetIntegration-API
        rm -rf BIDA2-ProjetIntegration-Client
        echo "Folders removed."
        exit 0
    fi
    
    echo "Checking if there are uncommited/unpushed changes in BIDA2-ProjetIntegration-API and BIDA2-ProjetIntegration-Client."
    if ! git diff --quiet BIDA2-ProjetIntegration-API; then
        echo "There are uncommited changes in BIDA2-ProjetIntegration-API. Please commit and push them first. Or use -d to force removal."
        exit 1
    fi
    if ! git diff --quiet BIDA2-ProjetIntegration-Client; then
        echo "There are uncommited changes in BIDA2-ProjetIntegration-Client. Please commit and push them first. Or use -d to force removal."
        exit 1
    fi

    echo "Removing folders..."
    rm -rf BIDA2-ProjetIntegration-API
    rm -rf BIDA2-ProjetIntegration-Client
    echo "Folders removed."
fi