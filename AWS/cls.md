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
    In AWS or any other cloud services we for a region we have different availability zones.
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

Feature

Internet Gateway (IGW)

VPC Endpoints (Gateway Endpoint)

VPC Interface Endpoints

Purpose

Enables public internet access

Enables private access to AWS services without internet

Enables private access to AWS services using ENI (Elastic Network Interface)

Connectivity

Routes traffic between VPC and the internet

Routes traffic to AWS services like S3 & DynamoDB via a private route

Connects AWS services via ENI within the VPC

Public/Private

Public

Private

Private

Components Used

Internet Gateway (IGW)

Gateway Endpoint (Added to Route Table)

Interface Endpoint (Uses ENI)

Use Case

When instances need internet access

When instances need to connect to S3 or DynamoDB privately

When instances need private access to AWS services like SSM, Secrets Manager, or API Gateway

Cost

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

3. VPC Interface Endpoints

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

  - Cross-Account Access: A company 'x' wants to access s3 service of other company 'y'
    - First create a role in Y account by x accound_ID
    - Then create a user in X account
    - Create a Assume_Access Policy with ARN of role in Y
    - Then attach the policy to the user in X.

  3. Web Identity/SAML 2.O Federation

     - The Web Identity/SAML 2.O Federation is a security feature that enables secure access to your AWS resources using temporary credentials obtained through external Identity providers(IdP) ex: google, github etc...

     - They will use OAuth 2.0 and OpenID Connect (OIDC) / SAML 2.O Federation
     - OAuth and OpenID Connect
     - OAuth 2.0 will handle authorization aspect.
     - OpenID Connect will handle Authentication and provides us the token. ex JWt

     - SAML 2.0 (Security and Assertion Markup Language)
     - In SAML it allows the user to authenticate once and gain access to multiplr applications without re-entering credentials.
     - Uses XML rather than JWT.

  4. Custom Trust Policies

  - Basically it is a kind similar to AWS Account in Trust policy
  - But the difference is in AWS Account Trust Policy erevy one can assume the role as it will be mentioned as "root" in the trust policy.
  - so it is not much secure.
  - So to have more security we use custom trust policy.
  - And also we can't directly assign role to user in AWS Account Trust Policy util unless we have explicit permissions. or else we have to update the Trust policy with specific user Name.

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
