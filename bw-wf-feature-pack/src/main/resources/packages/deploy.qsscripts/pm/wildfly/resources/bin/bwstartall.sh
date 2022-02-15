#! /bin/bash

DIRNAME=`dirname "$0"`

. $DIRNAME/bwdirstart.sh
. $DIRNAME/bwstarth2.sh
. $DIRNAME/bwstartoschqs.sh
. $DIRNAME/bwstartwildfly.sh $*

