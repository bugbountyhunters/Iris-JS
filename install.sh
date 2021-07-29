#!/bin/bash

# Script works in current directory

# https://golang.org/doc/install#install

export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$HOME/go/bin:$HOMEDIR/go/bin
third_party_go_dependencies(){
    gotools[0]="go get -v -u github.com/lc/gau"
    gotools[1]="go get -v -u github.com/tomnomnom/hacks/anti-burl"
    gotools[2]="go get -v -u github.com/ffuf/ffuf"


    echo "Installing Go tools"
    for gotool in "${gotools[@]}"; do
    #TOOL= echo "$gotool" | cut -d '/' -f3
    $gotool
    done
}
third_party_python_dependencies(){
    pytools[0]="git clone https://github.com/GerbenJavado/LinkFinder"
    pytools[1]="git clone  https://github.com/m4ll0k/Bug-Bounty-Toolz"
    pytools[2]="git clone https://github.com/m4ll0k/SecretFinder"

    echo "Installing Python Tools"
    for pytools in "${pytools[@]}";do
    $pytools
    done
}

main(){
third_party_go_dependencies
third_party_python_dependencies
}
main
