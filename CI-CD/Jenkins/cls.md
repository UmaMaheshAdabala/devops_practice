## CI/CD

- Continuous Integration/Continuous Delivery
- A Modern approach of automating the proecesses likes testing, building, code scan, Image build, image scan, image push & finally Deployment.

# Steps for CI

- code ---> commited to github ---> (jenkins comes)---> test(Junit), build(maven), report(sonarqube), image build, image push (docker as an AGENT)

## DrawBack of Jenkins

- Basically Jenkins is the one of the best tool used across many industries but the thing is let say we have one master node and 5 worker nodes running for different
  tasks, even no task is running on the worker nodes the nodes has to be upon running these will cause a huge billing and that is not effiecnt way.

## Best approch now a days

- Now a days we are using Kubeneties. In these when there is commit happend then the github action which is common for all across the project will create a worker node to
  perform the task once the task is done then the worker node is deleted.

## Jenkins

- Jenkins works on java, So we need to install java first
- Then install Jenkins
- But Jenkins runs on port 8080. So add 8080 in inbound rules in EC2 Instance Security Groups
- Then Go to the browser and enter IP followed by port to login into jenkins.
- Once done install the recomended packages.
- Here we use docker containers as worker nodes as they are light weight the work more efficiently, and more over if the task got completed they will get removed.

## SETUP CICD For Java Maven Project

- Launch an Instance of t2.large
- Then Install java inthe instance
- Then Install jenkins on the instance
- Then Goto New Items and pipeline project
- Then upload jenkins file that already writen as per your requirements into jenkins portal using GIT as SCM
- Then Goto plugins and download docker pipeline and sonarQube scanner.
- Now Install sonarqube in the ec2 instance
- For thet we have to adduser sonarqube and the install the sonarqube binary.
- Then follow necessary steps like unzip the file change the permissions and then using linux server, then login using port 9000 followed by ipAddress.
- Then the point is how the jenkins interact with sonarqube.
- For that we goto Addministrator settings inside the sonarqube and Generate the token.
- Then goto jenkins and manage jenkins and then to manage credentials.
- Then goto system goto credentials and add the token here.
- Then comeback to ec2 instance and download docker.io inside it and also add users the ubuntu and the jenkins. and restart the docker.
- Now come to jenkins portal and restart the jenkins portal.

- Once the docker is set then CI Part is completed.
- Then we have to download kubernetes and ArgoCD
- First we will install Kubernetes using minikube.
- Then by using operatorshub we install ArgoCd. Because the operatorhub will manage the Argocd life cycle.

- Now we have to integrate docker and jenkins so we go to administartor and then to credentianls and system
  then to add credentials and we add username and password and the id should be the name that you used inside the jenkinsfile that you wrote.
- And add github token also and the id should be same as in jenkins file.
- Restart jenkins
