#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y wget curl gnupg software-properties-common apt-transport-https

# Install Vivaldi
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/vivaldi.asc
echo 'deb [arch=amd64] https://repo.vivaldi.com/archive/deb/ stable main' | sudo tee /etc/apt/sources.list.d/vivaldi.list
sudo apt update
sudo apt install -y vivaldi-stable

# Install Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/packages.microsoft.gpg
echo 'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main' | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code

# Install Python and pip
sudo apt install -y python3 python3-pip

# Install Git
sudo apt install -y git

# Install additional packages
sudo apt install -y thefuck speedtest-cli htop stress iftop tcpdump

# Configure 'thefuck' (optional)
echo 'eval $(thefuck --alias)' >> ~/.bashrc
source ~/.bashrc

# Clean up
sudo apt autoremove -y
sudo apt clean

# Print the versions installed
vivaldi --version
code --version
python3 --version
pip3 --version
git --version
thefuck --version
speedtest-cli --version
htop --version
stress --version
iftop --version
tcpdump --version

echo "Development environment setup is complete!"
