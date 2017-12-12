#!/usr/bin/env bash

for jar in $(ls ../lib/*.jar)
do
CLASSPATH="$CLASSPATH:$jar"
done

#echo $CLASSPATH
JAVA_OPTS="-client "
JAVA_OPTS="$JAVA_OPTS -Dcapcher.config.file=../config/hosts.json "
JAVA_OPTS="$JAVA_OPTS -Dcapcher.result.file=../result/output.json "

java $JAVA_OPTS -classpath $CLASSPATH com.rock.healthcheck.parser.Capcher "$@"
