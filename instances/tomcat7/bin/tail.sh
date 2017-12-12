#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
. $BASEDIR/env.sh

unset JAVA_OPTS
LOG_DATE=`date +%Y-%m-%d`
 
tail -f -n 0 $LOG_DIR/${SERVER_NAME}_server.${LOG_DATE}.log
