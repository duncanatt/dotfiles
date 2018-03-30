#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished 
# executing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check if Homebrew is already installed on the system, if not, download it.
if [[ "$(which brew)" ]]; then
  printf "Homebrew already installed..updating..\n"
  brew update
else
  printf "Homebrew not installed..downloading..\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

printf "Done. Installing Homebrew bundle.\n"
brew bundle

printf "Setting up GIT configuration..\n"

# Read GIT user information.
printf "Enter GIT name: "
read U_NAME
printf "Enter GIT email: "
read U_EMAIL

# Copy .gitconfig file to home directory and replace user information.
cp .gitconfig "$HOME/.gitconfig"
sed -i '' "s/U_NAME/$U_NAME/g; s/U_EMAIL/$U_EMAIL/g" "$HOME/.gitconfig"
printf "Done.\n"

# Set up .erlang file, copy and compile user_default file.
printf "Setting up Erlang configuration..\n"
cp .erlang "$HOME/.erlang"
sed -i '' "s@U_HOME@$HOME@g" "$HOME/.erlang"
cp user_default.erl "$HOME/user_default.erl"
erlc -o "$HOME" "$HOME/user_default.erl"
printf "Done.\n"

# Restore configuration through Mackup.
printf "Do you want Mackup to restore your previous configuration from Dropbox? (y/n)? "
read U_RESP

if [[ "$U_RESP" =~ ^(y|Y|yes|Yes)$ ]]; then
  printf "Restoring configuration from Dropbox..\n"
  mackup restore
  printf "Done"
fi

# Copy .profile.
cp .profile "$HOME/.profile"

# Configure macOS defaults.
source .macos

printf "\nSome of the configuration requires a restart of your mac. Would you like to do that now? (y/n)"
read U_RESP
if [[ "$U_RESP" =~ ^(y|Y|yes|Yes)$ ]]; then
  sudo shutdown -r now
fi

