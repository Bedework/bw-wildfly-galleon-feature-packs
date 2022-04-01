#!/usr/bin/env bash

# Reset a bedework quickstart to its initial state - for testing

DIRNAME=`dirname "$0"`

# OS specific support (must be 'true' or 'false').
cygwin=false;
darwin=false;
case "`uname`" in
    CYGWIN*)
        cygwin=true
        ;;

    Darwin*)
        darwin=true
        ;;
esac

# For Cygwin, ensure paths are in UNIX format before anything is touched
if $cygwin ; then
    [ -n "$JBOSS_HOME" ] &&
        JBOSS_HOME=`cygpath --unix "$JBOSS_HOME"`
fi

# Setup JBOSS_HOME
RESOLVED_JBOSS_HOME=`cd "$DIRNAME/.."; pwd`
if [ "x$JBOSS_HOME" = "x" ]; then
    # get the full path (without any relative bits)
    JBOSS_HOME=$RESOLVED_JBOSS_HOME
else
 SANITIZED_JBOSS_HOME=`cd "$JBOSS_HOME"; pwd`
 if [ "$RESOLVED_JBOSS_HOME" != "$SANITIZED_JBOSS_HOME" ]; then
   echo "WARNING JBOSS_HOME may be pointing to a different installation - unpredictable results may occur."
   echo ""
 fi
fi

export JBOSS_HOME

# This should be quickstart
BASE_DIR=`cd "$JBOSS_HOME/.."; pwd`

h2calresources=$BASE_DIR/bw-quickstart/bw-calendar-data-h2/src/main/resources
h2cardresources=$BASE_DIR/bw-wildfly-galleon-feature-packs/bw-wf-carddav-feature-pack/src/main/resources/packages/data.carddav-h2/pm/wildfly/resources/h2
h2evregresources=$BASE_DIR/bw-wildfly-galleon-feature-packs/bw-wf-event-registration-feature-pack/src/main/resources/packages/data.eventreg-h2/pm/wildfly/resources/h2
h2noteresources=$BASE_DIR/bw-wildfly-galleon-feature-packs/bw-wf-note-feature-pack/src/main/resources/packages/data.notify-h2/pm/wildfly/resources/h2
h2selfregresources=$BASE_DIR/bw-wildfly-galleon-feature-packs/bw-wf-self-registration-feature-pack/src/main/resources/packages/data.selfreg-h2/pm/wildfly/resources/h2
h2synchresources=$BASE_DIR/bw-wildfly-galleon-feature-packs/bw-wf-synch-feature-pack/src/main/resources/packages/data.synch-h2/pm/wildfly/resources/h2

JBOSS_CONFIG="standalone"
JBOSS_BIN=$JBOSS_HOME/bin
JBOSS_SERVER_DIR="$JBOSS_HOME/$JBOSS_CONFIG"
JBOSS_DATA_DIR="$JBOSS_SERVER_DIR/data"
bedework_data_dir="$JBOSS_DATA_DIR/bedework"

if [ "x$bwOSCHdatadir" = "x" ]; then
    # get the full path (without any relative bits)
    bwOSCHdatadir=$JBOSS_HOME/opensearch/data
fi

TMP_DIR="$JBOSS_SERVER_DIR/tmp"

echo "Temp dir is $TMP_DIR"

if [ ! -d "$TMP_DIR" ]; then
  mkdir -p $TMP_DIR
fi

# Ensure nothing running

echo -n "Shutting down h2:  "
$JBOSS_BIN/bwstoph2.sh

echo -n "Shutting down apacheds:  "
$JBOSS_BIN/bwdirstop.sh

echo -n "Shutting down opensearch:  "
$JBOSS_BIN/bwstoposchqs.sh

# -------------------------------------------------------------------
# Each step is a function
# -------------------------------------------------------------------

# These are the steps in the process
installData="installData"

installData() {
  echo "---------------------------------------------------------------"
  echo "Install data: this will stop h2 and apacheds but not restart them"

  # ------------------------------------- h2 data

  rm -rf $bedework_data_dir/h2/*

  cp -r $h2calresources/* $bedework_data_dir/h2/
  cp -r $h2cardresources/* $bedework_data_dir/h2/
  cp -r $h2evregresources/* $bedework_data_dir/h2/
  cp -r $h2noteresources/* $bedework_data_dir/h2/
  cp -r $h2selfregresources/* $bedework_data_dir/h2/
  cp -r $h2synchresources/* $bedework_data_dir/h2/

  # ------------------------------------- opensearch data

  rm -rf $bwOSCHdatadir
  mkdir $bwOSCHdatadir
  cp -r $BASE_DIR/bw-quickstart/bw-opensearch-qs/src/main/resources/opensearch-1.2.4/data/nodes $bwOSCHdatadir/

  # ------------------------------------- directory data

  rm -rf $JBOSS_HOME/apacheds/instances/default/partitions
  cp -r $BASE_DIR/bw-quickstart/bw-apacheds/src/main/resources/apacheds/instances/default/partitions   $JBOSS_HOME/apacheds/instances/default/partitions
}

installData

