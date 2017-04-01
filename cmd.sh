#!/bin/bash
if [ -d /home/site/wwwroot ] && [ ! -e /home/site/wwwroot/hostingstart.html ] 
then
    echo '/home/site/wwwroot'
    cd /home/site/wwwroot
else
    echo '/opt/splash/splash'
    cd /opt/splash/splash
fi

[ -d tmp ] && rm -dr tmp
bundle install
rails db:migrate
rails server