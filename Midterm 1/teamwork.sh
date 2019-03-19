#!/bin/bash
# Cody Sayer

RED='\033[0;31m'
BLUE='\033[0;36m'
NC='\033[0m'
username="$(whoami)"		# username
time="$(date)"              # time/date

# While there are more than 0 positional arguments
while [ $# -gt 0 ]; do

    # If first positional argument is 'setup', set up file system, users, write to log
	if [ "$1" = "setup" ]; then

        # Add Dilbert, Wally, and Asok
        echo
        echo -e [${RED}ADDING USERS${NC}]
            useradd dilbert
            echo -e --${BLUE}user Dilbert added!${NC}
            useradd wally
            echo -e --${BLUE}user Wally added!${NC}
            useradd asok
            echo -e --${BLUE}user Asok added!${NC}

        # set user passwords to 'KillerApp27'
        echo
        echo -e [${RED}SETTING USER PASSWORDS${NC}]
            echo -e 'KillerApp27' | passwd --stdin dilbert >/dev/null
            echo -e --${BLUE}user Dilbert\'s password set!${NC}
            echo -e 'KillerApp27' | passwd --stdin wally >/dev/null
            echo -e --${BLUE}user Wally\'s password set!${NC}
            echo -e 'KillerApp27' | passwd --stdin asok >/dev/null
            echo -e --${BLUE}user Asok\'s password set!${NC}

        # Create the Team group
        echo
        echo -e [${RED}CREATING GROUPS${NC}]
            groupadd team
            echo -e --${BLUE}group Team created!${NC}

        # Add everyone to Team group
        echo
        echo -e [${RED}ADDING USERS TO GROUPS${NC}]
            for user in dilbert wally asok
            do
                usermod -aG team "$user"
            done
            echo -e --${BLUE}users Dilbert, Wally, and Asok added to the group Team!${NC}

        # Create KillerApp and subfolders
        echo
        echo -e [${RED}CREATING GROUP FOLDERS${NC}]
            mkdir /home/killerapp
            echo -e --${BLUE}folder KillerApp created!${NC}
            mkdir /home/killerapp/source
            echo -e --${BLUE}folder Source created!${NC}
            mkdir /home/killerapp/wip
            echo -e --${BLUE}folder WIP created!${NC}
            mkdir /home/killerapp/test
            echo -e --${BLUE}folder Test created!${NC}

        # Retrieve source files
        echo
        echo -e [${RED}RETRIEVING SOURCE FILES${NC}]
            cd /home/killerapp/source
            wget -q http://acit2420.jlparry.com/data/server.js
            echo -e --${BLUE}sourcefile server.js retrieved!${NC}
            wget -q http://acit2420.jlparry.com/data/utils.js
            echo -e --${BLUE}sourcefile utils.js retrieved!${NC}
            wget -q http://acit2420.jlparry.com/data/config.js
            echo -e --${BLUE}sourcefile config.js retrieved!${NC}
            cd

        # Give everyone RWX access to KillerApp folder
        echo
        echo -e [${RED}GIVING FOLDER ACCESS${NC}]
            chgrp -R team /home/killerapp
            echo -e --${BLUE}folder KillerApp ownership given to Team!${NC}
            chmod 775 /home/killerapp -R
            echo -e --${BLUE}folder KillerApp permissions set!${NC}

        # Create log file
        echo
        echo -e [${RED}CREATING LOG FILE${NC}]
            touch /home/killerapp/worklog.txt
            chmod 777 /home/killerapp/worklog.txt
            echo -e --${BLUE}file worklog created in folder KillerApp!${NC}

        echo -e "$ a $time $username: Killer app project setup!" >> /home/killerapp/worklog.txt
        # Cycle to next positional argument and continue execution
        shift
        continue
    fi



    # if first positional argument is 'cleanup', clean up users, group, and folders
	if [ "$1" = "cleanup" ]; then

        # Delete KillerApp folder if it already exists
        echo
        echo -e [${RED}SEARCHING FOR VESTIGIAL FOLDERS${NC}]
        if [ -d /home/killerapp ]; then
                rm -rf /home/killerapp
                echo -e --${BLUE}folder KillerApp detected, deleting...${NC}
            fi

        # Delete dilbert, wally, and asok if they already exist
        echo
        echo -e [${RED}SEARCHING FOR VESTIGIAL USERS${NC}]
            if [ -d /home/dilbert ]; then
                userdel -r dilbert
                echo -e --${BLUE}user Dilbert detected, deleting...${NC}
            fi
            if [ -d /home/wally ]; then
                userdel -r wally
                echo -e --${BLUE}user Wally detected, deleting...${NC}
            fi
            if [ -d /home/asok ]; then
                userdel -r asok
                echo -e --${BLUE}user Asok detected, deleting...${NC}
            fi

        # Remove the Team group
        echo
        echo -e [${RED}SEARCHING FOR VESTIGIAL GROUPS${NC}]
            if grep team /etc/group >/dev/null; then
                groupdel team
                echo -e --${BLUE}group Team detected, deleting...${NC}
            fi

        # Cycle to next positional argument and continue execution
		shift
		continue
	fi



    # if first positional argument is 'checkout', copy file to WIP if not already there, write to log
	if [ "$1" = "checkout" ]; then

        filename=$2
        if [ -d /home/killerapp/$filename ]; then
            if [ -d ~/home/killerapp/wip/$filename ]; then
                echo -e [${RED}$filename IS ALREADY PRESENT IN WIP${NC}]
                echo -e "$ a $time $username: $filename cannot be checked out" >> /home/killerapp/worklog.txt
                continue
            fi
            if [ -d /home/killerapp/test/$filename ]; then
                echo -e [${RED}$filename IS ALREADY PRESENT IN TEST${NC}]
                echo -e "$ a $time $username: $filename cannot be checked out" >> /home/killerapp/worklog.txt
            else
                cp /home/killerapp/$filename /home/killerapp/wip/$filename
                echo -e --${BLUE}$filename moved to WIP!${NC}
                chown $username /home/killerapp/wip/$filename
                echo -e --${BLUE}ownership of $filename given to $username!${NC}
                echo -e "$ a $time $username: $filename checked out" >> /home/killerapp/worklog.txt
            fi

            continue
        fi

        # Cycle to next positional argument and continue execution
		shift; shift;
		continue
	fi



    # if first positional argument is 'discard', discard file if user owns it, write to log
	if [ "$1" = "discard" ]; then

        filename=$2
        if [ -d ~/home/killerapp/wip/$filename ]; then
            fileowner= ls -l /home/killerapp/wip/$filename | awk '{ print $3 }'
            if [ "$fileowner" = "$username" ]; then
                if [ -d /home/killerapp/wip/$filename ]; then
                    rm $filename
                    echo -e --${BLUE}$filename deleted from WIP!${NC}
                    echo -e "$ a $time $username: $filename has been discarded" >> /home/killerapp/worklog.txt
                else
                    echo -e [${RED}$filename IS NOT PRESENT IN WIP${NC}]
                    echo -e "$ a $time $username: $filename cannot be discarded" >> /home/killerapp/worklog.txt
                fi
            else
                echo -e [${RED}ONLY THE FILE OWNER CAN DICARD${NC}]
                echo -e "$ a $time $username: $filename cannot be discarded" >> /home/killerapp/worklog.txt
            fi

            continue
        fi

        # Cycle to next positional argument and continue execution
		shift; shift;
		continue
	fi



    # if first positional argument is 'propose', move file to test if user owns it, write to log
	if [ "$1" = "propose" ]; then

        filename=$2
        if [ -d ~/home/killerapp/wip/$filename ]; then
            fileowner= ls -l /home/killerapp/wip/$filename | awk "{ print $3 }"
            if [ "$fileowner" = "$username" ]; then
                if [ -f /home/killerapp/wip/$filename ]; then
                    mv /home/killerapp/wip/$filename /home/killerapp/test/$filename
                    echo -e --${BLUE}$filename moved to Test!${NC}
                    echo -e "$ a $time $username: $filename has been proposed" >> /home/killerapp/worklog.txt
                else
                    echo -e [${RED}$filename IS NOT PRESENT IN WIP${NC}]
                    echo -e "$ a $time $username: $filename cannot be proposed" >> /home/killerapp/worklog.txt
                fi
            else
                echo -e [${RED}ONLY THE FILE OWNER CAN PROPOSE${NC}]
                echo -e "$ a $time $username: $filename cannot be proposed" >> /home/killerapp/worklog.txt
            fi
        fi

        # Cycle to next positional argument and continue execution
		shift; shift;
		continue
	fi



    # if first positional argument is 'reject', if file is in test and user doesn't own it, delete, write to log
	if [ "$1" = "reject" ]; then

        filename=$2
        if [ -d ~/home/killerapp/wip/$filename ]; then
            fileowner= ls -l /home/killerapp/wip/$filename | awk "{ print $3 }"
            if [ "$fileowner" = "$username" ]; then
                echo -e [${RED}FILE OWNER CANNOT REJECT FILE${NC}]
                echo -e "$ a $time $username: $filename cannot be rejected" >> /home/killerapp/worklog.txt
            else
                if [ -d /home/killerapp/test/$filename ]; then
                    rm /home/killerapp/test/$filename
                    echo -e --${BLUE}$filename removed from Test!${NC}
                    echo -e "$ a $time $username: $filename has been rejected" >> /home/killerapp/worklog.txt
                else
                    echo -e [${RED}$filename IS NOT PRESENT IN TEST${NC}]
                    echo -e "$ a $time $username: $filename cannot be rejected" >> /home/killerapp/worklog.txt
                fi
            fi

            continue
        fi

        # Cycle to next positional argument and continue execution
		shift; shift;
		continue
	fi



    # if first positional argument is 'approve', if file is in test and doesn't belong to user, move to source, write to log
	if [ "$1" = "approve" ]; then

        filename=$2
        if [ -d ~/home/killerapp/wip/$filename ]; then
            fileowner= ls -l /home/killerapp/wip/$filename | awk "{ print $3 }"
            if [ "$fileowner" = "$username" ]; then
                echo -e [${RED}FILE OWNER CANNOT APPROVE FILE${NC}]
                echo -e "$ a $time $username: $filename cannot be approved" >> /home/killerapp/worklog.txt
            else
                if [ -d /home/killerapp/test/$filename ]; then
                    mv /home/killerapp/test/$filename /home/killerapp/source/$filename
                    echo -e --${BLUE}$filename moved to Source!${NC}
                    echo -e "$ a $time $username: $filename has been approved" >> /home/killerapp/worklog.txt
                else
                    echo -e [${RED}$filename IS NOT PRESENT IN TEST${NC}]
                    echo -e "$ a $time $username: $filename cannot be approved" >> /home/killerapp/worklog.txt
                fi
            fi

            continue
        fi

        # Cycle to next positional argument and continue execution
		shift; shift;
		continue
	fi
done