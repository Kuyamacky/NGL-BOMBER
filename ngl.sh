#!/bin/bash

URL="https://ngl.link/api/submit"
 
pkg install figlet
clear

figlet NGL BOMBER
echo "Creator: Mark P."
echo "Version:1.0.1"
echo " "

read -p "Enter the username: " User
read -p "Enter the message: " msg

sent=0
termux-wake-lock 2>/dev/null

while true; do
  ((sent++))
  curl --max-time 5 -s -X POST "$URL" \
    -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" \
    -H "Origin: https://ngl.link" \
    -H "Referer: https://ngl.link/$User" \
    -H "User-Agent: Mozilla/5.0" \
    --data-urlencode "username=$User" \
    --data-urlencode "question=$msg" \
    --data-urlencode "deviceId=0128ea12-86ca-4233-a47d-7bd47145a141" \
    --data-urlencode "gameSlug=" \
    --data-urlencode "referrer=" \
    >/dev/null

  echo "[$sent] Message sent!"
  sleep $((RANDOM % 3 + 1)) 
  
clear
done
