function Install_ActiveMQ()
{
    echo -e "\033[47;30m [+] Installing ActiveMQ...\033[0m \n"
    tar zxvf $cur_dir/soft/apache-activemq-5.15.3-bin.tar.gz -C /usr/local
    cd /usr/local
    mv apache-activemq-5.15.3 activemq
    ln -s /usr/local/activemq/bin/activemq /usr/bin/activemq
    activemq start

}
