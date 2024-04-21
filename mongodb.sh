echo -e "\e[33m copy mongodb repo file\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[33m installing mongodb server\e[0m"
dnf install mongodb-org -y

# modify /etc/mongo.conf
echo -e "\e[33m installing mongodb server\e[0m"
sed -i 's /127.0.0.1/0.0.0.0' etc/mongod.conf

echo -e "\e[33m start mongodb server\e[0m"
systemctl enable mongod
systemctl start mongod