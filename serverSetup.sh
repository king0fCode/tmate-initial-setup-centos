#!/bin/bash

yum update -y &&
yum upgrade -y &&


# ssh-keygen #enter passphase unique


if systemctl --all --type service | grep -q "sshd";then
    echo "sshd exists."
else
    echo "sshd does NOT exist."
    yum install openssh -y &&
    ssh-keygen
fi

systemctl enable sshd
systemctl restart sshd 

if systemctl --all --type service | grep -q "firewalld";then
    echo "firewalld exists."
else
    echo "firewalld does NOT exist." &&
    yum install firewalld -y
fi

firewall-cmd --add-service=ssh --permanent
firewall-cmd --reload
firewall-cmd --list-all


function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}


package=tmate
if isinstalled $package; then
echo "Tmate already installed";
unset TMUX
tmate 
else
echo "Tmate not installed";
yum install tmate -y &&
if isinstalled $package; then
echo "Tmate successfully installed"
fi 


fi

echo "type : tmate show-messages" && 
tmate

