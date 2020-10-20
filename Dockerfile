FROM jupyter/datascience-notebook:lab-2.2.8
MAINTAINER mi2428 <tmiya@protonmail.ch>

ARG JUPYTER_VERSION="2.2.8"

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR /home/jovyan
USER root

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install \
        jupyterlab==${JUPYTER_VERSION} \
        jupyter-lsp \
        'python-language-server[all]' \
        xeus-python \
        ptvsd \
        ansible \
        autopep8 \
        jupyterlab_code_formatter \
        jupyterlab-git \
        jupyterlab_latex \
        ipywidgets

RUN jupyter labextension install \
        @jupyterlab/toc \
        @jupyterlab/debugger \
        @jupyterlab/git \
        @jupyterlab/github \
        @jupyterlab/latex \
        @axlair/jupyterlab_vim \
        @krassowski/jupyterlab-lsp \
        @krassowski/jupyterlab_go_to_definition \
        @lckr/jupyterlab_variableinspector \
        @lckr/jupyterlab_variableinspector \
        @oriolmirosa/jupyterlab_materialdarker \
        @mohirio/jupyterlab-horizon-theme \
        @wallneradam/custom_css \
        @ryantam626/jupyterlab_code_formatter \
        @ijmbarr/jupyterlab_spellchecker \
        @aquirdturtle/collapsible_headings \
        jupyterlab-drawio && \
    jupyter lab build

RUN jupyter serverextension enable --py \
        jupyterlab \
        jupyterlab_code_formatter \
        jupyterlab_git

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential software-properties-common nodejs \
        cmake gnupg fonts-noto-cjk libtool libffi-dev libzmq3-dev libczmq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jovyan

RUN npm install -g \
        zeromq \
        ijavascript && \
    ijsinstall

USER root

COPY jupyter_notebook_config.py .jupyter/jupyter_notebook_config.py
COPY user-settings .jupyter/lab/user-settings

RUN chown -R jovyan:users .jupyter

#USER jovyan
WORKDIR /home/jovyan/work

CMD ["jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
