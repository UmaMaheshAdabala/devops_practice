# SSL

- without ssl we have to send plain data b/w server and client.
- So to avoid this we use ssl/TLS handshake.
- This make communication more secure.

# Steps to create a SSL Certificate from ACM

- Go to ACM and then REQUEST a certificate
- provide the domain name - example.com & \*.example.com so that all the subdomains can have same cert.
- Click create
- And verify it by adding the CName records in the route53.
- Then use it inside the AWS. if want that outside select the export option while creating the cert.

## Steps to create own SSL

Root CA
└── Intermediate CA
└── Server Certificate (example.com)

- Create Root CA
- `mkdir ssl-lab & cd ssl-lab`
- `mkdir rootCA & cd rootCA`

- Generate RootCA private key
- `openssl genrsa -out rootCA.key 4096`

- Generate rootCA Certificate
- `openssl req -x509 -new -nodes -key rootCA.key -ssh256 -days 3650 -out rootCA.pem`
- when prompted Common Name (CN): My Root CA
- inspect rootCAcertificate --> `openssl x509 -in rootCA.pem -text -noout`
- Create Intermediate Cert
- `cd ..`
- `mkdir intermediateCA`
- `cd intermediateCA`

- Generate intermediate private key
- `openssl genrsa -out intermediate.key 4096`
- Create Intermediate CSR (request)
- `openssl req -new -key intermediate.key -out intermediate.csr`
- when prompted Common Name (CN): My Intermediate CA

- Sign Intermediate with ROOT CA
- `openssl x509 -req -in intermediate.csr -CA ../rootCA/rootCA.pem -CAkey ../rootCA/rootCA.key -CAcreateserial -out intermediate.pem -days 1825 -sha256`

- Verify the intermediate cert
- `openssl x509 -in intermediate.pem -text -noout`

- Create Server cert
- `cd ..`
- `mkdir server`
- `cd server`

- Generate server private key
- `openssl genrsa -out server.key 2048`

- Create server CSR
- `openssl req -new -key server.key -out server.csr`

- when portmpted Common Name (CN): example.com

- Sign server cert with INTERMEDIATE CA
- `openssl x509 -req -in server.csr -CA ../intermediateCA/intermediate.pem -CAkey ../intermediateCA/intermediate.key -CAcreateserial -out server.pem -days 365 -sha256`

- Build the CERTIFICATE CHAIN
- `cat server.pem ../intermediateCA/intermediate.pem > fullchain.pem`
- Server cert
- Intermediate cert

- Verify the Chain (CRITICAL)
- `openssl verify -CAfile ../rootCA/rootCA.pem fullchain.pem`

- Use this for Nginx to make the static website HTTPS supported.
- Copy the certs to ec2 - `scp server.key fullchain.pem ec2-user@<EC2_PUBLIC_IP>:/home/ec2-user/`
- `sudo mkdir -p /etc/nginx/ssl`
- `sudo mv server.key fullchain.pem /etc/nginx/ssl/`
- `sudo chmod 600 /etc/nginx/ssl/server.key`

- Configure Nginx for HTTPS
- `sudo vi /etc/nginx/nginx.conf`
- Add the below block
- ```server {
      listen 443 ssl;
      server_name example.com;

      ssl_certificate     /etc/nginx/ssl/fullchain.pem;
      ssl_certificate_key /etc/nginx/ssl/server.key;

      root /usr/share/nginx/html;
      index index.html;

      location / {
          try_files $uri $uri/ =404;
      }
  }
  ```

## Make the browser to trust

- copy the rootCA.pem to loacl machine
- goto chrome then goto settings and manage certs
- import the rootCA.pem there.

# SNI

- Server Name Indiacator is used in a case such that let say there are 3 websites hosted behind my alb so there are 3 ssl certs for my alb
- And for these 3 websites there are 3 diff domains web1.com, web2.com, web3.com.
- but all these 3 are associated with same ALB. So when we request any of the website then with which SSL cert does the ALB will respond
- so in such cases the SNI inside the alb will help the ALB to match the domain name with the certs it have and serves the correct cert
- the matching happens in O(1) it uses indexing.
- All thsi happens before the TCP connection, while TLS handshake.

- In NLB the SSL behaves different. in NLB we have two types
- 1. TLS passthrough: That mean the NLB passes the encrypted data directly to the application and the app has to provide the cert and decrypt the data
- 2. TLS termination: The NLB will provide the server cert and decrypt the data and send the request to application.

## Cipher Suite

- A cipher suite is a recipe for how TLS secures data.
- It defines:

1. Key exchange method

2. Authentication method

3. Encryption algorithm

4. Integrity check

- The main diff b/w TLS 1.2 and 1.3 is there are 2 roundtrips in handshake in 1.2 and in 1.3 there is only 1 round trip.
- The Security and the Performance is far better in 1.3 than 1.2

## Troubleshoot SNI

- `openssl s_client -connect api.example.com:443 -servername api.example.com` ---> check whether Cert is send and returned.

- `openssl s_client -connect payments.example.com:443 -showcerts` ---> checks whether chain is broken

