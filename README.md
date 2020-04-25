# jupyterlab ![GitHub CI/CD](https://github.com/mi2428/jupyterlab/workflows/GitHub%20CI/CD/badge.svg)

Ready to run docker image of [JupyterLab](https://github.com/jupyterlab/jupyterlab) based on [jupyter/base-notebook](https://hub.docker.com/r/jupyter/base-notebook/) installing some additional libraries.

## Getting started

Login password is `changeme`. Start container with `docker-compose.yml` or type the following:

```
% docker run --rm -p 8888:8888 -v $PWD:/home/jovyan/work docker.pkg.github.com/mi2428/jupyterlab/jupyterlab:latest
```

## License

Released under the [MIT License](LICENSE)
