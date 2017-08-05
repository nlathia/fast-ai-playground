#!/usr/bin/env bash
set -e

echo 'Submitting predictions...'

kg submit 'submission.csv' -u $1 -p $2 -c 'dogs-vs-cats' -m 'fast-ai-submission'
