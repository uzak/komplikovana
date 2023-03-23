#! /bin/sh

cd komplikovana-mirror-gitlab
git checkout main
git pull github main
git push --force
