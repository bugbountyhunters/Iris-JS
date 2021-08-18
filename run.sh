#!/bin/bash

# Declaring Vars
LINKFINDER=$(pwd)/LinkFinder/linkfinder.py
SECRETFINDER=$(pwd)/SecretFinder/SecretFinder.py
COLLECTOR=$(pwd)/Bug-Bounty-Toolz/collector.py
AVAILABLE=$(pwd)/Bug-Bounty-Toolz/availableForPurchase.py
OUTPUT=$(pwd)/jsrez
TARGET=$1

if [ $# -eq 0 ]; then
    echo "Error"
    usage
    exit 1
    fi

## Starting Gau ###
getallurls(){
    echo "[+] Starting Gau" ; gau $TARGET |grep -iE '.(\.json$|\.js$)' | sort -u | tee -a "$OUTPUT/$TARGET-JS.txt"
    }

anti-burl(){
    ~/go/bin/anti-burl "$OUTPUT/$TARGET-JS.txt" | awk -F ' ' '{print $4}' | tee -a "$OUTPUT/$TARGET-JSAlive.txt"
}
findlinks(){
   ## cat paypalJS.txt|xargs -n2 -I @ bash -c 'echo -e "\n[URL] @\n";python3 linkfinder.py -i @ -o cli' >> paypalJsSecrets.txt
    echo "[+] Starting Linkfinder" ; for link in $(cat "$OUTPUT/$TARGET-JSAlive.txt"); do echo "[+] URL $link" ; python3 $LINKFINDER -i $link -o cli | grep -oiaE "https?://[^\"\\'> ]+" ;done | tee -a "$OUTPUT/$TARGET-JSPathsWithUrl-Unfiltered.txt"
    cat "$OUTPUT/$TARGET-JSPathsWithUrl-Unfiltered.txt" | grep -v "[+]" >> "$OUTPUT/$TARGET-JSPathsWithUrl.txt"
    cat "$OUTPUT/$TARGET-JSPathsWithUrl.txt" | grep -iv '[URL]:' || sort -u | tee -a "$OUTPUT/$TARGET-JSPathsNoUrl.txt"
}
collector(){
    echo "[+] Parsing to Collector" ; for link in $(cat "$OUTPUT/$TARGET-JSAlive.txt");do python3 $LINKFINDER -i $link -o cli;done | python3 $COLLECTOR output
}
available(){
    echo "[+] Available for purchase" ; cat output/urls.txt | python3 $AVAILABLE
}
secret(){
    echo "[+] Running SecretFinder" ; for link in $(cat "$OUTPUT/$TARGET-JSAlive.txt"); do python3 $SECRETFINDER -i $link -o cli;done | tee -a "$OUTPUT/$TARGET-Secrets.txt"
}
logo(){
echo "[+] Javascript Recon Process on $TARGET"
}
usage(){
    echo "./run.sh target"
}
main(){

    logo
    getallurls
    anti-burl
    findlinks
    secret
    collector
    available
}

main
exit 0