- `aws acm describe-certificate --certificate-arn <arn>`. --> ACM cert validity

# Diff b/w TLS 1.2 and TLS 1.3 (MAIN)

The Two Models (This Is The Key)
Model A — TLS 1.2 (Old World)

“Send the secret securely”

Model B — TLS 1.3 (Modern World)

“Never send the secret at all”

This is the entire difference.

TLS 1.2 (Old Model) — Sending the Secret
How TLS 1.2 worked (simplified)
Server:
Public key (P)
Private key (S)

Client:
Generates secret K
Encrypts K with P
Sends encrypted(K) to server

Only server can decrypt because it has private key S.

So:

The secret actually travels on the network

But encrypted

Real-world analogy

Like:

You put a key in a box, lock it with server’s lock, and send the box.

The key is inside the box, moving across the internet.

The Fundamental Problem With TLS 1.2

If someday:

Server private key is stolen

Attacker recorded old traffic

Then:

Attacker opens all old boxes
Gets all old secrets
Decrypts all past traffic

❌ No forward secrecy (in RSA mode)

TLS 1.3 (New Model) — Nobody Sends The Secret

TLS 1.3 says:

“Why are we sending secrets at all?
Let’s derive a secret instead.”

So TLS 1.3 uses Diffie-Hellman math.

Diffie-Hellman (The Magic That Changes Everything)

This is the real heart.

Real-world analogy (Perfect)

Imagine:

Everyone agrees on a public paint color: Yellow

Client picks a private color: Blue

Server picks a private color: Red

Client sends:

Yellow + Blue mix → Green

Server sends:

Yellow + Red mix → Orange

Now:

Client mixes Orange with Blue

Server mixes Green with Red

Both get:

Same final secret color: Brown

Nobody ever sent:

Blue

Red

Brown

They only sent:

Green

Orange (public)

This is Diffie-Hellman.

TLS 1.3 — What Client Sends in First Message

Client sends:

“Here is my public DH value”

This is like:

“Here is my Green paint”

It is:

Not secret

Not encryption key

Just math material

What Server Sends Back

Server sends:

“Here is my public DH value”

Like:

“Here is my Orange paint”

How Both Get the Same Secret

Client:

ServerPublic + ClientPrivate → Secret

Server:

ClientPublic + ServerPrivate → Secret

Same result.

The secret was never transmitted.

It was mathematically derived independently.

So Where Is The Encryption Key?

The encryption key is derived locally from that secret.

It is:

Never sent

Never encrypted

Never on the wire

It only exists in RAM.

Then What Is The Server Certificate For?

This is the most important insight:

In TLS 1.3, the server public/private key is NOT used to encrypt the session key at all.

It is used only for identity (authentication).

Server Certificate Role Comparison
Version Role of server key
TLS 1.2 Encrypt session key
TLS 1.3 Prove server identity
How TLS 1.3 Prevents MITM

Diffie-Hellman alone is anonymous.

So attacker could:

Replace keys

Do MITM

TLS 1.3 fixes this by:

Server signs the handshake using its private key.

Client verifies:

Signature

Certificate chain

So:

DH gives secrecy

Certificate gives authenticity

The Final Mental Model (This Is Gold)
TLS 1.2
Server public key → locks secret
Secret travels (encrypted)

TLS 1.3
No secret travels
Both sides derive secret using math
Server key only proves identity

One Diagram You Should Remember Forever
TLS 1.2:
Client --(encrypted secret)--> Server

TLS 1.3:
Client --(public math)--> Server
Server --(public math)--> Client
Secret appears in both brains magically

Why TLS 1.3 Is a Revolution

Because now:

Even if server private key is stolen

Even if attacker recorded all traffic

Even with infinite time

👉 They can never derive old session keys.

Because those keys:

Were never transmitted

Were never stored

Were never encryptable

Final Real-World Analogy (Perfect)
TLS 1.2

Like:

Sending a safe key inside a locked box.

TLS 1.3

Like:

Two people doing mental math and independently arriving at the same password without ever saying it.

The One Sentence That Solves Everything

TLS 1.2 sends the secret securely.
TLS 1.3 never sends the secret at all.

Once you understand this, all confusion disappears forever.

# Auto Scaling Groups

- Basically the ASG is a controller that just see the desired count if the actual count is less, then it will increase the count vice versa.
- It wont have any monitoring it will get the data from the cloudwatch. if the cpu utilization is more then the alaram will send the notificatuon to asg and inside the asg the desired count is increased.
- Every time the a loop will run inside the asg that will check the desired count and actual count. If anything mismatch then the asg will scale in or out.
- There are diff types of scalings. 1. simple scaling: the asg will increase the instances proportionally 2. step scaling basing on the user dynamic input it will scale let say if cpu>70% count = 5 if cpu >90% count =9.
- Health check grace period: the asg will provide some grace period for the instance to warm up then only the health check happens.
- In ASG we hear term "cooldown" this mean how much time tha asg have to wait before trusting the next scaling.
- Imagine a security guard in a mall.

Crowd increases → he calls 2 more guards.

