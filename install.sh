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

#!/bin/bash

# Set up variables
USER_DIR="$HOME/cron-task"
TEXT_FILE_PATH="$USER_DIR/cronmessage.txt"
CREATE_TEXT_SCRIPT="$USER_DIR/create_text.sh"

# Create the directory
mkdir -p "$USER_DIR"

# Create the text file with the countdown logic inside the script
echo '#!/bin/bash

# Set the target date (payday)
target_date="2024-09-27"

# Get the current date in seconds since epoch
current_date=$(date +%s)

# Convert the target date to seconds since epoch
target_date_sec=$(date -d "$target_date" +%s)

# Calculate the difference in seconds
diff_sec=$((target_date_sec - current_date))

# Convert the difference from seconds to days
diff_days=$((diff_sec / 86400))

# Read the message template
message="This month'\''s pay day is 27th of September! There are {{DAYS_LEFT}} days left until payday."

# Replace the placeholder with the actual days left
final_message=$(echo "$message" | sed "s/{{DAYS_LEFT}}/$diff_days/")

# Output to the text file
echo "$final_message" > '"$TEXT_FILE_PATH"' ' > "$CREATE_TEXT_SCRIPT"

# Make sure the create_text.sh script is executable
chmod +x "$CREATE_TEXT_SCRIPT"

# Set up cron jobs to run the script and output the message to the terminal every hour

# Add a new cron job to execute the script every hour
(crontab -l ; echo "0 * * * * $CREATE_TEXT_SCRIPT") | crontab -

# Add a cron job to output the contents of cronmessage.txt every hour to the terminal (change /dev/pts/1 to your terminal)
(crontab -l ; echo "0 * * * * cat $TEXT_FILE_PATH >> /dev/pts/1") | crontab -

# Add a cron job to run the script at reboot (optional)
(crontab -l ; echo "@reboot $CREATE_TEXT_SCRIPT") | crontab -

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
