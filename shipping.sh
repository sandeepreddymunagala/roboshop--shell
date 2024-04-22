sudo su -
#set-hostname shipping
echo -e "\e[33m install maven \e[0m"
dnf install maven -y &>> /tmp/roboshop.log

echo -e "\e[33m add application user  \e[0m"
useradd roboshop &>> /tmp/roboshop.log
rm -f /app
mkdir /app

echo -e "\e[33m download application content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>> /tmp/roboshop.log
cd /app

echo -e "\e[33m extract application content \e[0m"
unzip /tmp/shipping.zip &>> /tmp/roboshop.log

echo -e "\e[33m download dependies \e[0m"
mvn clean package &>> /tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>> /tmp/roboshop.log

echo -e "\e[33m install mysql client \e[0m"
dnf install mysql -y &>> /tmp/roboshop.log

echo -e "\e[33m load schema \e[0m"
mysql -h mysql-dev.sandeepreddymunagala123.xyz -uroot -pRoboShop@1 < /app/schema/shipping.sql &>> /tmp/roboshop.log

echo -e "\e[33m start shipping service \e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable shipping &>> /tmp/roboshop.log
systemctl start shipping &>> /tmp/roboshop.log