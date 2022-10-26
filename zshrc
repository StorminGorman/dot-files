# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/bgorman/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH=$PATH:/Users/bgorman/development/flutter/bin
export PATH="$PATH":"$HOME/.pub-cache/bin":"$HOME/.local/bin"
export PATH=$PATH:/usr/local/bin
export LSCOLORS=Gxfxcxdxcxegedabagacad

export IDF_PATH=$HOME/development/esp-idf

alias pull="docker-compose pull"
alias up="docker-compose up"
alias down="docker-compose down"
alias ip="ifconfig | grep \"^.*inet.*broadcast.*$\" | sed \"s/.*inet //g\" | sed \"s/ netmask.*$//g\""
alias cleanDart="rm -rf .dart_tool && rm **/*.g.dart && pub get"
#alias git=/usr/local/bin/git
alias devvpn='sudo route -nv add -net 192.168.10.0/24 -interface ppp0'
alias setupesp='. $HOME/development/esp/esp-idf/export.sh'
alias buildesp='idf.py build'
alias configesp='idf.py menuconfig'
alias flash='idf.py flash'
alias monitor='idf.py monitor'
alias portcmd='echo lsof -i :80'
alias kubefwd='sudo kubectl port-forward -n dev --address 0.0.0.0 svc/postgres 5432 & sudo kubectl port-forward -n dev --address 0.0.0.0 svc/apache 80'
alias devdocker='ssh brian@dev-docker.internal.booksys.com'
alias db='docker exec -it apacheandpostgres_postgres_1 psql premade'
alias html='cd AtriuumData && npm run build:notest && cd ..'
alias vim=/opt/homebrew/bin/vim
alias hi="find ~/development/bsi/workspace | fzf-tmux -m --print0 | xargs -0 -o vim"

# kubectl create secret docker-registry gcr-json-key --docker-server=https://us.gcr.io --docker-username=_json_key --docker-password="$(cat pullkey3.json)" --docker-email=brian@gorbotics.com 
# kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gcr-json-key"}]}' 

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export GOOGLE_APPLICATION_CREDENTIALS=/Users/bgorman/development/keys/current.json
export CDPATH=.:~/work:/Users/bgorman/development/gorbotics:~/work/portico/client/patron:~/work/portico/client/librarian:~/work/portico/client:~/development/bsi:~/work/AtriuumBuild/AtriuumData/dart

export PATH=/Users/bgorman/.pgo/pgo:$PATH:/opt/homebrew/bin:~/.
export PGOUSER=/Users/bgorman/.pgo/pgo/pgouser
export PGO_CA_CERT=/Users/bgorman/.pgo/pgo/client.crt
export PGO_CLIENT_CERT=/Users/bgorman/.pgo/pgo/client.crt
export PGO_CLIENT_KEY=/Users/bgorman/.pgo/pgo/client.key
export PGO_APISERVER_URL='https://127.0.0.1:8443'
export PGO_NAMESPACE=pgo

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bgorman/development/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bgorman/development/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bgorman/development/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bgorman/development/google-cloud-sdk/completion.zsh.inc'; fi

nvm use 16
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export DEV_HOME=~/development
export BSI_HOME=$DEV_HOME/bsi
export BSI_WORKSPACE_HOME=$BSI_HOME/workspace
export ATRIUUM_HOME=$BSI_WORKSPACE_HOME/AtriuumBuild
