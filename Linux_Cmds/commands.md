# Linux

## File System Hirachy

- / (root) top level directory
- /home - user home directory
- /etc - system level configurations
- /var - variable data like logs and databases
- /usr - user related data and programs
- /tmp - Temporary files which will be cleared on reboot
- /bin - essential system binaries
- /opt - optional files/ third party softwares

## Basic

- `pwd` : Present working directory
- `ls` to see the list of files
- `mkdir -p <nestedFolder>`
- `touch` to create a file
- `cat` or open to open a file
- `vi` to write in file
- `cp` file_Name new_copy_file_name -- To create copy of a file
- `cp -r <directory> <otherDirectory>` -- To copy files from one dir to other dir
- `mv file_nme destination_name` -- To move file
- `mv file_name new_file_name` -- To rename file
- To rename multiple files we use " rename `s/\.txt$/\.bak/' \*.txt` " cmd.
- `rm file_name` -- to remove file
- `df` -- disk information
- `find` --To find the file or directory. "find /home/xyz <filename>"
- `grep` to find a pattern or some text in a file.
- `find . -prem 777` - to find files that have(read, write and execute) permissions

- `ps -ef` to see the processes that are running
- `ps -ef | grep "process name"` to find process by name

- ps -ef | grep "process name" | awk F " " '{print $2}'
- curl to retrive the information from internet // similar to postman
- less file.txt helps to view large files one page at a time.

## ZIP AND UNZIP

- mkdir myfolder
- unzip myfile.zip -d myfolder

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
- cd / completely back
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

- `iostat` used to monitor the cpu and disk I/O performance.

- Kill a Process - "ps aux | grep process_name", "kill <PID>" or "pkill <process_name>"

- HostName - "nano /etc/sysconfig/network
- diff ---> diff b/w to files
- cpm ---> compare two files
- sort ---> sort files
- export --> export files

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

### Practical

```
lsblk

fdisk </dev/sdb>
click 'n' to create partition
click 'p'
enter '+5G' (this is size)

repeat as no.of times the partitions are required

finally enter 'p' to see them

then
mkfs.ext4 </dev/sdb1>...
repeat the same to all blocks

create folders as many as the blocks you created

mount /dev/sdb1 <folder you created>

finally to make them persistent edit /ect/fstab file and add

/dev/sdb1 /<folder created>
repeact for all the disks you created
```

## Creating Logical Volumes

- using partitions we can oly create partitions in a single disk and use them we cant increase space and use that as combined disk. we can achieve that using Logical volumes

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

# SSH (Secure Shell)

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

# SSH

- We can create our own keys using `ssh-keygen`
- We can copy that public key an store it inside our aws and use the private to connect to the server.
- Once login we have all the keys in `.ssh/authorizedkeys` file.

- For better security we can change the port also.
- For that we have to edit `sshd_config` file. In that change the `port to 4444`
- To enable password login we can uncomment the passwordAuthentication is `sshd_config` file

- We can create a user and assign a password to that user and can login as that user using password without the pem key.
- I f we want we can create seperate .pem key for that user.

- Create a user.
- switch to that user `su - <uname>`
- Then create `.ssh` folder.
- Create `authorized_keys` file.
- Restrict the file permissions only to that user.
- Then generate keys using puttygen or key gen and paste the public key inside the authorized_keys file.
- And use the private key while connecting to the server.

## Connect b/w servers locally

- Edit the /etc/hosts file
- Add ip followed by locak name on both the servers.

- Then create users in both servers and enable password authentication.
- Login as the users
- Then create the authorized key file in `.ssh` folder
- in the same folder create the public key and private key using the `keygen`.
- Then copy the 2nd server public key into first server `authorizedkey` file.. vice versa.
- Then you can connect b/w the servers.

## SSH Tunneling

- To connect securely to a private instance like RDS, Redis Cache inside a private subnet we use ssh tunneling.
- `ssh -L 3307:rds.private.amazonaws.com:3306 ec2-user@bastion`
- For tunneling we use port forwarding. Through Port Forwarding we forward the traffic from local servers (local port) to the private instances (remote port).
- And the instance(RDS or Redis) is not publily accessed. It kept securely in private subnet. and we have connected within the tunnel's bastion host, not via open internet

- Similarly let say you have a website running on your local and your friend want to access it through internet. So we use ssh tunneling for that so we can securely access it.

# SSH into Multiple Servers

1. Basic

- Basically the very normal and basic approach is having same private and public key for all the instances.
- So that the controller instance can ssh into all the instances easily...
- But it is too risky as if the controller is compromised or hacked then all the 100's of worker servers also hacked

