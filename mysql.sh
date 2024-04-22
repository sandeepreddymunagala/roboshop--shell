
echo -e "\e[33m disable mysql default version \e[0m"
dnf module disable mysql -y &>> /tmp/roboshop.log

echo -e "\e[33m \e[0m"
cp /root/roboshop--shell/mysql.repo /etc/yum.repos.d/mysql.repo &>> /tmp/roboshop.log

echo -e "\e[33m installing mysql community server \e[0m"
dnf install mysql-community-server -y &>> /tmp/roboshop.log

echo -e "\e[33m start mysqld service \e[0m"
systemctl enable mysqld &>> /tmp/roboshop.log
systemctl start mysqld &>> /tmp/roboshop.log

echo -e "\e[33m setup mysql password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>> /tmp/roboshop.log
#