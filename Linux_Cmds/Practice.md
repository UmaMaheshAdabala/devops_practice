# Linux Process

- `sleep 1000` ---> This will create a process that do nothing but wait for 1000 seconds and exit
- `lsof /var/log/syslog` ---> This will show who is unig the file
- `ps -o pid,ppid,cmd -p <PID>` --> find the paretn of a process
- `ss -tulnp | grep 8080` ---> tells which process is using port 8080.
- `ip a` ---> shows all network interfaces and their IP's
- `nslookup google.com` ---> provides the DNS Info
- `ping google.com` ---> to know whether can I reach
- `lsof -i :8080` find process on port 8080.

1. ip a → do I have IP?
2. ip route → do I have gateway?
3. ping → basic connectivity?
4. nslookup → DNS works?
5. ss -tulnp → is app listening?
6. lsof → who owns port?
7. iptables → firewall?
8. tcpdump → are packets arriving?
9. curl → real HTTP test

# File Management

1. Navigation

`pwd` # where am I
`ls` # list files
`ls -l` # long listing
`ls -a ` # include hidden files
`cd /path ` # change directory
`cd ..` # one level up
`cd ~` # home directory

2. Create Files and Directories

`touch file.txt`
`mkdir folder`
`mkdir -p a/b/c` # create nested dirs

3. Move, Copy, Delete

`cp a.txt b.txt`
`cp -r dir1 dir2`

`mv old.txt new.txt`
`mv file /tmp/`

`rm file.txt`
`rm -r folder`
`rm -rf folder ` # force (danger)

4. Permissions

`ls -l`
`chmod 755 file`
`chmod u+x script.sh`
`chmod -R 644 folder`

5. Ownership

`chown user file`
`chown user:group file`
`chown -R user:group folder`

6. Searching & Finding Files

`find / -name file.txt`
`find /var -type f`
`find . -size +100M`
`find . -mtime -1`

7. Grep

`grep "error" file.txt`
`grep -r "password" /etc`
`grep -i "fail" logfile.log`

8. Disk Usage

`du -sh folder`
`df -h`
`ls -lh`

9. Compress

`tar -cvf backup.tar folder/`
`tar -xvf backup.tar`
`tar -czvf backup.tar.gz folder/`
`tar -xzvf backup.tar.gz`

`zip file.zip file.txt`
`unzip file.zip`

`gzip file.txt`
`gunzip file.txt.gz`

10. Hard & Soft links

`ln file1 file2` # hard link
`ln -s file1 link1` # soft link
`ls -li` # Check link

11. rsync

`rsync -av src/ dest/`
`rsync -av --delete src/ dest/`

# Process Management in Linux

## Introduction to Process Management

A process is an instance of a running program. Linux provides multiple utilities to monitor, manage, and control processes effectively. Each process has a unique **Process ID (PID)** and belongs to a parent process.

## Index of Commands Covered

### Viewing Processes

- `ps aux` – View all running processes
- `ps -u username` – View processes for a specific user
- `ps -C processname` – Show a process by name
- `pgrep processname` – Find a process by name and return its PID
- `pidof processname` – Find the PID of a running program

### Managing Processes

- `kill PID` – Terminate a process by PID
- `pkill processname` – Terminate a process by name
- `kill -9 PID` – Force kill a process
- `pkill -9 processname` – Kill all instances of a process
- `kill -STOP PID` – Stop a running process
- `kill -CONT PID` – Resume a stopped process
- `renice -n 10 -p PID` – Lower priority of a process
- `renice -n -5 -p PID` – Increase priority of a process (requires root)

### Background & Foreground Processes

- `command &` – Run a command in the background
- `jobs` – List background jobs
- `fg %jobnumber` – Bring a job to the foreground
- `Ctrl + Z` – Suspend a running process
- `bg %jobnumber` – Resume a suspended process in the background

### Monitoring System Processes

- `top` – Interactive process viewer
- `htop` – User-friendly process viewer (requires installation)
- `nice -n 10 command` – Run a command with a specific priority
- `renice -n -5 -p PID` – Change priority of an existing process

### Daemon Process Management

- `systemctl list-units --type=service` – List all system daemons
- `systemctl start service-name` – Start a daemon/service
- `systemctl stop service-name` – Stop a daemon/service
- `systemctl enable service-name` – Enable a service at startup

## Viewing Process Details

### Using `ps`

Show processes for a specific user:

```bash
ps -u username
```

Show a process by name:

```bash
ps -C processname
```

### Using `pgrep`

Find a process by name and return its PID:

```bash
pgrep processname
```

### Using `pidof`

Find the PID of a running program:

```bash
pidof processname
```

## Managing Processes

### Killing Processes

To terminate a process by PID:

```bash
kill PID
```

To terminate using process name:

```bash
pkill processname
```

Force kill a process:

```bash
kill -9 PID
```

Kill all instances of a process:

```bash
pkill -9 processname
```

### Stopping & Resuming Processes

Stop a running process:

```bash
kill -STOP PID
```

Resume a stopped process:

```bash
kill -CONT PID
```

### Changing Process Priority

View process priorities:

```bash
top  # Look at the NI column
```

Change priority of a running process:

```bash
renice -n 10 -p PID  # Lower priority (positive values)
renice -n -5 -p PID  # Higher priority (negative values, root required)
```

### Running Processes in the Background

Run a command in the background:

```bash
command &
```

List background jobs:

```bash
jobs
```

Bring a job to the foreground:

```bash
fg %jobnumber
```

Send a running process to the background:

```bash
Ctrl + Z  # Suspend process
bg %jobnumber  # Resume in background
```

## Monitoring System Processes

### Using `top`

Interactive process viewer:

- Press `k` and enter a PID to kill a process.
- Press `r` to renice a process.
- Press `q` to quit.

### Using `htop`

A user-friendly alternative to `top`:

```bash
htop
```

Allows mouse-based interaction for process management.

### Using `nice` & `renice`

Run a command with a specific priority:

```bash
nice -n 10 command
```

Change the priority of an existing process:

```bash
renice -n -5 -p PID
```

## Daemon Processes

Daemon processes run in the background without user intervention.
List all system daemons:

```bash
systemctl list-units --type=service
```

Start a daemon:

```bash
systemctl start service-name
```

Stop a daemon:

```bash
systemctl stop service-name
```

Enable a service at startup:

```bash
systemctl enable service-name
```

## Conclusion

Process management is crucial for system performance and stability. By using tools like `ps`, `top`, `htop`, `kill`, and `nice`, you can efficiently control and monitor Linux processes.

# Disk

- Disk layout
  `lsblk`
  `lsblk -f`
  `blkid`
  `fdisk -l`

- Mounted Filesystems

`mount`
`findmnt`
`findmnt -t ext4`

- Disk Usage (Capacity)
  `df -h`
  `df -T`
  `df -i`

- Disk Usage (Consumption)
  `du -sh /path`
  `du -sh *`
  `du -xh --max-depth=1 /`

- File & Filesystem Info

`file filename`
`file -s /dev/xvdf`
`stat filename`
`ls -lh`

- Memory / RAM
  `free -h`
  `vmstat`
  `cat /proc/meminfo`

- CPU & System Load
  `top`
  `htop`
  `uptime`

- Disk IO Performance
  `iostat`
  `iotop`
  `dstat`

- Network Visibility

`ip a`
`ip r`
`ss -tuln`
`netstat -tuln`
`lsof -i :80`

- System Files & Kernel

`/proc/meminfo`
`/proc/cpuinfo`
`/proc/diskstats`