2. Bastion(Manual HOP)

- In this approach we have a bastion host and then we have worker servers.
- And we can securely shh into all the worker nodes in the private subnet
- But still we need the private key of the private instances inside the Bastion host.

3. Proxy Jump(Using Bastion host)

- Create SSH Config On LAPTOP `~/.ssh/config`
- Add

  ```
  Host bastion
  HostName BASTION_PUBLIC_IP
  User ec2-user
  IdentityFile ~/.ssh/prod-key.pem

  Host private-server
  HostName PRIVATE_IP
  User ec2-user
  IdentityFile ~/.ssh/prod-key.pem
  ProxyJump bastion

  ```

- This file exists only on local laptop.

- Now run `ssh private-server`
- INTERNAL FLOW
- STEP 1 — SSH Reads Config

SSH client sees:

ProxyJump bastion

Meaning:

“To reach private-server,
first connect to bastion.”
STEP 2 — SSH Connection to Bastion

Laptop establishes:

Laptop ←encrypted SSH→ Bastion

using:

prod-key.pem
STEP 3 — Bastion Opens TCP Connection

Bastion now creates raw TCP connection:

Bastion → PrivateServer:22

VERY IMPORTANT:

NOT second SSH login

Just TCP forwarding.

STEP 4 — SSH Traffic Relayed

Now traffic path becomes:

Laptop SSH Client
↓ encrypted SSH
Bastion
↓ raw TCP forwarding
Private Server
STEP 5 — Laptop Performs Direct Authentication

THIS IS THE MOST IMPORTANT PART.

Authentication happens between:

Laptop ↔ Private Server

NOT:

Bastion ↔ Private Server
Meaning

Private server validates:

your laptop's key

directly.

- Here Bastion NEVER stores private key.

This is WHY ProxyJump is superior.

- Instead of writing all the instances details in the config file we can write that as

- ```
  Host bastion
    HostName 3.10.x.x
    User ec2-user
    IdentityFile ~/.ssh/prod-key.pem


  Host 10.0.2.\*
  User ec2-user
  IdentityFile ~/.ssh/prod-key.pem
  ProxyJump bastion

  ```

- But if we are using automations like ansible or jenkins then the pem key has to be stored in their server and the connection will be like

