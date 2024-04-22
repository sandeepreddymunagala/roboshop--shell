color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

stat_check() {
  if [ $1 -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
    exit 1
  fi
}

app_presetuo(){
echo -e "${color} add application user ${color}"
useradd roboshop &>> ${log_file}
rm -rf ${app_path}
mkdir ${app_path}

echo -e "${color}downloading application context ${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${log_file}
cd ${app_path}

echo -e "${color}extracting application context ${nocolor}"
unzip /tmp/${component}.zip &>> ${log_file}
}



systemd_setup() {
echo -e "${color}update systemd service ${nocolor}"
cp /home/centos/roboshop--shell/${component}.service /etc/systemd/system/${component}.service &>> ${log_file}

echo -e "${color}start ${component} service ${nocolor}"
systemctl daemon-reload &>> ${log_file}
systemctl enable ${component} &>> ${log_file}
systemctl start ${component} &>> ${log_file}
}

mongodb_schema(){
echo -e "${color}copy mongodb repo file ${nocolor}"
cp /home/centos/roboshop--shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>> ${log_file}

echo -e "${color}install mongodb client ${nocolor}"
dnf install mongodb-org-shell -y &>> ${log_file}

echo -e "${color}load schema ${nocolor}"
mongo --host mongodb-dev.sandeepreddymunagala123.xyz <${app_path}/schema/${component}.js

}

nodejs() {
echo -e "${color}disabling nodejs repos ${nocolor}"
dnf module disable nodejs -y &>> ${log_file}

echo -e "${color}configuring nodejs repos ${nocolor}"
dnf module enable nodejs:18 -y &>> ${log_file}
dnf install nodejs -y &>> ${log_file}

echo -e "${color}install nodejs dependencies ${nocolor}"
npm install &>> ${log_file}
}