#!/usr/bin/env bash

# Return 0 if CommandLineTools are installed
function isCommandLineToolsInstalled() {
  xcode-select -p 2>/dev/null 1>&2
}

# Start an installation sequence of CommandLineTools in GUI
function installCommandLineTools() {
  xcode-select --install 2>/dev/null
}

# Note: CommandLineTools can be installed only from GUI
function commandLineToolsShouldBeInstalled() {
  echo -n "[    ] Checking CommandLineTools..."
  if ! isCommandLineToolsInstalled; then
    echo -e "\r\033[K[ NG ] Checking CommandLineTools...Failure. Please try again after installed"
    installCommandLineTools
  else
    echo -e "\r\033[K[ OK ] Checking CommandLineTools...Success"
  fi
}

commandLineToolsShouldBeInstalled