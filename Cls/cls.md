## Difference b/w mvn celan package and mvn clean install

Feature mvn clean install mvn clean package
Cleans the project (target/ directory) ✅ ✅
Compiles the code ✅ ✅
Runs tests ✅ (unless skipped) ✅ (unless skipped)
Packages the artifact (.jar/.war) ✅ ✅
Installs artifact to local repository
(~/.m2/repository) ✅ ❌

---

## Difference b/w SCP and CP

Difference Between cp and scp in Linux
Both cp and scp are used for copying files, but they serve different purposes:

Feature cp (Copy) scp (Secure Copy)
Purpose Copies files locally Copies files between remote and local systems
Syntax cp source destination scp user@host:/source user@host:/destination
Network Use No, works only on the local filesystem Yes, works over SSH (Secure Shell)
Security No encryption Encrypted (SSH-based)
Speed Faster (local copy) Slower (depends on network speed)
Permissions Preserves file permissions if used with -p Preserves file permissions by default
Compression No built-in compression Supports compression with -C
Example Usage cp file.txt /home/user/ scp file.txt user@remote:/home/user/

---

## Difference Between find and grep in Linux

Both find and grep are used for searching, but they serve different purposes:

Feature find grep
Purpose Searches for files & directories Searches for text patterns inside files
Search Scope File system (directories & filenames) File content (lines inside files)
Use Case Finding a file by name, size, type, etc. Searching for a word, phrase, or pattern inside files
Syntax find /path -name "filename" grep "pattern" filename
Recursive by Default? Yes No (-r needed for recursive search)
Supports Regular Expressions? Limited (-regex option) Yes (grep -E)
Example Usage find /home -name "\*.txt" grep "error" /var/log/syslog

---

## Key Differences Between find and locate

Feature find locate
Search Method Searches in real-time by scanning the file system Uses a pre-built database (updatedb) for fast searching
Speed Slower (real-time search) Faster (pre-indexed search)
Accuracy Always up-to-date May show outdated results if the database is not updated
Syntax Example find /home -name "file.txt" locate file.txt
Search Scope Can search by name, size, type, permissions, etc. Only searches by file name
Database Dependency Does not require a database Uses mlocate database, which needs to be updated manually or automatically via cron

---

## Subneting in CIDR Example

To subnet a given block of **256 IP addresses**, we need to divide it into three subnets with **at least**:

1. **50 IPs**
2. **20 IPs**
3. **10 IPs**

Since subnets must follow the **power of 2** rule, the next closest power-of-2 sizes are:

- **64 IPs** (2⁶) → Covers **50 IPs**
- **32 IPs** (2⁵) → Covers **20 IPs**
- **16 IPs** (2⁴) → Covers **10 IPs**

Let’s assume the given **256 IPs** belong to **192.168.1.0/24**, which ranges from **192.168.1.0 to 192.168.1.255**.

---

### **Subnet 1: 64 IPs (for 50 usable IPs)**

- **Network Address:** `192.168.1.0`
- **Subnet Mask:** `/26` (255.255.255.192)
- **IP Range:** `192.168.1.0 - 192.168.1.63`
- **Usable IPs:** `192.168.1.1 - 192.168.1.62`
- **Broadcast Address:** `192.168.1.63`

---

### **Subnet 2: 32 IPs (for 20 usable IPs)**

- **Network Address:** `192.168.1.64`
- **Subnet Mask:** `/27` (255.255.255.224)
- **IP Range:** `192.168.1.64 - 192.168.1.95`
- **Usable IPs:** `192.168.1.65 - 192.168.1.94`
- **Broadcast Address:** `192.168.1.95`

---

### **Subnet 3: 16 IPs (for 10 usable IPs)**

- **Network Address:** `192.168.1.96`
- **Subnet Mask:** `/28` (255.255.255.240)
- **IP Range:** `192.168.1.96 - 192.168.1.111`
- **Usable IPs:** `192.168.1.97 - 192.168.1.110`
- **Broadcast Address:** `192.168.1.111`

---

### **Remaining IPs**

After allocating the required subnets, we still have unused IPs in the **192.168.1.112 - 192.168.1.255** range, which can be further subnetted if needed.

Let me know if you need further adjustments! 🚀
