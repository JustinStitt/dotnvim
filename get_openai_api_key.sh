#! /usr/bin/bash

cat $HOME/.env | grep --color=never -E '^OPENAI_API_KEY.*' | cut -d '=' -f2 | tr -d '\"'
