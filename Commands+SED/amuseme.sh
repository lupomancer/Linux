#! /usr/bin/env bash

# Initialize variables
fireflag=0					# firefox flag
username="$(whoami)"		# username
crown=crown					# default crown
vinegar=vinegar 			# default vinegar
outputmedia=JackAndJill.txt	# default output


# Prepares rhymes folder inside home folder,
if [ -d ~/rhymes ]; then
	rm -r ~/rhymes
fi
mkdir ~/rhymes

# retrieves Jack & Jill story there,
cd ~/rhymes
wget -q https://acit2420.jlparry.com/data/JackAndJill.txt

# exit program if no parameters
if [ $# -eq 0 ]; then
	echo parameters needed:
	echo -e "-u (username) \t\t\t replaces Jill in text"
	echo -e "-x \t\t\t\t opens results in firefox index.html file"
	echo -e "First positional argument \t replaces crown in Jack and Jill"
	echo -e "Second positional argument \t replaces vinegar in Jack and Jill"

	exit 0
fi

# stores the result in index.html
while [ $# -gt 0 ]; do
	# displays the result in firefox if x option provided
	if [ "$1" = "-x" ]; then
		# turn firefox flag on
		fireflag=1
		shift
		continue
	fi

	# replaces "Jill" with username or option (-u) username provided,
	if [ "$1" = "-u" ]; then
		username=$2
		shift; shift;
		continue
	fi

	# invalid commands
	if [[ "$1" = -* ]]; then
		shift
		continue
	fi

	# Replace "crown" with the first positional parameter, and "vinegar"
	# with the second positional parameter (if supplied)	
	if [ "$#" -gt 0 ]; then
		crown=$1
		shift

		if [ "$#" -gt 0 ]; then
			vinegar=$1
			shift
		fi
	fi

done


sed -i -e "s/Jill/$username/g" JackAndJill.txt
sed -i -e "s/crown/$crown/g" JackAndJill.txt
sed -i -e "s/vinegar/$vinegar/g" JackAndJill.txt

cp JackAndJill.txt index.html

if [ $fireflag -eq 1 ]; then
	firefox index.html
fi