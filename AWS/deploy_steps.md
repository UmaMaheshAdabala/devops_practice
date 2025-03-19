## AWS

- Create a Root user account
- Complete Process and continue to Console
- Search for Ec2
- Goto Ec2 and Click on Launch an Instance
- Give a Name
- Click on Ubuntu
- Create a Key Pair
- Launch Instance
- Once server is upon running
- Click on connect
- Use SSH

## Terminal

- Open Terminal
- Go to the location where the secret Key Pair .pem file is located
- Then use chmod 400 of the pen file to changes the settings
- Then run the ssh-i….. command
- Then enter YES
- Then you are logged in to the Ubuntu Server
- Then install Node by using Node manager
- Be careful about the version. The Version you install must match the version of the node that you are working in your local Machine.
- Now we have to deploy our code. So we have to clone your code from Github
- We use git clone “HTTP Link Here”
- Frontend

  - So you have to be in the frontend path in the terminal till end
  - Then we have to install all the dependencies of our project in the server. We use nam install for that
  - Then we will build out project in the server by using “npm run build”
  - To host and run the frontend we use Nginx
  - We have to update our server by “sudo apt update”
  - We have to install it by using “sudo apt install nginx”
  - Then we have to start our nginx. For that we use “sudo systemctl start nginx”
  - “Sudo systemctl enable nginx” to Enable nginx
  - Copy code from dist(build files) to var/www/html/(nginx folder)
  - Here are steps to do so
  - cd “frontend path” if u r not in this path then do so.
  - "sudo scp -r dist/\* /var/www/html/"
  - Then we have to enable port :80 to run our instance.
  - For that we go to AWS security and then we can edit the rules and add another rule with port 80

- Backend

  - To make you backend running 24/7 we use a package called pm2
  - we install pm2 using “npm install pm2 -g”
  - Now we can start our backend using this pm2
  - pm2 start npm — start
  - To check logs or status of the application we use "pm2 logs"
  - To clear logs we "pm2 flush npm"
  - We have to map the backend localhost 7777 port to /api
  - For that we have to use nginx for mapping. We have to change the settings
  - Run the command sudo nano /etc/nginx/sites-availabe/default
  - Edit server name as your domain name or public port number of the instance
  - then paste the custom code for mapping
  - Restart nginx by "sudo systemctl restart nginx"
