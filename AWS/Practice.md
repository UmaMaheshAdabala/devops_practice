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
