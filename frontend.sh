# installing nginx server for web frame
echo -e "\e[33mInstalling nginx server\e[0m"

dnf install nginx -y &>>/tmp/roboshop.log



systemctl start nginx &>>/tmp/roboshop.log

echo -e "\e[33mRemoving old app contente[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[33mextract front end content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log 2>/tmp/error.log
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
# we need to copy config file
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log