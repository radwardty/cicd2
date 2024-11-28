#!/bin/bash

# [Amazon Linux 시간 설정]
sudo timedatectl set-timezone 'Asia/Seoul'

# [X-Windows GUI Util]
yum install -y xorg-x11-xauth
yum install -y dbus-x11
yum install -y nautilus
yum install -y gnome-system-monitor
yum install -y gedit

# 한글폰트
yum install -y fonts-korean
fc-cache -r
cd /usr/share/fonts/
wget http://cdn.naver.com/naver/NanumFont/fontfiles/NanumFont_TTF_ALL.zip
unzip NanumFont_TTF_ALL.zip -d NanumFont
rm -f NanumFont_TTF_ALL.zip
fc-cache -r

# JDK 11
yum install -y java-11-amazon-corretto.x86_64

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
yum install -y ./google-chrome-stable_current_x86_64.rpm

# Docker
yum install -y docker
systemctl enable docker
systemctl start docker
systemctl status docker
usermod -aG docker ec2-user
curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

# My SQL server
docker container run -d \
    --name=mysqldb \
    --restart=always \
    -e MYSQL_ROOT_PASSWORD=education \
    -e MYSQL_DATABASE=guestbook \
    -p 3306:3306 \
    yu3papa/mysql_hangul:2.0
    
# Alias
echo "alias gnome-system-monitor='gnome-system-monitor > /dev/null 2>&1 &'" >> /home/ec2-user/.bashrc
echo "alias nautilus='nautilus > /dev/null 2>&1 &'" >> /home/ec2-user/.bashrc
echo "alias gedit='gedit > /dev/null 2>&1 &'" >> /home/ec2-user/.bashrc
echo "alias chrome='/usr/bin/google-chrome-stable > /dev/null 2>&1 &'" >> /home/ec2-user/.bashrc