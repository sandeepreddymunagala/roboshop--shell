
echo -e "\e[33m install redis repos \e[0m"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> /tmp/roboshop.log

echo -e "\e[33m enable redis 6.2 version\e[0m"
dnf module enable redis:remi-6.2 -y &>> /tmp/roboshop.log

echo -e "\e[33m install redis \e[0m"
dnf install redis -y &>> /tmp/roboshop.log

echo -e "\e[33m update redis listen service \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>> /tmp/roboshop.log
echo -e "\e[33m start redis service \e[0m"
systemctl enable redis &>> /tmp/roboshop.log
systemctl start redis &>> /tmp/roboshop.log