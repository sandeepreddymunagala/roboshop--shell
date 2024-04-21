# installing nginx server for web frame
echo -e "\e[33mInstalling nginx server\e[0m"
dnf install nginx -y

echo -e "\e[33m start the container\e[0m"
systemctl start nginx

echo -e "\e[33m removing old app content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[33m extracting roboshop frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

cp robo.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[33m restart nginx server\e[0m"
systemctl enable nginx
systemctl restart nginx