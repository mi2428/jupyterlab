FROM jupyter/datascience-notebook:lab-2.2.8
MAINTAINER mi2428 <tmiya@protonmail.ch>

ARG JUPYTER_VERSION="2.2.8"

ENV TZ=Asia/Tokyo

WORKDIR /home/jovyan
USER root

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install \
        jupyterlab==${JUPYTER_VERSION} \
        autopep8 \
        jupyterlab_code_formatter \
        jupyterlab-git

RUN jupyter labextension install \
        @oriolmirosa/jupyterlab_materialdarker \
        @mohirio/jupyterlab-horizon-theme \
        @wallneradam/custom_css \
        @lckr/jupyterlab_variableinspector \
        @jupyterlab/toc \
        @ryantam626/jupyterlab_code_formatter \
        @jupyterlab/git \
        @axlair/jupyterlab_vim

RUN jupyter serverextension enable --py \
        jupyterlab \
        jupyterlab_code_formatter \
        jupyterlab_git

COPY jupyter_notebook_config.py .jupyter/jupyter_notebook_config.py
COPY user-settings .jupyter/lab/user-settings

RUN chown -R jovyan:users .jupyter

USER jovyan
WORKDIR /home/jovyan/work

CMD jupyter lab

