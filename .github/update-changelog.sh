git fetch

last_version=$(git tag --sort=committerdate | tail -1)

penultimate_version=$(git describe --abbrev=0 --match="v*" --tags HEAD~)

release=${last_version#?}

tags=$penultimate_version..$last_version

echo $(> CHANGELOG.md);

title_section_changelog=$(echo "== Changelog ==")
echo "$title_section_changelog" >> CHANGELOG.md

title_release=$(echo "= ${release} =")
echo "$title_release" >> CHANGELOG.md

pull_requests=$(git log $tags --merges  --format="* %b" >> CHANGELOG.md)

echo $pull_requests