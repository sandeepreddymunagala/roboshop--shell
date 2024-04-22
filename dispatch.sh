
echo -e "\e[33m install golang \e[0m"
dnf install golang -y &>> /tmp/roboshop.log

echo -e "\e[33m add application user \e[0m"
useradd roboshop &>> /tmp/roboshop.log
rm -rf /app
mkdir /app

echo -e "\e[33m download application content \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>> /tmp/roboshop.log
cd /app

echo -e "\e[33m extract application content  \e[0m"
unzip /tmp/dispatch.zip &>> /tmp/roboshop.log

echo -e "\e[33m install golang dependencies \e[0m"
go mod init dispatch &>> /tmp/roboshop.log
go get &>> /tmp/roboshop.log
go build &>> /tmp/roboshop.log

echo -e "\e[33m install golang dependencies \e[0m"
cp /root/roboshop--shell/dispatch.service /etc/systemd/system/dispatch.service &>> /tmp/roboshop.log
echo -e "\e[33m start dispatch service \e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable dispatch &>> /tmp/roboshop.log
systemctl start dispatch &>> /tmp/roboshop.log
