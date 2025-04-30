#!/bin/bash

echo "===== Server Performance Stats ====="
echo ""

# Stretch Goal: OS version
echo "OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"'
echo ""

# Stretch Goal: Uptime
echo "Uptime:"
uptime -p
echo ""

# Stretch Goal: Load Average
echo "Load Average (1m, 5m, 15m):"
uptime | awk -F'load average:' '{ print $2 }'
echo ""

# Stretch Goal: Logged-in Users
echo "Logged-in Users:"
who | awk '{print $1}' | sort | uniq -c
echo ""

# Stretch Goal: Failed login attempts (requires root or sudo)
echo "Failed Login Attempts:"
lastb | grep -c 'tty'
echo ""

# CPU Usage
echo "Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{print "Used: " 100 - $8 "%"}'
echo ""

# Memory Usage
echo "Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB / %sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
echo ""

# Disk Usage
echo "Disk Usage (/):"
df -h / | awk 'NR==2{printf "Used: %s / %s (%s)\n", $3,$2,$5}'
echo ""

# Top 5 processes by CPU usage
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

# Top 5 processes by Memory usage
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""

echo "===== End of Report ====="
