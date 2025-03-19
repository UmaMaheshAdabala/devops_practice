## Basic

- pwd : Present working directory
- ls to see the list of files
- touch to create a file
- cat or open to open a file
- vi to write in file
- cp file_Name new_copy_file_name -- To create copy of a file
- mv file_nme destination_name -- To move file
- mv file_name new_file_name -- To rename file
- To rename multiple files we use " rename 's/\.txt$/\.bak/' \*.txt" cmd.
- rm file_name -- to remove file
- df -- disk information
- find --To find the file or directory. "find /home/xyz <filename>"
- grep to find a pattern or some text in a file.
- find . -prem 777 - to find files that have(read, write and execute) permissions

- ps -ef to see the processes that are running
- ps -ef | grep "process name" to find process by name

- ps -ef | grep "process name" | awk F " " '{print $2}'
- curl to retrive the information from internet // similar to postman
- less file.txt helps to view large files one page at a time.

## Searching for file

- find /path -name "file.txt"
- locate file.txt

## Search in a file

- grep awk sed
- sed is used to replace a word in a file : "sed -i 's/<old>/<new>/g <fileName>'

## File Deletion

- rm file.txt Deletes a file
- rmdir empty_folder Deletes an empty directory
- rm -r folder/ Deletes a directory and its contents
- find /path -name "\*.log" -delete Finds and deletes files matching a pattern

## Kill a process

- kill pid - kill by process ID
- pkill <pname> - kill by processname
- killall <pname> - kill all processes with that name
- top -p PID - gives the usage of a process.

# Permissions

- chmod u=rwx,g=rw,o=r file_name - setting the permissions for a file
- we can use binary as 777 etc.. that means u-rwx, g-rwx, o-rwx - r has val of 4 write has val of r exe has val of 1
- so 7 means rwx of 4 means rx ....
- chown root fileName -- change owner for file -- root gives root permissions
- grep "text" file_name -- to search some text in a file
- wget is used to download file from internet
- exit -to exit from root user

# Disk Info

- free to know the free space
- df -h to know about disk in human redable format
- du -sh folder/ gives size of a directory
- lsblk - gives disk partitions and mounted devices
- fdisk -l lists the disk partitions
- iostat - shows disk and i/o stats
- nproc to know about cpu
- "Top" to see all the data about disk and processor

## Process Management

- ps aux : all running process
- pgrep <processName> : gives processnames

# Script

- In the top of a script file we see #!/bin/{bash or sh or dash or ksh}
  here the dash or sh or bash are that execute the scripts
- to save a file and exit we use :wq!
- To execute a file we use ./file_Name or sh file_Name;

# Example Basic script

---

#!/bin/bash

#create folder

set -x #debug mode
set -e #exit the script if there is any error
set -o pipeline # if there is pipeline the set -e wont work so we have to use set -o pipeline

mkdir umesh
echo "folder Created"

cd umesh

touch file.text

echo "file created"

---

- to save a file and exit we use :wq!
- To execute a file we use ./file_Name or sh file_Name;
- set -x in the script helps to print the output in debug mode

- sudo su - -- to switch to root user
- exit to exit from root user

- sudo find / -name file_name --- to find file

# if else

if [expression]
then
echo " "
else
echo " "
fi

# for loop

for i in {1.100}; do echo $i; done

################################################################################

- ll - folders along with permission details
- ls - only folders
- ls -a // hidden folders also
- ls -al // all along with permissions also
- cd / completelu back
- cd .. just back by one step
- touch <filename> to create file we can create multiple files at once
- cat - to read file
- df -h to see the disk free space
- mkdir make folder
- rmdir remove folder
- grep - to find by name
- vi, vim, nano to create and edit a file
- uptime - to know the time since the serever is upon running
- Add a User "useradd -m <name>"
- To login as that user "su - <name>"
- chown <username> <filename> - to change owner of a file.
- we can use 'top' or "ps aux" to see the running process
- `stat <file>` - Show detailed file information.

- Kill a Process - "ps aux | grep process_name", "kill <PID>" or "pkill <process_name>"

- HostName - "nano /etc/sysconfig/network
- diff ---> diff b/w to files
- cpm ---> compare two files
- sort ---> sort files
- export --> export files

