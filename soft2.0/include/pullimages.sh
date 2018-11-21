function pull_images () {
    if [ $(docker images|grep tomcat|wc -l) != 1 ];then
        echo -e "\033[47;30m ------ ++++ Pull tomcat Image ++++++ ----- \033[0m \n"
        docker pull tomcat
        if [ $(docker images|grep tomcat|wc -l) != 1 ];then
            echo -e "\033[41;37m ------Pull failed ! Please check Internet !! ----- \033[0m \n"
        fi
    fi

    if [ $(docker images|grep nodeimage|wc -l) != 1 ];then
        echo -e "\033[47;30m ------ ++++ Make node_image ..... ++++++ ----- \033[0m \n"
        mkdir -p /udata/docker/node/
        cp $cur_dir/config/nodedockerfile /udata/docker/node/dockerfile
        cd /udata/docker/node
        docker build -t nodeimage .
        if [ $(docker images|grep nodeimage|wc -l) != 1 ];then
            echo -e "\033[41;37m ------Pull failed ! Please check Internet !! ----- \033[0m \n"
        fi
    fi

    if [ $(docker images|grep jdk|wc -l) != 1 ];then
        echo -e "\033[47;30m ------ ++++ Make jdk_images ..... ++++++ ----- \033[0m \n"
        mkdir -p /udata/docker/jdk/
        cp $cur_dir/config/jdkdockerfile /udata/docker/jdk/dockerfile
        cp $cur_dir/soft/jdk-8u171-linux-x64.tar.gz /udata/docker/jdk/
        cd /udata/docker/jdk
        docker build -t jdk .
        if [ $(docker images|grep jdk|wc -l) != 1 ];then
            echo -e "\033[41;37m ------Pull failed ! Please check Internet !! ----- \033[0m \n"
            fi
    fi
}
