#!/bin/sh -l

curl -Lo answers.zip $2
if unzip -qt answers.zip > /dev/null; then
    unzip -q answers.zip -d answers
    rm answers.zip
else
    echo "The answers url input is not a valid zip file"
    exit 1
fi

for file in answers/*
do
    echo "File: $file"
done 

time=$(date)

echo "::set-output name=time::$time"