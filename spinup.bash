#! /bin/bash

#spin up the irc bots on each host

#where path.txt would have the absolute path of the bot.bash file to execute on each host

for host in `cat hosts.txt` ; do
    ssh $host -t /bin/bash < `cat path.txt` &
done


