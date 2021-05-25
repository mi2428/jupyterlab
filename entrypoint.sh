#!/bin/bash

if [[ $USE_LSP == "no" ]]; then
    jupyter labextension disable @krassowski/jupyterlab-lsp
fi

exec $@
