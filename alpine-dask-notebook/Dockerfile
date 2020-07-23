ARG BUILD_FROM
FROM $BUILD_FROM

ARG NOTEBOOK_VERSION
ARG JUPYTERLAB_VERSION=2.1.5

ARG DASKLABEXTENSION_VERSION=2.0.2
ARG JUPYTERLAB_MANAGER_VERSION=2.0.0

# Does the following in one layer
# - Installs jupyter notebook and jupyter lab, with dependencies
# - Installs the dask labextension
# - Cleans up after building the dask labextension
# - Uninstalls transient nodejs dependency
# - Cleans up conda files
# - Removes unnecessary static libraries
# - Removes unnecessary *.pyc files
# - Removes unnecessary *.js.map files
RUN export PATH="/opt/conda/bin/:$PATH" \
    && conda install --freeze-installed -y \
    notebook==${NOTEBOOK_VERSION} \
    jupyterlab=${JUPYTERLAB_VERSION} \
    ipywidgets \
    nodejs \
    && pip install dask-labextension==${DASKLABEXTENSION_VERSION} --no-cache-dir --no-dependencies \
    && jupyter labextension install \
    @jupyter-widgets/jupyterlab-manager@${JUPYTERLAB_MANAGER_VERSION} \
    dask-labextension@${DASKLABEXTENSION_VERSION} \
    && npm cache clean --force \
    && rm -rf /opt/conda/share/jupyter/lab/staging \
    && rm -rf /home/anaconda/.cache/yarn \
    && conda uninstall nodejs -y \
    && conda clean -afy \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete


COPY --chown=anaconda:anaconda jupyter_notebook_config.py /etc/jupyter/

CMD ["jupyter", "lab"]
