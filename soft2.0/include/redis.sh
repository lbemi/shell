function Install_Redis()
{
    echo  -e "\033[47;30m [+] Installing Redis...\033[0m \n"
    sleep 1
    yum -y install lsb gcc-c++
    tar zxvf $cur_dir/soft/redis-4.0.9.tar.gz -C /usr/local
    cd /usr/local/redis-4.0.9 && make && cd src && make install
    mkdir -p /usr/local/redis/bin
    mkdir -p /usr/local/redis/etc
    mkdir -p /usr/local/redis/log
    touch  /usr/local/redis/log/redis.log
    cd /usr/local/redis-4.0.9/src
    cp redis-server redis-cli /usr/local/redis/bin/
    cp $cur_dir/config/redis.conf /usr/local/redis/etc/
    ln -s /usr/local/redis/bin/redis-server /usr/bin/redis-server
    ln -s /usr/local/redis/bin/redis-cli /usr/bin/redis-cli
    nohup redis-server /usr/local/redis/etc/redis.conf &
}