
echo -e "\e[33m install python36 \e[0m"
dnf install python36 gcc python3-devel -y &>> /tmp/roboshop.log

echo -e "\e[33m adding application user \e[0m"
useradd roboshop &>> /tmp/roboshop.log
rm -rf /app
mkdir /app

echo -e "\e[33m downloading application context \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>> /tmp/roboshop.log
cd /app

echo -e "\e[33m  extract application context \e[0m"
unzip /tmp/payment.zip &>> /tmp/roboshop.log

echo -e "\e[33m install application dependencies \e[0m"
pip3.6 install -r requirements.txt &>> /tmp/roboshop.log

echo -e "\e[33m update systemd service \e[0m"
cp payment.service /etc/systemd/system/payment.service &>> /tmp/roboshop.log

echo -e "\e[33m start payment service\e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable payment &>> /tmp/roboshop.log
systemctl start payment &>> /tmp/roboshop.log
