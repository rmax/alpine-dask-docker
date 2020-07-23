.PHONY: all alpine-conda alpine-dask alpine-dask-notebook

OWNER ?= rmaxio

# These are versions availble in the default (anaconda) channel.
CONDA_VERSION ?= 4.8.3
DASK_VERSION ?= 2.20.0
NOTEBOOK_VERSION ?= 6.0.3

CONDA_IMAGE = $(OWNER)/alpine-conda
DASK_IMAGE = $(OWNER)/alpine-dask
NOTEBOOK_IMAGE = $(OWNER)/alpine-dask-notebook

all: alpine-conda alpine-dask alpine-dask-notebook

alpine-conda:
	docker build \
	--build-arg CONDA_VERSION=$(CONDA_VERSION) \
	-t $(CONDA_IMAGE):$(CONDA_VERSION) alpine-conda

alpine-dask: alpine-conda
	docker build \
	--build-arg BUILD_FROM=$(CONDA_IMAGE) \
	--build-arg DASK_VERSION=$(DASK_VERSION) \
	-t $(DASK_IMAGE):$(DASK_VERSION) alpine-dask

alpine-dask-notebook: alpine-dask
	docker build \
	--build-arg BUILD_FROM=$(DASK_IMAGE) \
	--build-arg NOTEBOOK_VERSION=$(NOTEBOOK_VERSION) \
	-t $(NOTEBOOK_IMAGE):$(NOTEBOOK_VERSION) alpine-dask-notebook

push:
	docker push $(CONDA_IMAGE):$(CONDA_VERSION)
	docker push $(DASK_IMAGE):$(DASK_VERSION)
	docker push $(NOTEBOOK_IMAGE):$(NOTEBOOK_VERSION)

tag-latest:
	docker tag $(CONDA_IMAGE):$(CONDA_VERSION) $(CONDA_IMAGE):latest
	docker tag $(DASK_IMAGE):$(DASK_VERSION) $(DASK_IMAGE):latest
	docker tag $(NOTEBOOK_IMAGE):$(NOTEBOOK_VERSION) $(NOTEBOOK_IMAGE):latest

push-latest:
	docker push $(CONDA_IMAGE):latest
	docker push $(DASK_IMAGE):latest
	docker push $(NOTEBOOK_IMAGE):latest
