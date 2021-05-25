FROM jupyter/datascience-notebook:lab-2.2.8
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"

ARG JUPYTER_VERSION="2.2.8"
ARG JUPYTER_LSP_VERSION="2.1.4"

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV TZ Asia/Tokyo
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

USER jovyan
WORKDIR /home/jovyan

COPY requirements.txt requirements.txt
COPY pip.conf .config/pip/pip.conf
COPY keyringrc.cfg .confg/python_keyring/keyringrc.cfg

RUN pip install --verbose --upgrade keyring pip \
 && pip install --verbose -r requirements.txt \
 && pip install --verbose \
        jupyterlab==${JUPYTER_VERSION} \
        jupyter-lsp \
        'python-language-server[all]' \
        xeus-python \
        ptvsd \
        ansible \
        autopep8 \
        flake8 \
        pycodestyle \
        pycodestyle_magic \
        jupyterlab_code_formatter \
        # jupyterlab-git \  # Suspended
        jupyterlab_latex \
        ipywidgets

RUN jupyter labextension install \
        @jupyterlab/toc \
        @jupyterlab/debugger \
        # @jupyterlab/git \     # Suspended
        # @jupyterlab/github \  # Suspended
        @jupyterlab/latex \
        @axlair/jupyterlab_vim \
        @krassowski/jupyterlab-lsp@${JUPYTER_LSP_VERSION} \
        @krassowski/jupyterlab_go_to_definition \
        @lckr/jupyterlab_variableinspector \
        @lckr/jupyterlab_variableinspector \
        @oriolmirosa/jupyterlab_materialdarker \
        @mohirio/jupyterlab-horizon-theme \
        @wallneradam/custom_css \
        @ryantam626/jupyterlab_code_formatter \
        @ijmbarr/jupyterlab_spellchecker \
        @aquirdturtle/collapsible_headings \
        jupyterlab-drawio

RUN jupyter serverextension enable --py \
        jupyterlab \
        jupyterlab_code_formatter
        # jupyterlab_git  # Suspended

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        build-essential software-properties-common ca-certificates nodejs \
        cmake gnupg fonts-noto-cjk libtool libffi-dev libzmq3-dev libczmq-dev \
        iproute2 iputils-ping net-tools dnsutils openssh-client telnet \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh
RUN echo "jovyan ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jovyan

RUN npm install -g \
        zeromq \
        ijavascript \
 && ijsinstall

COPY jupyter_notebook_config.py .jupyter/jupyter_notebook_config.py
COPY user-settings .jupyter/lab/user-settings

WORKDIR /home/jovyan/work

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
