FROM rocker/geospatial:3.5.1

ARG arg_minicondaversion=4.5.12
ARG arg_gitlfsversion=2.6.0

ENV minicondaversion=${arg_minicondaversion}
ENV gitlfsversion=${arg_gitlfsversion}
ENV condaprefix=/opt/conda
ENV CONDA_ENVS_PATH=${condaprefix}/envs

RUN apt-get update && apt-get install time

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

RUN conda install -c bioconda -y biopython=1.72 \
                                 bowtie2=2.3.4.3 \
                                 gatk4=4.1.0.0 \
                                 jupyter=1.0.0 \
                                 matplotlib=3.0.2 \
                                 picard=2.18.26 \
                                 pandas=0.24.1 \
                                 samtools=1.9 \
                                 scipy=1.2.0 \
                                 sra-tools=2.9.1_1 \
                      && \
    conda clean -tipsy
