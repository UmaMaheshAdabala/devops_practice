# LINKS

- VPC COMPLETE `https://siddhantacademy101.medium.com/build-your-vpc-and-launch-a-web-server-deploy-a-static-website-fea0e316f7be `

## IAM ---

    Identity and Access Management
        - Groups
        - Users
        - Policies
    We can create the above using IAM. In organization we wont work as an root user. We login as IAM User and we can give only some permissions as part of Policies.
    We can also Group the users based on their tasks

## VPC ---

    Virtual Private Cloud

    This is a secure place where you can create your Instance
    In this vpc you can create subnets
    For secutiy we can use
    - Security Groups (At ec2 Level)
    - NACL (At subnet level)
    - NAT for subnets

    Security Groups:
    - Inbound rules - The ports that we can allow from which the clients can come and access the EC2 Instance. (Deney all by default)
    - outbound rules -  The ports that the server uses to connect to outside the instance. (allow all except 25 by default )


    ---

    VPC: Virtual Private cloud.
    In AWS or any other cloud services we have a region we have different availability zones.
    This is important because if we dont have more than 1 availability zone, when the server at single availability zone is down then the work will be off.
    So we should have multiple availability zones. And the clients in this Availability zones will communicate with each other within a region.
    But the problem here is if there are 2 clients in this availability zones. if one client in able to see the other clients data, as they communicate each other it will
    be a security breach so to avoid such breaches we use "VPC".

    ** Within a VPC a single client is hosted and the VPC is across the availability zones in a region.
    So there will be no communication b/w two clients.
    But a single clients can communicate b/w all his availability zones.

# Route 53 --

    Route 53 helps in DNS Registration
    Route table helps in finding ip with help of domain name
    And Checks the Hosted Zones
    And also Health Checks
    Route table defines network traffic also

## VPC DEPLOY --

    Create VPC in aws with vpc and more
    configure the required things and create it
    Then before creating EC2 instance create Auto Scaling Group

# Auto Scaling Group -- ( Automatically scales the no of EC2 Instances based on the traffic)

        Go to EC2 and search for Auto Scaling Group
        First create Template for AutoScaling Group
        Go to template creation and give name
        Descriotion
        Then give Application and OS Images
        Then Instance Type
        Key Login pair
        select security Group
        Give name and description
        Select your vpc name
        Add inboud rules if you want
        Click Launch Template
        Now come to Auto Sclaing page and andd the template that you created and give the name to ASG
        Click Next
        Give VPC and Availability Zones- select both private Zones
        Click next and next
        Give desired capacity as 2 and min as 1 and max as 4 then next to last and launch

        -- Jump Host or Bastian Host
        Create the EC2 Instance with name of bastian_host (name is of your wish)
        But create it in same VPC that you created
        Launch it

    --Terminal--

        You have ssh to private subnets from your bastian Host
        So you have first copy the pem file from local to ubuntu
        cmd: sudo scp -i /Users/umesh/Downloads/practice_1.pem /Users/umesh/Downloads/practice_1.pem ubuntu@<IPADDRESS>:/home/ubuntu
        Then you can login to ubuntu server using: ssh -i pem_file_name ubuntu@<IPADDRESS>

        Now you can login to private subnets

        use ssh -i pem_file_name ubuntu@<IPADDRESS>
        now deploy your application here
        And also login to second subnet and upload other project there

    -- Load Balancer --
        Go to Load Balancer
        Then give name
        select internet facing
        select create Template
        Go to template
        Give name
        select port 8000
        select vpc
        click next
        select the instance and select include as pending below
        click create
        Then select the tamplate you created
        And launch

        using the DNS provide copy and paste it in browser

--- AWS CLI ----

    AWS CLI is the command line Interface where we can do our tasks without UI

--- AWS CFT ---

    AWS CFT is a IAC ( Infracstructure as Code )
    CFT is a tool that converts the USER given YAML or JSON code into Infracstructure

    JSON/YAML ---> CFT(converts to API that Tools understand) ---> Infrastructure created

    prinicipals:
     - Declerative & versioned

     Drift Detection : Drift detection means when there is a change that a user made un intentionally in the UI then the CFT will notify us

    We use Stacks in AWS to UPLOAD the YAML files that we write to AUTOMATE our tasks
    So first write the YAML file for your requirement
    Go to aws console and open CF stack and upload your YAML file and submit

--- AWS CI/CD ---
--- AWS CODECOMMIT --- (similar to GitHub) // Not used mostly
--- CI ---
--- AWS CodeBuild ---
Responsible for code checkout, code build, code scan, image build, image scan, image push

            GoTo AWS CODEBUILD and create a Build
            Give the repository details and then write the  build file / upload it
            Meanwhile we have to create a roles and give required permissions to the role
            Then we have to use AWS System Manager to store Credentials of docker file etc..

        --- CODE PIPE LINE --- THIS INVOKES CODE BUILD as well as CODEDEPLOY
            Create a code pipeline and give github auth to it
            Give the CODEBUILD that you created

    --- CD ---
        First create an EC2 Instance
        Then Goto Code Deploy and  create an Application
        Then you have to Install an Agent to Invoke the deploy actions
        So install ruby-full by ssh into the instance that we created
        Then run necessary commands
        Then we have to create a ROLE for the Instance and give permissions of Code Deploy & assign it to Instance
        Then restart the ruby agent
        Then come back to code deploy
        And goto deployment group and give required info
        Then go to create deploy and create deploy
        Before providing GITHUB details make sure that we have appspect.yml and scripts/start_container.yml amd scripts./stop_container.yml in root level of repo folder
        Then create it
        Once created Goto code pipeline and add this code deploy also
        Then CI/CD is completed

---

## Difference Between Internet Gateway, VPC Endpoints, and VPC Interface Endpoints in AWS

Feature---

Internet Gateway (IGW)

VPC Endpoints (Gateway Endpoint)

VPC Interface Endpoints

Purpose---

Enables public internet access

Enables private access to AWS services without internet

Enables private access to AWS services using ENI (Elastic Network Interface)

Connectivity---

Routes traffic between VPC and the internet

Routes traffic to AWS services like S3 & DynamoDB via a private route

Connects AWS services via ENI within the VPC

Public/Private---

Public

Private

Private

Components Used--

Internet Gateway (IGW)

Gateway Endpoint (Added to Route Table)

Interface Endpoint (Uses ENI)

Use Case---

When instances need internet access

When instances need to connect to S3 or DynamoDB privately

When instances need private access to AWS services like SSM, Secrets Manager, or API Gateway

Cost---

Free

Free

Charged per data transfer

Traffic Path

Through the internet

Stays inside AWS network

Stays inside AWS network

1. Internet Gateway (IGW)

Definition: A component that allows resources in a VPC to communicate with the internet.

Function: Routes traffic between a public subnet and the internet.

Example: If you have an EC2 instance in a public subnet, it can access the internet using an IGW.

Real-World Analogy

Think of an Internet Gateway as the main entrance of a city. It allows people (data) to move in and out of the city (VPC) through a controlled entry point.

2. VPC Endpoints (Gateway Endpoint)

Definition: A private connection that allows resources in a VPC to connect to specific AWS services (like S3 or DynamoDB) without using the internet.

Function: Uses a route table entry to send traffic directly to AWS services.

Example: If an EC2 instance in a private subnet needs to access S3, you can set up a Gateway Endpoint for S3.

Real-World Analogy

A Gateway Endpoint is like a private road connecting two buildings in the same campus, without needing to exit the main entrance.

3. VPC Interface

Definition: A private connection to AWS services using an Elastic Network Interface (ENI) inside your VPC.

Function: Allows resources in your VPC to privately connect to AWS services like SSM, API Gateway, and Secrets Manager.

Example: If an EC2 instance in a private subnet needs to connect to AWS Secrets Manager, it can use an Interface Endpoint.

Real-World Analogy

A VPC Interface Endpoint is like a dedicated phone line inside a company. You can directly call another department without going through the public phone network.

## Public and private subnets

- we can make a subnet as private or public by the way of assinging it in the route table.
- If we want a subnet to be private then attach it to the local only and NATGATE also.
- If it has to be public then assign it to the Internet Gate Way.
- The routing will decide whether it is private or public.

## VPN in VPC

- A VPN (Virtual Private Network) in AWS VPC (Virtual Private Cloud) is used to establish a secure and encrypted connection between your AWS environment and an on-premises network or another cloud provider. It allows private communication over the internet between AWS and external networks without exposing data to public access.
- A VPN in AWS VPC is typically used in the following cases:
  - Connecting On-Premises Network to AWS (Hybrid Cloud Setup)
  - Secure Access for Remote Employees
  - Connecting Multiple AWS VPCs (VPC-to-VPC VPN)
  - Extending Corporate Network to AWS

# 2 Types of VPN

- Static VPN
  - Uses static routing where routes are manually configured.

  - The customer gateway device (on-premises router) must have predefined routes to AWS.

  - Ideal for simple networks with few routes that do not change frequently.

  - Less overhead but not scalable for large or frequently changing networks.

  - Requires manual updates if the network topology changes.

- Dynamic VPN
  - Uses dynamic routing via BGP (Border Gateway Protocol).

  - Routes are automatically exchanged between AWS and the customer gateway.

  - Supports failover and redundancy by automatically rerouting traffic in case of failure.

  - Ideal for large and complex networks that require frequent route updates.

  - More scalable and reduces manual configuration effort.

- BGP:
  - Border Gateway Protocol (BGP) is a dynamic routing protocol used to exchange routing information between different networks, particularly across the internet or within large enterprise networks. It helps routers determine the best path for data to travel between different networks.

  - BGP is used in AWS Site-to-Site VPN (Dynamic VPN) to automate the exchange of routes between AWS and an on-premises network.

## AWS DX (Dirrect Connect)

- This is a dedicated direct connection b/w aws & on prem N/W.
- This is more secure and low cost.
- IMG- AWS_DX.

## VPC Peering

- VPC peering is used to connect 2 vpc's and they can communicate with each other.

### Creating VPC with CLI

- ""aws ec2 create-vpc --cidr-block 10.0.0.0/16"".

# Create subnet

- aws ec2 create-subnet --vpc-id <vpc-id> -- cidr-block 10.0.1.0/24 --availability-zone us-east-1a.

# create route-table

- aws ec2 create-route-table --vpc-id <vpc-id>

# Create IGW

- aws ec2 create-internet-gateway

# Attach IGW to VPC

- aws ec2 attach-internet-gateway --internet <igw-id> --vpc <vpc-id>

# Create route

aws ec2 create-route --ro rtb-<id> --destination 0.0.0.0/0 --gateway-id igw-<id>

# Attach subnet to routetable

aws ec2 associate-route-table --route-table-id rtb<id> --subnet-id <subnet-id>.

## NAT GATEWAY

- A NAT (Network Address Translation) Gateway is a managed service in AWS that allows instances in a private subnet to access the internet or other AWS services while preventing inbound connections from the internet.

- In a Virtual Private Cloud (VPC), private subnets do not have direct internet access. However, instances in these subnets might need to:

- Download software updates.

- Communicate with external APIs.

- Connect to AWS services that require internet access.

- A NAT Gateway solves this problem by allowing outbound traffic to the internet while blocking unsolicited inbound connections.

### IAM

- IAM is a web service that helps securelty control access to AWS resources by managing users, permissions, and credentials.

## IAM Policy

- Defines who is allowed to do what with which AWS resources.
- Controls access to AWS services and resources.
- A set of rules in a JSON Format
- Helps keep your AWS environment secure
- Can be attached to three types of entities.
  1. user
  2. Group
  3. roles
- In IAM there are 3 essential policies.
  1. AWS Managed Policies
  2. Customer Managed Policies
  3. Inline Policies

1. AWS managed polocies

- created and managed by AWS
- for comman use cases across a wide range of aws services
- Ready to attach to multiple IAM users
- Automatically updated by AWS
- Provide a way to quick assign necessary permissions
- Types
  1. AWS Managed (General Use)
  2. Service-linked policies

- DrawBack: We can't customize.

2. Customer Managed Policies

- Created by user.
- Have to maintain by our self
- can be customized.

- Visual format or JSON format
- In JSON format we have effect whether it is allow or deny
- And We Have Ation which specifies which action will be performed.
- And then resources which specifies on which resources the action will be performed.

3. Inline Policies

- Inline policies are more over restricted to a single user.
- They will provide more security
- creation is same as Customer Managed Policies.

## IAM Users

- Users that a root user creates for a particular task.
- Their credentilas lasts for long period.
- High risk for security.
- Better to use Roles.

## IAM Group

- A collection of IAM users
- Grant users access to specific AWS resources
- Groups reduces the need for individual user policy management

## IAM Roles

