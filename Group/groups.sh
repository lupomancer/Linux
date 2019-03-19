#!/bin/bash

RED='\033[0;31m'
BLUE='\033[0;36m'
NC='\033[0m'

# Delete Padme, Jarjar, and Anakin if they already exist
echo
echo -e [${RED}SEARCHING FOR VESTIGIAL USERS${NC}]
if [ -d /home/padme ]; then
	userdel -r padme
    echo -e --${BLUE}user Padme detected, deleting...${NC}
fi
if [ -d /home/jarjar ]; then
	userdel -r jarjar
    rm -rf /home/jarjar
    echo -e --${BLUE}vistigial Jarjar directory detected, deleting...${NC}
fi
if [ -d /home/meesahome ]; then
    userdel -r jarjar
	rm -rf /home/meesahome
    echo -e --${BLUE}user Jarjar detected, deleting...${NC}
fi
if [ -d /home/anakin ]; then
	userdel -r anakin
    echo -e --${BLUE}user Anakin detected, deleting...${NC}
fi

# Add Padme, Jarjar, and Anakin
echo
echo -e [${RED}ADDING USERS${NC}]
useradd padme
echo -e --${BLUE}user Padme added!${NC}
useradd jarjar -d /home/meesahome
echo -e --${BLUE}user Jarjar added!${NC}
useradd anakin
echo -e --${BLUE}user Jarjar added!${NC}

# Remove the Naboo and Besotted groups
echo
echo -e [${RED}SEARCHING FOR VESTIGIAL GROUPS${NC}]
if grep naboo /etc/group >/dev/null; then
    groupdel naboo
    echo -e --${BLUE}group Naboo detected, deleting...${NC}
fi
if grep besotted /etc/group >/dev/null; then
    groupdel besotted
    echo -e --${BLUE}group Besotted detected, deleting...${NC}
fi

# Create the Naboo and Besotted groups
echo
echo -e [${RED}CREATING GROUPS${NC}]
groupadd naboo
echo -e --${BLUE}group Naboo created!${NC}
groupadd besotted
echo -e --${BLUE}group Besotted created!${NC}

# Add Jarjar to the Naboo group
# Add Padme and Anakin to the Besotted group
echo
echo -e [${RED}ADDING USERS TO GROUPS${NC}]
usermod -aG naboo jarjar
echo -e --${BLUE}user Jarjar added to the group Naboo!${NC}
usermod -aG besotted,naboo padme
echo -e --${BLUE}user Padme added to the group Naboo and Besotted!${NC}
usermod -aG besotted anakin
echo -e --${BLUE}user Anakin added to the group Besotted!${NC}

# echo the chosen password twice with a newline in between when running the passwd command
echo
echo -e [${RED}SETTING USER PASSWORDS${NC}]
echo -e 'secret123' | passwd --stdin padme >/dev/null
echo -e --${BLUE}user Padme\'s password set!${NC}
echo -e 'secret123' | passwd --stdin jarjar >/dev/null
echo -e --${BLUE}user Jarjar\'s password set!${NC}
echo -e ')(DLKJK@$#$%LKJEW_*$Nnnnsert87X' | passwd --stdin anakin >/dev/null
echo -e --${BLUE}user Anakin\'s password set!${NC}

# Add Anakin to sudo group
echo
echo -e [${RED}ADDING SUPERUSER${NC}]
usermod -aG wheel anakin
echo -e --${BLUE}user Anakin added to sudo group!${NC}