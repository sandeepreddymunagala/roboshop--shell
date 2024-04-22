sudo su -
#set-hostname cart
echo -e "\e[33m disabling nodejs repos \e[0m"
dnf module disable nodejs -y &>> /tmp/roboshop.log

echo -e "\e[33m configuring nodejs repos \e[0m"
dnf module enable nodejs:18 -y &>> /tmp/roboshop.log
dnf install nodejs -y &>> /tmp/roboshop.log

echo -e "\e[33m add application cart \e[0m"
useradd roboshop &>> /tmp/roboshop.log
rm -rf /app
mkdir /app

echo -e "\e[33m downloading application context \e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>> /tmp/roboshop.log
cd /app

echo -e "\e[33m extracting application context \e[0m"
unzip /tmp/cart.zip &>> /tmp/roboshop.log

echo -e "\e[33m install nodejs dependencies \e[0m"
npm install &>> /tmp/roboshop.log

echo -e "\e[33m update systemd service \e[0m"
cp /root/roboshop--shell/cart.service /etc/systemd/system/cart.service &>> /tmp/roboshop.log

echo -e "\e[33m start cart service \e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable cart &>> /tmp/roboshop.log
systemctl start cart &>> /tmp/roboshop.log

