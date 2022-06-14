#!/bin/bash

git fetch

last_version=$(git tag --sort=committerdate | tail -1)

versions=$(git tag --sort=committerdate | tail -2)

release=${last_version#?}

tags=$(echo $versions | tr ' '  '..')

echo 'New release version' $release

echo 'Tags' $tags

echo $(> CHANGELOG.md);

x=$(echo "== Changelog ==")
echo "$x" >> CHANGELOG.md

x=$(echo "= ${release} =")
echo "$x" >> CHANGELOG.md

pull_requests=$(git log v5.0.0..v6.0.0 --merges  --format="* %b" >> CHANGELOG.md)

delimiter="Merge pull request #"

git log v5.0.0..v6.0.0 --merges  --format="* %b"

echo $pull_requests