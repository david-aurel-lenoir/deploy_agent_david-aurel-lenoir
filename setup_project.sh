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

# this is the folder name
folder="attendance_tracker_$input"
 
# this function runs if they press Ctrl+C
function clean_up {
	    echo ""
	        echo "You pressed Ctrl+C Saving and cleaning up"
		    tar -czf "$folder"_archive "$folder"
		        rm -rf "$folder"
			    echo "Done. Saved to "$folder"_archive"
			        exit
			}
		 
		# tell the script to use my function when Ctrl+C is pressed
		trap clean_up SIGINT

# make the folders
echo "Making the folders"
mkdir "$folder"
mkdir "$folder/Helpers"
mkdir "$folder/reports"
