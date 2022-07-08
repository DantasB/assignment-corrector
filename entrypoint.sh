#!/bin/sh -l

echo "The selected programming language was $1! :rocket:"

time=$(date)

echo "::set-output name=time::$time"