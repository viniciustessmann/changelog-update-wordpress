#!/bin/sh

git fetch

last_version=$(git tag --sort=committerdate | tail -1)

new_release=${last_version#?}

echo 'New release version' $new_release 'by' $1 'on branch' $2

content=$(cat  "$1")

old_version=$(grep -h "Version" $1)

result=$(echo "$content" | sed "s/$old_version/Version: $new_release/")

printf "$result" > $1

git config --global user.email "vinicius.tessmann@melhorenvio.com"

git config --global user.name "Bot updater"

git checkout $2

git fetch

git add $1

git commit -m "update version"

git push origin $2 --force
