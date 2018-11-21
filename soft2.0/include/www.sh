function www_docker()
{
    node_name="www"
    node_port=7300
    docker run -dti --name=$node_name -p $node_port:8000 -v /data/logs/www:/root/logs/master/proxyapi/ -v /etc/localtime:/etc/localtime -v /www/servers/web:/manage --privileged=true nodeimage /bin/bash
    docker exec $node_name /bin/sh -c "echo "/root/npmstart.sh" >> /root/.bashrc"
    docker cp $cur_dir/config/npmstart.sh $node_name:/root/
    docker exec $node_name chmod +x /root/npmstart.sh
    docker restart $node_name
   # docker exec $node_name npm start
    if [ $(docker ps |grep $node_name |wc -l)  == 1 ];then
        echo -e  "\033[47;30m ------Docker $node_name install successed!! ----- \033[0m \n"
    else
        echo -e "\033[41;5m ------$node_name install failed !Please check !! ----- \033[0m \n"
        exit 1
    fi
}
