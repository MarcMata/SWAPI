#!/usr/bin/env bash

# Show logo
echo -e "\033[33m$(cat images/star_wars.txt)\033[0m"

# Get category
echo -n "What do you want to search for?"
read type
echo "You entered: $type"

# Declare an associative array to store API endpoints
declare -A endpoints=(
    ["1"]="films"
    ["2"]="people"
    ["3"]="planets"
    ["4"]="species"
    ["5"]="starships"
    ["6"]="vehicles"
)


# Get subcategory
echo -n "What inside $type do you want to search for?"
read searchTerm
echo "Searching for: $searchTerm"

# Query API
api_url="https://swapi.dev/api/$type/?search=$searchTerm"
response=$(curl -s "$api_url")

if [ $? -eq 0 ]
then
    echo $response | jq
else
    echo "Error: Failed to retrieve star wars data"
fi


#1 run the script
#2 opens a terminal with a death star
#3 menu for first search
#4 Second search
#5 displays results
#6 run again (loop) or exit (Exit)

# Ascii art

http://www.ascii-art.de/ascii/s/starwars.txt