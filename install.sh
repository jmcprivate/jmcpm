#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y wget curl gnupg software-properties-common apt-transport-https

# Install Vivaldi
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository 'deb [arch=amd64] https://repo.vivaldi.com/archive/deb/ stable main'
sudo apt update
sudo apt install -y vivaldi-stable

# Optional: Automatically login to Vivaldi (this is tricky due to security reasons)
# Note: Automating login for browsers is complex due to security; manual login might be necessary.

# Install Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install -y apt-transport-https
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
