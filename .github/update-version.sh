#!/bin/sh

git fetch

last_version=$(git tag --sort=committerdate | tail -1)

new_release=${last_version#?}

echo 'New release version' $new_release

content=$(cat  "changelog-update-wordpress.php")

old_version=$(grep -h "Version" changelog-update-wordpress.php)

result=$(echo "$content" | sed "s/$old_version/Version: $new_release/")

printf "$result" > changelog-update-wordpress.php

git config --global user.email "vinicius.tessmann@melhorenvio.com"

git config --global user.name "Bot updater"

git add changelog-update-wordpress.php

git commit -m "update version"

git push origin main --force
