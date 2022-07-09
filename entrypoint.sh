#!/bin/sh -l

if [ -z "$2" ]; then
  echo "The ANSWERLOCATION environment variable is not set. Please set it to the location of the zip file containing the answers and the input files."
  exit 1
fi

curl -Lo answers.zip $2
if unzip -qt answers.zip > /dev/null; then
    unzip -q answers.zip -d answers
    rm answers.zip
else
    echo "The answers url input is not a valid zip file or the url is not accessible. Please check the url and try again."
    exit 1
fi

for file in answers/*
do
    echo "File: $file"
done 

time=$(date)

echo "::set-output name=time::$time"