git fetch

last_version=$(git tag --sort=committerdate | tail -1)

versions=$(git tag --sort=committerdate | tail -2)

release=${last_version#?}

tags=$(echo $versions | tr ' '  '..')

echo 'New release version' $release

echo 'Tags' $tags