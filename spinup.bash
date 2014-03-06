#! /bin/bash

#spin up the irc bots on each host

#where path.txt would have the absolute path of the bot.bash file to execute on each host
#$1 is channel to join, $2 is path to channel key

for host in `cat hosts.txt` ; do
    ssh $host ``cat path.txt` $1 $2` &
done


