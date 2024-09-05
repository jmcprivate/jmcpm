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

# Ensure cron service is enabled and starts on boot
sudo systemctl enable cron
sudo systemctl start cron
check_success "Cron service setup"

# Create the CRON task in Linux to output when I'm getting paid for the month (hourly output)
USER_DIR="$HOME/cron-task"
TEXT_FILE_PATH="$USER_DIR/cron-message.txt"
CREATE_TEXT_SCRIPT="$USER_DIR/create_text.sh"

# Create the directory
mkdir -p "$USER_DIR"

# Create the text file creation script
echo -e "#!/bin/bash\n\necho \"This month's pay day is 27th of September!\" > $TEXT_FILE_PATH" > "$CREATE_TEXT_SCRIPT"

# Make sure the create_text.sh script is executable
chmod +x "$CREATE_TEXT_SCRIPT"

# Set up cron jobs to hourly output
# Check current crontab
crontab -l
# Add a new cron job
echo "0 * * * * /home/parallels/cron-task/create_text.sh" | crontab -
(crontab -l ; echo "0 * * * * /home/parallels/cron-task/create_text.sh") | crontab -
(crontab -l ; echo "0 * * * * cat /home/parallels/cron-task/cron-message.txt >> /dev/pts/1") | crontab -
(crontab -l ; echo "0 * * * * echo \"This month's pay day is 27th September\" > /dev/pts/1 2>&1") | crontab -
(crontab -l ; echo "@reboot /home/parallels/cron-task/create_text.sh") | crontab -

echo "Cron jobs set up successfully."

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
wget -O code-latest.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'

# Install the downloaded .deb package
sudo apt install -y ./code-latest.deb

# Remove the installer file
rm code-latest.deb



echo "Development environment setup is complete!"