- An IAM role is an IAM identity that you can create in your account that has specific permissions.
- A role os for anyone who needs it, not just for one person, unlike an IAM user.
- A role gives you temperory credentials when assumed
- You can use roles to delegate access to users, applications, or services that don't normally have access to your AWS resources

- USECASES:
  1. AWS Service
  - There are so many services in AWS but one cannot access other so for that we use IAM Roles to provide access when ever required.
  2. AWS Account | Assume Role
  - Same account: A User x wants a temporary access to s3 service
    - First create User
    - Then create a role
    - Go to role and edit trust policies and add IAM user-name there
    - Then goto policies and create policy to Assume_Access and Role_Name
    - Then attach the policy to the user.

  - Cross-Account Access: A company 'x' wants to access s3 service of other company 'y' - First create a role in Y account by x accound_ID

  - Trust Policy
    ---t

        {

    "Version": "2012-10-17",
    "Statement": [
    {
    "Effect": "Allow",
    "Principal": {
    "AWS": "arn:aws:iam::ACCOUNT_A_ID:root"
    },
    "Action": "sts:AssumeRole"
    }
    ]
    }

    ***

        - Then create a user in X account
        - Create a Assume_Access Policy with ARN of role in Y
        - Then attach the policy to the user in X.

    ```

    ```

  ## Cross Account Access (IAM --> EC2)
  1. Create a role in account B and give ec2 full access to it on the name of Account A ID.
  2. create a role in account A and select lambda as service and attach STS:AssumeRole policy on the name of role created in Account B
  3. Attach the role to lambda fn.

  ```
  4. Web Identity/SAML 2.O Federation

   - The Web Identity/SAML 2.O Federation is a security feature that enables secure access to your AWS resources using temporary credentials obtained through external Identity providers(IdP) ex: google, github etc...

   - They will use OAuth 2.0 and OpenID Connect (OIDC) / SAML 2.O Federation
   - OAuth and OpenID Connect
   - OAuth 2.0 will handle authorization aspect.
   - OpenID Connect will handle Authentication and provides us the token. ex JWt

   - SAML 2.0 (Security and Assertion Markup Language)
   - In SAML it allows the user to authenticate once and gain access to multiplr applications without re-entering credentials.
   - Uses XML rather than JWT.

  5. Custom Trust Policies

  - Basically it is a kind similar to AWS Account in Trust policy
  - But the difference is in AWS Account Trust Policy erevy one can assume the role as it will be mentioned as "root" in the trust policy.
  - so it is not much secure.
  - So to have more security we use custom trust policy.
  - And also we can't directly assign role to user in AWS Account Trust Policy util unless we have explicit permissions. or else we have to update the Trust policy with specific user Name.

  - IAM ROLE from one account to another account(ONE ROLE TO ACCESS OTHER ROLE and that ROLE has ACCESS to EC2)👇

  - we use lambda function and lambda function has access to Role in 1st account
  - we create a Role in 2nd account
  - Give EC2 permissions to that role.
  - Then in the trust policies give 1st role name
  - In the first account create a Role and assume the role that was created in the 2nd Acount.
  - Create a lambda function and attach it to the 1st account role.
  - Then you can access the EC2 Instance in the second account with the role in first account.

  ### CHAT GPT (CRR)

  Thanks for sharing the trust policy! 👌 You're **almost there**, and the trust policy you posted is **correct** for allowing AWS Account `257394459123` (Account B) to assume the role.
  ```

---

### ✅ Let’s recap what should be in place:

#### 🛠️ From **Account A (Your Account)**:

1. You've created a role with:
   - Trust policy allowing `arn:aws:iam::257394459123:root`
2. You've attached the right **permissions** (e.g., EC2 access) to the role.
3. The **role name** is exactly what you’re entering in Account B (case-sensitive).

#### 💡 Make sure you’re sharing the **Role Name**, not the Role ARN.

---

### 🔑 In **Account B (257394459123)** – When Switching Role:

Here’s what to enter on the "Switch Role" screen in the AWS Console:

| Field          | Value                           |
| -------------- | ------------------------------- |
| **Account ID** | `YOUR_ACCOUNT_A_ID` (12 digits) |
| **Role Name**  | `ExactlyAsCreatedInAccountA`    |

✅ Don't use the ARN here — only Account ID and Role Name.

---

### 🧪 Still Getting Error?

Let’s verify 3 common mistakes:

#### 🔸 **1. Role Name Mismatch**

Double-check you're not pasting the **ARN** like this:

```
arn:aws:iam::111122223333:role/CrossAccountEC2AccessRole
```

Instead, enter only:

```
CrossAccountEC2AccessRole
```

#### 🔸 **2. Account ID Typo**

Ensure you're entering the correct **Account A ID** when switching roles — not Account B’s ID.

#### 🔸 **3. Missing Permission to Assume Role**

In **Account B**, the user must have **permission to call `sts:AssumeRole`**. You can attach a policy like this to the IAM user in Account B:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::ACCOUNT_A_ID:role/CrossAccountEC2AccessRole"
    }
  ]
}
```

---

### ✅ Final Check – Summary

| What to Verify                       | Where                      |
| ------------------------------------ | -------------------------- |
| Trust policy contains Account B ID   | In Account A IAM Role      |
| Role name matches exactly            | Use in Account B to switch |
| Account A's ID is entered correctly  | In Account B during switch |
| `sts:AssumeRole` permission is given | IAM user in Account B      |

---

If you'd like, you can:

- Tell me the **exact error message** you're seeing
- Share the **Role Name**
- Confirm **Account A ID** you're entering when switching

And I’ll pinpoint it for you 🔍

## GPT

- Great question! 🔐 Accessing EC2 instances in another AWS account is a **common multi-account setup**, especially in enterprises with dev/test/prod environments or multiple teams.

Here’s a step-by-step on **how to securely access EC2 instances in another AWS account** (e.g., Account A accessing EC2 in Account B):

---

## 🎯 Goal:

You want to **SSH into EC2 instances** or **manage them via CLI/API** in **Account B** from **Account A**, using **IAM Roles and Trust Relationships**.

---

## ✅ Option 1: **Use IAM Role + AssumeRole**

This is the **recommended and secure method**.

---

### 🧭 Step-by-Step

### 🔧 1. **Create an IAM Role in Account B** (EC2-owner account)

This role allows users from Account A to assume it and manage EC2.

#### Trust Relationship:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::ACCOUNT_A_ID:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

#### Permissions (Example for EC2 access):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:StartInstances",
        "ec2:StopInstances",
        "ec2:TerminateInstances"
      ],
      "Resource": "*"
    }
  ]
}
```

Give the role a name like: `CrossAccountEC2AccessRole`.

---

### 🧑‍💻 2. **In Account A**, allow your IAM user or role to **assume** that role

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::ACCOUNT_B_ID:role/CrossAccountEC2AccessRole"
    }
  ]
}
```

---

### 🚀 3. **Use the Role to Access EC2 Instances**

From AWS CLI in Account A:

```bash
aws sts assume-role \
  --role-arn arn:aws:iam::ACCOUNT_B_ID:role/CrossAccountEC2AccessRole \
  --role-session-name ec2-session
```

You’ll get **temporary credentials** (Access Key, Secret Key, Session Token). Use them to run EC2 commands:

```bash
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_SESSION_TOKEN=...

