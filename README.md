# Iris-JS

I made this script to automate some of the Task mentioned by [M4ll0k](https://gist.github.com/m4ll0k/31ce0505270e0a022410a50c8b6311ff) 
It will help you gather JS endpoints and look for creds and juicy strings / words

# Installation

After cloning the repo you can run `./install.sh` it will automatically install the dependencies needed and the tools used to perform the recon

```
chmod +x install.sh
./install.sh
```

# Usage

`./run.sh target.com`

# Process
* This will run [getallurls](https://github.com/lc/gau) and find `Json/JS` files
* Check the alive ones only
* Send the to Linkfinder to find `Paths` (can be used to build your own wordlist)
* Pipe all the Collector for better output for `links` `paths` `params` found
* Check which domains are available for purchase 
* Checking secrets with `Secretfinder`

# Contributing
Contributions are very welcome 🙌 🤓


