#!/bin/bash
 
# This makes all the folders and files for me
 
# ask the user for the name
echo "Welcome to my project setup!"
echo "Please type a name for your projec:"
read input
 
# check that they typed something
if [ "$input" = "" ]
then
	    echo "You did not type a name! Stopping."
	        exit
fi
