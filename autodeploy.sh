#!/bin/bash

gitSslVerify="git config --global http.sslverify false"
gitEc2UserName=""
destDir=""
gitBranch=""

clear;
printf "GIT Configurations\n"
printf "==================\n"
printf "Setting SSL Verification to: "
eval $sslVerify
printf "\nEnter EC2 Username (IE: moe.saidi):"
 read gitEc2Username
 allowedInput="$(echo $gitEc2UserName  |sed -e 's/[^[:alnum:]\.]//g')"
printf "\nEnter working release (IE: 1.2.8): "
 read release

if [ "$allowedInput" != "$gitEc2Username" ]; then
	printf "\nUsing $gitEc2Username...\n"
	printf "Enter Branch/Release (IE: bugfix/SCRIPT-329):"
	  read gitBranch
	  if [ -z "$gitBranch" ]; then
		printf "\n\nERROR: Empty string 'gitBranch'\n"
		exit 0;
	  fi
	printf "Enter destination directory (Full Directory, with leading and trailing '/'): "
	  read destDir
	  if [ -z "$destDir" ]; then
		printf "\n\nERROR: Empty string 'destDir'\n"
	  	exit 0;
	  fi
	  if [ ! -d "$destDir" ]; then
		printf "\nMaking directory.. $destDir \n"
		/usr/bin/sudo mkdir -p $destDir
		printf "\nDeploying...\n"
	  elif [ ! -x "$destDir" ]; then
		printf "\nERROR: No access to directory..."
	  else
		printf "\nWARNING: All files will be overwritten. Proceed? [y/n] "
		 read input
		   if ["$input" == 'y']; then
			printf "I'm copying!"
		   elif ["$input" == 'n']; then
		        printf "\nBack up your files first. The directory $destDir exists!"
			exit 0;
		   else
			printf "\nERROR: Invalid character or could not determine input for over write confirmation. You entered $input . Accepted answers are 'y' or 'n'"
			exit 0;
		   fi
	   fi 
	
else
	printf "Outside, i'm invalid"
fi
