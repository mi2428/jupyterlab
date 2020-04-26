FROM jupyter/base-notebook:lab-2.0.1
MAINTAINER mi2428 <tmiya@protonmail.ch> 

ENV TZ=Asia/Tokyo

COPY requirements.txt requirements.txt
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN pip install --upgrade jupyterlab
RUN jupyter labextension install \
        @axlair/jupyterlab_vim
RUN jupyter serverextension enable --py jupyterlab

COPY jupyter_notebook_config.py $HOME/.jupyter/jupyter_notebook_config.py

CMD jupyter lab

