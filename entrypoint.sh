#!/bin/sh -l

validate_answers_folder() {
    subdircount=$(find answers/ -maxdepth 1 -type d | wc -l)
    if [[ "$subdircount" -eq 1 ]]
        echo "The answers folder does not contain any subdirectories. Please create a subdirectory for each question."
        exit 1
    fi

    for folder in $(ls -d answers/*/)
    do
        # Check if the folder doesn't have 2 files
        if [ $(ls -1 $folder | wc -l) -ne 2 ]; then
            echo "The folder $folder does not have 2 files. Please check if the folder contains the answer and the input files."
            exit 1
        fi
        
        # Check if folder/input.txt exists
        if [ ! -f $folder/input.txt ]; then
            echo "The folder $folder does not have an input.txt file. Please check if the folder contains the answer and the input files."
            exit 1
        fi

        # Check if folder/answer.txt exists
        if [ ! -f $folder/answer.txt ]; then
            echo "The folder $folder does not have an answer.txt file. Please check if the folder contains the answer and the input files."
            exit 1
        fi
    done
}

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

validate_answers_folder

time=$(date)

echo "::set-output name=time::$time"
