#!/bin/bash

DIRNAME=`dirname "$0"`
GREP="grep"

. "$DIRNAME/bwcommon.sh"

# Set default modular JVM options
setDefaultModularJvmOptions $JAVA_OPTS
JAVA_OPTS="$JAVA_OPTS $DEFAULT_MODULAR_JVM_OPTIONS"

# Override ibm JRE behavior
JAVA_OPTS="$JAVA_OPTS -Dcom.ibm.jsse2.overrideDefaultTLS=true"

# Sample JPDA settings for remote socket debugging
#JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n"
echo "Run bwcli to provide request/session info"
echo "  $0 taskId <task> [options] <file-name>"
echo "  $0 sessionId <sessid> [options] <file-name>"
echo "  $0 sessionUser <user> [options] <file-name>"
echo "  $0 requestDt <dt> [options] <file-name>"
echo " e.g."
echo "$0 taskId 'default task-176' wildfly/standalone/logs/server.log.2022-10-21"
echo "  for only that task-id (note they get reused)"
echo "$0 sessionUser 'douglm' wildfly/standalone/logs/server.log.2022-10-21"
echo "  for only that user"
echo "$0 requestDt '2022-10-21 11:25:52,449' wildfly/standalone/logs/server.log.2022-10-21"
echo "  for any records with the given string as a prefix, e.g."
echo "$0 requestDt '2022-10-21 11' wildfly/standalone/logs/server.log.2022-10-21"
echo "  for any records in the 11th hour"
echo "Options"
echo "  skipAnon - skip anonymous sessions"
echo "  displayTotals - display the log analysis informations also"
echo "  list|summary|full - increasing amounts of info fullis default"

array=( "$@" )
len=${#array[@]}
file=${array[$len-1]}
args=( "${array[@]:0:$len-1}" )

echo "File: $file"
echo "All Args before $file are: $args"

LOG_CONF=`echo $JAVA_OPTS | grep "logging.configuration"`
if [ "x$LOG_CONF" = "x" ]; then
    exec "$JAVA" $JAVA_OPTS -Dlogging.configuration=file:"$JBOSS_HOME"/bin/jboss-cli-logging.properties -jar "$JBOSS_HOME"/jboss-modules.jar -mp "${JBOSS_MODULEPATH}" org.bedework.cli.cli-app "${args[@]}" sessions $file
else
    echo "logging.configuration already set in JAVA_OPTS"
    exec "$JAVA" $JAVA_OPTS -jar "$JBOSS_HOME"/jboss-modules.jar -mp "${JBOSS_MODULEPATH}" org.bedework.cli.cli-app "${args[@]}" sessions $file
fi
