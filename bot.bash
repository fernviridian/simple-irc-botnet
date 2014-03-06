#!/bin/bash

mkfifo .botfile
chan=$1
if [ $2 != '' ] && [ -f $2 ] ; then
  key=`cat $2`
fi

host=`hostname`

#botname
ircnick=$host-"bot"

#command to listen for
command="@bots say hello"

tail -f .botfile | openssl s_client -connect irc.cat.pdx.edu:6697 | while true; do
  if [[ -z $started ]] ; then
    echo "USER $ircnick $ircnick $ircnick :$ircnick" >> .botfile
    echo "NICK $ircnick" >> .botfile
    echo "JOIN #$chan $key" >> .botfile
    started="yes"
  fi

  read irc
  echo $irc
  if `echo $irc | cut -d ' ' -f 1 | grep PING > /dev/null` ; then
    echo "PONG" >> .botfile
  elif `echo $irc | grep PRIVMSG | grep "$command" > /dev/null` ; then
    nick="${irc%%!*}"; nick="${nick#:}"
    if [[ $nick != $ircnick ]] ; then
      chan=`echo $irc | cut -d ' ' -f 3`
      echo "PRIVMSG $chan :Hello from $host!" >> .botfile
    fi
  fi
done
