alias d='docker $*'
alias d-c='docker-compose $*'
alias dockerclean='docker rm $(docker ps -a -q); docker rmi -f $(docker images --quiet --filter "dangling=true"); docker volume rm $(docker volume ls -q -f dangling=true);'
