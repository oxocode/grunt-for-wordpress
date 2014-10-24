#! /bin/bash
#
# Install Grunt, Git, and 10up WordPress Grunt scripts.
#
#

if [ "Darwin" == `uname -s` ] # Detect Mac OS
then
	## Mac

	# Install Homebrew package manager
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# Node (Update in case it already exists)
	brew install node; brew upgrade node

	# Grunt
	sudo npm install -g grunt-cli
	sudo npm install -g grunt-init

	# Git and git-flow
	brew install git; brew update git
	brew install git-flow; brew update git-flow

	# 10up Grunt scripts
	# Run as sub-commands so script continues if they already exist
	$(git clone git@github.com:10up/grunt-wp-theme.git ~/.grunt-init/wp-theme)
	$(git clone git@github.com:10up/grunt-wp-plugin.git ~/.grunt-init/wp-plugin)

elif [ "MINGW32_NT" == "$(expr substr $(uname -s) 1 10)" ] # Detect Windows
then

	## Windows

	# Check if Node exists
	echo "Checking for Node version ${NODE_VERSION}"
	ls | grep node
	if [[ $? != 0 ]] ; then
	    echo "Node not installed. Visit: http://nodejs.org/download/"
	else
	    # Check if Node Package Manager exists
	    echo "Checking for NPM version ${NPM_VERION}"
        	    npm --version | grep ${NPM_VERSION}
      	    if [[ $? != 0 ]] ; then
    		echo "Downloading npm"
    		git clone git://github.com/isaacs/npm.git && cd npm
    		git checkout v${NPM_VERSION}
    		make install
	    fi
	# Upgrade Node Package Manager
	npm cache clean; npm update

	# Grunt
	npm install -g grunt-cli --save-dev
	npm install -g grunt-init --save-dev

	# Cygwin is the best git installer for Windows. That will need to be done manually.
	# Check if git is installed.
	git --version 2>&1 >/dev/null
	GIT_IS_AVAILABLE=$?
	if [ $GIT_IS_AVAILABLE -eq 0 ]; then # if git is available
	# Git-flow
	wget -q -O - --no-check-certificate https://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh | bash

	# 10up Grunt scripts
	# Run as sub-commands so script continues if they already exist
	$(git clone git@github.com:10up/grunt-wp-theme.git ~/.grunt-init/wp-theme)
	$(git clone git@github.com:10up/grunt-wp-plugin.git ~/.grunt-init/wp-plugin)

	fi # git is available
fi
else
	## Not Mac or Windows

	echo 'Only Mac OS & Windows are supported right now.'

	# Detect Linux
	# Some Linux package managers

    	# Install the things
	# Get latest Nodejs version
	# VERSION=$(curl http://nodejs.org/download/ | grep 'Current version:' | grep -o "v[0-9]\+.[0-9]\+.[0-9]\+")

	# Check if Linux is 64 or 32 bit
	# if [ $(uname -m | grep '64' | wc -l) == 1 ]; then
	#   FILENAME="node-${VERSION}-linux-x64.tar.gz"
	# else
    	#   FILENAME="node-${VERSION}-linux-x86.tar.gz"
	# fi
	# wget "http://nodejs.org/dist/${VERSION}/${FILENAME}"
	# tar -zxf "${FILENAME}" -C /usr/local/ --strip-components=1
	# rm -f "${FILENAME}"
	# if [ $(node -v | grep $VERSION | wc -l) == 1 ]; then
    	#   echo "Upgrade successful $VERSION"
	# fi

	# Upgrade Node
	# npm cache clean; npm update -g

	# Grunt
	# npm install grunt-cli
	# npm install grunt-init

    	# 10up Grunt scripts
	# Run as sub-commands so script continues if they already exist
	# $(git clone git@github.com:10up/grunt-wp-theme.git ~/.grunt-init/wp-theme)
	# $(git clone git@github.com:10up/grunt-wp-plugin.git ~/.grunt-init/wp-plugin)

fi
