#!/bin/sh -l

execute_command() {
    # according to the file format, run the program and store the output in a file
    if [ $1 == "py" ]; then
        python3 $2/answer.py < $2/input.txt > $2/output.txt
    elif [ $1 == "java" ]; then
        java $2/answer.java < $2/input.txt > $2/output.txt
    elif [ $1 == "c" ]; then
        gcc $2/answer.c -o $2/answer
        $2/answer < $2/input.txt > $2/output.txt
    elif [ $1 == "cpp" ]; then
        g++ $2/answer.cpp -o $2/answer
        $2/answer < $2/input.txt > $2/output.txt
    elif [ $1 == "rb" ]; then
        ruby $2/answer.rb < $2/input.txt > $2/output.txt
    elif [ $1 == "sh" ]; then
        sh $2/answer.sh < $2/input.txt > $2/output.txt
    elif [ $1 == "go" ]; then
        go run $2/answer.go < $2/input.txt > $2/output.txt
    elif [ $1 == "js" ]; then
        node $2/answer.js < $2/input.txt > $2/output.txt
    elif [ $1 == "ex" ]; then
        elixir $2/answer.ex < $2/input.txt > $2/output.txt
    elif [ $1 == "f" ]; then
        gfortran $2/answer.f -o $2/answer
        $2/answer < $2/input.txt > $2/output.txt
    else
        echo "The answer file in $2 is not a valid file format. Please check if the answer file is a valid file format."
        exit 1
    fi
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

#access every folder in the answers folder
for folder in $(ls -d answers/*/)
do
    #check if the folder doesn't have 2 files
    if [ $(ls -1 $folder | wc -l) -ne 2 ]; then
        echo "The folder $folder does not have 2 files. Please check if the folder contains the code and the input files."
        exit 1
    fi
    
    # check if folder/input.txt exists
    if [ ! -f $folder/input.txt ]; then
        echo "The folder $folder does not have an input.txt file. Please check if the folder contains the code and the input files."
        exit 1
    fi

    # check if there's any file in the folder that starts with answer
    if [ $(ls -1 $folder | grep -c "^answer") -ne 0 ]; then
        # get the file format of the answer
        answer_format=$(file $folder/answer* | cut -d " " -f 2)
        execute_command $answer_format $folder 
    fi
done


time=$(date)

echo "::set-output name=time::$time"