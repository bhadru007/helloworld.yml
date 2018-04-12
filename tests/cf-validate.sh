#!/bin/bash

MY_PATH="`dirname \"$0\"`"

for file in $MY_PATH/../templates/*
do
    echo "Testing - $file"
    results=`aws cloudformation validate-template --template-body "file://$file"`
    echo $results
    
done

