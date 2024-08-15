Install git on multiple falvours of os

#! /bin/bash
echo "script to install git"
echo "Installation started"
if ["$(uname)" == "Linux" ];then
 echo "this is linux machine, installing git"
 yum install git -y
elseif ["$(uname)" == "Darwin" ];then
 echo "this is macos"
 brew install git
else
 echo "not installing git"
fi

----------------------------------------------------------------------------------------------------
script for disk utilization

#! /bin/bash
echo "check disk utilization in linux system"
disk_size='df -h |grep /files |awk '{print $5}'|cut -d '%' -f1'
echo "$disk_size% of disk is filled"
if [$disk_size -gt 80 ];then
 echo "disk utilized morethan 80%, expand your disk or delete unwanted files"
else
 echo "enough disk is available"
fi
------------------------------------------------------------------------------------------------------
script for 10 biggest files in the system

#! /bin/bash
echo "this program get first 10 biggest file in the file system passed via positional argument"
path="$1"
echo $path
du -ah $path | sort -hr | head -n 5 > /tmp/filesize.txt
echo "this is thelist of big files in the system $path "
cat /tmp/filesize.txt

------------------------------------------------------------------------------------------------------
script to delete logs which are created one month before

#! /bin/bash
echo "this script delete files which are older than 30 days"
path="$1"
echo $path
find $path -mtime +30 -delete
if [[ $? -eg 0]];then
 echo "files are successfully deleted "
else 
 echo "deletion of files was having some issue"
fi
------------------------------------------------------------------------------------------------
download prometheus binaries

#! /bin/bash
echo "Download prometheus binaries"
if [ -e /home/prometheus-2.42.0.linux-amd64.tar.gz ];then
 echo "files are already existing so no need to downlaod"
 tar -zxvf /home/prometheus-2.42.0.linus-amd64.tar.gz
else
 echo "binary doesn not exists in system first we need to download it"
 wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.42.0.linus-amd64.tar.gz
 tar -zxvf /home/prometheus-2.42.0.linuz-amd64.tar.gz
 echo "file has been extracted, you can start prometheus"
fi
-------------------------------------------------------------------------------------------------------------
deletion folder if it exist in directory

#! /bin/bash
for folder in $(find -type d);
do
 echo "the folder is $folder"
 if [ -d test ];
 then 
  echo "this folder exists "
  echo "removing the folder "
  rm -rf test
 else
  echo "test folder doesnt not exists"
 fi
done
------------------------------------------------------------------------------------------------------------
check if docker service is active or not

#! /bin/bash
echo "status check docker service"
status="`systemctl status docker|awk 'NR==3 {print}'|cut -d ':' -f 2 |cut -d '(' -f 1 `"
echo $status
if [ $status = "active" ];then
 echo  "service os running fine.."
else 
 echo "service is not running"
fi
-------------------------------------------------------------------------------------------------------------------
schedule a job automatically to run at regular interval and check if docker service is down, if its down start the service automatically

it check every minute wheather docker isrunning or not.

crontab -e 
****** /home/ec2/docker_service_check.sh > /dev/null

-----------------------------------------------------------------------------------------------------------------------
Script which accepts a command line argument and install many software

#! /bin/bash
# installing multiple packages