- Ansible Controller
  ├── private keys
  ↓
  Bastion
  ↓
  100 Servers

  (but the bastion doesn't have the private key)

# SSM(System Session Manager)

- AWS Systems Manager Session Manager is a secure way to connect with servers instead of SSH.
- It has no port and is authorized using IAM
- So users will have only some particular permissions. so we use SSM insted of SSH for very secure applications.
- Even we can have port forwarding and tunneling for SSM.
- In SSM we don't have inbound connection to Server. the server has outbound connection to SSM

- One more Advantage is we don't need Bastion Host to connect to private instances in a private subnet.

- Steps:👇
- Launch a EC2 instance
- create a IAM role.
- Give

```

aws ssm start-session \
 --target i-123456 \
 --document-name AWS-StartPortForwardingSessionToRemoteHost \
 --parameters '{"host":["mydb.xxxxxx.rds.amazonaws.com"],"portNumber":["3306"],"localPortNumber":["3307"]}'

```

- Laptop
  ↓ IAM + MFA
  AWS SSM
  ↓
  Private EC2
  ↓
  Private RDS

## CronScheduler

- When You want to execute a task at a particular time or periodically then " Cron Scheduler will take care of it "

  # Cron Commands
  - First Launch an instnace
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
- sudo su - --> Changes to root user && root user home directory
- sudo su --> just changes to root user but past directory
- sudo -i --> recomented to use to change to root user because more secure and easy to audit
- To change hostname use `hostnamectl set-hostname <hostname_new>`
- Can verify that in /etc/hostname file

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

## Giving a user in a group more permissions than other.

- let say there is a developers group and in that developers group there is a Lead. and the lead need more permissions.
- So at that time if we have more leads who need similar permission then we can create a leads groups and give permissions.
- But if we have single lead then `sudo setfacl -m u:lead1:rwx /production`

# Linux Troubleshooting

## Ping (Packet Internet Grouper)

- CHECK IF HOST IS REACHABLE
- we can ping from one server to other server using- " ping <ipaddress-of-2nd-server> "
- we can also configure the 2nd server name in /etc/hosts file and the we can ping through name.
- if ping is not working that doesn't mean that server is not working so we use "telnet"

- There are some switches in Ping such as:
  - ping -c 10 <ip> pings 10 times c-count
  - ping -q -c 5 <ip> // pings quietly 5 times

## telnet ( Telephone N/W)

- CHECK IF SPECIFIC PORT IS OPEN
- " telnet <ipAddress / DNS Name> <port> "
- we can use telnet to connect to server that is in other security group
- We use this to check the open port of other server

## netstat / SS

- we use this to check the ports and process of our own machine.
- But `SS` is the advanced cmd, it does the same task. but more efficiently. It directly deals with the kernel instead of `\proc` file.

## ifconfig

- ifconfig gives your ip
- "netstat -tulnp" gives the dynamic port connection b/w server to our machine
- Apart from netstat we use ss -tulnp.

## nslookup

- we can get the server name and some other details using - " nslookup <ipadress> "
- To see or to debug the DNS related issues.

## Route

- We can see the active routes by using "route -n"
- Gives and manages Route Table of the server

## host

- "host <dnsName>" gives you the alias name in the dns table and its ip address

## curl

- curl is used to test the website or to downlod some files from internet
- It is basically to check URL
- `curl -I https://example.com` - Shows Headers, server type, Redirects, Content type
- `curl -v https://example.com`- DNS resolution, TCP connection, SSL handshake, Request headers, Response headers
- `curl -L http://example.com` - With -L, curl automatically follows redirects.
- `curl -O https://example.com/file.zip` - Download files.

## wget

- wget is mainly to download something

## dig

- gives the domain information group
- ex: dig www.facebbok.com

## Traceroute

- Basically checks from the traffic goes to where
- traceroute shows each hop (router or gateway) your data passes through before reaching its final destination — helping you identify network delays or connection problems.

- It tells how the packet flow from source to destination

## Top

- Top is used to get the CPU Utilization related data

## htop

- similar to top but gives much UI exp than top.

## Iptraf

- Gives the trafic and ip's that we connected to in a gui way

## wireshark

- Wireshark is a powerful network protocol analyzer used for capturing and inspecting network traffic in real time. It is commonly used for network troubleshooting, security analysis, protocol development, and ethical hacking

## nmap

- To see the live ports of other server

## tcpdump

- when logs are not clear and the frontend is calling backend but the backend is not responding then we use tcpdump.
- It will act as a CCTV and tells who the traffic leaves and comeback.
- `sudo tcpdump -i eth0 port 8080`

### Use Cases

## mkdir

- To create folder
- mkdir -p /home/src/demo/file : to create a folder along with its parents
- mkdir -m 777 <folderNAme> : we can set permissions
- mkdir -v <folderName> : verbose mode gives us message of creating a file.

## pwd

- To know the present working directory

---

######

# Abhishek

## Change Owner of the file

- chown <owner>:<group> <fileName>

- kill <pid> to kill the process
- kill -9 <pid> to forcefully kill the process and remove it
- kill -3 <pid> to get the threads of the process.

## priority

- Starts from -19 to 20. less number more priority and higher number less priority.

- `renice -n 10 -p <PID>`

---

- List all services `systemctl list-units--type=service`
- we can start stop services like `systemctl start <serviceName>`

---

## Monitor

- CPU - `nproc, top, htop`
- Memory - `free`
- disk space - `df -h`
- folder disk info - `du -sh`

## SED

| Task                         | Command Example                              | What It Does                            |
| ---------------------------- | -------------------------------------------- | --------------------------------------- |
| **Substitute** (replace)     | `sed 's/old/new/' file.txt`                  | Replaces first occurrence per line      |
| Replace globally             | `sed 's/old/new/g' file.txt`                 | Replaces all occurrences per line       |
| Replace and save to new file | `sed 's/old/new/g' file.txt > newfile.txt`   | Writes changes to a new file            |
| Edit in-place (overwrite)    | `sed -i 's/old/new/g' file.txt`              | Modifies the original file              |
| Delete lines                 | `sed '/pattern/d' file.txt`                  | Deletes lines containing "pattern"      |
| Print only matching lines    | `sed -n '/pattern/p' file.txt`               | Like `grep`                             |
| Insert line before match     | `sed '/pattern/i\This is new line' file.txt` | Inserts before lines matching "pattern" |
| Append line after match      | `sed '/pattern/a\This comes after' file.txt` | Appends after lines matching "pattern"  |

- Example: `sudo sed -i '/ swap / s/^/#/' /etc/fstab`

👉 here -i means interatively

- `/ swap /` means it will search for 'swap' word
- `s/^/#/` means the syntax is s/old/new/ here `^` is to replace in every line starting and id will add `#`

```

```

```

```

```

```

```

```
