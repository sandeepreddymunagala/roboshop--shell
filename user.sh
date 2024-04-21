echo -e "\e[33mInstalling nginx server\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
useradd roboshop
rm -rf /app
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
cp user.service /etc/systemd/system/user.service
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
cp mongodb.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js