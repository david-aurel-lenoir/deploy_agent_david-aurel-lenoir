This project uses one shell script (setup_project.sh) to build the whole attendance tracker. when you run it, it creates all the folders and files for you so that the only file in the repo is script_project.sh.
when you run the script, it creates a structure where "input" is your project name
# HOW TO RUN THE SCRIPT
1 open a terminal and "cd" into the repo containing the file "setup_project.sh"
2 make the script executable using "chmod +x setup_project.sh"
3 Run the script using "./setup_project.sh"
4 the script will ask you:
  - the project name, where you can enter your project name
  - the warning number which is 75
  - the failure number which is 50
*take note that the number you type must be a whole number if not the script stops automatically.
5 after that the script checks if "python3" is installed and prints a "present" message since its there

# HOW TO RUN THE ATTENDANCE CHECKER
*before, take note the script only created the files. so to run the python program, do: 
"cd attendance_tracker_yourprojectname",
"python3 attendance_checker.py"
- this reads the csv file, works each students attednace and writes the result into "reports/reports.log"
# HOW TO TRIGGER THE ARCHIVE FEATURE
the script has a safety feature for when something goes wrong while its running
-during the running of the script, press "control+c". it sends an interrupt.
when y'll do that, the script:
1- bundle the unfinished project folder into a compressed backup file named "attendance_tracker_yourprojectname_archive"
2- it deletes the unfinished folder so it does not leave a half made folder behind

so if you cancel the setup, you are left with a single clean backup file instead of a half made folder.
