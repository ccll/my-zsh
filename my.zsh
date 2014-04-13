ZSH_THEME="af-magic"
plugins=(git brew virtualenv bower cabal common-aliases node npm per-directory-history pip pod python sublime)

# alias
OS=`uname`
if [[ "$OS" == "Darwin" ]]; then
    alias ls="ls -aFG"
    alias ll="ls -alhFG"
elif [[ "$OS" == "Linux" ]]; then
    alias ls="ls -aF --color"
    alias ll="ls -alhF --color"
fi
alias em="emacs"

# Docker helpers
docker-rename-image () {
    docker tag $1 $2 && docker rmi $1
}
docker-purge-images () {
    docker rmi $(docker images | grep '^<none>' | awk '{print $3}')
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

