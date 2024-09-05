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

# Create the CRON task in Linux to output when I'm getting paid for the month (hourly outout)
# Define the paths
USER_DIR="$HOME/cron-task"
TEXT_FILE_PATH="$USER_DIR/cron-message.txt"
CREATE_TEXT_SCRIPT="$USER_DIR/create_text.sh"

# Create the directory
mkdir -p "$USER_DIR"

# Create the text file creation script
echo -e "#!/bin/bash\n\necho \"This month's pay day is 27th of September!\" > $TEXT_FILE_PATH" > "$CREATE_TEXT_SCRIPT"

# Make sure the create_text.sh script is executable
chmod +x "$CREATE_TEXT_SCRIPT"

# Add the create_text.sh script to the cron job to run every minute
(crontab -l 2>/dev/null; echo "* * * * * $CREATE_TEXT_SCRIPT") | crontab -

# Add the cron job to display the text file content
(crontab -l 2>/dev/null; echo "* * * * * cat $TEXT_FILE_PATH | wall") | crontab -

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
