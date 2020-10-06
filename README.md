# jupyterlab ![GitHub CI/CD](https://github.com/mi2428/jupyterlab/workflows/GitHub%20CI/CD/badge.svg)

Ready-to-run docker image of [JupyterLab](https://github.com/jupyterlab/jupyterlab) based on [jupyter/datascience-notebook](https://hub.docker.com/r/jupyter/base-notebook/) with some additional libraries.

### Available kernels

- Python3
- Javascript (NodeJS)
- Julia 1.5.1
- Python3.8 (XPython)
- R

## Getting started

Login password is `changeme`. Launch container with `docker-compose.yml` or type the following:

```
# Fetch from DockerHub
% docker run --rm -p 8888:8888 -v $PWD:/home/jovyan/work mi2428/jupyterlab:latest

# Fetch from GitHub Package Registry
% docker run --rm -p 8888:8888 -v $PWD:/home/jovyan/work docker.pkg.github.com/mi2428/jupyterlab/jupyterlab:latest
```

To deploy using Singularity, the following commands will help:

```
% singularity pull jupyterlab.sif docker://mi2428/jupyterlab:latest
% ./jupyterlab.sif
```

## License

Released under the [MIT License](LICENSE)
