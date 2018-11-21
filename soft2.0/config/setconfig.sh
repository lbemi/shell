#!/usr/bin/env bash

confirm='n'
while ([ $confirm != "y" ])
do
    echo "---------------填写配置环境信息--------------------"
    echo -n "+++Redis IP:"
    read redis_ip
    echo "Rdis IP is:$redis_ip"

    echo -n "+++Mysql IP:"
    read mysql_ip
    echo "Mysql IP is:$mysql_ip"

    echo -n "+++ActiveMQ IP:"
    read mq_ip
    echo "ActiveMQ IP is:$mq_ip"
    echo -n "Enter 'y' continue:"
    read confirm
    if [ -z $confirm ]
    then
        confirm="n"
    elif [ $confirm = "y" ]
    then
        for file in mz mz-log mz-topic addhosts npmstart
        do
            echo $file
            echo "echo $redis_ip  redis.imuzhuang.com>>/etc/hosts" > $file.sh
            echo "echo $mq_ip  mq.imuzhuang.com>>/etc/hosts" >> $file.sh
            echo "echo $mysql_ip  mysql.imuzhuang.com>>/etc/hosts" >> $file.sh
            echo "echo 47.95.254.28 rftp.imuzhuang.com>>/etc/hosts
export LANG=en_US.utf8
export TZ='Asia/Shanghai'
echo "" >> /manage/logs/$file.log
nohup java -jar $file.jar --spring.profiles.active=test,yxsmstpl --server.port=8000>>/manage/logs/$file.log&">> $file.sh
        done
        sed -i '7,$d' addhosts.sh
		sed -i '7,$d' npmstart.sh
        echo 'npm start'>> npmstart.sh
    fi
done