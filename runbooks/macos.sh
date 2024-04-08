#!/bin/zsh

# Install homebrew
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Adding homebrew to HOME dir
(echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/aleks/.zprofile
eval "$(/usr/local/bin/brew shellenv)"

# Install tools and plugins
brew install fzf