if [[$# -eq 0]]
then
 echo "usage: please provide software names as command line argumnet"
 exit 1
fi

if [[ $(id -u) -ne 0 ]]
then
 echo "please run from root user or with sudo privilage"
 exit 2
fi

for softwares in $@
do 
 if which $softwares &> /dev/null
 then
  echo "Already $softwares is installed"
 else
  echo "indtalling $softwares....."
  yum install $softwares -y &> /dev/null
  if [[ &? -eq 0]]
  then 
   echo "successfully installed $softwares packages"
  else
   echo "unable to install $softwares"
  fi
 fi

done

----------------------------------------------------------------------------------------------------------------------
script to read user input and print the status of service in system

#! /bin/bash
read -p "what is your name: " name
read -p "what is your password: " -s password
echo $name
echo $password
read -p "It will time out in 10 sec: " -t 10

chmod +x test.sh


#! /bin/bash
echo "while demo...."
while read -r line;
do
 echo "$line"
done < test.txt

#! /bin/bash
echo "Welcome to service status checek script"
read -p "Enter the service name to check its status" service_name
if [ -z $service_name ];
then
 echo " please enter a valid service name "
else
 systemctl status $service_name
fi

----------------------------------------------------------------------------------------------------------------------
script to check errors in error log

#! /bin/bash
error_file=`cat /var/log/messages `
matched_error=`grep -i error /var/log/messages`
echo [[ $? -eq 0]];then
 echo "found error in os logs: $matched_error"
else
 echo "no errorfound in message logs"
fi
----------------------------------------------------------------------------------------------------------------------
script to create a menu driven script which can do 4 actions, addition, subtraction, multiplication and deivision

#! /bin/bash

echo "----------------------------------"
echo "------welcome to calculator-------"
echo "----------------------------------"
echo -e "[a]addition\n[b]subtraction\n[c]multiplication\n[d]division\n"
read -p "Enter your choice: " choice
case $choice in
  [aA])
    read -p "Enter first number: " num1
	read -p "Enter second number: " num2
	result=$((num1+num2))
	echo "The result for your choice is: $result"
	;;
  [bB])
    read -p "Enter first number: " num1
	read -p "Enter second number: " num2
	result=$((num1-num2))
	echo "The result for your choice is: $result"
  [cC])
    read -p "Enter first number: " num1
	read -p "Enter second number: " num2
	result=$((num1*num2))
	echo "The result for your choice is: $result"
  [dD])
    read -p "Enter first number: " num1
	read -p "Enter second number: " num2
	result=$((num1/num2))
	echo "The result for your choice is: $result"
	
------------------------------------------------------------------------------------------------------------------------
dick utilization function

#! /bin/bsh
echo "this is a function"
disk_utilization()
{
disk=`df -h`
echo "disk utilizationis : $disk "
}
if [[ $? -eq 0]];
then
 echo "this is disk usage report"
  disk utilization
else
 echo "disk has some issue "
fi

-----------------------------------------------------------------------------------------
curl command script

#! /bin/bash

URL="https:/github.com/"
echo "%{http_code}"
response=$(curl -s -w "%{http_code}" $URL)

http1_code=$(tail -n1 <<< "$response") # get the last line
content=$(sed '$ d' <<< "$response") # get all but the last line with contains the status code

echo "$http1_code"
if [ $htpp1_code == 200 ];
then
 echo "request is working fine"
else 
 echo "send slcak message that respomse 9is denied "
fi
#echo "$content"
-----------------------------------------------------------------------------------------------------------
script which will help to generate cpu load alert for our system

#! /bin/bash
echo "CPU load average value check "
load=`top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}'|cut -d '%' -f1`
echo &load
if [[${load%.*} > 1 ]];
then
 echo "cpu load is very high: $load"
else
 echo "load is normal"
fi
-------------------------------------------------------------------------------------------------------------
 script to take backup of directories in system and transfer it to specified location
 
#! /bin/bash

backup_dirs=("/etc" "/home")
dest_dir="/root/backup"
mkdir -p $dest_dir
backup_date=$(date +%b-%d-%y)

echo "starting backup of: ${backup_dirs[@]}"

for i in "${backup_dirs[@]}";do
sudo tar -pczf /tmp/$i-$backup_date.tar.gz $i
if [ $? -eq 0 ];then
 echo "$i backup is succeeded."
else
 echo "$i transfer failed. "
fi
done

