#!/usr/bin/env bash
: ${BRANCH_FILTER:? "BRANCH_FILTER environment variable mandatory. e.g. '(feature|bugfix)/'"}

git branch -r --merged | egrep "$BRANCH_FILTER" | sed 's/origin\///' > merged_branches.txt

if [[ "$DRY_RUN" == "true" ]]; then
    echo $(cat merged_branches.txt)
else
    cat merged_branches.txt | xargs -n 1 git push --delete origin
fi
