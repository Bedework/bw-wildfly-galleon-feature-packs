#!/usr/bin/env bash

DIRNAME=`dirname "$0"`

. "$DIRNAME/bwcommon.sh"

. $DIRNAME/bwdirstop.sh
. $DIRNAME/bwstoph2.sh
. $DIRNAME/bwstoposchqs.sh
. $DIRNAME/bwstopwildfly.sh $*
