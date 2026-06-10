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

# makes the attendance_checker.py file
echo "Making theendance_checker.py file"
cat > "$folder/attendance_checker.py" << 'END'
import csv
import json
import os
from datetime import datetime
 
def run_attendance_check():
# 1. Load config
    with open('Helpers/config.json', 'r') as f:
        config = json.load(f)

# 2. Archive old reports.log if it exists 
    if os.path.exists('reports/reports.log'):
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        os.rename('reports/reports.log', f'reports/reports_{timestamp}.log.archive')
 
# 3. Process Data
    with open('Helpers/assets.csv', mode='r') as f, open('reports/reports.log', 'w') as log:
        reader = csv.DictReader(f)
        total_sessions = config['total_sessions']
        log.write(f"--- Attendance Report Run: {datetime.now()} ---\n")
 
        for row in reader:
            name = row['Names']
            email = row['Email']
            attended = int(row['Attendance Count'])

            # Simple Math: (Attended / Total) * 100
            attendance_pct = (attended / total_sessions) * 100
 
            message = ""
            if attendance_pct < config['thresholds']['failure']:
                message = f"URGENT: {name}, your attendance is {attendance_pct:.1f}%. You will fail this class."
            elif attendance_pct < config['thresholds']['warning']:
                message = f"WARNING: {name}, your attendance is {attendance_pct:.1f}%. Please be careful."
 
            if message:
                if config['run_mode'] == "live":
                    log.write(f"[{datetime.now()}] ALERT SENT TO {email}: {message}\n")
                    print(f"Logged alert for {name}")
                else:
                    print(f"[DRY RUN] Email to {email}: {message}")
 
if __name__ == "__main__":
    run_attendance_check()
END

# makes the assets.csv file
echo "Making the assets.csv file..."
cat > "$folder/Helpers/assets.csv" << 'END'
Email,Names,Attendance Count,Absence Count
alice@example.com,Alice Johnson,14,1
bob@example.com,Bob Smith,7,8
charlie@example.com,Charlie Davis,4,11
diana@example.com,Diana Prince,15,0
END
