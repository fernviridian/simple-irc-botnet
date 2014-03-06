#! /bin/bash


#kills all processes on a host, I hope you dont have anything important running :P
for host in `cat hosts.txt` ; do
    ssh $host kill -9 -1
done


