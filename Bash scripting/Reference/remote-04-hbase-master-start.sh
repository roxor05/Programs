#!/bin/bash

SOURCE_FILE=04-hbase-master-start.sh
USER=haas
HOST1=50.19.115.197
R_HOME=/home/$USER
REMOTE=$R_HOME/04-hbase-master-start.sh

SCP="scp -i haas $SOURCE_FILE $USER@$HOST1:"
SSH="ssh $USER@$HOST1"
SSHOPT="-t"
SCPOPT="-p"

COMMAND="$SCP"
echo $COMMAND
$COMMAND

COMMAND="$SSH -i haas $SSHOPT ls -l $REMOTE"
echo "$COMMAND"
$COMMAND

COMMAND="$SSH -i haas $SSHOPT chmod +x $REMOTE"
echo "$COMMAND"
$COMMAND

COMMAND="$SSH -i haas $SSHOPT $REMOTE"
echo "$COMMAND"
$COMMAND

COMMAND="$SSH -i haas $SSHOPT rm -f $REMOTE"
echo "$COMMAND"
$COMMAND
