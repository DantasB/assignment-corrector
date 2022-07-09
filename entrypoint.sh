#!/bin/sh -l

echo "The selected programming language was $1! :rocket:"

echo "The code location is $2"

time=$(date)

echo "::set-output name=time::$time"