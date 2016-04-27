#!/usr/bin/env bash

### Installs a whole bunch of packages. To run after a fresh install of a Debian distro.

# Versions
# Ruby
current_ruby_version='2.2.2'

# Creates codes folder
mkdir ~/codes

# Adding repositories
sudo add-apt-repository ppa:ecometrica/servers

# Installing various essentials
sudo apt-get update
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties memcached imagemagick wkhtmltopdf

# Node packages
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs

# Installing rbenv qnd rbenv-vars
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

# Installing vim and necessary plugins for development
sudo apt-get install vim
cd ~/codes && git clone git@github.com:etiennebaque/dotitup.git
cd dotitup
rake
cp ./vimrc ~/.vimrc

cd

# Getting RubyMine
wget 'https://download.jetbrains.com/ruby/RubyMine-2016.1.tar.gz'

# Installing Ember, Bower
sudo npm install -g bower
sudo npm install -g ember-cli

# Installing FontConfig for oh-my-zsh
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

# Much needed system restart
sudo reboot
