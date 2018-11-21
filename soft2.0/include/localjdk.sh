function Install_jdk()
{
    mkdir -p /usr/java
    tar zxvf $cur_dir/soft/jdk-8u171-linux-x64.tar.gz -C /usr/java/
    echo "export JAVA_HOME=/usr/java/jdk1.8.0_171
    export JAVA_BIN=/usr/java/jdk1.8.0_171/bin
    export JRE_HOME=/usr/java/jdk1.8.0_171/jre
    export PATH=\$JAVA_HOME/bin:\$PATH:/usr/local/bin:\$JRE_HOME/bin:/usr/local/node/bin
    export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >> /etc/profile
    source /etc/profile
    java -version
}