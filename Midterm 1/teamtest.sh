#!/usr/bin/bash

#---------------------------------------------
# ACIT2420 Midterm, winter 2019
#
# Testing script - exercise all the teamwork.sh
# functionality. Run as root!
#---------------------------------------------

# cleanup any previous testing results
./teamwork.sh cleanup
# setup a new team environment
./teamwork.sh setup

# dilbert is going to work on server.js
su dilbert -c "./teamwork.sh checkout server.js"
# asok is going to work on utils.js
su asok -c "./teamwork.sh checkout utils.js"
# wally isn't going to do much --> no such file
su wally -c "./teamwork.sh checkout bogus.js"
# asok is also going to update the config
su asok -c "./teamwork.sh checkout config.js"
# wally still isn't doing much --> already in use
su wally -c "./teamwork.sh checkout config.js"

# dilbert completes his work
su dilbert -c "./teamwork.sh propose server.js"
# wally rejects it so he looks busy
su wally -c "./teamwork.sh reject server.js"
# asok finished the config
su asok -c "./teamwork.sh propose config.js"
# dilbert approves it
su dilbert -c "./teamwork.sh approve config.js"
# wally tries to reject it, too late --> not being reviewed
su wally -c "./teamwork.sh reject config.js"
# asok discards his work on utils.js
su asok -c "./teamwork.sh discard utils.js"

#-----------------------------
# At this point:
# - "source" should contain config.js (asok), server.js (root) and utils.js (root)
# - "test" should contain server.js (dilbert)
# The project root should contain "worklog", with a history matching the above

