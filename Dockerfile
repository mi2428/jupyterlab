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
        jupyterlab-git \
        jupyterlab_latex \
        ipywidgets

RUN jupyter labextension install @krassowski/jupyterlab-lsp@${JUPYTER_LSP_VERSION}
RUN jupyter labextension install @jupyterlab/toc
RUN jupyter labextension install @jupyterlab/debugger
RUN jupyter labextension install @jupyterlab/git
RUN jupyter labextension install @jupyterlab/github
RUN jupyter labextension install @jupyterlab/latex
RUN jupyter labextension install @axlair/jupyterlab_vim
RUN jupyter labextension install @krassowski/jupyterlab_go_to_definition
RUN jupyter labextension install @lckr/jupyterlab_variableinspector
RUN jupyter labextension install @lckr/jupyterlab_variableinspector
RUN jupyter labextension install @oriolmirosa/jupyterlab_materialdarker
RUN jupyter labextension install @mohirio/jupyterlab-horizon-theme
RUN jupyter labextension install @wallneradam/custom_css
RUN jupyter labextension install @ryantam626/jupyterlab_code_formatter
RUN jupyter labextension install @ijmbarr/jupyterlab_spellchecker
RUN jupyter labextension install @aquirdturtle/collapsible_headings
RUN jupyter labextension install jupyterlab-drawio

# RUN jupyter labextension install \
#         @jupyterlab/toc \
#         @jupyterlab/debugger \
#         @jupyterlab/git \
#         @jupyterlab/github \  # deprecated
#         @jupyterlab/latex \
#         @axlair/jupyterlab_vim \
#         @krassowski/jupyterlab-lsp@${JUPYTER_LSP_VERSION} \
#         @krassowski/jupyterlab_go_to_definition \
#         @lckr/jupyterlab_variableinspector \
#         @lckr/jupyterlab_variableinspector \
#         @oriolmirosa/jupyterlab_materialdarker \
#         @mohirio/jupyterlab-horizon-theme \
#         @wallneradam/custom_css \
#         @ryantam626/jupyterlab_code_formatter \
#         @ijmbarr/jupyterlab_spellchecker \
#         @aquirdturtle/collapsible_headings \
#         jupyterlab-drawio \

RUN jupyter serverextension enable --py \
        jupyterlab \
        jupyterlab_code_formatter
        # jupyterlab_git

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        build-essential software-properties-common ca-certificates nodejs \
        cmake gnupg fonts-noto-cjk libtool libffi-dev libzmq3-dev libczmq-dev \
        iproute2 iputils-ping net-tools dnsutils openssh-client telnet \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER jovyan

RUN npm install -g \
        zeromq \
        ijavascript \
 && ijsinstall

RUN conda clean --all -f -y \
 && rm -rf \
       $CONDA_DIR/share/jupyter/lab/staging \
       /home/jovyan/.cache/yarn \
 && fix-permissions $CONDA_DIR \
 && fix-permissions /home/jovyan

COPY jupyter_notebook_config.py .jupyter/jupyter_notebook_config.py
COPY user-settings .jupyter/lab/user-settings

WORKDIR /home/jovyan/work

CMD ["jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
