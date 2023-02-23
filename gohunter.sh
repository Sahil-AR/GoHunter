#!/bin/bash

# Check if running as root
if [ "$(id -u)" != "0" ]; then
  echo "Error: This script must be run as root." >&2
  exit 1
fi

# Set up logging
LOG_FILE="/var/log/gohunter-install.log"
touch "$LOG_FILE"
exec &> >(tee -a "$LOG_FILE")

# Install dependencies
echo "Installing dependencies..."
apt install -y wget curl git gcc

# Install Go
echo "Installing Go..."
apt install -y golang-go
echo 'export GOPATH="$HOME/go"' >> ~/.bashrc
echo 'export PATH="$PATH:$GOPATH/bin"' >> ~/.bashrc
source ~/.bashrc

# Function to install tools
install_tools() {
  # Define tools to install
  tools=(
    "github.com/tomnomnom/anew@latest"
    "github.com/tomnomnom/httprobe@latest"
    "github.com/tomnomnom/unfurl@latest"
    "github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest"
    "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
    "github.com/projectdiscovery/httpx/cmd/httpx@latest"
    "github.com/hakluke/hakrawler@latest"
    "github.com/hakluke/hakrevdns@latest"
    "github.com/003random/getJS@latest"
    "github.com/brentp/gargs@latest"
    "github.com/lc/gau@latest"
    "github.com/ffuf/ffuf@latest"
    "github.com/tomnomnom/waybackurls@latest"
    "github.com/tomnomnom/hacks/html-tool@latest"
    "github.com/asciimoo/wuzz@latest"
    "github.com/jaeles-project/jaeles@latest"
    "github.com/lukasikic/subzy@latest"
    "github.com/haccer/subjack@latest"
    "github.com/hahwul/dalfox@latest"
    "github.com/OWASP/Amass/v3/...@latest"
    "github.com/michenriksen/aquatone@latest"
    "github.com/hiddengearz/jsubfinder@latest"
    "github.com/anshumanbh/tko-subs@latest"
    "github.com/anshumanbh/git-all-secrets@latest"
    "github.com/dwisiswant0/crlfuzz@latest"
    "github.com/dwisiswant0/hinject@latest"
    "github.com/j3ssie/go-auxs/bypassetcpfw@latest"
    "github.com/j3ssie/go-auxs/cp-scanner@latest"
    "github.com/j3ssie/go-auxs/jaeles-signature@latest"
    "github.com/j3ssie/go-auxs/meg@latest"
    "github.com/j3ssie/go-auxs/nuclei-templates@latest"
    "github.com/BBB/dnsx@latest"
    "github.com/tomnomnom/gf@latest"
    "github.com/sensepost/gowitness@latest"
    "github.com/tomnomnom/assetfinder@latest"
    "github.com/tomnomnom/gron@latest"
    "github.com/tomnomnom/hacks/concurl@latest"
  )

  if [[ "$1" == "all" ]]; then
    echo "Installing all tools..."
    for tool in "${tools[@]}"
do
install_tool "$tool"
done
elif [[ "$1" == "custom" ]]; then
echo "Select which tools to install:"
select tool in "${tools[@]}"
do
if [[ -n "$tool" ]]; then
install_tool "$tool"
fi
break
done
else
echo "Invalid option. Usage: ./gohunter.sh [all|custom]"
exit 1
fi
echo "Done installing GoHunter!"
