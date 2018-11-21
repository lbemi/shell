echo 192.168.7.85  redis.imuzhuang.com>>/etc/hosts
echo 192.168.7.85  mq.imuzhuang.com>>/etc/hosts
echo 192.168.7.96  mysql.imuzhuang.com>>/etc/hosts
echo 47.95.254.28 rftp.imuzhuang.com>>/etc/hosts
export LANG=en_US.utf8
export TZ='Asia/Shanghai'
echo  >> /manage/logs/mz.log
nohup java -jar mz.jar --spring.profiles.active=test,yxsmstpl --server.port=8000>>/manage/logs/mz.log&
