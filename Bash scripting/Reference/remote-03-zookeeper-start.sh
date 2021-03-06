#!/bin/bash

SOURCE_FILE=03-zoo-start.sh
USER=haas

#Datanodes HOST Names
HOST1=184.73.223.86
HOST2=54.243.147.30
HOST3=23.21.119.101

R_HOME=/home/$USER
REMOTE=$R_HOME/03-zoo-start.sh

#NODE-1
SCP="scp -i haas $SOURCE_FILE $USER@$HOST1:"
SSH="ssh -i haas  $USER@$HOST1"
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


#NODE-2
SCP="scp -i haas  $SOURCE_FILE $USER@$HOST2:"
SSH="ssh -i haas $USER@$HOST2"
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


#NODE-3
SCP="scp  -i haas $SOURCE_FILE $USER@$HOST3:"
SSH="ssh -i haas $USER@$HOST3"
SSHOPT="-t"

COMMAND="$SSH $SSHOPT chmod 400 $HAAS_FILE"
echo "$COMMAND"
$COMMAND


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

