#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y wget curl gnupg software-properties-common apt-transport-https

# Ensure cron service is enabled and starts on boot
sudo systemctl enable cron
sudo systemctl start cron

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

# Set up cron job to run every hour
(crontab -l 2>/dev/null; echo "0 * * * * $CREATE_TEXT_SCRIPT") | crontab -

# Add a cron job to display the text file content every hour
(crontab -l 2>/dev/null; echo "0 * * * * cat $TEXT_FILE_PATH | wall") | crontab -

# Optional: Add cron job to run the script once at reboot
(crontab -l 2>/dev/null; echo "@reboot $CREATE_TEXT_SCRIPT") | crontab -

echo "Cron jobs set up successfully."


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
