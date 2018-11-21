#!/usr/bin/env bash

function Check_Install_docker()
{
    echo -e "\033[47;30m ++++++Install docker ......\033[0m \n"
    yum install -y docker
    echo "{ \"registry-mirrors\": [\"https://1h1v6myi.mirror.aliyuncs.com\"] } " >/etc/docker/daemon.json
    systemctl enable docker
    systemctl start docker
}