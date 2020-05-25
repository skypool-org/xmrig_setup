#!/bin/bash

VERSION=0.1

# printing greetings

echo "Skypool mining uninstall script v$VERSION."
echo

if [ -z $HOME ]; then
  echo "ERROR: Please define HOME environment variable to your home directory"
  exit 1
fi

if [ ! -d $HOME ]; then
  echo "ERROR: Please make sure HOME directory $HOME exists"
  exit 1
fi

echo "[*] Removing skypool miner"
if sudo -n true 2>/dev/null; then
  sudo systemctl stop skypool_miner.service
  sudo systemctl disable skypool_miner.service
  rm -f /etc/systemd/system/skypool_miner.service
  sudo systemctl daemon-reload
  sudo systemctl reset-failed
fi

sed -i '/skypool/d' $HOME/.profile
killall -9 xmrig

echo "[*] Removing $HOME/skypool directory"
rm -rf $HOME/skypool

echo "[*] Uninstall complete"

