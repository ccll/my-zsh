ZSH_THEME="af-magic"
plugins=(git brew virtualenv bower cabal common-aliases node npm per-directory-history pip pod python sublime)

# alias
OS=`uname`
if [[ "$OS" == "Darwin" ]]; then
    #alias ls="ls -aFG"
    #alias ll="ls -alhFG"
    alias ls="gls -aF --color=auto --group-directories-first"
    alias ll="gls -alhF --color=auto --group-directories-first"
elif [[ "$OS" == "Linux" ]]; then
    alias ls="ls -aF --color=auto --group-directories-first"
    alias ll="ls -alhF --color=auto --group-directories-first"
fi
alias em="emacs"

# Docker helpers
docker-rename-image () {
    docker tag $1 $2 && docker rmi $1
}
docker-purge-images () {
    docker rmi $(docker images | grep '^<none>' | awk '{print $3}')
}
docker-tag-latest () {
    local image=$(echo $1 | awk -F ':' '{print $1}')
    local tag=$(echo $1 | awk -F ':' '{print $2}')
    if [[ "$tag" == "" ]]; then
        echo "Error: missing tag!"
        return
    fi
    docker tag $1 $image\:latest
}
docker-purge-containers () {
    docker rm $(docker ps -a -q)
}
docker-rm-container () {
    docker kill $1 && docker rm $1
}
docker-ssh () {
    ssh -i ~/dockerfiles/initimage/initimage-key root@$(docker inspect $1 | grep IPAddress | cut -d '"' -f 4)
}

# load local config
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