### SSH (Secure Shell)

    Basically the ssh is used to connect to the linux server from our machine. While connecting we use TCP SSH 22 port and then the linux gives us the reply from random TCP ephernal ports ranges from 1024 to 65535.
    ssh - TCP/22
    HTTP - TCP/80
    HTTPS - TCP/443
    DNS - UDP/53

    - "netstat -a" ( To see the ports that are in connection)
    -- To ping into 2nd server from 1st server we have to edit the etc/hosts file
      - nano /etc/hosts
      - enter the cmd
        <ipAddress_Of_1st_Serevr> <serevr_name.local> <serevrName>
        <ipAddress_Of_2st_Serevr> <serevr_name.local> <serevrName>
      - enter this in ect/hosts file in both the servers

    -- To have passwordless authentication
       we go to /etc/ssh/sshd_config and we allow password authenticationa and then we create password

    ## Loging into 2nd server from 1st server vice-versa

      - First Create a User
      - Then create a password for the user
      - Then create a .ssh folder - "mkdir .ssh"
      - Then change the pwemissions for the folder "chmod 700 .ssh"
      - Then create a file authorized_keys in .ssh folder - "touch authorized_keys"
      - Chgange the permissions "chmod 600 authorized keys"
      - Then generate keys - "ssh-keygen"
      - You will get id_rsa, id_rsa.pub files
      - Then run this command - "ssh-copy-id <nameOfThe2ndServer>" ex: ssh -copy-id server2user@server2
      - Do this in both the servers
      - Now you can login from 1st server to 2nd server vice -versa using "ssh <name_of_2nd_server>"


      - Login into both the servers
      - Then goto .ssh folder
      - Generate keys by "ssh-keygen"
      - Then paste the public key into other server authorized key file vice versa.
      - Then ssh into second sever "ssh <ipAddress>"




    --- EDIT the SSH File

    - Edit Port
    - Go to cd /etc/ssh
    - Open sshd_congif file
    - Then change port, allow password Authentication, Permit root user login
    - Then restart the sshd -"service sshd restart"

    --- Generating Keys
      We can generate keys using keygen

      - ls .ssh/
      - ssh -keygen
      - Then see ls .ssh/
      - we can see authorized keys file, id_rsa file, id_rsa.pub file
    --- Password AUth
      We can generate a password By usnig "passwd <userNameForWhichYouWantToCreate>" cmd

## Creating pations

- First create a Disk of 15 GB
- lsblk - to see the drives is visible or not
- fdisk <path and folder> ex: fdisk dev/sdb
- using the above cmd and then click "p" to see the partitions already present in the disk
- Then click "n" to create a new partition and "p" and set it as primary and give the partition size that you want
- Create as many as per the space and ur requirement
- Then finally enter "w" to save the changes
- Now we have to create file system for them
- So use 'mkfs.ext4' and press enter for each of the partition ex. mkfs.ext4 <path and folder>
- create 3 folders at root level
- Now mount the three folders to each of the partitions respectively.
- cmd for that is jsut enter lsblk and then enter mount /dev/<partitionName> /<foldername>
- Finally we have to edit the /etc/fstab and we have to add our mounts there because we may loose our data once the memory got refreshed.

## Creating Logical Volumes

- First while creating instance create 3 disks of required size
- Then see the disks if present or not by "lvmdiskscan" or lsblk to list down the drives
- Then create the physical volumes ffor each disk - "pvcreate <path disk>" ex: pvcreate /dev/xyz
- Then use "pvdisplay" to display the physical volumes
- Then create volume groups with these physical volumes - "vgcreate <name for group> <path disk that you created at instance>" ex: vgcreate awsTraining /dev/xyz /dev/abc
- Then we have to create logical volumes on top of groups
- We use "lvcreate -L <size> -n <nameof volume> <name of the volume group>" ex: lvcreate -L 2G -n awsLogicVolume <name of my volumegroup>
- we can see the volumes by - "lvdisplay"
- To use them we have to mount them
- So first create file system for each use -"mkfs.ext4 <path and folder>" ex: mkfs.ext4 /dev/awsTraining/awsLogicalVolume01
- Now create folders to mount them to folder
- Now mount them using " mount <path, folder> <folder that you created> " ex: mount dev/awsTraining/awsLogicalVolume01 <folder that you created in above step>
- use df -h to see whether mounted or not.
- Now the issue is if we want to extend the space of the logical Volumes first we have to extend the volume group for that we have to add a new disk into the volume grouo
- For that we use - "vgextend <volumeGrouopName> <disklocation/name>" ex: vgextend awsTraining /dev/mno
- Now we can extend the logical volume. we use - "lvextend -L +2G <locationOfLogicalVolume>" ex: lvextend -L +2G /dev/mapper/awsTraining/awsLogicalVolume01
- Finally we have to resize the filesystem so we use "resize2fs <logivalVolume>"
- To save them we have to do "cat /etc/fstab"
- If we want to remove them then we can first unmount them and then we can remive the lv and then vg then pv using lvremove, vgremove, pvremove followed by their details

  /dev/xvdb [ 5.00 GiB]
  /dev/xvdc [ 6.00 GiB]
  /dev/xvdd [ 7.00 GiB]

