#!/bin/sh

### DESCRIPTION
# Script to deploy TravelNest system.
# Additionally you can run it while compose is running,
# automatically containers will be removed and recreated from scratch.

### EXIT CODES
#  0 - Success
#  1 - Docker daemon is not running
#  2 - Failed to change directory
#  3 - Failed to read .env file

### CHANGE LOG
# Author:   Stanisław Horna
# GitHub Repository:  https://github.com/PLProjektKompetencyjny/PK_6IO1z_Projekt4
# Created:  21-May-2024
# Version:  1.0

# Date            Who                     What
#

# define echo colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
RESET='\033[0m'

Main() {
    checkDockerDaemonRunning
    askUserAboutStorageRemoval
    stopRunningContainers
    removePersistantStorage
    buildCompose
    startCompose
    showComposeStatus
}

checkDockerDaemonRunning() {

    # check if docker is running
    if docker ps -a -q -f name="Certainly Not Exist"; then
        printGreenMessage "Docker daemon is running"
    else
        printRedMessage "Docker daemon is not running"
        exit 1
    fi
}

askUserAboutStorageRemoval() {

    response=""
    while [ "$response" != "y" ] && [ "$response" != "n" ]; do
        echo "Remove persistent data? [y/n]: \c"
        read -r response
    done
}

stopRunningContainers() {

    docker compose down
}

removePersistantStorage() {

    if [ "$response" = "y" ]; then
        printYellowMessage "Removing persistant storage"

        dirPath=$(getDotenvVariable "HOST_PERSISTENT_DATA_PATH")
        sudo rm -fr "$dirPath"

    fi
}

buildCompose() {

    printYellowMessage "Building compose containers"

    docker compose build
}

startCompose() {

    printYellowMessage "Starting compose containers"

    docker compose up -d --force-recreate
}

showComposeStatus() {

    docker compose ps
}

getDotenvVariable() {
    VariableName=$1

    # Check if .env file exist
    if [ -e .env ]; then

        # grep variable name from .env file
        # split it by = and print second element
        # sed to remove spaces before any char and after the latest one
        grep "$VariableName" .env | awk -F= '{print $2}' | sed 's/^[   ]*//;s/[    ]*$//'
    else
        exit 3
    fi
}

printGreenMessage() {
    Message=$1

    echo ""
    echo "${GREEN}$Message${RESET}"
    echo ""
}

printRedMessage() {
    Message=$1

    echo ""
    echo "${RED}$Message${RESET}"
    echo ""
}

printYellowMessage() {
    Message=$1

    echo ""
    echo "${YELLOW}$Message${RESET}"
    echo ""
}

Main
