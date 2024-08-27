# celestia Node

## Setup

Clone required repositories:

```bash
laconic-so --stack celestia-node setup-repositories --pull
```

Checkout to a non-default branch in the cloned repos if required:

```bash
# Default repo base dir
cd ~/cerc

# Set build platform to linux amd64
sed -i 's/\$BUILDPLATFORM/linux\/amd64/' Dockerfile

# Example
cd celestia-node
git checkout <your-branch> && git pull

# Remove the corresponding docker image if it already exists
docker image rm cerc/celestia-node:local
# Remove any dangling images
docker image prune
```

Build the container images:

```bash
laconic-so --stack celestia-node build-containers
```

## Create a deployment

Initialize deployment and create "spec" file:

```bash
laconic-so --stack celestia-node deploy init --output celestia-node-spec.yml
```


```
$ cat celestia-node-spec.yml
stack: celestia-node
network:
  ports:
    celestia-node:
      - '2121:2121'
      - '26658:26658'

```

Create deployment:

```bash
laconic-so --stack celestia-node deploy create --spec-file celestia-node-spec.yml --deployment-dir celestia-node-deployment
```

## Start the stack

Update `config.env` file inside deployment directory with the following values before starting the stack:

```bash
# Set Celestia Consensus RPC endpoint the celestia node will use

# Node type: bridge, full or light
export NODE_TYPE=
# Network: celestia, mocha or arabica
export P2P_NETWORK=
# Celestia consensus RPC endpoint. (Full and Bridge needs access to GRPC)
export RPC_URL=
```

Example `config.env` file:

```bash
# Node type: bridge, full or light
export CEL_NODETYPE=light
# Network: celestia, mocha or arabica
export CEL_NETWORK=celestia
# Celestia consensus RPC endpoint. (Full and Bridge needs access to GRPC)
export RPC_URL=rpc.celestia.pops.one
```

Deploy the stack:

```bash
laconic-so deployment --dir celestia-node-deployment start

# Note: Remove any existing volumes in the cluster for a fresh start
```

After all services have started, follow `celestia-node` logs:

```bash
laconic-so deployment --dir celestia-node-deployment logs -f celestia-node
```


## Clean up

Stop all the services running in background run:

```bash
laconic-so deployment --dir celestia-node-deployment stop
```

Clear volumes created by this stack:

```bash
laconic-so deployment --dir celestia-node-deployment stop --delete-volumes
```
