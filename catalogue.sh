sudo su -
#set-hostname catalogue
echo -e "\e[33m disabling nodejs repos \e[0m"
dnf module disable nodejs -y &>> /tmp/roboshop.log

echo -e "\e[33m configuring nodejs repos \e[0m"
dnf module enable nodejs:18 -y &>> /tmp/roboshop.log
dnf install nodejs -y &>> /tmp/roboshop.log

echo -e "\e[33m add application user \e[0m"
useradd roboshop &>> /tmp/roboshop.log
rm -rf /app
mkdir /app

echo -e "\e[33m downloading application context \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> /tmp/roboshop.log
cd /app

echo -e "\e[33m extracting application context \e[0m"
unzip /tmp/catalogue.zip &>> /tmp/roboshop.log

echo -e "\e[33m install nodejs dependencies \e[0m"
npm install &>> /tmp/roboshop.log

echo -e "\e[33m update systemd service \e[0m"
cp /root/roboshop--shell/catalogue.service /etc/systemd/system/catalogue.service &>> /tmp/roboshop.log

echo -e "\e[33m start catalogue service \e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable catalogue &>> /tmp/roboshop.log
systemctl start catalogue &>> /tmp/roboshop.log

echo -e "\e[33m copy mongodb repo file \e[0m"
cp /root/roboshop--shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

echo -e "\e[33m install mongodb client \e[0m"
dnf install mongodb-org-shell -y &>> /tmp/roboshop.log

echo -e "\e[33m load schema \e[0m"
mongo --host mongodb-dev.sandeepreddymunagala123.xyz </app/schema/catalogue.js