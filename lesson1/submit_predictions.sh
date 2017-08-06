#!/usr/bin/env bash
set -e

echo 'Submitting predictions...'

# Note: dogs-vs-cats doesn't appear to be accepting submissions
kg submit 'submission.csv' -u $1 -p $2 -c 'dogs-vs-cats' -m 'fast-ai-submission'
