#!/bin/bash

#Name and OS Version
echo ""
grep "PRETTY_NAME" /etc/os-release	 
grep "VERSION=" /etc/os-release
echo ""

echo "===================================="
echo "      Server Performance Stats      "
echo "===================================="

#Total CPU Usage
echo "Total CPU Usage: $(mpstat -A | awk 'FNR == 4 {print "%" (100-$12)}')"
echo ""
mpstat -A | awk 'FNR == 4 {print "User: %" $3 " |  System: %" $5  " |  Idle: %" $12 }'

#Total Memory Usage
echo "-------------------------------------"
echo "Total Memory Usage:"
echo ""
free -h | awk 'FNR == 2 {print "Used: " $3 " (%" ($3/$2*100) ")" " | buff/cache: " $6 " (%" ($6/$2*100) ")" " | Free: " $4 " (%" ($4/$2*100) ")" }'

#Total Disk Usage
echo "-------------------------------------"
echo "Total Disk Usage:"
echo ""
df -h --total | awk 'FNR == 9 {print "Used: " $3 " (%" ($3/($3+$4)*100) ")" " | Free: " $4 " (%" ($4/($3+$4)*100) ")" }'

#Top 5 processes by CPU usage
echo "-------------------------------------"
echo "Top 5 processes by CPU usage:"
echo ""
ps -Ao pid,comm,%cpu --sort=-%cpu | head -n 6

#Top 5 processes by memory usage
echo "-------------------------------------"
echo "Top 5 processes by Memory usage:"
echo ""
ps -Ao pid,comm,%mem --sort=-%mem | head -n 6
echo "-------------------------------------"
