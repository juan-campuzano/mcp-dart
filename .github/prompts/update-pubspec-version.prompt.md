---
mode: 'agent'
model: GPT-4o
tools: ['codebase', 'fetch', 'githubRepo', 'editFiles', 'pub']
description: 'Update pubspec version and changelog for new release'
---

Your goal is to update the pubspec.yaml file with a new version number and update the CHANGELOG.md file for the new release.

Ask the user for the new version number, if it's either a major, minor or patch and upgrade accordingly.