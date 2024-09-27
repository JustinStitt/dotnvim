#! /usr/bin/bash

cat /usr/local/google/home/justinstitt/.env | grep --color=never -E '^OPENAI_API_KEY.*' | cut -d '=' -f2 | tr -d '\"'
