function mzjar_docker()
{
    node_name="mzjar"
    node_port=7000
    docker run -dti --name=$node_name -p $node_port:8000 -v /www/servers/$node_name:/manage -v /data/logs/$node_name:/manage/logs -v /etc/localtime:/etc/localtime --privileged=true jdk /bin/bash
    docker exec $node_name /bin/sh -c "echo "/root/mz.sh" >> /root/.bashrc"
    docker cp $cur_dir/config/mz.sh $node_name:/root/
    docker exec $node_name chmod +x /root/mz.sh
    docker restart $node_name
    if [ $(docker ps |grep $node_name |wc -l)  == 1 ];then

        echo -e "\033[47;30m ------Docker $node_name install successed!! ----\033[0m \n"
    else
        echo -e "\033[41;5m ------$node_name install failed !Please check !! ----- \033[0m \n"
        exit 1
    fi
}