aws ec2 describe-instances --region us-east-1
```

---

### 🧷 Optional: Automate SSH Access

If you want to **SSH into EC2 in Account B**:

1. Share the **key pair** or use **Session Manager (SSM)**
2. Make sure the EC2 instance has:
   - The correct **security group** (allow SSH or SSM)
   - An **IAM instance profile** if using SSM

Using **SSM Session Manager** is safer and doesn’t need key pairs or open ports:

- Install SSM Agent on EC2
- Attach IAM role with `AmazonSSMManagedInstanceCore`
- Use:

```bash
aws ssm start-session --target instance-id
```

---

## 🤝 Summary

| Task                  | Done In   | Description                              |
| --------------------- | --------- | ---------------------------------------- |
| Create IAM Role       | Account B | Allows Account A to assume it            |
| Set Trust Policy      | Account B | Grants trust to Account A                |
| Set Assume Permission | Account A | Allows user/role to assume the role in B |
| Use AssumeRole API    | Account A | Get temporary creds and access EC2       |

---

## Best Practices

## IAM Reports

- IAM reports are document generated within AWS that offers insights into the configuration, usage and security.

- These reports are instrumental for auditing, compilance and security
- They typically include details about User Credentials, Permissions, Policy Usage, Access patterns across the aws service and resources.

- 3 primary types of IAM reports are
  1. IAM Credential Report
  2. IAM Access Advisor Report
  3. AWS IAM Access Analyzer

1. IAM Credential Report

- Provides an overview of IAM user credentials status within an AWS account.

2. IAM Access Advisor report

- The Access Advisor will provide which user has which access report

3. AWS IAM Access Analyzer

- Helps to access resources permissions.
- It helpa to identify resources in AWS environment thar are shared with externam entity or having permisssions that are not being used.
- We can provide report for particular region which in=s not possible in other.

### AWS Organization

📌 When to Use AWS Organizations?

✅ Managing multiple AWS accounts efficiently.✅ Enforcing security policies across accounts.✅ Reducing costs through consolidated billing.✅ Creating isolated environments (e.g., Dev, Staging, Prod) while maintaining governance.

📌 AWS Organizations vs AWS IAM

Feature

AWS Organizations

AWS IAM

Scope

Manages multiple AWS accounts.

Manages users, roles, and permissions within a single AWS account.

Security Control

Uses Service Control Policies (SCPs) to restrict actions across accounts.

Uses IAM policies to control permissions for users and roles.

Billing

Supports consolidated billing for multiple accounts.

Billing is account-specific.

Use Case

Best for enterprises managing multiple AWS accounts.

Best for managing permissions within a single AWS account.

## Service Control Policies

- SCP's are set of rules that control what you can and cannot do in your AWS Account.

## IAM Identity Center (SSO - Single Sign on)

- AWS Identity Center is essentially an SSO service by AWS.
- This allows to use all services with single credential.
- Enable Users to login once to access multiple aws services
- AWS Identity center is designed to simplify how users access AWS accounts and applications across multiple accounts.

- Steps to set an Identity user with some policies attached.
  - Enable IAM Identity.
  - Create Identity center user.
  - Then create permissions set
  - let say one set is to give ec2 full access and 2nd one is s3 full access
  - Goto permission set and create set and select the required permission and create set.
  - Similarly create set for 2nd one also.
  - Then goto organization and add the user that you created in Identity to which account you want.
  - Then give permission set to the accound based on the reqyuirement.

---

# S3 SIMPLE STORAGE SERVICE

- Object Storage service

- Provides: 1. Industry-leading Scalabilit 2. Data Availability 3. Data Security 4. Performance

## Benifits of S3

- Performance
- Scalability
- Availability
- Low Cost
- Security

## Objects and Buckets in S3

- Objects are fundemental entities stored in S3.
- Buckets are containers where objects are stored

## Types of S3

- S3 Standard, S3 Standard-IA, S3 Intellegent- Tiering, S3 One Zone-IA, S3 Glacier, S3 Glacier Deep Archive.

- S3 Standard: Used when we have to use data frequently.
- S3 Standard-IA: Used when we won't use the bucket directly.
- Amazon Glacier: Suitable where data can be archived, and high performance is not required.
- One Zone: Basically s3 stores in around 3 Availability Zones. But this will be stored in only 1 Zone so cost is reduced.

- AMAZON S3 Standard Reduced Redundancy Storage: It is used where the data is non critical and reproduced quickly.

## Features of S3

- Life Cycle : This will automatically analize your tasks and move the buckets b/w types of s3. maintaing data security availability and mainly cost in consideration.

## Bucket Policy

- It is an IAM Policy which lets you allow and deny permissions to your S3 resources.
- With this you also define security parameters for more than one file in desired bucket.

## Data Encryption

- The Data in the bucket is Encrypted by AES-256 Encryption.

## CRR IN S3 (Cross Region Replication)

- CRR allows automically copying of every object uploaded to your buckets into different AWS region.

## Transfer Acceleration

- It allows easy and secure transfer of files over long distances b/w client and S3

---

## GITHUB

What is Amazon S3?

Simple Storage Service is a scalable and secure cloud storage service provided by Amazon Web Services (AWS). It allows you to store and retrieve any amount of data from anywhere on the web.

What are S3 buckets?

S3 buckets are containers for storing objects (files) in Amazon S3. Each bucket has a unique name globally across all of AWS. You can think of an S3 bucket as a top-level folder that holds your data.

Why use S3 buckets?

S3 buckets provide a reliable and highly scalable storage solution for various use cases. They are commonly used for backup and restore, data archiving, content storage for websites, and as a data source for big data analytics.

Key benefits of S3 buckets

S3 buckets offer several advantages, including:

Durability and availability: S3 provides high durability and availability for your data.
Scalability: You can store and retrieve any amount of data without worrying about capacity constraints.
Security: S3 offers multiple security features such as encryption, access control, and audit logging.
Performance: S3 is designed to deliver high performance for data retrieval and storage operations.
Cost-effective: S3 offers cost-effective storage options and pricing models based on your usage patterns.
Creating and Configuring S3 Buckets
Creating an S3 bucket

To create an S3 bucket, you can use the AWS Management Console, AWS CLI (Command Line Interface), or AWS SDKs (Software Development Kits). You need to specify a globally unique bucket name and select the region where you want to create the bucket.

Choosing a bucket name and region

The bucket name must be unique across all existing bucket names in Amazon S3. It should follow DNS naming conventions, be 3-63 characters long, and contain only lowercase letters, numbers, periods, and hyphens. The region selection affects data latency and compliance with specific regulations.

Bucket properties and configurations

Versioning: Versioning allows you to keep multiple versions of an object in the bucket. It helps protect against accidental deletions or overwrites.
Bucket-level permissions and policies

Bucket-level permissions and policies define who can access and perform actions on the bucket. You can grant permissions using IAM (Identity and Access Management) policies, which allow fine-grained control over user access to the bucket and its objects.

Uploading and Managing Objects in S3 Buckets
Uploading objects to S3 buckets

You can upload objects to an S3 bucket using various methods, including the AWS Management Console, AWS CLI, SDKs, and direct HTTP uploads. Each object is assigned a unique key (name) within the bucket to retrieve it later.

Object metadata and properties

Object metadata contains additional information abouteach object in an S3 bucket. It includes attributes like content type, cache control, encryption settings, and custom metadata. These properties help in managing and organizing objects within the bucket.

File formats and object encryption

S3 supports various file formats, including text files, images, videos, and more. You can encrypt objects stored in S3 using server-side encryption (SSE). SSE options include SSE-S3 (Amazon-managed keys), SSE-KMS (AWS Key Management Service), and SSE-C (customer-provided keys).

Lifecycle management

Lifecycle management allows you to define rules for transitioning objects between different storage classes or deleting them automatically based on predefined criteria. For example, you can move infrequently accessed data to a lower-cost storage class after a specified time or delete objects after a certain retention period.

Multipart uploads

Multipart uploads provide a mechanism for uploading large objects in parts, which improves performance and resiliency. You can upload each part in parallel and then combine them to create the complete object. Multipart uploads also enable resumable uploads in case of failures.

Managing large datasets with S3 Batch Operations

S3 Batch Operations is a feature that allows you to perform bulk operations on large numbers of objects in an S3 bucket. It provides an efficient way to automate tasks such as copying objects, tagging, and restoring archived data.

Advanced S3 Bucket Features
S3 Storage Classes

S3 offers multiple storage classes, each designed for different use cases and performance requirements:

Screenshot 2023-07-06 at 7 16 51 PM

S3 Replication

S3 replication enables automatic and asynchronous replication of objects between S3 buckets in different regions or within the same region. Cross-Region Replication (CRR) provides disaster recovery and compliance benefits, while Same-Region Replication (SRR) can be used for data resilience and low-latency access.

S3 Event Notifications and Triggers

S3 event notifications allow you to configure actions when specific events occur in an S3 bucket. For example, you can trigger AWS Lambda functions, send messages to Amazon Simple Queue Service (SQS), or invoke other services using Amazon SNS when an object is created or deleted.

S3 Batch Operations

S3 Batch Operations allow you to perform large-scale batch operations on objects, such as copying, tagging, or deleting, across multiple buckets. It simplifies managing large datasets and automates tasks that would otherwise be time-consuming.

Security and Compliance in S3 Buckets
S3 bucket security considerations

Ensure that S3 bucket policies, access control, and encryption settings are appropriately configured. Regularly monitor and audit access logs for unauthorized activities.

Data encryption at rest and in transit

Encrypt data at rest using server-side encryption options provided by S3. Additionally, enable encryption in transit by using SSL/TLS for data transfers.

Access logging and monitoring

Enable access logging to capture detailed records of requests made to your S3 bucket. Monitor access logs and configure alerts to detect any suspicious activities or unauthorized access attempts.

S3 Bucket Management and Administration
S3 bucket policies

Create and manage bucket policies to control access to your S3 buckets. Bucket policies are written in JSON and define permissions for various actions and resources.

S3 access control and IAM roles

Use IAM roles and policies to manage access to S3 buckets. IAM roles provide temporary credentials and fine-grained access control to AWS resources.

S3 APIs and SDKs

Interact with S3 programmatically using AWS SDKs or APIs. These provide libraries and methods for performing various operations on S3 buckets and objects.

Monitoring and logging with CloudWatch

Utilize Amazon CloudWatch to monitor S3 metrics, set up alarms for specific events, and collect and analyze logs for troubleshooting and performance optimization.

S3 management tools

AWS provides multiple management tools, such as the AWS Management Console, AWS CLI, and third-party tools, to manage S3 buckets efficiently and perform operations like uploads, downloads, and bucket configurations.

Troubleshooting and Error Handling
Common S3 error messages and their resolutions

Understand common S3 error messages like access denied, bucket not found, and exceeded bucket quota. Troubleshoot and resolve these errors by checking permissions, bucket configurations, and network connectivity.

Debugging S3 bucket access issues

Investigate and resolve issues related to access permissions, IAM roles, and bucket policies. Use tools like AWS CloudTrail and S3 access logs to identify and troubleshoot access problems.

Data consistency and durability considerations

Ensure data consistency and durability by understanding S3's data replication and storage mechanisms. Verify that data is correctly uploaded, retrieve objects using proper methods, and address any data integrity issues.

Recovering deleted objects

If an object is accidentally deleted, you can often recover it using versioning or S3 event notifications. Additionally, consider enabling Cross-Region Replication (CRR) for disaster recovery scenarios.

# EC2

## AMI (AMAZON MACHINE IMAGE):

- An AMI is a template that is used to create a new instance/ machine based on user requirements

- AMI contains Software Information, Operating System Information, Volume Information, Access Permissions.

- PREDEFINED AMI's ( Predefined by amazon and can be modified) and Custom AMI's (Created by user and can be reused).

## Instance Type:

1. Compute Optimized: Lot of computing and Optimizing Power

2. Memory Optimized: More Caching Power.

3. GPU Optimized: Used for Applications that used GPU like Games

4. Storage Optimized: Used for Storage Servers

5. General Purpose: All above are equally managed, used when we are not sure about above all.

## Configure Instance:

- Public, Private IP's, IAM Roles, subnets, SG's

## Storage

1. Ephemeral Storage(Temporary and Free)
2. Amazon Elastic Block Storage (Permanent and paid)
3. Amazon S3

## SSH into Private Instance from Bastian Host

- Open Pagent and Click Add Key
- Select ppk file
- Open putty and in auth section select ALLOW AGENT Forwarding
- Then do ssh ubuntu@<privateINstanceIP>.
- Good to go.

## Other ways to ssh into private instance

- eval "$(ssh-agent -s)"
- ssh-add -K <pemkey>
- ssh -A ec2-user@<publicIP>
- ssh ec2-user@<privateIP>

# EBS Volume

- types of EBS Volumes

- GP3 and GP2 - general Purpose one
- IO2 and IO1 - Input and Output intense operations.

1. create EC2 Instance
2. Create a volume on ebs section
3. Attach Volume
4. Verification: ---> lsblk ---> see disk partitions: fdisk -l ---> see filesystem: file -s <drive> ---> create file system: mkfs -t xfs <drive>
   ---> mount to folder: mount <drive> <folder>

   ```t

   lsblk : to block storages
   sudo fdisk -l : to see files
   sudo file -s <drive> : to see file system
   sudo mkfs -t xfs <drive> <directory> : to see create file system
   df -h
   ls -lart

   ```

   Now create a file in thet folder you created and then

5. Snapshot: ---> create EC2 ---> create snapshot for the first volume ---> create volume for the snapshot
6. The file system in the 1st volume will replicate here but we have to mount it to a folder. Once done you will see the file that you created for the first instance in the 2nd instance.

# EFS (Elastic File System)

- serverless, highly scalable, durable and Available.
- It will automatically grow and shrink as per requirement.
- Ec2 Instance can access it across multiple AVZ's within a region.
- Can replicate to multiple regions but only read only access.

- Components: EFS, Mounts, Relication, EC2 Connection.

- Create EFS Volume
- Create mount, replication
- Create 2 EC2 Instances in two availability zones.
- Connect to Instance
- Lets host a website to see cross access
- Install httpd.
- Install `amazon-efs-utils`.
- Edit the Security Group and allow the NFS
- Attach the volume to instance to the var/www/html folder
- Create a index.html file
- Create Ec2 Instamce in replicated region
- And mount to same folder
- And try to access the file

## Load Balancing

## Scalability

- The Capacity to change the Scale & Size.
- In cloud computing it meand, if the demand of the application increases the system should be able to scale by increasing/ growing/managing the resources for the customer using it.
- 2 Types of Scaling

1. Horizontal
2. Vertical

## Vertical Scalability

- The property to increase the capacity of a machine/system by adding more processing power. Like Increasing storage, CPU, Memory and other resources.
- In AWS it means increasing the capacity of Instance.

## Horizontal Scaling

- The Process of adding multiple systems for your rescue which could share the load accross multiple systems.
- In AWS adding/launching additional instance and balancing the load.
- In Horizontal Scaling we add more instances and balance the load by adding load balancers.
- ScaleOut: Adding more instances
- ScaleDown: Removing the unnecessary instances.

## Availability

- Having the ability to make your application more available to your customers.
- In most of the cases for more availability zone we host our application in different availability zones.

## Load Balancer

- Elastic Load Balancer automatially distributes incoming applocation traffic across multiple targets.
- Load Balancers are the servers that forward the traffic from internet traffic to the other servers/ instances, thus balancing the load.

- N/W Load Balancers - Best suit for Extreme performance
- Application Load Balancer(works on Layer 7) - Best suit for load blnc of HTTP and HTTPS Traffic, for Micro Services and container based applications. Support Path/Host Base Routing.
- Classic Load Balancer - Provides basic load Balancing, operated ate connection and request level.

## Health Check in Load Balance.

- Load Balancers use the actice and passive health checks to determine whether target is available to handel requests.

- Active Health Check: LB will periodically sends a request to each registered target to check it status.
- Passive Health Check: Load Balancer obeserves how target responds to connections. Enables LB to detect an unhealthy target before it reports as unhealthy by active check

## Points to consider

- Not advicesable to use Classic LB, they are depricated.
- Application Loadblncer for HTTP/HTTPS, WebSockets (Layer 7)
- N/W Load Balancer- For TCP(LAyer 4)
- Health Checks can be enabled using all load balancers.
- ALB are the best for Microservices and container based applications. can route with /path or hostname.
- The loadbalancer will have its URL. Don't resolve it
- To scale LB's rapidly contact AWS to warm up your load balancer.
- ALB cant see the client IP directly. NLB can

## Sticky Sessions in LB

- With Sticky Sessions it is possible to instruct the load balancer to route repeated requests to same EC2 Instances whenever possible.
- All requests goto same instance every time.
- Stickness is generated by ELB.
- Works with both classic and application load balancers.
- Stickiness works with Cookies and has ab expiration date.

## SSL/TLS Certificated for Classic Load Balancers

- SSL/TLS Certificated encrypt data sent over internet. They help trust and identify website.

# Auto Scaling Groups

- An AUto Scaling Group contains of AMaxon EC2 instance that are treated as logical grouping for the purposees of automatic scaling and management.
- When your application load increses or decreases, we use AutoScaling groups to make out life easier by adding or decreasing the resources as per our need.
- In the customer environment, we cam have diverse situations that impact as performance of our application.
- ScalingOut: Adding more instances to meet the growing demand.
- ScaleIn: Dreasing the instances when you don't need them.
- Desired Capacity: Allocate the minimum and the maximum number of instances that you intend to spin.
- Auto Assign: Adding/decreasing instances to meet growing/ decreasing Demand.

### Diff B/W N/W LB Application LB and Classic LB

Perfect! This is one of the **most common and important AWS interview questions** — and also super useful when you're designing scalable apps.

Let's break it down into:

- 🔍 Basic differences
- ✅ Real-world use cases
- 🧠 When to use which

---

## 🎯 1. Application Load Balancer (ALB)

**Layer**: Application Layer (Layer 7 of OSI model)  
**Smart Routing**: Yes — based on URL, hostname, HTTP headers, etc.  
**Protocols**: HTTP, HTTPS  
**Target Types**: Instance ID, IP, Lambda

### ✅ Real-world Use Case:

- You have a web app: `example.com`
- `/api/*` should go to your Node.js backend
- `/app/*` should go to your React frontend
- `/admin/*` should go to a different service

**ALB can route traffic to different target groups based on URL path.**

### 🧪 Example:

| Request             | Routed To               |
| ------------------- | ----------------------- |
| `example.com/api`   | Node.js backend         |
| `example.com/app`   | React frontend          |
| `example.com/admin` | Admin dashboard service |

---

## ⚙️ 2. Network Load Balancer (NLB)

**Layer**: Transport Layer (Layer 4)  
**Smart Routing**: ❌ No — just based on IP and port  
**Protocols**: TCP, UDP, TLS  
**High Performance**: ✅ Designed for extreme speed and low latency  
**Target Types**: Instance ID, IP

### ✅ Real-world Use Case:

- You are hosting a **game server**, **VoIP**, or **custom TCP app** (like MQTT, Redis, MySQL replication).
- You need **millisecond-level latency**
- You don’t care about HTTP-level stuff like URL routing.

**NLB is great for high-performance, low-latency backend systems.**

### 🧪 Example:

| Service           | Port | Handled By           |
| ----------------- | ---- | -------------------- |
| Game server       | 3000 | EC2 or ECS container |
| Financial app TCP | 9090 | Backend microservice |

---

## 🌐 3. Classic Load Balancer (CLB) — Legacy

**Layer**: Mix of Layer 4 & Layer 7  
**Limited Routing**: Yes, but not as powerful as ALB  
**Protocols**: HTTP, HTTPS, TCP, SSL  
**Old generation**: AWS recommends moving to ALB/NLB

### ✅ Real-world Use Case (legacy systems):

- You have a **legacy web app** still running on an older EC2 stack
- You just need simple load balancing (no path-based routing)
- You're gradually migrating to modern architecture

### 🧪 Example:

| Old Java EE app on EC2 | Load balanced by CLB |
| ---------------------- | -------------------- |

---

## 📊 Feature Comparison Table

| Feature                    | ALB                   | NLB                | CLB                   |
| -------------------------- | --------------------- | ------------------ | --------------------- |
| OSI Layer                  | Layer 7 (HTTP)        | Layer 4 (TCP)      | Layer 4 & 7           |
| Protocol Support           | HTTP, HTTPS           | TCP, TLS, UDP      | HTTP, HTTPS, TCP, SSL |
| Smart Routing (URLs, Host) | ✅ Yes                | ❌ No              | Limited               |
| Sticky Sessions            | ✅ (via cookies)      | ❌                 | ✅                    |
| WebSocket Support          | ✅                    | ✅                 | ✅                    |
| IP Addresses Targeting     | ✅                    | ✅                 | ❌                    |
| Use with Lambda            | ✅                    | ❌                 | ❌                    |
| Pricing                    | Cheaper for HTTP apps | Better for raw TCP | Same as legacy        |
| TLS Offloading             | ✅                    | ✅                 | ✅                    |

---

## 🤔 When to Use Which?

| Use Case                                  | Use This Load Balancer     |
| ----------------------------------------- | -------------------------- |
| Modern web apps with APIs & microservices | **ALB**                    |
| Game servers, TCP/UDP traffic, high speed | **NLB**                    |
| Simple legacy app or EC2-only setup       | **CLB** (but consider ALB) |
| Lambda backend or containerized routing   | **ALB**                    |
| IoT, streaming, or financial apps         | **NLB**                    |

---

## 🧠 Summary:

- **ALB = Smart HTTP routing** (ideal for web & API apps)
- **NLB = Raw speed + low latency for TCP/UDP**
- **CLB = Outdated, avoid for new apps**

---

Want a visual diagram or a hands-on example in AWS Console? I can walk you through setting one up!

### SETUP for ASG & LB

- First create a Launch Template and Give the necessary data in the Launch Template.
- Then Goto ASG and Create a ASG
- Then Create a Target Group and Create a Load Balancer and attach the Target Group to the ASG.
- Ensure that We can only HTTP to instance with only LB!!!.

### USER DATA FOR INSTANCE

#!/bin/bash
yum update -y
yum install -y httpd -y

# Start Apache

systemctl enable httpd
systemctl start httpd

# Fetch IMDSv2 token

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
 -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Fetch instance ID using the token

INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
 -s http://169.254.169.254/latest/meta-data/instance-id)

# Create a simple web page

cat <<EOF > /var/www/html/index.html

<html>
  <head><title>Welcome</title></head>
  <body>
    <h1>Welcome to my EC2 instance!</h1>
    <p><b>Instance ID:</b> $INSTANCE_ID</p>
  </body>
</html>
EOF

# ROUTE 53

- It is a Cloud-Based Service provided by AWS that allows you to manage and route internet traffic for your Domain Names.
- Amazon Route 53 is a highly available and scalable cloud domain name system(DNS) web service.
- Can configure route53 for DNS health checks, helps with load balancer as well.
- It offers the DOMAIN NAME REGISTRATION.

## Records used in Route53

- A Record ---> URL to IPv4
- AAAA Record ---> URL to IPv6
- CNAME Record ---> URL to URL
- Alias Record ---> URL to AWS resources

## AWS Route53 DNS Record TTL(TIME TO LIVE)

- when you request for an Route53 it will respond back with IP and TTL
- Till the TTL the website data(IP and the application associated with IP) will be cached in the browser.
- If we request again for the URL it will respond from the cache.
- Once the TTL is done and we request again, it will now request the Route53.
- DNS records will have a TTL in order for clients to know how long to caches these values and not overload the DNS with DNS request.
- TTL should be set to strike balance b/w how long the value should be cached vs how much pressure should go on the DNS.

## CNAME in AWS

- A CNAME (Canonical Name) record is a type of DNS (Domain Name System) record that maps one domain name (like www.example.com) to another domain name (like myapp.example.com or even an AWS service like an S3 bucket or CloudFront distribution).

## DNS Resolver

- A DNS Service such as Amazon Route 53 is a Globally Distributed Service that translates human readable names like www.example.com into numeric IP Address like 192.0.2.1 that computer use to connect to each other.

## Domain Registration

- Process of aquring the unique name that identifies the website.

## DNS Routing

- First when a DNS resolver receives a request for a domain name that is dosen't have cached locally, it queries a root server to find out which authoritative name server it should contact next to get the information it needs.
- Then TLD server are responsible for managing the resolution of domain names for a specific top-level domain such as .com, .org, .net.
- The DNS resolver then queries the authoritative name server to obtain IP address of domain name.
- Then it contact the authoritative name server to obtain the IP address of the domain name.

- Example www.xyz.com first contact the Root Server and root server will tell the DNS to contact TLD based on .com/.in.... and the the TDL will give the N.S.Address & will ask DNS to contact Authoritative name and based on the N.S. Address it will tell the IP

DNS--->Root Server(tell TLD)--->TLD(gives Name Server Record)--->Autoritative Server(Gives IP).

- Root Server

- Gives the TLD for the domain (.com or .org)

- TLD

- By using the .com or .org the resolver queries the respective TLD if it is .com TLD it queries the .com TLD

- Then the respective TLD will give the approprivate authoritaive server with the name server details.

- Authoritative server

- By using the name server provided by the TLD the authoritative server will provide the IP

## DNS Record

- A DNS recors is a database record used to map a URL to an IP address. DNS records are stored in DNS servers and work to help users connect their websites to the outside world.

## DNS Rules

- A DNS Rule is a set of configuration settings that determines How DNS queries are resolved for a particular domain or set of domains.

## Hosted Zones

- A hosted zone is like a phonebook for your website or application.
- It's a place where you can store the DNS records that tell the internet where to find your website, where to send email, & how to access other resources associated with your domain name.
- Public hosted zones
- Private hosted zones

## Health Checks

- A Routing policy is a set of rules that determines how traffic is routrf b/w different endpoints, such as servers or services.

# Health check at EndPoint

- Route 53 sends HTTP/HTTPS/TCP requests to monitor the health of your application or resource.
  a. HTTP / HTTPS Health Checks
  b. TCP Health Checks

# Parental Health Check

- The parent health check will monitor upto 255 child health check.
- If certain no.of health checks are healthy then the parent is considered as healthy.

## Routing Policy

### Simple Routing policy

- Use Case: When you have a single resource (like one web server) that performs a given function.

- How It Works: Maps a domain to a single IP or hostname.

- No health checks involved.

### Failover Routing Policy

- Use Case: High availability setups (primary and secondary resources).

- How It Works: Routes traffic to a primary resource unless it fails a health check, then traffic is routed to the secondary.

### Geolocation Routing Policy

- Use Case: Deliver content based on the user’s location (country, continent, or state).

- How It Works: You define different endpoints for different geographic locations.

### Geo Proximity Routing Policy (Traffic Flow Only)

- Use Case: Route traffic based on the geographic location of users and resources, and optionally, bias it.

- How It Works: Can shift traffic based on distance or bias settings, but requires Traffic Flow feature (not supported in standard console routing).

- Bias Distance:
  - Positive Bias Distance: actual distance \* [1-(bias/100)]
  - Negatie Bias Distance : actual distance / [1+(bias/100)]

### Latency Routing Policy

- Use Case: Route traffic based on the lowest latency for the user.

- How It Works: Directs requests to the AWS Region with the lowest latency (fastest response time).

### IP Based Routing Policy

- By using IP based routing we can fine-tune our DNS routing by matching the Client IP with CIDR block ID of the source IP's and send the traffic to matched IP Address.

### Multi-Value Answer Routing Policy

- Use Case: Similar to simple routing but supports health checks and returns multiple IPs.

- How It Works: Returns up to 8 healthy records randomly to increase availability and load distribution.

### Weighted Routing Policy

- Use Case: Distribute traffic across multiple resources in proportions (for A/B testing or gradual traffic shifts).

- How It Works: You assign a weight (e.g., 70% vs 30%) to each resource.

# CLOUDFRONT

- Amazon CloudFront is a Content Delivery Network (CDN) service from AWS. It delivers your website’s static and dynamic content to users faster and more securely by caching it in edge locations around the world.

- Instead of always fetching content from your main server (origin), CloudFront serves it from the nearest AWS edge location to the user—reducing latency, improving load times, and offloading traffic from your origin.

## CloudFront Signed URL and Signed Cookies

- CloudFront Signed URLs and Signed Cookies are used to restrict access to your private content.

- They help ensure that only authorized users can access your files (like videos, PDFs, images) hosted behind CloudFront.

- Your app/server generates a signed URL or cookie using a CloudFront key pair (public-private key).

- The user receives this temporary access.

- CloudFront validates the signature when a request is made.

- If valid → serves the content. If invalid/expired → returns 403 Forbidden.

- Using cloud front we can send different info to different servers based on their location. For that we can use Lambda@Edge or Cloudfront Headers.

## Restrict access to objects on s3 using cloud front with OAI (Origin Access Identity).

- OAI used to share the private content via cloud front.

- First create a s3 bucket and upload a static web site
- Restrict public access to it
- Then Create a CloudFront distributer and then select the OAI
- Then allow the CF to change the bucket policy.
- Then access it via CF domain.(This will take some time).

# GLOBAL ACCELERATOR

- AWS Global Accelerator is a networking service that improves the availability, performance, and reliability of your internet-facing applications.

- Instead of sending user traffic across the public internet, Global Accelerator routes it through Amazon’s highly available and optimized global network infrastructure.

- It routes the traffic to closest edge location via ANYCAST, then by routing it to closest regional endpoint over AWS global network.

- How it works: lets say we are in india and they have hosted the application in us-east 1a and us-east-1b and ap-mumbai. then we create 2 end point groups
  1 for US and one for india.
  Then client (from india)----> GLOBAL ACCELERATOR ----> ENDPOINT GROUP(india) ----> ap-mumbai region.
- It provides two static IP's.

# Handson

- create 2 instances in two different loactions.
- Then create global accelerator
- Give name, and add listener i.e add port to which we want to listen.
- Then add end point group
- Then add end points
- then use DNS name to access them.

### AWS SEREVERLESS

- AWS server less means giving responsibilites of the opearations to the AWS and just focusing only on the development more
- fast and reliable
- cost efficient
- reduces overhead.

## AWS Lambds

- AWS Lambda is a serverless compute service by AWS that lets you run your code without provisioning or managing servers.
- No server to manage
- continuous scaling
- sub-second metering
- consistemt performance

🚀 Real-Time Example – Image Resizer App
Scenario:
Let’s say you run a photo-sharing app. Users upload big images. You want to create a thumbnail version of each uploaded image.

How You’d Use Lambda:
✅ Step 1: User uploads an image to an S3 bucket.

✅ Step 2: S3 triggers a Lambda function.

✅ Step 3: Lambda function resizes the image (e.g., to 100x100 pixels).

✅ Step 4: Lambda saves the resized image to another S3 bucket.

## AWS Lambda ways to trigger

- Synchronous invoking ( we don't need to wait after invoking an API call)
- Asynchronous invoking ( After invoking it is placed in QUEUE and it will get execute when it turn come in queue)
- Poll based Invoking (lambda will handle the poll based services on your behalf)

## AWS Concurrency

- Concurrency: Number of requesthe that your function is serving at given time.
  -Concurrency means how many instances of your Lambda function can run at the same time.

- Every time a new request comes in, Lambda either reuses an existing execution environment or creates a new one to handle the request.

- If 100 users hit your API at the same time, Lambda might run 100 copies (instances) of your function simultaneously — this is concurrency.

# Reserved Concurrency

- A function has reserved concurrency , no other fn can use that concurrency
- To ensure that a fn can always reach a certain concurrency, you can configure the fn with reserved concurrency.
- You reserve (book) a certain number of concurrency for your function only.

- Example: You reserve 50 concurrency for Lambda A.

- No matter how much load there is elsewhere, your function will always have up to 50 instances ready to serve.

- It protects your function from being throttled when AWS account-level concurrency limits are reached.

- PROBLEM HERE: If we have hier pool of reserved concurrency then the other fn with no reserved concurrency will face higher latency.

# Provisoned Concurrency

- Provisioned Concurrency pre-warms a set number of Lambda instances before they are needed.

- It's made to eliminate cold starts.

- When traffic arrives, Lambda doesn’t need to "boot up" — it instantly serves requests.

- You pay for keeping these instances warm (even if they are idle).

- You can integrate Application Auto scaling also for this.

- Coffee shop again:
- You pre-make 10 cups of coffee at the start of the day, expecting customers.

- When customers come in, you hand them coffee immediately — no wait.

- But if no one comes, those 10 coffees still cost you (wasted money).

## Function URL

- We can configure function URL to use the lambda from browser.

## Environment Variables

- we can configure env variables in lambda to maintain security.

# What happens if more requests come than provisioned concurrency?

Suppose:

Provisioned Concurrency = 50

Suddenly 100 requests come at the same time.

👉 Here's what happens:

First 50 requests are served instantly by the provisioned instances.

Remaining 50 requests behave like normal Lambda behavior:

Lambda tries to scale up automatically (burst scaling).

BUT scaling new instances will have cold starts because they are not pre-warmed.

If the burst limits (per-region burst rules) allow it, new instances are created.

Otherwise, requests will be throttled (rejected) until concurrency becomes available.

# Lambda @EDGE

- Lambda@Edge is a service that lets you run Lambda functions at AWS edge locations (near the user) instead of inside a specific region (like us-east-1, us-west-2).

- It's closely tied to Amazon CloudFront (which is AWS's CDN — Content Delivery Network).

- Real-World Example 📦
  Imagine Netflix:

A user in Tokyo opens Netflix.

Netflix wants to show a special promotion only for Japan users.

Instead of routing the user’s request back to a big server in the US, Netflix uses Lambda@Edge to run logic at Tokyo Edge location:

"Is user from Japan? → Show promotion!"

Fast, local, and efficient!

# API GATEWAY

- "API Gateway is the smart receptionist that handles, secures, and forwards every API request to your backend perfectly and professionally." 🔥

## USES

- Create and Manage APIs
- Secure Your APIs
- Connect Frontend to Backend
- Throttling and Rate Limiting
- API Monitoring and Logging
- Request and Response Transformation
- Caching
- Cost Optimization

# AWS DYNAMODB

- It is a nosql database provided by AWS, that stores data as key-value pair.

- AWS Manages:
- Automatic data replication over 3 availability zones in a single region.
- Data backup to S3.
- Integration with Elastic Map Reduce(EMR), Data pipeline, kinesis
- DynamoDB used DAX ( DynamoDB Accerelators) for Caching.

- AMAZON DynamoDB Stream is a ordered flow of information about changes

- Once you create Table(Region A) it will be in provisioning state.
- Then DynamoDB will create certain amount of partitions in the region.
- Once all the partition is created and it is in active state then we can Read, update, write the data.
- It will create a Synchronous Replications.
- And it uses DynamoDB streams to create realtime near cross region replications
- If we want to replicate in multiple regions then it uses Async Replication with Global Tables.

### CRUD Application

- Create a DynamoDB Table
- Create a LAMBDA Function with all API's
- Create a HTTP API Gateway
- Create Routes
- Integrate the lambda fn with them
- Done 👍

## CODE

import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
DynamoDBDocumentClient,
ScanCommand,
PutCommand,
GetCommand,
DeleteCommand,
} from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});

const dynamo = DynamoDBDocumentClient.from(client);

const tableName = "http-crud-tutorial-items";

export const handler = async (event, context) => {
let body;
let statusCode = 200;
const headers = {
"Content-Type": "application/json",
};

try {
switch (event.routeKey) {
case "DELETE /items/{id}":
await dynamo.send(
new DeleteCommand({
TableName: tableName,
Key: {
id: event.pathParameters.id,
},
})
);
body = `Deleted item ${event.pathParameters.id}`;
break;
case "GET /items/{id}":
body = await dynamo.send(
new GetCommand({
TableName: tableName,
Key: {
id: event.pathParameters.id,
},
})
);
body = body.Item;
break;
case "GET /items":
body = await dynamo.send(
new ScanCommand({ TableName: tableName })
);
body = body.Items;
break;
case "PUT /items":
let requestJSON = JSON.parse(event.body);
await dynamo.send(
new PutCommand({
TableName: tableName,
Item: {
id: requestJSON.id,
price: requestJSON.price,
name: requestJSON.name,
},
})
);
body = `Put item ${requestJSON.id}`;
break;
default:
throw new Error(`Unsupported route: "${event.routeKey}"`);
}
} catch (err) {
statusCode = 400;
body = err.message;
} finally {
body = JSON.stringify(body);
}

return {
statusCode,
body,
headers,
};
};

## AWS CloudWatch

- AWS CloudWatch monitors your AWS resources and applications you run as AWS in real time.
- Collect and tract metrics, which are variables you can measure for your resources and applications.
- create alarams which watch metrics and send notifications.
- Automatically make changes to resources you are monitoring when a threshold is breached.
- You can monitor the CPU usage and disk reads and writes of your AWS Instances.
- You can also use the above data to stop under-used isnatnces to save money.
- can use custom metric as an Auto Scaling Policy.

# AWS Cloud Watch

- AWS CloudWatch is a powerful monitoring and observability service provided by Amazon Web Services. It enables you to gain insights into the performance, health, and operational aspects of your AWS resources and applications. CloudWatch collects and tracks metrics, collects and monitors log files, and sets alarms to alert you on certain conditions.
- Cloud Watch is like a watch man for the cloud that will keep track on most of the aws activities.
- It will Monitor, Alaram, Report and log the activities in aws.

- USES:
  - Monitoring
  - Real time metrix (CPU Utilization)
  - Alarams
  - Log insights (Which service is used by which one).
  - Custom metrix (Memory Utilization) - By default the clous watch won't track this but we have to enhance cloud watch to track this.
  - Cost Optimization.
  - Scaling

# AWS Config

- AWS Config is a service that enables you to:

- Track configuration changes of your AWS resources over time.

- Audit resource configurations and relationships.

- Evaluate compliance with internal policies or best practices using rules.

- Get visibility into configuration history and drift.

# AWS CLOUDTRAIL

- AWS CloudTrail is a service that enables governance, compliance, and operational and risk auditing of your AWS account. It records all API calls made within your AWS environment, including actions taken through the AWS Management Console, AWS SDKs, command-line tools, and other AWS services.

- CloudTrail captures event history of your AWS account activities.
  - It logs information such as:

  - Who made the request (IAM user, role, or service).

  - When the request was made.

  - What actions were performed.

  - Which resources were involved.

  - From where (IP address) the request was made.

- Events are stored as log files in Amazon S3 and can be viewed in CloudTrail Event History.

# AWS Databases

- Mostly databases are divided based on VVV velocity(R/W speed), variety(Relational? Non-Relational), Volume(storage capacity).
- Types: RDS, Aurora, DymanoDB, DocumentDB.....

# AWS RDS

- LINK `https://github.com/yeshwanthlm/YouTube/blob/main/aws-rds-masterclass.md`

- Basically in self hosted DB we have to manage Hardware, OS, DB.
- In EC2 we have to manage the OS and DB
- But in RDS Hardware, OS, DB are managed by AWS. we can directly use them.

- Amazon RDS is a managed relational database service that makes it easy to set up, operate, and scale a relational database in the cloud. It supports several database engines.

Supported Database Engines:
Amazon Aurora

MySQL

MariaDB

PostgreSQL

Oracle

SQL Server

Key Benefits:
Automated backups

Automatic software patching

Monitoring and metrics via Amazon CloudWatch

Easy replication and scaling

High availability with Multi-AZ deployments

## 🔄 What Are Amazon RDS Read Replicas?

Read Replicas allow you to create one or more read-only copies of your primary (source) RDS database instance. These replicas asynchronously replicate data from the primary DB.

✅ Key Benefits:

- Offload read traffic from the primary DB

- Improve performance for read-heavy applications

- Can be promoted to a standalone DB in case of failure

- Useful for analytics, reporting, and backup operations

🧠 How It Works

- Data is replicated asynchronously, so there's a small replication lag.

- Uses the database engine's native replication features (e.g., MySQL binlog, PostgreSQL streaming replication).

- You can create up to 5 read replicas per source DB (more with Aurora).

- Read replicas can be in the same region or different AWS regions (Cross-Region Replication).

## 📦 1. Automated Backups (Managed by AWS)

✅ What Are They?
Automated backups are daily backups of your RDS instance managed by AWS.

They include:

Database snapshots

Transaction logs

Allow point-in-time recovery within a retention window (up to the second).

🔄 How It Works:
Backups are created once a day during a backup window.

Transaction logs are backed up every 5 minutes.

You can restore to any point in time within your retention window.

## Manual Snapshots (User-Initiated)

✅ What Are They?
Manual snapshots are user-created backups of the RDS instance at a specific point in time.

They do not expire until you manually delete them.

✍️ How to Create:
Console: Select DB → Actions → "Take snapshot"

CLI:

###

aws rds create-db-snapshot \
 --db-instance-identifier my-db \
 --db-snapshot-identifier my-snapshot

###

🔄 How to Restore:
You can restore a snapshot to create a new DB instance.

This restored DB is independent of the original.

### ✅ PART 3: RDS Proxy

🔄 What is RDS Proxy?
RDS Proxy is a fully managed database proxy service that sits between your application and your RDS/Aurora database.

🚀 Why Use It?
Connection pooling: Reuses DB connections to handle high traffic efficiently

Improved scalability: Prevents DB from being overwhelmed by connections

Better failover: Minimizes application downtime during DB failovers

IAM authentication support

🛠️ How It Works
Without Proxy:

Each Lambda or app container creates a new DB connection (overload risk)

With Proxy:

RDS Proxy maintains a pool of DB connections and serves client requests via those

🔧 How to Set It Up
Go to RDS Console → Proxies → Create Proxy

Choose DB engine (Aurora/MySQL/PostgreSQL)

Attach IAM role and VPC

Define idle timeout, secrets, and connection pool settings

Example Lambda Integration:

Lambda → RDS Proxy → RDS → Responds back

# 🚀 What is Amazon Aurora?

Amazon Aurora is a fully managed relational database from AWS that is compatible with MySQL and PostgreSQL, but much faster and more scalable than standard MySQL/PostgreSQL databases.

📌 Think of Aurora as a supercharged version of MySQL/PostgreSQL — built for cloud-scale performance, availability, and resilience.

## 🧠 Key Features of Amazon Aurora

Feature Description
✅ High Performance Up to 5x faster than MySQL and 3x faster than PostgreSQL
✅ MySQL/PostgreSQL Compatible Drop-in replacement for existing MySQL/PostgreSQL apps
✅ High Availability (HA) Built-in replication, auto failover, and Multi-AZ support
✅ Auto-Scaling Storage Automatically scales from 10 GB to 128 TB
✅ Fast Backups & Restore Continuous backups to S3 and point-in-time recovery
✅ Fault-Tolerant 6-way data replication across 3 AZs (Availability Zones)
✅ Aurora Serverless Auto-start, auto-stop, and scale DB capacity based on app demand
✅ Aurora Global Database Cross-region replication for global apps
✅ RDS Proxy Integration Seamless integration for managing DB connections

🏗️ Architecture of Aurora
Aurora separates compute from storage:

Compute: EC2 instances running MySQL/PostgreSQL-compatible engines

Storage: Distributed, SSD-backed virtual volume that auto-scales

Data is replicated 6 times across 3 Availability Zones

Crash recovery and failover are fast because only the compute layer is restarted — not the whole DB

### Aurora serverless

| Feature            | Aurora Serverless v2 Highlights                    |
| ------------------ | -------------------------------------------------- |
| Auto-scaling       | 0.5–128 ACUs in seconds                            |
| Fully managed      | No need to manage servers or capacity              |
| Cost-efficient     | Pay only for what you use                          |
| Highly available   | Multi-AZ, failover support                         |
| Developer-friendly | Ideal for startups, dev/test, and bursty workloads |

### GLOBAL DB

| Term                    | Description                                                                              |
| ----------------------- | ---------------------------------------------------------------------------------------- |
| **Primary Region**      | Region where the database is writable (read/write operations)                            |
| **Secondary Region(s)** | Region(s) with **read-only replicas** of the DB                                          |
| **Replication**         | Aurora Global Database replicates changes from primary to secondary within **<1 second** |
| **Failover**            | You can promote a secondary region to become the new primary (manual)                    |

# 🧠 What is Amazon SQS?

Amazon SQS is a fully managed message queuing service that allows decoupling of components in a distributed application. It enables different parts of an application (or different services) to communicate reliably via messages, without requiring each part to be always available.

There are two types of queues in SQS:

Standard Queue – High throughput, best-effort ordering, at-least-once delivery.

FIFO Queue (First-In-First-Out) – Preserves exact order, exactly-once processing, but with lower throughput.

🧱 Basic Terminology
Message: A unit of data sent through the queue (e.g., JSON, XML, text).

Queue: The storage area that temporarily holds messages.

Producer (Sender): Component that sends messages to the queue.

Consumer (Receiver): Component that retrieves and processes messages.

Visibility Timeout: A period when a message is invisible to other consumers after being picked up by one (to avoid double-processing).

🧑‍💻 Real-World Example: E-commerce Order Processing
Let’s say you have an online store. When a customer places an order:

The Order Service (Producer) sends an order message to an SQS queue.

The Inventory Service, Payment Service, and Shipping Service (Consumers) each process the message asynchronously.

This way, if any service goes down, messages are not lost – they wait in the queue.

🧾 Example flow:

Producer: Order microservice

Queue: OrdersQueue

Consumers:

Inventory microservice checks and reserves stock.

Payment microservice processes payment.

Shipping microservice arranges delivery.

⚙️ How Visibility Timeout Works
Imagine two consumers try to process the same message. SQS uses a Visibility Timeout to hide the message temporarily after one consumer picks it up.

Example:

Visibility Timeout is 30 seconds.

Consumer A picks up a message at 12:00:00.

Until 12:00:30, SQS hides it from other consumers.

If Consumer A fails to delete the message before timeout, it becomes visible again and another consumer (say B) can pick it up.

✅ This ensures:

No duplicate processing during normal operation.

Recovery from consumer failure.

💡 Common Use Cases
Order Processing Pipelines (eCommerce, Food Delivery)

Background Jobs (Video encoding, thumbnail generation)

Log Processing Systems

Email or Notification Dispatchers

Microservices Communication

# Industry Practice.

✅ **Great, very practical question! Let’s break it down clearly so you understand what’s normally done in industry — and what might make sense for _your_ situation.**

---

## 💡 **Your current setup**

- You have an EC2 instance (a single virtual machine).
- You installed Docker on that EC2.
- You built and ran your app in a Docker container (e.g., `docker build`, `docker run`).
- The app is running and accessible (or you're working towards that).

---

## 🤔 **What’s next? Should you deploy to ECS or Kubernetes?**

👉 **Short answer:**
You don’t _have_ to move to ECS or Kubernetes right now, but in **real-world production setups**, companies typically **do not rely on one EC2 + manual Docker commands**.
They move to ECS, EKS (Kubernetes on AWS), or similar platforms to:
✅ Manage scaling
✅ Handle container orchestration
✅ Automate deployment & updates
✅ Improve reliability
✅ Simplify network & security configs

---

## 💼 **What does the industry do?**

| Scenario                                   | What companies usually do                                                                      |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------- |
| **Small-scale / dev / POC**                | EC2 + Docker is fine temporarily — fast to start                                               |
| **Production / scalable / robust systems** | Move to container orchestration like **ECS** (native AWS) or **EKS (Kubernetes)**              |
| **Serverless trend**                       | Some companies skip managing EC2 and use **Fargate** (ECS or EKS without managing servers)\*\* |

---

## 🚀 **What is the correct next step?**

Here’s how professionals approach it:

### 🟣 If your app is small, experimental, or internal:

➡ **Keep running on EC2 + Docker**
➡ Add things like:

- `docker-compose` (if multi-container)
- a systemd service / cronjob to restart if down
- snapshot backups, AMI images, etc.

---

### 🟣 If your app needs to:

✅ scale
✅ survive instance failures
✅ auto-update easily
✅ have better load balancing
✅ integrate cleanly with CI/CD

➡ **Move to ECS, EKS, or Fargate**

💬 _In AWS ecosystem, ECS with Fargate is often the easiest next step._

---

## ⚡ **ECS vs Kubernetes (EKS) — what’s chosen in industry?**

| ECS                                            | EKS (Kubernetes)                                       |
| ---------------------------------------------- | ------------------------------------------------------ |
| Fully AWS-managed, no need to learn Kubernetes | Open standard, portable across cloud vendors           |
| Easier learning curve if you know AWS          | Steeper learning curve (but very powerful)             |
| Great for most AWS-only shops                  | Preferred in multi-cloud or Kubernetes-first companies |
| Faster to get started                          | More flexible for complex needs                        |

✅ **In many AWS-heavy companies, ECS is the first step.**

---

## 🌟 **Suggested next steps for you**

👉 If you’re doing this as learning / for a small app:
✅ Stick with EC2 + Docker for now
✅ Focus on making the app robust (handle restarts, data persistence, security groups)

👉 If you want to follow _best practice for production_:
✅ Try setting up ECS (with or without Fargate)
✅ Or, if you’re ready to learn K8s: Try EKS
✅ Integrate CI/CD (CodePipeline / CodeBuild / GitHub Actions)

---

## 💬 **Summary**

📝 The **correct next step in industry** → use ECS / EKS / Fargate rather than a single EC2 running Docker manually.

But **for small apps or personal projects** → EC2 + Docker is fine _temporarily_.

---

👉 **If you want, I can guide you:**

- How to move your app to ECS step-by-step
- How to create a production-grade Docker + EC2 setup
- How to decide between ECS, EKS, or Fargate with a decision tree

Let me know what direction you'd like! 🚀

💯 **Excellent question! Let’s break it down so you see the _real-world, professional flow_ for containerized app deployment — from scratch to production.**

---

## 🚀 **Step-by-step process followed in industry (for Docker-based apps)**

---

### ⚡ **1️⃣ App development**

✅ Developer writes code (Node.js, Java, Python, etc.)
✅ Code is version-controlled in **Git** (GitHub, GitLab, Bitbucket)

✅ A **Dockerfile** is written to define how the app runs
✅ Example:

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 7000
CMD ["node", "app.js"]
```

✅ **Test locally** using:

```bash
docker build -t my-app .
docker run -d -p 8080:7000 my-app
```

---

### ⚡ **2️⃣ Container image build + store**

✅ Once the image works locally, industry practice:

- **Push to container registry**
- Example: Amazon ECR / Docker Hub / GitLab registry / private registry

➡ Steps:

```bash
# Tag image
docker tag my-app:latest 1234567890.dkr.ecr.ap-south-1.amazonaws.com/my-app:latest

# Login to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 1234567890.dkr.ecr.ap-south-1.amazonaws.com

# Push image
docker push 1234567890.dkr.ecr.ap-south-1.amazonaws.com/my-app:latest
```

✅ _CI/CD pipelines (CodeBuild, Jenkins, GitHub Actions) usually handle this automatically._

---

### ⚡ **3️⃣ Choose orchestration**

✅ Now decide **where to run the containers**

- **ECS (with EC2 or Fargate)** → easy AWS-native orchestration
- **EKS (Kubernetes)** → portable, complex use cases
- **Fargate** → no servers to manage (purely serverless container hosting)

✅ Industry usually picks **ECS + Fargate for AWS-only small/medium projects**, or **EKS for large, multi-cloud, or K8s-standard orgs**

---

### ⚡ **4️⃣ Infrastructure as Code**

✅ Infra is provisioned using **Terraform / CloudFormation / CDK**

- VPC (with public/private subnets)
- ALB (Application Load Balancer)
- ECS cluster / EKS cluster
- Security groups (open only needed ports like 80/443)

✅ Example: Use Terraform to define ECS service, task definition, ALB

---

### ⚡ **5️⃣ CI/CD pipeline**

✅ Code + container image updates trigger **build pipelines**
✅ Pipelines do:

- Test the code
- Build Docker image
- Push image to ECR
- Update ECS/EKS service to use the new image

✅ Tools: CodePipeline + CodeBuild, GitHub Actions, GitLab CI, Jenkins

---

### ⚡ **6️⃣ DNS + Load Balancer**

✅ Set up Route 53 DNS → point domain to ALB
✅ ALB forwards to ECS/EKS service

✅ Certificates (ACM) added for HTTPS

---

### ⚡ **7️⃣ Monitoring + scaling**

✅ Add **CloudWatch** for logs & metrics
✅ Set auto-scaling policies (CPU %, request count, etc.)
✅ Set alarms (PagerDuty / email / Slack)

---

### ⚡ **8️⃣ Data persistence (if needed)**

✅ For database containers:

- Use **EFS / EBS / RDS / DynamoDB** → don’t keep critical data inside containers
  ✅ For file uploads: S3 buckets

---

## 🌟 **Summary: The full flow**

```
[ Git repo ] → [ CI/CD build + test ] → [ Build docker image ] →
[ Push to ECR ] → [ Deploy to ECS/EKS via IaC ] →
[ ALB + Route 53 + HTTPS ] → [ CloudWatch + auto-scaling ]
```

---

## 💡 **Real-world best practices**

✅ **Never run production containers directly on EC2 by hand** → always use orchestration
✅ **Always version control infra (Terraform / CDK)**
✅ **Automate builds + deployments (CI/CD)**
✅ **Separate data storage from containers**
✅ **Secure network (security groups, VPC, no open ports unnecessarily)**

---

## 💬 **I can help you**

👉 Create a sample **Terraform setup** for ECS
👉 Create a **CodePipeline template** for this flow
👉 Show **real ECS Task Definitions + ALB configs**

⚡ **Tell me if you want AWS ECS, EKS, or Fargate full example!**

Would you like a step-by-step for _one specific path_ (e.g. ECS with Fargate)? 🚀

## Things Required and reason why they are required

Excellent questions! Let’s break this down **clearly and simply** so you understand what ECS, a cluster, and a task definition are — **and why you need them.**

---

## 🤔 **What is ECS?**

👉 **Amazon ECS (Elastic Container Service)** is a _managed container orchestration service_.

✅ It lets you **run Docker containers** on AWS without managing servers yourself.
✅ It handles **container scheduling, scaling, and health management**.

💡 You could think of it as _AWS's way of managing and running your Docker containers on the cloud_.

---

## 🚀 **Why do we need an ECS Cluster?**

👉 An **ECS Cluster** is a logical _group of resources_ (like EC2 or Fargate instances) where your containers will run.

✅ It’s like a “home” or “pool” where AWS will place and manage your containers.

✅ Even if you're using **Fargate** (serverless containers — no EC2 instances you manage), AWS still needs to logically group the resources = that’s the **cluster**.

✅ Without a cluster, ECS wouldn’t know _where_ to launch or manage your containers.

---

### Example:

💡 If you have:

- 3 microservices (e.g., frontend, backend, database sidecar)
- Each as a separate container

You run them inside the _same cluster_ or multiple clusters, depending on your design.

---

## 📝 **What is an ECS Task Definition?**

👉 A **Task Definition** is like a **blueprint** or **recipe** for running your container.

✅ It describes:

- Which Docker image to use
- How much CPU/memory it needs
- What ports to open
- Environment variables
- Networking mode
- Volumes (if any)

💡 _You can think of it like a Docker `docker-compose.yml`, but in ECS format._

---

### Example task definition (simplified):

```json
{
  "containerDefinitions": [
    {
      "name": "my-app",
      "image": "my-app:latest",
      "cpu": 256,
      "memory": 512,
      "portMappings": [
        {
          "containerPort": 80
        }
      ]
    }
  ]
}
```

👉 This tells ECS: _"Run a container with this image, open port 80, use this much CPU/memory, etc."_

---

## ⚙ **What does ECS do overall?**

✅ **ECS responsibilities:**

- Places your containers onto AWS-managed infrastructure (Fargate or EC2)
- Ensures they run as defined in your task definition
- Monitors health and restarts failed containers
- Handles scaling (up/down) as per your settings
- Lets you connect your containers to load balancers, logging, IAM roles, etc.

---

## 📌 **In short**

| Component           | Purpose                                               |
| ------------------- | ----------------------------------------------------- |
| **ECS**             | Manages and runs Docker containers in AWS             |
| **Cluster**         | Logical group (or pool) where containers are deployed |
| **Task Definition** | Blueprint describing how to run each container        |

---

## ⚡ **Why is this structure important?**

👉 Because AWS needs:

- A place to run containers (**Cluster**)
- A plan for _what_ to run and _how_ (**Task Definition**)
- A way to manage and monitor running containers (**ECS Service**)

---

## 🌟 **Would you like?**

✅ A diagram showing how all these pieces fit together?
✅ A simple working example Terraform setup (cluster + task + service)?

Let me know! 🚀

---

- why they are neede

## 🤔 **What is ECS?**

👉 **Amazon ECS (Elastic Container Service)** is a _managed container orchestration service_.

✅ It lets you **run Docker containers** on AWS without managing servers yourself.
✅ It handles **container scheduling, scaling, and health management**.

💡 You could think of it as _AWS's way of managing and running your Docker containers on the cloud_.

---

## 🚀 **Why do we need an ECS Cluster?**

👉 An **ECS Cluster** is a logical _group of resources_ (like EC2 or Fargate instances) where your containers will run.

✅ It’s like a “home” or “pool” where AWS will place and manage your containers.

✅ Even if you're using **Fargate** (serverless containers — no EC2 instances you manage), AWS still needs to logically group the resources = that’s the **cluster**.

✅ Without a cluster, ECS wouldn’t know _where_ to launch or manage your containers.

---

### Example:

💡 If you have:

- 3 microservices (e.g., frontend, backend, database sidecar)
- Each as a separate container

You run them inside the _same cluster_ or multiple clusters, depending on your design.

---

## 📝 **What is an ECS Task Definition?**

👉 A **Task Definition** is like a **blueprint** or **recipe** for running your container.

✅ It describes:

- Which Docker image to use
- How much CPU/memory it needs
- What ports to open
- Environment variables
- Networking mode
- Volumes (if any)

💡 _You can think of it like a Docker `docker-compose.yml`, but in ECS format._

---

### Example task definition (simplified):

```json
{
  "containerDefinitions": [
    {
      "name": "my-app",
      "image": "my-app:latest",
      "cpu": 256,
      "memory": 512,
      "portMappings": [
        {
          "containerPort": 80
        }
      ]
    }
  ]
}
```

👉 This tells ECS: _"Run a container with this image, open port 80, use this much CPU/memory, etc."_

---

## ⚙ **What does ECS do overall?**

✅ **ECS responsibilities:**

- Places your containers onto AWS-managed infrastructure (Fargate or EC2)
- Ensures they run as defined in your task definition
- Monitors health and restarts failed containers
- Handles scaling (up/down) as per your settings
- Lets you connect your containers to load balancers, logging, IAM roles, etc.

---

## 📌 **In short**

| Component           | Purpose                                               |
| ------------------- | ----------------------------------------------------- |
| **ECS**             | Manages and runs Docker containers in AWS             |
| **Cluster**         | Logical group (or pool) where containers are deployed |
| **Task Definition** | Blueprint describing how to run each container        |

---

## ⚡ **Why is this structure important?**

👉 Because AWS needs:

- A place to run containers (**Cluster**)
- A plan for _what_ to run and _how_ (**Task Definition**)
- A way to manage and monitor running containers (**ECS Service**)

---

## 🌟 **Would you like?**

✅ A diagram showing how all these pieces fit together?
✅ A simple working example Terraform setup (cluster + task + service)?

Let me know! 🚀

## LINK for ECS and ECR

- `https://faun.pub/what-is-amazon-ecs-and-ecr-how-does-they-work-with-an-example-4acbf9be8415`

## ECS with Fargate + Managed Instances

- here we have ec2 instance as laucnh type but they are managed by aws.
- they are scaled and patched by aws
- but for scaling we need the capacity_provider block
- In the min step cound and max step count are imp which tell us how many instances to add based on spike.
- and along with them the weight and base are imp where base mean how many tasks to run on first go itself ans weight comes in pic when there are multiple capacity provides i.e fargate and ec2 both are used at once.

- In the capacity Provider block we can provide the required instance compatibilites

## Diff b/w FARGATE & ECS MANAGED

Excellent question! Here are the key features and capabilities that ECS Managed Instances provide that Fargate cannot:
🚀 Hardware & Performance Capabilities

1. GPU Support & Specialized Hardware
   ECS Managed Instances:
   Full GPU support with multiple instance families:
   g4dn: NVIDIA T4 GPUs (machine learning inference, graphics)
   g5, g5g: NVIDIA A10G GPUs (high-performance graphics and ML)
   g6, g6e, g6f: Latest generation GPU instances
   p3dn: NVIDIA V100 GPUs (deep learning training, HPC)
   p4d: NVIDIA A100 GPUs (highest performance ML training)
   p5: NVIDIA H100 GPUs (latest generation)
   p6-b200: Next generation with NVIDIA B200 GPUs
   Pre-installed NVIDIA drivers and CUDA toolkit
   Fargate:
   No GPU support - Limited to CPU-only workloads
2. Instance Type Selection & Specialized Compute
   ECS Managed Instances:
   Access to full range of EC2 instance types (100+ instance types)
   Specialized instance families:
   High-performance computing (HPC) instances
   Memory-optimized instances (up to several TB of RAM)
   Storage-optimized instances
   Network-optimized instances
   Burstable performance instances
   Attribute-based selection with 20+ attributes (CPU architecture, network performance, etc.)
   Fargate:
   Limited to predefined configurations
   Maximum limits: 16 vCPUs, 120 GiB memory
   No specialized hardware access
   🔧 Advanced System Capabilities
3. Privileged Containers & Linux Capabilities
   ECS Managed Instances:
   Full privileged container support
   Advanced Linux capabilities:
   CAP_NET_ADMIN (network administration)
   CAP_SYS_ADMIN (system administration)
   CAP_BPF (eBPF programs)
   Docker-in-Docker support
   System-level monitoring tools (eBPF-based solutions)
   Fargate:
   No privileged containers
   Limited Linux capabilities (only CAP_SYS_PTRACE supported)
   Cannot run Docker-in-Docker
   Restricted system access
   💰 Cost Optimization Features
4. Resource Utilization & Multi-tenancy
   ECS Managed Instances:
   Multi-task placement - Multiple tasks share the same instance
   Better resource utilization - Pack more workloads per dollar
   Shared infrastructure components
   Reserved Instance support for predictable workloads
   Spot Instance integration
   Fargate:
   1:1 task-to-infrastructure ratio - Each task gets dedicated resources
   Higher per-task overhead
   Limited cost optimization options
   🏗️ Infrastructure Control
5. Capacity Reservations & Predictable Performance
   ECS Managed Instances:
   EC2 Capacity Reservations support
   Predictable performance with specific instance types
   Consistent hardware across tasks
   Instance storage access
   Fargate:
   No capacity reservations
   Variable performance depending on underlying hardware
   No control over instance placement
6. Advanced Networking & Storage
   ECS Managed Instances:
   Enhanced networking features
   Instance storage access (NVMe SSD, etc.)
   Custom network configurations
   Advanced storage options
   Fargate:
   Limited networking options
   No instance storage access
   Standard networking only
   🔍 Monitoring & Observability
7. Advanced Monitoring Capabilities
   ECS Managed Instances:
   System-level monitoring with privileged access
   eBPF-based monitoring solutions
   Custom monitoring agents with system access
   Performance profiling tools
   Fargate:
   Container-level monitoring only
   Limited system visibility
   No privileged monitoring tools
   📊 When to Choose ECS Managed Instances Over Fargate:
   Choose ECS Managed Instances when you need:
   GPU acceleration for ML/AI workloads
   High-performance computing applications
   Specialized hardware requirements
   Privileged containers or system-level access
   Cost optimization through resource sharing
   Predictable performance with capacity reservations
   Advanced monitoring and observability tools
   Docker-in-Docker or container orchestration tools
   Large memory requirements (>120 GiB)
   High CPU requirements (>16 vCPUs)
   Fargate is still better for:
   Simple, stateless applications
   Variable or unpredictable workloads
   Quick prototyping and development
   Minimal operational overhead
   Applications that don't need specialized hardware
   The key insight is that ECS Managed Instances give you the full power of EC2 with the operational simplicity of a managed service, while Fargate prioritizes simplicity and serverless operations at the cost of flexibility and specialized capabilities.
   Sources

## Diff b/w EC2 and FARGATE launch types indepth

Excellent 👏 — this is one of the **most important and misunderstood topics in AWS ECS**, especially when you start moving from basic deployments to real-world production setups.

Let’s break this down in a **real-world, DevOps-focused way**, covering all aspects — **networking, scaling, cost, performance, and operations** — with clear **examples** for each.

---

# 🚀 ECS Launch Types — Fargate vs EC2 (Managed)

ECS can run your containers in **two major modes**:

| Launch Type            | Who Manages the Infrastructure?                           |
| ---------------------- | --------------------------------------------------------- |
| **Fargate (Managed)**  | AWS manages the servers (you just define CPU/memory/task) |
| **EC2 (Self-Managed)** | You manage the EC2 instances that run the containers      |

---

## 🧱 1. INFRASTRUCTURE MANAGEMENT

| Aspect                  | **Fargate (Managed)**                            | **EC2 (Launch Type)**                                                 |
| ----------------------- | ------------------------------------------------ | --------------------------------------------------------------------- |
| Who provisions compute? | AWS — you don’t touch servers                    | You provision EC2 instances (via Auto Scaling Group)                  |
| OS patching             | Done by AWS automatically                        | You must patch & maintain AMIs                                        |
| Scaling                 | You scale tasks, AWS automatically adds capacity | You scale both EC2 instances _and_ tasks manually or via Auto Scaling |
| Control                 | Limited (no SSH, no daemon access)               | Full control (you can SSH into EC2)                                   |

**Example:**

- In **Fargate**, you simply say:
  “Run 5 tasks, each 512 CPU & 1024 MB” — AWS provisions exactly what’s needed.
- In **EC2**, you must ensure your EC2 Auto Scaling Group has enough capacity to host those 5 tasks.

---

## 🌐 2. NETWORK MANAGEMENT

### **Fargate (awsvpc mode required)**

- Each task **gets its own ENI (Elastic Network Interface)** in your VPC.
- That means:
  - Each container has its own private IP address.
  - It behaves like a small EC2 instance inside your subnet.

- You attach **security groups directly to the task**, not the instance.
- Simpler isolation — AWS manages the networking layer.

**Example:**
If you deploy 10 backend containers in a private subnet, AWS will create 10 ENIs — each with a private IP.
These ENIs connect directly to your NAT Gateway for outbound Internet.

---

### **EC2 Launch Type**

- Multiple containers share the same ENI (the EC2 instance’s network interface).
- Containers communicate through Docker bridge networking.
- Security groups apply to the EC2 instance, not directly to each container.
- More flexibility but more complexity.

**Example:**
If your EC2 has IP `10.0.1.12`, and you run 5 containers, all of them share that same IP — only different internal ports.

---

✅ **Network Summary**

| Feature                          | **Fargate**   | **EC2**                          |
| -------------------------------- | ------------- | -------------------------------- |
| Network Mode                     | `awsvpc` only | `bridge`, `host`, `awsvpc`       |
| ENI per Task                     | Yes           | No (shared per EC2)              |
| Security Group                   | Task-level    | Instance-level                   |
| IP per Task                      | Unique        | Shared                           |
| Internet Access (Private Subnet) | NAT Gateway   | NAT Gateway via instance routing |

---

## ⚙️ 3. DEPLOYMENT & OPERATIONS

| Feature          | **Fargate**                            | **EC2**                               |
| ---------------- | -------------------------------------- | ------------------------------------- |
| Start time       | Slower (needs to provision task infra) | Faster (instances already running)    |
| Access logs      | Through CloudWatch only                | You can SSH, view Docker logs locally |
| Custom agents    | Not possible                           | Possible (you control the host)       |
| Spot instances   | Not supported                          | Fully supported                       |
| Daemon processes | Not supported                          | Supported using “Daemon” scheduling   |

**Example:**

- In Fargate: You **can’t run Datadog agents** or **sidecar logging daemons** easily — you rely on ECS logging drivers.
- In EC2: You can install extra agents, tweak Docker settings, etc.

---

## 💰 4. COST MODEL

| Factor         | **Fargate**                       | **EC2**                                |
| -------------- | --------------------------------- | -------------------------------------- |
| Billing        | Pay per vCPU-second & GB-second   | Pay for entire EC2 instance uptime     |
| Idle cost      | None — no running tasks → no cost | You pay even if containers are idle    |
| Discounts      | Savings Plan, Spot not available  | EC2 Spot, Reserved Instances supported |
| Predictability | Simple (pay per task)             | Complex (instance mix, scaling needed) |

**Example:**

- 10 tasks running 24x7 → cheaper in EC2.
- Bursty workloads (e.g. jobs triggered on demand) → cheaper in Fargate.

---

## 🔒 5. SECURITY & ISOLATION

| Aspect            | **Fargate**                 | **EC2**                               |
| ----------------- | --------------------------- | ------------------------------------- |
| Host isolation    | AWS fully isolates          | You share kernel between containers   |
| Security boundary | Per task                    | Per instance                          |
| SSH               | Not allowed                 | Allowed                               |
| File access       | Task ephemeral storage only | Full control over host EBS/EFS mounts |

**Example:**
Fargate tasks are sandboxed by AWS Firecracker microVMs — you can’t escape the container boundary.
EC2 tasks share the host kernel — you must harden your AMI.

---

## 📈 6. SCALING BEHAVIOR

| Scaling              | **Fargate**                       | **EC2**                             |
| -------------------- | --------------------------------- | ----------------------------------- |
| Horizontal           | Increase task count easily        | Must ensure enough EC2 capacity     |
| Vertical             | Change task CPU/memory definition | Resize EC2 instances manually       |
| Auto Scaling trigger | CloudWatch metrics                | CloudWatch + EC2 Auto Scaling Group |

**Example:**
If traffic spikes:

- Fargate → Just increase `desired_count = 10` → AWS handles capacity.
- EC2 → ECS may fail to place tasks if EC2 instances are full — you must scale your ASG.

---

## ☁️ 7. INTEGRATION WITH NETWORKING COMPONENTS

| Resource           | **Fargate**                                       | **EC2**                          |
| ------------------ | ------------------------------------------------- | -------------------------------- |
| ALB / NLB          | Works natively (via awsvpc)                       | Works, but needs port mapping    |
| VPC Private Subnet | Supported                                         | Supported                        |
| NAT Gateway        | Required for private tasks needing Internet       | Same (for private instances)     |
| EFS Mounts         | Supported (via volume definitions)                | Supported                        |
| ENI Limits         | Each task consumes one ENI → subnet limit matters | Shared ENI, less ENI consumption |

**Example:**
If your private subnet allows 200 ENIs, and you run 200 Fargate tasks — you’ll hit the subnet ENI limit.
In EC2 mode, hundreds of containers share one ENI per instance.

---

## 🧩 8. WHEN TO USE WHICH (Real-World Scenarios)

| Use Case                                         | Recommended Launch Type | Reason                              |
| ------------------------------------------------ | ----------------------- | ----------------------------------- |
| Simple API backend (like your employee app)      | **Fargate**             | Easy management, no EC2 to maintain |
| Predictable, long-running workloads              | **EC2**                 | Cheaper at scale                    |
| Batch processing / event-driven                  | **Fargate**             | Pay only per job                    |
| Complex networking (e.g. service mesh, sidecars) | **EC2**                 | Full control                        |
| Security-sensitive apps                          | **Fargate**             | Stronger isolation                  |
| Heavy network throughput or GPU workloads        | **EC2**                 | Hardware control & optimization     |

---

## 🧠 Example Diagram Summary

```
FARGATE (Managed)
-----------------
[Task-1] → ENI → Private Subnet → NAT Gateway → Internet
[Task-2] → ENI → Private Subnet → NAT Gateway → Internet

EC2 (Self-Managed)
-----------------
[EC2 Instance ENI] → Private Subnet → NAT Gateway → Internet
 ├── [Container-1 :3000]
 ├── [Container-2 :3001]
 └── [Container-3 :3002]
```

---

## 🏁 TL;DR Summary

| Category       | Fargate        | EC2                        |
| -------------- | -------------- | -------------------------- |
| Infrastructure | Fully managed  | You manage EC2             |
| Network Mode   | `awsvpc` only  | Multiple modes             |
| Scaling        | Simpler        | More manual                |
| Cost           | Pay-per-task   | Pay-per-instance           |
| Control        | Low            | High                       |
| Isolation      | Strong         | Moderate                   |
| Speed          | Slower startup | Faster once EC2s are ready |

---

Would you like me to show a **Terraform comparison** between:

- One ECS Service on **Fargate**
- The same service running on **EC2**

so you can visually see the infrastructure difference (VPC, task definition, ALB, networking)?

- SSL (Secure Sockets Layer) and its successor TLS (Transport Layer Security) are cryptographic protocols that secure communication over a network — especially the Internet.

🔧 Purpose:
Encrypt data (so no one can eavesdrop)

Authenticate the server (you’re talking to the real site, not a fake one)

Preserve integrity (data isn’t modified in transit)

- When your browser connects to a website (https://example.com):

The server sends its public key inside a digital certificate (SSL cert)

Your browser uses the public key to encrypt a random "session key"

Only the server with the private key can decrypt that session key

Now both browser and server use the same session key for fast symmetric encryption

- | Action                                 | Performed With                  |
  | -------------------------------------- | ------------------------------- |
  | Encrypt session key (browser → server) | **Public key**                  |
  | Decrypt session key (server)           | **Private key**                 |
  | Prove identity of server               | Private key (used to sign cert) |
  | Verify certificate (browser)           | Public key (of CA)              |

# How Browser Verifies

Step 2: Browser Validates Certificate
✅ 1. Is the certificate signed by a trusted Certificate Authority (CA)?
The browser checks the digital signature on the certificate.

It verifies that the certificate is signed by a CA whose public key is already stored in the browser’s Trusted Root CA store.

Think of it like checking if a passport was issued by a real government.

✅ 2. Is the certificate expired?
The browser checks Not Before and Not After dates.

If today’s date is outside that range → ❌ rejected

✅ 3. Does the domain match?
The browser checks if the domain name in the certificate matches the domain being visited.

✅ 4. Is the certificate revoked?
Some browsers or systems also check OCSP (Online Certificate Status Protocol) or CRLs (Certificate Revocation Lists).

✅ 2. Types of SSL Certificates
Let’s break this into validation level, coverage, and usage type:

| Type   | Who Issues It          | What Is Verified            | Use Case                        |
| ------ | ---------------------- | --------------------------- | ------------------------------- |
| **DV** | Let's Encrypt, ZeroSSL | Only domain ownership       | Blogs, test apps, small sites   |
| **OV** | DigiCert, GoDaddy      | Domain + Org existence      | Small business websites         |
| **EV** | DigiCert, Sectigo      | Domain + Org + Legal entity | Banking, healthcare, government |

B. Based on Coverage

| Type                   | Example                                         | Description                         |
| ---------------------- | ----------------------------------------------- | ----------------------------------- |
| **Single Domain**      | `example.com`                                   | Secures one domain                  |
| **Wildcard**           | `*.example.com`                                 | Secures all subdomains of a domain  |
| **Multi-Domain / SAN** | `example.com`, `api.example.com`, `example.org` | Covers multiple domains in one cert |

🔎 C. Based on Issuer

| Type            | Description                                       |
| --------------- | ------------------------------------------------- |
| **Self-Signed** | You generate and sign it yourself (local testing) |
| **CA-Signed**   | Issued and signed by a public CA (trusted)        |

⚖️ Quick Comparison Table:

| Cert Type   | Verified Info        | Cost        | Trusted by Browsers | Use Case                   |
| ----------- | -------------------- | ----------- | ------------------- | -------------------------- |
| DV          | Domain               | Free or Low | ✅ Yes              | Blogs, dev sites           |
| OV          | Domain + Org         | Medium      | ✅ Yes              | Business sites             |
| EV          | Domain + Org + Legal | High        | ✅ Yes              | Financial, medical, secure |
| Self-Signed | Nothing              | Free        | ❌ No               | Internal testing/dev only  |

## Create a SSL certificate

- Launch an Instance
- Install nginx/apache
- Install openssl
- Create the ssl certificate
- Modify the nginx config file
- make sure that these sertificates are in nginx's `/etc/nginx/ssl/` folder

## What is cipher suite

- When the browser and server have to communicate they first decide the Authentication, type of Encryption and Hashing and then Key Exchange. All the set of versiond or types is called cipher suite

## Server certificate

- It's the actual certificate issued for your website or API.

- Contains your domain name, public key, expiration, etc.

- Installed on your server/load balancer to enable HTTPS.

## Certificate Chain

### SSL/TLS Certificate Chain: Practical Lab

- STAGE 1: Setup Folder Structure

```t
mkdir -p ~/certs/{root,intermediate,server}
cd ~/certs
```

- STAGE 2: Create Your Own Root Certificate Authority

- Step 1: Generate Private Key

```t
openssl genrsa -out root/rootCA.key 4096

```

- Step 2: Generate Root Certificate (self-signed)

```t
openssl req -x509 -new -nodes -key root/rootCA.key -sha256 -days 1024 -out root/rootCA.pem

```

- STAGE 3: Create Intermediate CA

- Step 1: Generate Intermediate Private Key

```t
openssl genrsa -out intermediate/intermediateCA.key 4096

```

- Step 2: Create CSR for Intermediate

```t
openssl req -new -key intermediate/intermediateCA.key -out intermediate/intermediateCA.csr

```

- Step 3: Sign Intermediate CSR with Root CA

```t
openssl x509 -req -in intermediate/intermediateCA.csr \
  -CA root/rootCA.pem -CAkey root/rootCA.key -CAcreateserial \
  -out intermediate/intermediateCA.pem -days 500 -sha256

```

- STAGE 4: Create Server Certificate Signed by Intermediate CA

- Step 1: Generate Server Private Key

```t
openssl genrsa -out server/server.key 2048

```

- Step 2: Create Server CSR

```t
openssl req -new -key server/server.key -out server/server.csr

```

- Step 3: Sign Server CSR with Intermediate CA

```t
openssl x509 -req -in server/server.csr \
  -CA intermediate/intermediateCA.pem -CAkey intermediate/intermediateCA.key -CAcreateserial \
  -out server/server.crt -days 365 -sha256

```

- STAGE 5: Create Full Chain

- Create server/fullchain.pem file by combining:

```t
cat server/server.crt intermediate/intermediateCA.pem > server/fullchain.pem

```

- STAGE 6: Configure NGINX

- Edit default config:

```t
server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate /home/ubuntu/cert/server/fullchain.pem;
    ssl_certificate_key /home/ubuntu/cert/server/server.key;

    location / {
        root /var/www/html;
        index index.html;
    }
}


```

## SNI

- SNI is an extension to the TLS (Transport Layer Security) protocol that allows a client to specify the hostname it's trying to reach at the start of the handshake.

# AWS KINESIS

- AWS Kinesis is a massively scalable, real-time data streaming service.

- It is used to collect, process, and analyze real-time data streams such as:

- Log streams

- Clickstream data

- IoT sensor data

- Application events

- Video streams

- Security events

- Financial transactions

- Think of it as AWS’s version of Apache Kafka, but serverless and fully managed.

## Componentrs of Kinesis

### Kinesis Data Streams (KDS)

Real-time, low-latency streaming service like Kafka.

Use Cases:

Real-time log processing (ECS, EC2, web apps)

Clickstream analysis

Fraud detection systems

Gaming leaderboards

Stock market applications

Features:

Millisecond latency

Order guaranteed within a shard

Retention: 24 hours to 1 year

Consumers: Lambda, KCL apps, Firehose, custom apps

Replayable (you can reprocess data)

### Kinesis Data Firehose (Serverless & No Ops)

Fully managed pipeline that automatically delivers data to:

S3

Redshift

OpenSearch

Splunk

Datadog

New Relic

Use Cases:

Log delivery EC2 → Firehose → S3

App logs → Firehose → OpenSearch (ELK)

Custom events → Firehose → Splunk

Security logs → Firehose → S3 (Data Lake)

Features:

No management

Auto scaling

No shards or consumers

Batching + compression + transformation

Good for streaming → storage targets

### Kinesis Data Analytics

Runs SQL queries on streaming data.

Use Cases:

Detect anomalies in a stream

Real-time dashboards

Detect unusual events

Calculate rolling averages

Transform event streams before putting into S3

### Kinesis Video Streams

Used for streaming live video or camera feeds.

Use Cases:

CCTV monitoring

Live IoT cameras

Medical video streams

Drone video feeds

ML video processing (Rekognition)
