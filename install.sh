#!/bin/bash

# Function to check command success
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error occurred: $1 failed."
        exit 1
    fi
}

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y
check_success "System update/upgrade"

# Install essential packages
sudo apt install -y wget curl gnupg software-properties-common apt-transport-https
check_success "Essential packages installation"

# Install Vivaldi 
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg
echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" | sudo dd of=/etc/apt/sources.list.d/vivaldi-archive.list
sudo apt install vivaldi-stable

# Install Python and pip
sudo apt install -y python3 python3-pip
check_success "Python and pip installation"

# Install Git
sudo apt install -y git
check_success "Git installation"

# Install additional packages
sudo apt install -y thefuck speedtest-cli htop stress iftop tcpdump
check_success "Additional packages installation"

# Configure 'thefuck' (optional)
echo 'eval $(thefuck --alias)' >> ~/.bashrc
source ~/.bashrc

# Install Docker
# Add Docker's official GPG key and set up the stable repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index and install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
check_success "Docker installation"

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker
check_success "Docker service setup"

# Add the current user to the Docker group (for non-root Docker usage)
sudo usermod -aG docker $USER

# Clean up
sudo apt autoremove -y
sudo apt clean

# Print the versions installed
python3 --version
pip3 --version
git --version
thefuck --version
speedtest-cli --version
htop --version
stress --version
iftop --version
tcpdump --version
docker --version
docker-compose --version

echo "CLI tools installed. Now installing software"
#!/bin/bash

# Download the latest version of Visual Studio Code
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB3E94ADBE1229CF
sudo add-apt-repository -y "deb [arch=arm] https://packages.microsoft.com/repos/vscode stable main"
sudo apt -y install code
sudo apt -y upgrade
sudo apt -y dist-upgrade



echo "Development environment setup is complete!"
