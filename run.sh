#!/bin/bash

# run.sh — executa una classe amb main del projecte.
# Ús: ./run.sh com.project.Classe [arguments del programa...]
#   ./run.sh com.project.PR110ReadFile
#   ./run.sh com.project.PR112cat data/GestioTasques.java
#   ./run.sh com.project.PR115cp data/origen.txt data/desti.txt

export MAVEN_OPTS="--add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.nio=ALL-UNNAMED --add-opens java.base/java.util=ALL-UNNAMED"

if [ -z "$1" ]; then
    echo "Ús: ./run.sh <classe.principal> [arguments...]"
    exit 1
fi

mainClass=$1
shift
execArgs="$*"

echo "Main Class: $mainClass"
echo "Arguments:  $execArgs"

mvn clean test-compile exec:java -PrunMain "-Dexec.mainClass=$mainClass" "-Dexec.args=$execArgs"
