#!/bin/bash

set -e

# Function to build the application
build() {
    echo "Building the application..."

    cd src && javac \
        -sourcepath java/ \
        --module-path $PATH_TO_FX \
        --add-modules javafx.controls,javafx.fxml java/gr/ntua/medialab/application/App.java
    
    cd ..
}

# Function to run the application
run() {
    echo "Running the application..."

    cd src && java \
        # Specifying a different output folder for the classfiles will break the program,
        # unless you make copies of the various "fxml" folders and the "resources" folder,
        # as paths inside the program are all relative.
        -cp java/ \
        --module-path $PATH_TO_FX \
        --add-modules javafx.controls,javafx.fxml gr.ntua.medialab.application.App

    cd ..
}

# Function to delete the application's class files
cleanup() {
    echo "Cleaning up..."

    find src/java -type f -name "*.class" -delete
}

# Main logic
if [[ -z $PATH_TO_FX ]]; then
    echo "\$PATH_TO_FX is not set"
    exit 1
fi

build

if [[ "$1" == "--build-only" ]]; then
    exit 0

run
