function Mzpush_build()
{
    server_name="mzpush"
    server_port=7600
    echo -e  "\033[47;30m ------ Check Docker Status ----- \033[0m \n"
    docker run -d --name=$server_name -p $server_port:8080 -v /www/servers/$server_name:/www/$server_name -v /etc/localtime:/etc/localtime -v /data/logs/$server_name:/usr/local/tomcat/logs --privileged=true tomcat
    sleep 1
    docker exec $server_name /bin/sh -c "sed -i '/Host>/i\\<Context path=\"\" reloadable=\"false\" docBase=\"/www/$server_name\" />' /usr/local/tomcat/conf/server.xml"
    docker exec $server_name /bin/sh -c "echo "/root/addhosts.sh" >> /root/.bashrc"
    docker cp $cur_dir/config/addhosts.sh $server_name:/root/addhosts.sh
    docker exec $server_name chmod +x /root/addhosts.sh
    docker restart $server_name
    if [ $(docker ps |grep $server_name |wc -l) == 1 ];then
        echo -e  "\033[47;30m ------Docker $server_name install successed!! ----- \033[0m \n"
    else
        echo -e "\033[47;30m ------$server_name install failed !Please check !! ----- \033[0m \n"
        exit 1
    fi
}