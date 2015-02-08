#!/bin/bash -e
#
clear
echo " "
echo "                   ..,;cloudPaaSRHOS:,.." && echo "               .;lxxxxxxxxxxxxxxxxxxxxxxo:." && echo "            .cxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxl'" && echo "          ,dxxxxxxxxxxxdlc:;;;;:cldxxxxxxxxxxxx;  .." && echo "        'dxxxxxxxxxo;.              .,lxxxxxxkkkxdkkkl" && echo "       cxxxxxxxxx;.                     '.. .ckkkdl:,." && echo "      lxxxxxxxx:                           .',o;" && echo "     ;xxxxxxxx,                        ,ldxxxxxx." && echo "     xxxxxxxx:                          lxxxxxxxd" && echo "    .xxxxxkkklldo                       .xxxxxxxx;.,:," && echo "    .:,.lkkkkkkdc                        dl::kkkkkkkk;" && echo "        .d:,..                              ;kkkkkxxx." && echo "  ..,:ldxl                                 .xxxxxxxxl" && echo " .xxxxxxxxl                               ;xxxxxxxxd" && echo "  'xxxxxxxxd'  ..,.                     ;dxxxxxxxxl" && echo "   .oxxdodxkkxkkkkkd:.              .;oxxxxxxxxxx," && echo "     .    ,dkkkkxxxxxxxxoc:;;;;:codxxxxxxxxxxxx;" && echo "            .:dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxc'" && echo "               .,ldxxxxxxxxxxxxxxxxxxxxxl;." && echo "                    .';:looddddoolc;,.."
echo " "
read -p "Humm. This Script Will Install OctoPress on OpenShift. Hit Y or N " -n 1 -r
echo "For DRY run, disconnect Internet Connection and run without SUDO privilege."
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "Run this script in a separate new Terminal Window with Sudo Privilege"
echo "You can get sudo privilege by running :"
echo "sudo su"
fi
echo " "
echo "Run this command in a separate new Terminal Window with Sudo Privilege"
echo " "
echo "\x1B[36mrhc app create octopress ruby-1.9\x1B[0m"
echo "(or create a Ruby-1.9 App named octopress from Web Control Panel)"
echo " "
echo "+++++"
echo "+"
echo "+  You must have installed git, ruby and ruby-dev beforehand."
echo "+"
echo "+  If you are not ready, close this window"
echo "+  and again run this script after the needed things installed."
echo "+  Uncomment #1 and #2 inside the script, if you are using OS X"
echo "+  Do not run from iTerm2 in case of OS X, use Terminal"
echo "+ "
echo "+  We Will Not Check for Errors. Script Will Run of its Own."
echo "+  THIS SCRIPT HAS NO TIMEOUT. BE LAZY TO COPY THE SSH URL."
echo "+  DR. ABHISHEK GHOSH CREATED THIS THING and Released Under GNU GPL 3.0"
echo "+"
echo "++++++"
echo " "
read -p "Read the instruction? Y will proceed, N will Quit " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "Copy Paste the git URL from the Git remote URL from OpenShift Panel for octopress App which looks like:"
echo "\x1B[36mssh://548e1873e0b8cddccf000094@octopress-username.rhcloud.com/~/git/octopress.git/\x1B[0m"
read key
fi

RUBY_VERSION=1.9.3-p448

#sudo brew update #1
#sudo brew install git ruby ruby-dev #2
#sudo rm -rf octopress #3
git clone git://github.com/imathis/octopress.git octopress && cd octopress
sudo gem install bundler
rbenv rehash
bundle install
rake install
cd ..
mkdir _deployment && cd _deployment
cp ../octopress/config.ru .
cp ../octopress/Gemfile .
bundle install
mkdir public/
git init .
git remote add openshift $key
git add .
git commit -am 'initial deploy'
cd ..
mv _deployment octopress
cd octopress
git add _deployment/
echo "Depending on your environment, use bundle exec"
echo "Edit and save the file in source/_posts/2015-02-09-Hello-World.markdown"
echo "Proceed? Y/N"
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
rake new_post['Hello World'] 
echo "sudo su"
fi
rake generate
rm -rf _deployment/public/*
cp -R public/* _deployment/public/
cd _deployment
git add .
git commit -am 'New blog post'
git push openshift master --force
echo " "
finish=`date "+%Y-%m-%d-%H-%M-%S"`
echo "Deployment at $key completed at ${finish}"
echo " "
echo "Visit our Website:"
echo "https://thecustomizewindows.com"
echo "Can not Remember? OK, this one:"
echo "JiMA.in"
echo " "
echo "Check whether OctoPress is actually running..."
echo " "
read -p "OK. This Script Will Quit. That is Desired. Hit Y or N " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
exit
fi