Immediately after, crowd still looks big.

Should he call 2 more again instantly?

No. He waits to see effect of the first decision.

That waiting time = cooldown.

- Cooldown sits after ASG acts:

ASG scales
↓
enter cooldown
↓
ignore new alarms
↓
wait
↓
re-evaluate metrics

So cooldown is inside ASG control loop.

- Instance Warm-up (Modern, Best)

- This is the real production-grade one.

- Instead of waiting fixed time:

- ASG waits until new instance is actually contributing to metrics.

- should we always dependon cpu metrics? other than that we have to use demand metrics such as Request per second, latency, connections, job waiting.

- Because these Demand metrics matters more than the Resource metrics.

- We can use `Hooks` in ASG's these hooks will come into picture before the instance serves the traffic and before the instance terminates.
- Let say before instance serves traffic we need some softwares to be installed some monitoring need to be configured. and before terminating some connections need to be closes. some logs has to be backedup.
- All this will be done by hooks.

# Route53

- The Route53 is a AWS Managed service to manage the DNS Queries.

## TTL

- The TTL is the time period that the browser stores the DNS Data i.e IP of a website. so that it when a browser request a website's IP, the request not need to hit the route53. The browser can get that from it cache.

## DNS Rules

- The DNS rules are set of configuration settings that determines how the dns queries has to be resolved. It contains. URL, Type of record, Routing Policy, IP Value

# Cloud Watch

Namespace: AWS/EC2
Metric: CPUUtilization
Dimensions: InstanceId=i-123
Statistic: Average
Period: 60 seconds

- To create custom metrics

- ''' aws cloudwatch put-metric-data \
  --namespace "MyApp" \
  --metric-name "Latency" \
  --dimensions Service=Login \
  --value 120 '''

- This will create. a custom metrics with MyApp as name and Service as Dimention(Filter). In that dimention we have service section. In that section we have login, payments and other services also.. for that service we have the metrics for latency.

## Ingession

- Ingession is like injecting the data into cloudwatch..
- Basically we inject the custom data and also the services data like EC2 data, VPC data ... all this comes usder ingession.
- The main cost that cloudwatch bills you is for Ingession only. Because the putMetrics API will cost you more than any other thing.
- To reduce cost one should know what to send to cloudwatch and what all data need to be injected.

## AI Operations

- AI Operatiin is used to Perform AI Investigation on the Services and the logs that we have.
- It perform the investion on the Log insignts or the metrics that are collected and suggest some suggestion based on that.

## GenAI Observability

- Then GenAI Observability is for the AI Agents in AWS.
- It will scan the tokens, models in the Agents and their performance and suggest the changes and necessary data for the Admins to Observe.

## Application Signals

- The service only provide the CPU Utilization and memory related data. Rest of the main things like Latency, error Rate, Payment Failures, No of Requests we have to send Explicitly using custom metrics.
- So to avoid this AWS came up with new solutin called Application Signals. Once this was configured the Cloudwatch Itself collect the Data with out any custom metrics.
- we don't need to calculate all the Error Rates, No.of Requests all these things. The cloudwatch itself will take care and the data can be seen inside the cloudwatch.

- Application Signals (APM)
  What it is

Automatic application performance monitoring

It gives you:

latency

error rate

request rate

dependency health

Without writing custom metrics.

2. Service Map / Application Map

- Visual graph of how services talk to each other.

3. Traces

- One full joirney of a single request

4. Trace Map

- What it is

Aggregated view of many traces.

Instead of one request, it shows:

patterns

hotspots

bottlenecks

5. Transaction Search

- Search engine for bad requests.

You can search:

slow requests

failed requests

specific users

Real example

Search:

duration > 3s AND error = true

Find:

Only users from India failing due to one API.

6. SLO (Service Level Objectives)

- What it is

Your promise to users.

Example:

99.9% requests < 500ms

CloudWatch tracks:

Are you meeting this?

How fast are you burning budget?

7. Synthetics Canaries

- What it is

Robot users that test your app.

They:

open website

login

checkout

Every minute.

8. RUM (Real User Monitoring)
   What it is

Monitoring real browsers and users.

It shows:

page load time

JS errors

slow devices

bad networks

9. Application Insights
   What it is

AI-based analysis of your application.

It:

finds anomalies

correlates metrics + logs + traces

suggests root cause

## Network Monitoring

| Tool                   | Core Question                               |
| ---------------------- | ------------------------------------------- |
| **Flow monitors**      | What traffic is flowing inside my VPC?      |
| **Internet monitors**  | Is the internet path to my users healthy?   |
| **Synthetic monitors** | Can a user actually reach my app right now? |

- Flow Monitoring ---> ALB → EC2 → RDS
- Internet Monitors ---> Networng outside the AWS. From the internet till the AWS
- Synthetic Monitors ---> Synthetic monitors are robot users.

# Config

- Congif is like a audit of whether the resources are following the compliances or not.
- We can have the AWS pre defined rules or custom rules that we can write via Lambda functions.
- We can store the CI (Configuration Items), Configuration History, compliance History and the Confuguration Snapshots inside the S3
