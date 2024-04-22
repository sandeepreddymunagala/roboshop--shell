sudo su -
#set-hostname mongodb
echo -e "\e[33m copy mongodb repo file\e[0m"
cp /root/roboshop--shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

echo -e "\e[33m installing mongodb server\e[0m"
dnf install mongodb-org -y &>> /tmp/roboshop.log

# modify /etc/mongo.conf
echo -e "\e[33m update mongodb listen address\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>> /tmp/roboshop.log

echo -e "\e[33m start mongodb server\e[0m"
systemctl enable mongod &>> /tmp/roboshop.log
systemctl start mongod &>> /tmp/roboshop.log