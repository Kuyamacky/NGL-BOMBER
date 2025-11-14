#!/bin/bash

URL="https://ngl.link/api/submit"
 
pkg install figlet
clear

figlet NGL BOMBER
echo "Creator: Mark P."
echo "Version:1.0.1"
echo " "
UPDATE_URL="YOUR_RAW_GITHUB_LINK"
LOCAL_FILE="$0"

echo "Checking for updates..."

# Get version numbers
remote_version=$(curl -s "$UPDATE_URL" | grep -m1 "Version:")
local_version=$(grep -m1 "Version:" "$LOCAL_FILE")

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
