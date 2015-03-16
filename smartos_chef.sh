#!/bin/bash
pkgin -f update
for package in gcc47 gmake ruby200-base ruby200-yajl ruby200-nokogiri ruby200-readline pkg-config; do
  pkg_info $package >/dev/null 2>&1
  if [ $? -gt 0 ]; then
    pkgin -y install $package
  else
    echo "$package already installed ... skipping"
  fi
done
  
export PATH=/opt/local/gnu/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin

gem update --system

gem install --no-ri --no-rdoc --force ohai
gem install --no-ri --no-rdoc --force chef
gem install --no-ri --no-rdoc rb-readline

# mkdir -p /etc/chef
mkdir -p /opt/chef/bin
for bin in $(ls /opt/local/bin/chef*) /opt/local/bin/ohai /opt/local/bin/knife; do 
	ln -sf $bin /opt/chef/bin/$(basename $bin)
done


