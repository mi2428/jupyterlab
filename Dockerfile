FROM jupyter/datascience-notebook:lab-2.2.8
MAINTAINER mi2428 <tmiya@protonmail.ch>

ARG JUPYTER_VERSION="2.2.8"

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR /home/jovyan
USER root

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#         build-essential software-properties-common nodejs \
#         cmake gnupg fonts-noto-cjk libtool libffi-dev libzmq3-dev libczmq-dev && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install \
        jupyterlab==${JUPYTER_VERSION} \
        powershell_kernel \
        autopep8 \
        jupyterlab_code_formatter \
        jupyterlab-git \
        jupyterlab_latex \
        ipywidgets \
        jupyter-kite

RUN jupyter labextension install \
        @oriolmirosa/jupyterlab_materialdarker \
        @mohirio/jupyterlab-horizon-theme \
        @wallneradam/custom_css \
        @lckr/jupyterlab_variableinspector \
        @jupyterlab/toc \
        @ryantam626/jupyterlab_code_formatter \
        @jupyterlab/git \
        @jupyterlab/github \
        @axlair/jupyterlab_vim \
        @jupyterlab/latex \
        @ijmbarr/jupyterlab_spellchecker \
        jupyterlab-drawio \
        @aquirdturtle/collapsible_headings \
        @krassowski/jupyterlab_go_to_definition \
        @lckr/jupyterlab_variableinspector \
        @kiteco/jupyterlab-kite && \
    jupyter lab build

RUN jupyter serverextension enable --py \
        jupyterlab \
        jupyterlab_code_formatter \
        jupyterlab_git

COPY jupyter_notebook_config.py .jupyter/jupyter_notebook_config.py
COPY user-settings .jupyter/lab/user-settings

RUN chown -R jovyan:users .jupyter

USER jovyan
WORKDIR /home/jovyan/work

# RUN npm install -g \
#         ijavascript \
#         typescript \
#         itypescript @types/node && \
#     ijsinstall && \
#     its --install=global

CMD ["jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
