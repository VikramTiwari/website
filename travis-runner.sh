#!/bin/bash
set -o pipefail

if [ "$TRAVIS_BRANCH" = "master" ] && [ "$TRAVIS_PULL_REQUEST" = "false" ]
then
  git config --global user.email "vikramtheone1@gmail.com" && \
  git config --global user.name "Vikram Tiwari" && \
  echo "Deploying!" && \
  sed -i.tmp "s/\/\/ app.baseUrl = '\/website/app.baseUrl = '\/website/" app/scripts/app.js && \
  rm app/scripts/app.js.tmp && \
  bower i && \
  gulp deploy && \
  sed -i.tmp "s/app.baseUrl = '\/website/\/\/ app.baseUrl = '\/website/" app/scripts/app.js && \
  rm app/scripts/app.js.tmp
else
  npm run lint
  npm test
fi
