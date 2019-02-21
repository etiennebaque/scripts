#!/bin/bash

### On Debian, Firefox ESR comes by default. To use (regular) Firefox, we need to untar it.
### This script downloads the latest version of Firefox and untar it where the previous version is.

wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
sudo tar -jxvf FirefoxSetup.tar.bz2 -C /opt/
rm FirefoxSetup.tar.bz2
