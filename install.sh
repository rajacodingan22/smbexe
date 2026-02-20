#!/bin/bash
# smbexec modern installer
# Updated for Ubuntu 22.04+ and modern Ruby

f_Banner(){
    echo "************************************************************"
    echo -e "                \e[1;36msmbexec modern installer\e[0m       "
    echo "    A rapid psexec style attack with samba tools              "
    echo "************************************************************"
    echo
}

f_install_reqs(){
    echo -e "\n\e[1;34m[*]\e[0m Installing pre-reqs for Debian/Ubuntu...\n"
    
    # Update package list
    apt-get update
    
    # Install dependencies
    apt-get install -y ruby ruby-dev build-essential libxml2-dev libxslt1-dev \
        nmap python3-pip python3-impacket wget unzip git screen xterm \
        mingw-w64 gcc-mingw-w64 g++-mingw-w64
    
    # Install Ruby gems
    echo -e "\e[1;34m[*]\e[0m Installing required ruby gems..."
    gem install bundler
    bundle install
}

f_setup_paths(){
    # Set up symbolic link
    ln -f -s $(pwd)/smbexec.rb /usr/bin/smbexec
    chmod +x smbexec.rb
    chmod +x progs/*
    
    # Create log directory
    mkdir -p log
    
    # Workaround for samba error
    if [ ! -e /usr/local/samba/lib/smb.conf ]; then
        mkdir -p /usr/local/samba/lib/
        cp patches/smb.conf /usr/local/samba/lib/smb.conf
    fi
}

f_main(){
    clear
    f_Banner
    
    if [ "$(id -u)" != "0" ]; then
        echo -e "\e[1;31m[!]\e[0m This script must be run as root" 1>&2
        exit 1
    fi
    
    f_install_reqs
    f_setup_paths
    
    echo -e "\n\e[1;32m[+]\e[0m smbexec has been successfully installed/updated!"
    echo -e "\e[1;34m[*]\e[0m You can now run it by typing 'smbexec' in your terminal."
}

f_main
