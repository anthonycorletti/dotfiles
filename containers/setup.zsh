cli_plugins=$HOME/.docker/cli-plugins
mkdir -p $cli_plugins
ln -sfn "$(brew --prefix)/bin/docker-compose" $cli_plugins/docker-compose
ln -sfn "$(brew --prefix)/bin/docker-buildx" $cli_plugins/docker-buildx

