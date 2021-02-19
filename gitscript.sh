#!/bin/bash

#u_name=""
#email=""
#dir=""
home=`eval echo "~$USER" $home`

read -p 'Username:' u_name
read -p 'Email:' email
read -p 'Name of local direcotry' dir

#while getopts ":u:e:d:" opt; do
# case $opt in
#	u) u_name=$OPTARG ;;
#	e) email=$OPTARG ;;
#	d) dir=$OPTARG ;;
#	*) echo "Invalid option: -$OPTARG" >&2 
#	exit 1
#	;;
#  esac
#done

#Setup user and email        
git config --global user.name "$u_name"
git config --global user.email "$email"

#Create local dir for repo and initialize.
git_repo="${home}/${dir}"
mkdir $git_repo	
cd $git_repo
git init
git remote add origin git@github.com:lachezaraspa/endeva.git

#Copy script to local repo
cp "${home}/gitscript.sh" "${git_repo}"

git status

#Push the script to master
git add gitscript.sh
git commit -m "1st commit"
git push origin master

touch time_stamp

date > ${git_repo}/time_stamp

#Push the time stamp to master
git add time_stamp
git commit -m "Time stamp for master"
git push origin master
git branch -a

#Create new branch in master
git checkout -b develop
git push origin develop
git branch -a

#Append new time stamp to file, print difference and push the changes to the new branch - develop
date >> ${git_repo}/time_stamp
git diff HEAD^ HEAD -- ./time_stamp
git add time_stamp
git commit -m "Time stamp for develop"
git push origin develop


