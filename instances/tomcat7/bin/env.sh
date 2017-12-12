#!/usr/bin/env bash
# env.sh - start a new shell with instance variables set

DATE=`date +%Y%m%d%H%M%S`

export SERVER_USER=ssong
export SERVER_NAME=tomcat7

## set base env
export SERVER_HOME=../../..
export CATALINA_HOME=$SERVER_HOME/engines/apache-tomcat-7.0.79
export CATALINA_BASE=$SERVER_HOME/instances/${SERVER_NAME}
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SERVER_HOME/commons/native

export JAVA_HOME=$HOME/Apps/java/jdk1.7.0_80
#export PATH=$JAVA_HOME/bin:$PATH 
export LOG_DIR=$CATALINA_BASE/logs

# PORT OFFSET GROUP
export JMX_BIND_ADDR=127.0.0.1
export PORT_OFFSET=0

let HTTP_PORT=8080+$PORT_OFFSET
let HTTPS_PORT=8443+$PORT_OFFSET
let AJP_PORT=8009+$PORT_OFFSET
let SHUTDOWN_PORT=8005+$PORT_OFFSET
let MGT_PORT=9990+$PORT_OFFSET
let JMX_PORT=9999+$PORT_OFFSET
export HTTP_PORT HTTPS_PORT AJP_PORT SHUTDOWN_PORT MGT_PORT JMX_PORT

JAVA_OPTS="-server"
JAVA_OPTS="$JAVA_OPTS -D[SERVER_NAME=${SERVER_NAME}]"
JAVA_OPTS="$JAVA_OPTS -Dserver.base=${SERVER_HOME}"
JAVA_OPTS="$JAVA_OPTS -Dcatalina.base.log=${LOG_DIR}" 

JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8"
JAVA_OPTS="$JAVA_OPTS -Dserver.encoding=UTF-8" 
JAVA_OPTS="$JAVA_OPTS -Dserver.name=${SERVER_NAME}"

JAVA_OPTS="$JAVA_OPTS -Xms1024m"
JAVA_OPTS="$JAVA_OPTS -Xmx1024m"
JAVA_OPTS="$JAVA_OPTS -XX:PermSize=256m"
JAVA_OPTS="$JAVA_OPTS -XX:MaxPermSize=256m" 

JAVA_OPTS="$JAVA_OPTS -XX:+UseParallelGC" 
JAVA_OPTS="$JAVA_OPTS -XX:+UseParallelOldGC"  

JAVA_OPTS="$JAVA_OPTS -verbose:gc"
JAVA_OPTS="$JAVA_OPTS -Xloggc:$LOG_DIR/gclog/${SERVER_NAME}_gc.log"
JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCDetails"
JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCTimeStamps"
JAVA_OPTS="$JAVA_OPTS -XX:+PrintHeapAtGC"
JAVA_OPTS="$JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError"
JAVA_OPTS="$JAVA_OPTS -XX:HeapDumpPath=$LOG_DIR/${SERVER_NAME}_java_pid_$DATE.hprof"

JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote"
JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.ssl=false"
JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.authenticate=true"
JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.access.file=${SERVER_HOME}/commons/conf/jmxremote.access"
JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.password.file=${SERVER_HOME}/commons/conf/jmxremote.password"
JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.port=${JMX_PORT}"
JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.host=${JMX_BIND_ADDR}"
JAVA_OPTS="$JAVA_OPTS -Djava.rmi.server.hostname=${JMX_BIND_ADDR}"

# BINDING PORT GROUP - edit server.xml
JAVA_OPTS="$JAVA_OPTS -Dhttp.bind.port=${HTTP_PORT}"
JAVA_OPTS="$JAVA_OPTS -Dhttps.bind.port=${HTTPS_PORT}"
JAVA_OPTS="$JAVA_OPTS -Dajp.bind.port=${AJP_PORT}"
JAVA_OPTS="$JAVA_OPTS -Dshutdown.bind.port=${SHUTDOWN_PORT}"
JAVA_OPTS="$JAVA_OPTS -Dmanagement.bind.port=${MGT_PORT}"

# SecureRandom Bug
# http://wiki.apache.org/tomcat/HowTo/FasterStartUp
JAVA_OPTS="$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom"

JAVA_OPTS="$JAVA_OPTS -Djava.net.preferIPv4Stack=true"
JAVA_OPTS="$JAVA_OPTS -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false"

export JAVA_OPTS

printf "\e[1;34m%s\n" "================================================"
#printf " %-15s = %-20s \n" "SERVER_HOME" "${SERVER_HOME}"
printf " %-15s = %-20s \n" "CATALINA_HOME" "${CATALINA_HOME}"
printf " %-15s = %-20s \n" "CATALINA_BASE" "${CATALINA_BASE}"
printf " %-15s = %-20s \n" "SERVER_NAME" "${SERVER_NAME}"
#printf " %-15s = %-20s \n" "JAVA_OPTS" "${JAVA_OPTS}"
printf "%s\e[0m\n" "================================================"

UNAME=$USER 
if [ e$UNAME != "e$SERVER_USER" ]
then 
    printf "\033[0;31m%-10s\033[0m\n" "Opps! you are logged in as \"${UNAME}\" now, Run script as \"${SERVER_USER}\""
    exit;
fi 
