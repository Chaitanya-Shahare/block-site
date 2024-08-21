#!/bin/bash

# Function to block a website
block_website() {
  local domain="$1"
  
  # Check if the domain is already blocked
  if ! grep -q "$domain" /etc/hosts; then
    # Add the block to the /etc/hosts file
    echo "127.0.0.1 $domain" | sudo tee -a /etc/hosts > /dev/null
    echo "127.0.0.1 www.$domain" | sudo tee -a /etc/hosts > /dev/null
    
    # Flush the DNS cache
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    
    echo "$domain has been blocked."
  else
    echo "$domain is already blocked."
  fi
}

# Function to unblock a website
unblock_website() {
  local domain="$1"
  
  # Check if the domain is blocked
  if grep -q "$domain" /etc/hosts; then
    # Remove the block from the /etc/hosts file
    sudo sed -i '' "/$domain/d" /etc/hosts
    
    # Flush the DNS cache
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    
    echo "$domain has been unblocked."
  else
    echo "$domain is not currently blocked."
  fi
}

# Check if the user wants to block or unblock a site
case "$1" in
  --block)
    if [ -z "$2" ]; then
      echo "Usage: $0 --block domain"
      exit 1
    fi
    block_website "$2"
    ;;
  
  --unblock)
    if [ -z "$2" ]; then
      echo "Usage: $0 --unblock domain"
      exit 1
    fi
    unblock_website "$2"
    ;;
  
  *)
    echo "Usage: $0 --block domain OR $0 --unblock domain"
    exit 1
    ;;
esac
