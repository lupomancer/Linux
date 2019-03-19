#!/bin/bash

RED='\033[0;31m'
BLUE='\033[0;36m'
NC='\033[0m'

# Delete Homer, Marge, Bart, and Lisa if they already exist
echo
echo -e [${RED}SEARCHING FOR VESTIGIAL USERS${NC}]
    if [ -d /home/homer ]; then
        userdel -r homer
        echo -e --${BLUE}user Homer detected, deleting...${NC}
    fi
    if [ -d /home/marge ]; then
        userdel -r marge
        echo -e --${BLUE}user marge detected, deleting...${NC}
    fi
    if [ -d /home/bart ]; then
        userdel -r bart
        echo -e --${BLUE}user bart detected, deleting...${NC}
    fi
    if [ -d /home/lisa ]; then
        userdel -r lisa
        echo -e --${BLUE}user lisa detected, deleting...${NC}
    fi

# Add Homer, Marge, Bart, and Lisa
echo
echo -e [${RED}ADDING USERS${NC}]
    useradd homer
    echo -e --${BLUE}user Homer added!${NC}
    useradd marge
    echo -e --${BLUE}user Marge added!${NC}
    useradd bart
    echo -e --${BLUE}user Bart added!${NC}
    useradd lisa
    echo -e --${BLUE}user Lisa added!${NC}

# set user passwords to 'password'
echo
echo -e [${RED}SETTING USER PASSWORDS${NC}]
    echo -e 'password' | passwd --stdin homer >/dev/null
    echo -e --${BLUE}user Homer\'s password set!${NC}
    echo -e 'password' | passwd --stdin marge >/dev/null
    echo -e --${BLUE}user Marge\'s password set!${NC}
    echo -e 'password' | passwd --stdin bart >/dev/null
    echo -e --${BLUE}user Bart\'s password set!${NC}
    echo -e 'password' | passwd --stdin lisa >/dev/null
    echo -e --${BLUE}user Lisa\'s password set!${NC}

# Remove the Family and Finance groups
echo
echo -e [${RED}SEARCHING FOR VESTIGIAL GROUPS${NC}]
    if grep family /etc/group >/dev/null; then
        groupdel family
        echo -e --${BLUE}group Family detected, deleting...${NC}
    fi
    if grep finance /etc/group >/dev/null; then
        groupdel finance
        echo -e --${BLUE}group Finance detected, deleting...${NC}
    fi

# Create the Family and Finane groups
echo
echo -e [${RED}CREATING GROUPS${NC}]
    groupadd family
    echo -e --${BLUE}group Family created!${NC}
    groupadd finance
    echo -e --${BLUE}group Finance created!${NC}

# Add everyone to Family group
# Add Marge and Homer to Finance group
echo
echo -e [${RED}ADDING USERS TO GROUPS${NC}]
    for user in homer marge
    do
        usermod -aG finance "$user"
    done
    echo -e --${BLUE}users Homer and Marge added to the group Finance!${NC}
    for user in homer marge bart lisa
    do
        usermod -aG family "$user"
    done
    echo -e --${BLUE}users Homer, Marge, Bart, and Lisa added to the group Family!${NC}

# Delete Family and Finance folders if they already exist
echo
echo -e [${RED}SEARCHING FOR VESTIGIAL FOLDERS${NC}]
if [ -d /home/family ]; then
        rm -rf /home/family
        echo -e --${BLUE}folder Family detected, deleting...${NC}
    fi
    if [ -d /home/finance ]; then
        rm -rf /home/finance
        echo -e --${BLUE}folder Finance detected, deleting...${NC}
    fi

# Create Family and Finance folders
echo
echo -e [${RED}CREATING GROUP FOLDERS${NC}]
    mkdir /home/family
    echo -e --${BLUE}folder Family created!${NC}
    mkdir /home/finance
    echo -e --${BLUE}folder Finance created!${NC}

# Give Marge ownership of Family and Finance folders
echo
echo -e [${RED}CHANGING FOLDER OWNERSHIP${NC}]
    chown -R marge /home/family
    echo -e --${BLUE}folder Family given to Marge!${NC}
    chown -R marge /home/finance
    echo -e --${BLUE}folder Finance given to Marge!${NC}

# Give groups access to their respective folders
echo
echo -e [${RED}GIVING FOLDER ACCESS${NC}]
    chgrp -R family /home/family
    echo -e --${BLUE}folder ownership given to Finance!${NC}
    chmod 775 /home/family -R
    echo -e --${BLUE}folder Family permissions set!${NC}
    chgrp -R finance /home/finance
    echo -e --${BLUE}folder ownership given to Finance!${NC}
    chmod 750 /home/finance -R
    echo -e --${BLUE}folder Finance permissions set!${NC}

# Creating dummy files
echo
echo -e [${RED}CREATING DUMMY FILES${NC}]
    touch /home/family/test1.txt
    touch /home/family/test2.txt
    echo -e --${BLUE}files test1.txt and test2.txt created in folder Family!${NC}
    touch /home/finance/test1.txt
    touch /home/finance/test2.txt
    echo -e --${BLUE}files test1.txt and test2.txt created in folder Finance!${NC}
