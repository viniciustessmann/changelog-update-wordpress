git fetch

last_version=$(git tag --sort=committerdate | tail -1)

penultimate_version=$(git describe --abbrev=0 --match="v*" --tags HEAD~)

release=${last_version#?}

tags=$penultimate_version..$last_version
tags="v5.0.0..v6.0.0" #remove this

content=$(cat README.md)

if printf -- '%s' "$content" | egrep -q -- "= $release ="
then
  printf "Changelog updated"
else 
    pull_requests=$(git log $tags --merges  --format="* %b")
    # echo "= $release ="
    # echo "$pull_requests"

    line_started_changelog=$(awk '/== Changelog ==/{ print NR; exit }' README.md)

    line_started_changelog=$((line_started_changelog + 1))

    echo $line_started_changelog

    sed -i $line_started_changelog' i\'$pull_requests README.md



fi

# pull_requests=$(git log $tags --merges  --format="* %b" >> CHANGELOG.md)

# title_section_changelog=$(echo "== Changelog ==")
# echo "$title_section_changelog" >> CHANGELOG.md

# title_release=$(echo "= ${release} =")
# echo "$title_release" >> CHANGELOG.md