- How to add them permenently in fstab ???

## CronScheduler

- When You want to execute a task at a particular time or periodically then " Cron Scheduler will take care of it "

  # Cron Commands

  - Frist Launch an instnace
  - Login into it
  - Go to etc/cron folder
  - To see the list of crons in crontab - " corntab -l "
  - To edit our schedules - " contab -e"
  - Ex: cron ---> "\* \* \* \* \* echo " A mesage " >> /tmp/<fileName>"
  - To see the contabs of a user use "crontab - u <userName> -l"

## User Management

# User Details?

- "whoami" to see who u are
- "id" to get your id, group id, groups id.
- To see all the users we use - "cat /etc/passwd"
- "who" - shows all logged in users

# Creating a user?

- sudo useradd <NameOfUser> // Low level command just add an user
- sudo adduser <NameOfUser> // Add user and create a home directory as well - high level command.
- "id <Name_of_user> " to see the id and group id ... of the user that you created.
- create a password - " sudo passwd <Name_of_user> "
- But we can't login with password so you have to edit /etc/ssh/sshd_config file.
- Then restart the service - use " sudo service sshd restart"

# Adding User to a Group

- "groups" to see in which group u are presented.
- create a group - " sudo groupadd <group_name> "
- "cat /etc/group " to see all groups
- Add user to a group - " sudo usermod -aG <GroupName> <User_name> "
- groups <username> - to see the all groups of the user

# Providing sudo access to user

- go to visudo file - "visudo "
- Then add the username for which u want to give sudo permissions below the root user and save the file.

# USer Permissions

- chown <username> <filename> - to change owner of a file.
-

## Linux Troubleshooting

# Ping (Packet Interbet Grouper)

- we can ping from one server to other server using- " ping <ipaddress-of-2nd-server> "
- we can also configure the 2nd server name in /etc/hosts file and the we can ping through name.
- if ping is not working that doesn't mean that server is not working so we use "telnet"

- There are some switches in Ping such as:
  - ping -c 10 <ip> pings 10 times c-count
  - ping -q -c 5 <ip> // pings quietly 5 times

# telnet ( Telephone N/W)

- " telnet <ipAddress / DNS Name> <port> "
- we can use telnet to connect to server that is in other security group

# ifconfig

- ifconfig gives your ip
- "netstat -tulnp" gives the dynamic port connection b/w server to our machine
- Apart from netstat we use ss -tulnp.

# nslookup

- we can get the server name and some other details using - " nslookup <ipadress> "
- To see or to debug the DNS related issues.

# Route

- We can see the active routes by using "route -n"

# host

- "host <dnsName>" gives you the alias name in the dns table and its ip address

# curl

- curl is used to test the website or to downlod some files from internet
- It is basically to check URL

# wget

- wget is mainly to download something

# dig

- gives the domain information group
- ex: dig www.facebbok.com

# Traceroute

- Basically checks from the traffic goes to where

# Top

- Top is used to get the CPU Utilization related data

# htop

- similar to top but gives much UI exp than top.

# Iptraf

- Gives the trafic and ip's that we connected to in a gui way

# wireshark

- Wireshark is a powerful network protocol analyzer used for capturing and inspecting network traffic in real time. It is commonly used for network troubleshooting, security analysis, protocol development, and ethical hacking

### Use Cases

## mkdir

- To create folder
- mkdir -p /home/src/demo/file : to create a folder along with its parents
- mkdir -m 777 <folderNAme> : we can set permissions
- mkdir -v <folderName> : verbose mode gives us message of creating a file.

## pwd

- To know the present working directory
