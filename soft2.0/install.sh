#!/bin/bash

# -v /etc/localtime:/etc/localtime
#
cur_dir=$(pwd)
echo y|cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install!"
    exit 1
fi

. include/active.sh
. include/activemq.sh
. include/checkdocker.sh
. include/h5.sh
. include/localjdk.sh
. include/mzbiz.sh
. include/mzchannel.sh
. include/mzfinance.sh
. include/mzjar.sh
. include/mzlog.sh
. include/mzpush.sh
. include/mztask.sh
. include/mztopic.sh
. include/redis.sh
. include/www.sh
. include/pullimages.sh
echo "+------------------------------------------------------------------------+"
echo "|                        Shell, Written by WJL                           |"
echo "+------------------------------------------------------------------------+"
echo "|                 Install Docker、Jdk、Redis、Activemq                   |"
echo "+------------------------------------------------------------------------+"
echo "|                Pro:h5,mzbiz,mzjar,mzlog,mzfinance,www,                 |"
echo "|                    mzchannel,mzpush,mztask,active,mztopic              |"
echo "+------------------------------------------------------------------------+"

echo -n "Please entery 'y' to confirm:"
read confirm
if [ $confirm = "y" ];then

    function Set_projects()
    {

        if [ $(rpm -qa|grep unzip|wc -l)!="1" ];then
            yum install -y unzip
        fi
        mkdir -p /www/servers/mzjar
        mkdir -p /www/servers/mztopic
        mkdir -p /www/servers/mzlog
        cp -R $cur_dir/projects/*  /www/servers/
        cd /www/servers/
        ls *.zip | xargs -n1 unzip -o -P infected
        ls *.tar.gz|xargs -n1 tar zxvf
        ls *.tar|xargs -n1 tar xvf
        mv mzsas mzchannel
        mv mz.jar mzjar/
        mv mz-topic.jar mztopic/
        mv mz-log.jar mzlog/
        rm -rf *.zip
        rm -rf *.gz
        rm -rf *.tar
        chmod -R 755 /www
        mkdir -p /udata/docker/node
    }
    status=$(rpm -qa|grep docker |wc -l)
    if [ $status -ne 0 ];then
        echo -e "\033[47;30m Docker have been already installd!!\033[0m \n"
    else
        Check_Install_docker
    fi
#    r=$(ps -ef|grep docker|grep -v grep|wc -l)
    if [ $(ps -ef|grep docker|grep -v grep|wc -l) != 0 ]; then
        echo -e "\033[47;30m Docker start sucessed!!\033[0m \n"
    else
        echo -e "\033[41;37m ------Docker start  failed ! Please check !! ----- \033[0m \n"
        exit 1
    fi
    sleep 2
    if [ -d "/usr/java/jdk1.8.0_171" ];then
        echo -e "\033[47;30m JDK have been install sucessed!!\033[0m \n"
    else
        Install_jdk
        echo -e "\033[47;30m JDK  install sucessed!!\033[0m \n"
    fi
    sleep 1
    if [ $(ps -ef|grep redis|grep -v grep|wc -l) != 0 ];then
        echo  -e "\033[47;30m Redis  install sucessed!!\033[0m \n"
    else
        Install_Redis
    fi
    sleep 1
    if [ $(ps -ef|grep activemq|grep -v grep|wc -l) = 1 ];then
        echo -e "\033[47;30m ------ActiveMQ install successed!! ----\033[0m \n"
    else
        Install_ActiveMQ
        if [ $(ps -ef|grep activemq|grep -v grep|wc -l) != 1 ];then
            echo -e "\033[41;37m ------ActiveMQ  install failed ! Please check !! ----- \033[0m \n"
        fi
    fi
#
    if [ -e "/www/servers/" ];then
        echo -e "\033[41;37m ------File have existed !!Are you want to overwrite ?  'y' OR 'n' ----- \033[0m \n"
        read result
        if [ $result = "y" ];then
            dd=$(date "+%Y-%m-%d")
            mv /www /www-$dd-bak
            Set_projects
        fi
    else
        Set_projects
    fi
    sleep 1
    function check_status() {
        if [ $(rpm -qa|grep docker |wc -l) -ne 0 ];then
            if [ $(docker ps -a|grep $2|wc -l) != 1 ]
            then
                $1
                if [ $(docker ps |grep $2|wc -l) = 0 ];then
                    echo -e "\033[41;5m ------$2  start failed !Please check !! ----- \033[0m \n"
                else
                    echo -e "\033[47;30m ------ $2 start success!!  ----- \033[0m \n"
                fi
            else
                if [ $(docker ps |grep $2|wc -l) = 0 ];then
                    echo -e "\033[41;5m ------$2  start failed !Please check !! ----- \033[0m \n"
                else
                    echo -e "\033[47;30m ------ $2 start success!!  ----- \033[0m \n"
                fi
            fi
        fi
    }
    pull_images
    check_status mzjar_docker mzjar
    #check_status  mzlog_docker mzlog
    check_status  mztopic_docker mztopic
    check_status  www_docker www
    check_status  h5_docker h5
    #check_status  active_docker active
    check_status  Mztask_build mztask
    check_status Mzbiz_build mzbiz
    check_status Mzfinance_build mzfinance
    #check_status Mzpush_build mzpush
    check_status Mzchannel_build mzchannel

fi
