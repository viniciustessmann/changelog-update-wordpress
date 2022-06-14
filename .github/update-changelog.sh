git fetch

last_version=$(git tag --sort=committerdate | tail -1)

penultimate_version=$(git describe --abbrev=0 --match="v*" --tags HEAD~)

release=${last_version#?}

echo $last_version

echo $penultimate_version

tags=$penultimate_version..$last_version

echo $(> CHANGELOG.md);

x=$(echo "== Changelog ==")
echo "$x" >> CHANGELOG.md

x=$(echo "= ${release} =")
echo "$x" >> CHANGELOG.md

pull_requests=$(git log $tags --merges  --format="* %b" >> CHANGELOG.md)

delimiter="Merge pull request #"

echo $pull_requests