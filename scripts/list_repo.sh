#!/bin/bash

if [ -z $1 ]; then
    echo 'An organization name must be provided'
    exit 1
else
    # Set ORGA with the first args provided to the script
    ORGA=$1
fi

if [ -z $2 ]; then
    # Get the total pages to request with authentication
    NB_PAGES=$(curl -si -I -H "Accept: application/vnd.github.v3+json" https://api.github.com/orgs/$ORGA/repos | grep '^link:' | sed -e 's/^link:.*page=//g' -e 's/>.*$//g')
else
    TOKEN=$2
    # Get the total pages to request with authentication
    NB_PAGES=$(curl -si -I -H "Accept: application/vnd.github.v3+json" -H "Authorization: $TOKEN" https://api.github.com/orgs/$ORGA/repos | grep '^Link:' | sed -e 's/^Link:.*page=//g' -e 's/>.*$//g')
fi

get_repos() {
    # Construct a list with filtered results
    # If some value is null it is replaced by NS (means Not Specified)
    # According to the github documention, pagination always start to 1

    for ((i = 1; i <= $NB_PAGES; i++)); do
        LIST+=$(curl -s -H "Accept: application/vnd.github.v3+json" -H "Authorization: $TOKEN" https://api.github.com/orgs/$1/repos?page=$i |
            jq -r '.[] | [.name, (.language | tostring), (.license.key | tostring)]' |
            sed "s/null/NS/g")
    done

}

echo -e "$ORGA repositories list\n"

get_repos $ORGA $NB_PAGES

# Display a table with filtered results and sort by the first column
echo $LIST |
    jq 'join(" ")' |
    sed "s/\"//g" |
    awk 'BEGIN {printf("%-50s %-20s %-20s \n\n" ,"Name", "Language", "License")} {printf("%-50s %-20s %-20s \n", $1, $2, $3)}' |
    sort -k 1

echo -e "\nNS = Not Specified"
