#!/bin/bash

RED='\033[0;31m'
BLUE='\033[0;36m'
NC='\033[0m'
set -m

echo
echo -e [${RED}STARTING PROCESS EXPLORATION${NC}]
    echo
    echo -e --${BLUE}there\'s going to be a lot of windows opening so you\'re going to have to do some manual window managing here. There are certain tools you can use that can deal with this via terminal commands but you don\'t have any installed.${NC}
    sleep 15

# run gotop to monitor all activities
echo
echo -e [${RED}RUNNING GOTOP${NC}]
    echo
    echo -e --${BLUE}in about five seconds a process monitor called \'gotop\' is going to open in a new terminal window${NC}
    sleep 2
    echo
    echo -e --${BLUE}I recommend you drag it to the side just so you can see the main terminal window${NC}
    sleep 2
    echo
    echo -e --${BLUE}there\'s a lot of cool information in gotop but we\'re going to be focussing on the CPU graph at the top${NC}
    sleep 2
    echo
    sleep 2
    echo -e ${BLUE}opening...${NC}
    sleep 2
    gnome-terminal -e gotop >>/dev/null
    sleep 5

# open firefox in the background
echo
echo -e [${RED}OPENING FIREFOX${NC}]
    echo
    echo -e --${BLUE}now I\'m going to open Firefox in the background. This\'ll take a while.${NC}
    sleep 2
    echo
    echo -e --${BLUE}you\'ll notice firefox has started booting by a massive swell on the CPU graph that saturates both cores${NC}
    sleep 2
    echo
    echo -e --${BLUE}this section will wait 40 seconds for firefox to boot, just in case${NC}
    firefox &
    sleep 40
    echo
    echo -e --${BLUE}it should be open by now so I\'m going to assign firefox\'s PID to a variable so we can suspend it${NC}
    ffID="$(pgrep firefox)"
    kill -SIGSTOP $ffID
    sleep 5


# open gpedit in the background
echo
echo -e [${RED}OPENING GEDIT${NC}]
    echo
    echo -e --${BLUE}for my next trick, I\'ll open gedit detatched from the terminal, wait 10 seconds, then suspend it${NC}
    gedit &
    sleep 10
    geID="$(pgrep gedit)"
    kill -SIGSTOP $geID

# open gnome calculator in the background
echo
echo -e [${RED}OPENING GNOME CALCULATOR${NC}]
    echo
    echo -e --${BLUE}here I\'ll open gnome calc and assign it\'s PID to a variable for later use${NC}
    gnome-calculator &
    sleep 10
    calcID="$(pgrep gnome-calculator)"

# suspend gnome calc
echo
echo -e [${RED}SUSPENDING GNOME CALCULATOR${NC}]
    echo
    echo -e --${BLUE}SUSPEND GNOME CALC!${NC}
    echo
    echo -e --${BLUE}I WANT YOUR BADGE AND YOUR GUN, YOU\'RE OFF THE CASE${NC}
    kill -SIGSTOP %3
    sleep 5

echo
echo -e [${RED}SENDING GNOME CALC TO BACKGROUND${NC}]
    echo
    echo -e --${BLUE}this is where I\'d use \'bg gnome-calculator\' to send it to the background but I need to open all these programs in the background or else the rest of the script won\'t run${NC}
    sleep 5

# stressing the CPU
echo
echo -e [${RED}STRESSING CPU${NC}]
    sleep 1
    echo
    echo -e --${BLUE}giving the CPU massive student debt...${NC}
    sleep 1
    echo
    echo -e --${BLUE}making the CPU sit through a family meal while its parents fight${NC}
    sleep 1
    echo
    echo -e --${BLUE}giving the CPU the feeling of crushing failure${NC}
    sleep 2
    echo ...
    sleep 1
    echo ...
    sleep 1
    echo -e --${BLUE}okay actually running the stress test now${NC}
    sleep 1
    echo
    echo -e --${BLUE}watch the CPU graph pin at 100%${NC}
    stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout 10s >>/dev/null
    sleep 5

# sending gnome calc to foreground
echo
echo -e [${RED}SENDING GNOME CALC TO FOREGROUND${NC}]
    echo
    echo -e --${BLUE} this is the part where I\'d enter \'fg gnome-calculator\' to bring gnome calc back to foreground, but since I\'m running this all in a script I can\'t execute another command after that.${NC}
    sleep 5

# sending gnome calc to foreground
echo
echo -e [${RED}KILLING GNOME CALC${NC}]
    echo
    kill %3 >>/dev/null
    echo -e --${BLUE}dead${NC}
    sleep 5 #for some reason this line prints out to the console and I don't know why so I won't worry about it

# open new terminal window and kill processes
echo
echo -e [${RED}KILLING A BUNCH${NC}]
    gnome-terminal -x bash -c "ps; sleep 5; echo Firefox\'s PID is $ffID; kill %1 >>/dev/null; pgrep -f firefox; kill %2 >>/dev/null; exec bash" >>/dev/null
    echo
    echo -e --${BLUE}Firefox and Gedit will stick around in your task bar until the program has finished running, don\'t worry${NC}
    sleep 5

# final thoughts
echo
echo -e [${RED}FINAL THOUGHTS${NC}]
    echo
    echo -e --${BLUE}so you can see there are a lot of small spikes and changes when starting and killing processes.${NC}
    sleep 3
    echo
    echo -e --${BLUE}you notice the highest loads when booting Firefox and running the CPU stress test${NC}
    sleep 3
    echo
    echo -e --${BLUE}I don\'t know how conclusive our results are supposed to be here, but I found this interesting at the very least to learn job manipulation and stuff like gotop${NC}
    sleep 3
    echo
    echo -e --${BLUE}gotop is so cool${NC}
    sleep 3
    echo
    echo
    echo -e --${BLUE}well, that\'s it${NC}
    sleep 10

#shutdown fancy
echo
echo -e [${RED}SHUTTING DOWN${NC}]
    echo
    echo -e --${BLUE}5${NC}
    sleep 1
    echo
    echo -e --${BLUE}4${NC}
    sleep 1
    echo
    echo -e --${BLUE}3${NC}
    sleep 1
    echo
    echo -e --${BLUE}2${NC}
    sleep 1
    echo
    echo -e --${BLUE}1${NC}
    sleep 1