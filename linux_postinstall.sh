#!/usr/bin/env bash

### Installs a whole bunch of packages. To run after a fresh install of a Debian distro.

# Versions
# Ruby
current_ruby_version='2.2.2'

# Adding repositories
sudo add-apt-repository ppa:ecometrica/servers
sudo add-apt-repository ppa:ubuntu-lxc/lxd-stable
sudo apt-get update

# Installing various essentials
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties memcached imagemagick wkhtmltopdf autoconf automake python-dev gitk redshift redshift-gtk exuberant-ctags zsh htop update-manager-core screen keepassx qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x clang

# Node packages
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs

# Installing rbenv and rbenv-vars
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
if ([ ! -d "$HOME/.rbenv/plugins" ]); then
  mkdir -p "$HOME/.rbenv/plugins"
fi
cd $HOME/.rbenv/plugins
git clone https://github.com/sstephenson/rbenv-vars.git

# Installing Ruby
rbenv install "$current_ruby_version"
rbenv global "$current_ruby_version"

echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler --no-ri --no-rdoc

# Installing Postgresql
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib libpq-dev

# Installing Go
sudo apt-get install golang

# Installing vim and various plugins.
sudo apt-get install vim
git clone git@github.com:etiennebaque/dotitup.git ~/codes/dotitup
cd ~/codes/dotitup
rake
cp ./vimrc ~/.vimrc

cd

# Installing Ember, Bower
sudo npm install -g bower
sudo npm install -g ember-cli

# Installing diff-fancy
sudo npm install -g diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

# Making ZSH my default shell
chsh -s $(which zsh)

# Installing FontConfig for oh-my-zsh
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

# Zsh plugin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/psprint/zsh-navigation-tools/master/doc/install.sh)"

# Installing various gems
gem install capybara-webkit

# Compiling YouCompleteMe plugin for vim
cd ~/.vim/plugged/YouCompleteMe && sh ./install.sh

# Installing theme for vim
mkdir ~/.vim/colors && cd ~/.vim/colors
wget 'https://raw.githubusercontent.com/jpo/vim-railscasts-theme/master/colors/railscasts.vim'

# AWS
sudo pip install awscli

# Fuzzy finder for terminal
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "------------------------------"
echo "-- Documentation:"
echo "-- Create templates for git hooks: http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html"
echo "-- Install ZSH: https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH"
echo "-- Install Docker: https://docs.docker.com/engine/installation/linux/ubuntulinux/"
echo "-- Install Docker compose: https://docs.docker.com/compose/install/"
echo "-- You Complete Me vim plugin: https://valloric.github.io/YouCompleteMe/#ubuntu-linux-x64"
echo "-- Configure AWS CLI: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html"
echo "------------------------------"
