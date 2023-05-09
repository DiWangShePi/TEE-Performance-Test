#!/bin/bash
  
# For dedup
#sudo apt-get install locales
#sudo locale-gen en_US.UTF-8
#sudo update-locale LANG=en_US.UTF-8
cd parsec-3.0/pkgs/libs/ssl/src/doc/apps
sed -i.bak 's/item \([0-9]\+\)/item C<\1>/g' *
cd ../ssl
sed -i.bak 's/item \([0-9]\+\)/item C<\1>/g' *
cd ../../../../../../..


# For ferret
grep -rl "HUGE" parsec-3.0/pkgs/apps/ferret | xargs sed -i "s/HUGE/DBL_MAX/g"
grep -rl "HUGE" parsec-3.0/pkgs/netapps/netferret | xargs sed -i "s/HUGE/DBL_MAXX/g"

# For swaptions
sudo apt-get install libtbb-dev pkg-config -y
source /etc/profile

# For vips
apt-get install gettext -y

# For raytrace
apt-get install libx11-dev libxext-dev libxt-dev libxmu-dev libxi-dev -y