sudo rm /tmp/*.gz
echo "Backup is done"

--------------------------------------------------------------------------------------------
create a service script to monitor the disk usage every 2 min and store information in all log file.

#! /bin/bash
3script check fielsystem utilization every 120 seconds stoer in file
while true 
do
date >> /var/log/fs-monitor.txt
sudo df -h >> /var/log/fs-monitor.txt
sleep 120
done

create a service in 
vi /etc/systemd/system/fs-monitor.service 
in execstart give the script with path 
to check systemctl status fs-monitor.service 
to start systemctl start fs-monitor.service
to stop systemctl stop fs-monitor.service 
------------------------------------------------------------------------------------------------------
script to delete the user account, kill the process associated with that user 

#! /bin/bash
#
#delete user automates the 4 steps to remove an account
#
#################################
#define functions
#
##################################
function get_answer {
#
unset answer
ask_count=0
#
while [ -z "$answer" ] #while no answer is given, keep asking.
do
 ask_count=$[ $ask_count + 1 ]
#
 case $ask_count in #if user gives no answer in time alloted 
  2)
    echo
	echo "please answer the question."
	echo
	;;
  3) 
    echo 
	echo "one last try....please answer the question."
	echo 
	;;
  4) 
    echo
	echo "since you refuse to answer the question..."
	echo
	#
	exit
	;;
	esac
#
   if [ -n "#line2"]
   then    #print 2 line
      echo $line1
	  echo -e $line2" \c"
   else
       echo -e $line1" \c"
   fi
#
# allow 60 seconds to answer before timeout
  read -t 60 answer 
 done
# do a little variable clean-up
unset line1
unset line2
#
}  #end of get_answer function
#
##########################################
function process_answer {
#
answer=$(echo $answer | cut -c1)
#
case $answer in
y|Y)
# if user answers "yes", do nothing.
;;
*)
#if user answers anything but "yes",exit script
    echo 
	echo $exit_line1
	echo $exit_line2
	echo
	exit
;;
esac
#
# do a little variable clean-up
#
unset exit_line1
unset exit_line2
#
} #end of process_answer function
#
####################################
# end ofd function definitions
#
############Main script ##########
# get name of user account to check 
#
echo "step #1 - determine uer account name to delete "
echo 
line1="please enter the username of the user "
line2="account you wish to delete from system:"
get_answer
user_account=$answer
#
#double check with script user that this is the correct user account 
#
line1="Is $user_account the user account "
line2="you wish to delete from the system ? [y/n]"
get_answer
#
# call process_answer function:
# if user answers anything but "yes", exit script
#
exit_line1="because the account. $user_account, is not"
exit_line1="the one you wish to delete, we are leaving the script..."
process_answer
#
##########################################################
#check that user_account is really an account on the system
#
user_account_record=$(cat /etc/passwd | grep -w $user_account)
#
if [ $? -eq 1 ]   # if the account is not found, exit script 
then
    echo
    echo " account, $user_account, not found."
    echo "leaving the script........."
    echo
    exit
fi
#
echo 
echo "I found this record:"
echo $user_account_record
echo
#
line1="is this the correct user account? [y/n]"
get_answer
#
#
# call process_answer function:
# if user answers anything but "yes",exit script
#	
exit_line1="Because the account. $user_account, is not "
exit_line2="the one you wish to delete, we are leaving the script...."
process_answer
#
##########################################################
# search for any running process that belong to the user account
#
echo
echo "step #2 - find process on system belonging to user account"
echo
#
ps -u $user_account> /dev/null  #list uesr proccessing running.


case $? in
1)   # No proccess running for this user account
     #
	 echo "there are no proccesses for this account currently running ."
	 echo
;;
0)  #process runnning for this user account.
    #ask script user if wants us to kill the processes.
	#
	echo "#user_account has the following process(es)? running:"
	ps -u $user_account
	#
	line1="would you like me to kill the process(es)? [y/n]"
	get_answer
	#
	answer=$(echo $answer | cut -c1)
	#
	case $answer in
	y|Y)  #if user answers "yes",
	#kill user account processes.
	#
	echo
	echo "killing off process(es)..."
	#
	#list user process runnug code in command_1
	command_1="ps -u $user_account --no leading"
	#
	#create command_3 to kill proccesses in variable
	command_3="xargs -d \\n /usr/bin/sudo /bin/kill -9"
	#
	#kill processes via piping commands together
	$command_1 | gawk '{print $1}' | $command_3
	#
	echo
	echo "process(es) killed."
;;
*)  #if user answers anything but "yes", do not kill.
    echo
	echo "will not kill process(es)."
	;;
	esac
;;
esac
####################################################################
#create a report of all files owned by user account 
#
echo
echo "step #3 - find files on system belonging to user account"
echo
echo "creating a report of all files owned by $user_account."
echo 
echo "it is recommended that you backup/archive these files,"
echo "and then do one of two things:"
echo "1) delete the files "
echo "2) changes the files 'ownership to a current user account"
echo
echo "please wait. this may take a while....."
#
report_date=$(date +%y%m%d)
report_file="$user_account"_Files_"$report_date".rpt
#
find / -user $user_account> $report_file 2>/dev/null
#
echo
echo "report is complete "
echo "name of report: $report_file"
echo -n "location of report: "; pwd
echo
##############################################
# rremove user account
echo
echo "step #4 - remove user account"
echo
#
line1="do you wish to remove $user_account's account from system? [y/n]"
get_answer
#
# call process_answer function:
# if user answers anything but "yes", exit script
#
exit_line1="since you do not wish to remove the user account"
exit_line2="$user_account at this time, exiting the script..."
process_answer
#
userdel $user_account     #delete user account
echo
echo "user account, $user_account, has been removed"
echo
#
exit
  
--------------------------------------------------------------------------------------------------------------
