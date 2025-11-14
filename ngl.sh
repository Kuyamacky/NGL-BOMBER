#!/bin/bash

URL="https://ngl.link/api/submit"
UPDATE_URL="https://raw.githubusercontent.com/Kuyamacky/NGL-BOMBER/main/ngl.sh"
LOCAL_FILE="ngl.sh"  # use actual filename

echo "Checking for updates..."
sleep 3

remote_version=$(curl -s "$UPDATE_URL" | grep -m1 "Version:" | tr -d ' ')
local_version=$(grep -m1 "Version:" "$LOCAL_FILE" | tr -d ' ')

if [ "$remote_version" != "$local_version" ]; then
    echo "New update found!"
    echo "Updating..."
    curl -s -o "$LOCAL_FILE" "$UPDATE_URL"
    chmod +x "$LOCAL_FILE"
    echo "Update complete. Restart the script."
    exit
else
    echo "You are using the latest version."
fi

 
pkg install -y figlet >/dev/null 2>&1
clear

figlet NGL BOMBER
echo "Creator: Makii official"
echo "Version:1.0.4"
echo " "
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
