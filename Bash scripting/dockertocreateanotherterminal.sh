#!/bin/bash

SOURCE_FILE=doc.sh
USER=root

#Datanodes HOST Names
HOST1=95.216.147.252

R_HOME=/$USER
REMOTE=$R_HOME/filename

#NODE-1
SCP="scp -i /home/roxor/Downloads/access $SOURCE_FILE $USER@$HOST1:"
SSH="ssh -i /home/roxor/Downloads/access $USER@$HOST1"
SSHOPT="-t"


COMMAND="$SCP"
echo $COMMAND
$COMMAND

COMMAND="$SSH $SSHOPT ls -l $REMOTE"
echo "$COMMAND"
$COMMAND

COMMAND="$SSH $SSHOPT chmod +x $REMOTE"
echo "$COMMAND"
$COMMAND

COMMAND="$SSH $SSHOPT $REMOTE"
echo "$COMMAND"
$COMMAND

COMMAND="$SSH $SSHOPT rm -f $REMOTE"
echo "$COMMAND"
$COMMAND