#!/bin/bash

SOURCE_FILE=/home/roxor/doc1.sh
USER=root

#Datanodes HOST Names
HOST1=95.216.147.252

R_HOME=/$USER
REMOTE=$R_HOME/doc1.sh

#NODE-1
SCP="scp -i /home/roxor/Downloads/access $SOURCE_FILE $USER@$HOST1:/root/"
SSH="ssh -i /home/roxor/Downloads/access $USER@$HOST1"
SSHOPT="-t"


COMMAND="$SCP"
echo $COMMAND
$COMMAND

COMMAND="$SSH $SSHOPT ls -l $REMOTE" #"$SSH chmod 755 $REMOTE doc1.sh"
echo "$COMMAND"
$COMMAND

COMMAND="$SSH $SSHOPT chmod 755 $REMOTE"
echo "$COMMAND"
$COMMAND

COMMAND="$SSH $SSHOPT sh $REMOTE"
echo "$COMMAND"
$COMMAND

# COMMAND="$SSH $SSHOPT ls -l $REMOTE" #"$SSH chmod 755 $REMOTE doc1.sh"
# echo "$COMMAND"
# $COMMAND

# COMMAND="$SSH $SSHOPT $REMOTE"
# echo "$COMMAND"
# $COMMAND

# COMMAND="$SSH $SSHOPT rm -f $REMOTE"
# echo "$COMMAND"
# $COMMAND