#! /usr/bin/env bash

# set initial values
zedfound=1           # no "-z" given
fruit="apple"        # default fruit

# iterate over the arguments
while [ $# -gt 0 ]    # repeat as long as there are still arguments
do
    # each iteration looks at the next (now first) argument

    # look for a single letter option with no value
    if [ $1 = "-z" ]; then
        zedfound=0;  # we have a "-z" argument
        shift;      # drop it, shifting the remaining arguments left
        continue          # continue the while loop with the next argument
    fi

    # look for a single letter option followed by a value
    if [ $1 = "-f" ]; then
        fruit=$2;  # take the following argument as an option value
        shift;shift;  # drop the option and its value, shifting the remaining arguments left
        continue          # continue the while loop with the next argument
    fi

    # if we get here, the next argument isn't an option we are interested in
    break;          # the next argument is a parameter
done