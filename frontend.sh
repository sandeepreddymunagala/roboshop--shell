# installing nginx server for web frame
echo -e "\e[33mInstalling nginx server\e[0m"
dnf install nginx -y  &>> /tmp/roboshop.log

echo -e "\e[33m start the container\e[0m"
systemctl start nginx &>> /tmp/roboshop.log

echo -e "\e[33m removing old app content\e[0m"
rm -rf /usr/share/nginx/html/* &>> /tmp/roboshop.log

echo -e "\e[33m extracting roboshop frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> /tmp/roboshop.log
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[33m update frontend configuration\e[0m"
cp /root/roboshop--shell/roboshop--shell/robo.conf /etc/nginx/default.d/roboshop.conf &>> /tmp/roboshop.log

echo -e "\e[33m restart nginx server\e[0m"
systemctl enable nginx &>> /tmp/roboshop.log
systemctl restart nginx