ARG BUILD_FROM
FROM $BUILD_FROM

ARG DASK_VERSION
ARG NUMPY_VERSION=1.18.5
ARG PANDAS_VERSION=1.0.5

# Does the following in one layer
# - Installs dask and dependencies
# - Cleans up conda files
# - Removes unnecessary static libraries
# - Removes unnecessary *.pyc files
# - Removes unnecessary *.js.map files
# - Removes unminified bokeh js
RUN /opt/conda/bin/conda install --freeze-installed -y \
    dask==${DASK_VERSION} \
    numpy==${NUMPY_VERSION} \
    pandas==${PANDAS_VERSION} \
    nomkl \
    && /opt/conda/bin/conda clean -afy \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && find /opt/conda/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete
