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

