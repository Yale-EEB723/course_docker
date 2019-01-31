FROM rocker/geospatial:3.5.1

ARG arg_minicondaversion=4.5.11
ARG arg_gitlfsversion=2.6.0

ENV minicondaversion=${arg_minicondaversion}
ENV gitlfsversion=${arg_gitlfsversion}
ENV condaprefix=/opt/conda
ENV CONDA_ENVS_PATH=${condaprefix}/envs

# install git LFS
RUN wget --quiet https://github.com/git-lfs/git-lfs/releases/download/v${gitlfsversion}/git-lfs-linux-amd64-v${gitlfsversion}.tar.gz && \
    tar xvf git-lfs-linux-amd64-v${gitlfsversion}.tar.gz \
        -C /usr/local/bin/ \
        git-lfs && \
    rm git-lfs-linux-amd64-v${gitlfsversion}.tar.gz

# install miniconda
RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-${minicondaversion}-Linux-x86_64.sh && \
    /bin/bash Miniconda3-${minicondaversion}-Linux-x86_64.sh -f -b -p ${condaprefix} && \
    rm Miniconda3-${minicondaversion}-Linux-x86_64.sh

ENV PATH=${condaprefix}/bin:$PATH

RUN conda install -y anaconda=2018.12-py37_0 && conda clean -tipsy