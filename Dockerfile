FROM jupyter/datascience-notebook:lab-2.0.1
MAINTAINER mi2428 <tmiya@protonmail.ch> 

ARG JUPYTER_VERSION="2.1.1"

ENV TZ=Asia/Tokyo

COPY requirements.txt requirements.txt
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN pip install jupyterlab==${JUPYTER_VERSION}
RUN jupyter labextension install \
        @oriolmirosa/jupyterlab_materialdarker \
        @mohirio/jupyterlab-horizon-theme \
        @wallneradam/custom_css \
        @axlair/jupyterlab_vim
RUN jupyter serverextension enable --py jupyterlab
RUN mkdir -p \
        .jupyter/lab/user-settings/@jupyterlab/notebook-extension \
        .jupyter/lab/user-settings/@jupyterlab/shortcuts-extension \
        .jupyter/lab/user-settings/@wallneradam/custom_css

COPY jupyter_notebook_config.py .jupyter/
COPY tracker.jupyterlab-settings .jupyter/lab/user-settings/@jupyterlab/notebook-extension/
COPY shortcuts.jupyterlab-settings .jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/
COPY custom_css/plugin.jupyterlab-settings .jupyter/lab/user-settings/@wallneradam/custom_css/plugin.jupyterlab-settings

CMD jupyter lab

