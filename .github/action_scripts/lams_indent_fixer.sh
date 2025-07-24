#!/bin/bash
git config user.name "github-actions"
git config user.email "github-actions@github.com"
git commit --allow-empty -m "Trigger CI"
git push https://x-access-token:${TOKEN}@github.com/${GH_REPO} HEAD:main
