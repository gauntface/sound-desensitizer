#!/bin/bash

# Catch and log errors
trap uncaughtError ERR
function uncaughtError {
  echo -e "\n\t❌  Error\n"
  echo "$(<${ERROR_LOG})"
  echo -e "\n\t😞  Sorry\n"
  exit $?
}

function initTempDir() {
    TEMP_DIR="$(mktemp -d)"
    ERROR_LOG="${TEMP_DIR}/sound-desensitizer-install-err.log"
}


function installNode() {
  # Install Node and NPM - https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
  echo -e "📦  Installing Node.js..."
  if ! [ -x "$(command -v node)" ]; then
    NODE_VERSION=13
    curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | sudo bash - &> ${ERROR_LOG}
    sudo apt-get install -y nodejs &> ${ERROR_LOG}
  fi
  echo -e "\n\t✅  Done\n"
}

function installFFmpeg() {
  echo -e "📦  Installing ffmpeg..."
  sudo apt install ffmpeg
  echo -e "\n\t✅  Done\n"
}

function getSrcCode() {
  echo -e "📦  Getting Source Code..."
  if [ ! -d ~/sound-desensitizer/ ]; then
    git clone https://github.com/gauntface/sound-desensitizer.git ~/sound-desensitizer/
  fi
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

initTempDir

installFFmpeg

installNode


getSrcCode

installNPMDeps

setupCron