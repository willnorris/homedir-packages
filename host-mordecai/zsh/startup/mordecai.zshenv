# vim: ft=zsh

# Homebrew
export HOMEBREW_HOME=/opt/homebrew
path=($HOMEBREW_HOME/bin $HOMEBREW_HOME/sbin $path)
manpath=($HOMEBREW_HOME/man $HOMEBREW_HOME/share/man $manpath)

export RBENV_ROOT=$HOMEBREW_HOME/var/rbenv

path=($HOME/Projects/jekyll/bin $path)

# Android Developer Tools
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK=$ANDROID_HOME
path=($ANDROID_HOME/tools $ANDROID_HOME/platform-tools $path)

# Go
path=(/usr/local/go/bin $path)
export GOPATH=$HOME
path=($(go env GOPATH)/bin $(go env GOROOT)/bin $path)

path=($GOPATH/src/camlistore.org/bin $path)

export LYNX_CFG=$HOME/.lynx.cfg
