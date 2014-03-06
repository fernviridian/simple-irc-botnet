#! /bin/bash

#spin up the irc bots on each host

#$1 is the absolute path of the bot.bash file to execute on each host

for host in `cat hosts.txt` ; do
    ssh $host $1 &
done


