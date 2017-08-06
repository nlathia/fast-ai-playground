#!/usr/bin/env bash
set -e

echo 'Submitting predictions...'
kg submit submission.csv -m 'fast-ai-submission'
