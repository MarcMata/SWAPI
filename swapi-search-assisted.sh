#!/usr/bin/env bash

# Make sure jq is installed
which jq &> /dev/null || {
	echo -e "\033[31mjq not installed\033[0m"
	exit 1
}

# Show logo
echo -e "\033[33m$(cat images/star_wars.txt)\033[0m"

# Get user input for search category
PS3="Select a category to search for: "
options=(films people planets species starships vehicles Quit)
select opt in ${options[@]}
do

case $opt in
	"films"|"people"|"planets"|"species"|"starships"|"vehicles")

		# Get subcategory
		echo -n "Enter a search term for $opt: "
		read searchTerm
		echo "Searching for: $searchTerm"

		# Query API
		api_url="https://swapi.dev/api/$opt/?search=$searchTerm"
		api_url=$(echo $api_url | sed 's/ /%20/g')
		echo -e "\033[31m$api_url\033[0m"
		response=$(curl -s "$api_url")

		# Echo if successful
		if [ $? -eq 0 ]
		then
			echo "$response" | jq
		
		# Expand URLs of result
            expanded_urls=$(echo "$response" | jq -r '.results[].url')
            
            # for i in ${!options[@]}
            # do
			# 	option=${!options[i]}
            #     echo $response | jq ".results[].$option.url"
            # done
		
		else
			echo "Error: Failed to retrieve Star Wars data"
		fi
		;;

	"Quit")
		echo "Exiting..."
		echo -e "\033[32m$(cat images/buffshrek.txt)\033[0m"
		break
		;;
	*)
		echo "Invalid option. Please select a valid category or select 'Quit' to exit."
		;;
esac

done
