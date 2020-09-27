#!/bin/bash

# Catch and log errors
trap uncaughtError ERR
function uncaughtError {
  echo -e "\n\t❌  Error\n"
  echo "$(<${ERROR_LOG})"
  echo -e "\n\t😞  Sorry\n"
  exit $?
}

function getSrcCode() {
  echo -e "📦  Getting Source Code..."
  git clone https://github.com/gauntface/sound-desensitizer.git ~/sound-desensitizer/
  echo -e "\n\t✅  Done\n"
}

function installNPMDeps() {
  echo -e "📦  Installing npm deps..."
  cd ~/sound-desensitizer/
  npm install
  echo -e "\n\t✅  Done\n"
}

function setupCron() {
  echo -e "📦  Setting up cron..."
  sudo cp ./sound-desensitize.cronjob /etc/cron.d/sound-desensitize.cronjob
  echo -e "\n\t✅  Done\n"
}

# -e means 'enable interpretation of backslash escapes'
echo -e "\n📓  Installing sound desensitizer\n"

getSrcCode

installNPMDeps

setupCron