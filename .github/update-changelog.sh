#!/bin/sh

git fetch

last_version=$(git tag --sort=committerdate | tail -1)

penultimate_version=$(git describe --abbrev=0 --match="v*" --tags HEAD~)

release=${last_version#?}

tags=$penultimate_version..$last_version

content=$(cat README.md)

if printf -- '%s' "$content" | egrep -q -- "= $release ="
then
  echo  "Changelog updated"
else 
    pull_requests=$(git log $tags --merges  --format="* %b")

    if test -z "$pull_requests" 

    then
        echo "Not found pull requests"
    else
        echo "$pull_requests" > CHANGELOG.tmp

        line_started_changelog=$(awk '/== Changelog ==/{ print NR; exit }' README.md)

        line_started_changelog=$((line_started_changelog + 1))

        sed -i $line_started_changelog" i\ " README.md

        while read pull; do
            sed -i $line_started_changelog" i\ ${pull}" README.md
        done <CHANGELOG.tmp

        rm CHANGELOG.tmp

        sed -i $line_started_changelog" i\= ${release} =" README.md

        sed -i $line_started_changelog" i\ " README.md

        if [ -n "$2" ]; then
            git config --global user.email $2
        fi

        if [ -n "$3" ]; then
        git config --global user.name $3
        fi

        git checkout $1
        
        git fetch

        git add README.md

        git commit -m "update changelog plugin"

        git push origin $1 --force

    fi
fi