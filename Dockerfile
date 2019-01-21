# Dockerfile generated on 2019-01-19 19:26:37.060641
# Name: R Tidyverse (+ Python3) in Jupyter Quickstart
# Description: A JupyterLab install for CRAN PPA R + tidyverse packages, etc.

FROM gigantum/r-tidyverse:a7dc69c7-2018-09-13
## Adding individual packages
RUN apt-get -y update
RUN apt-get -y --no-install-recommends install libomp-dev
RUN pip install nest_asyncio==0.9.10
# Custom docker snippets
# Custom Docker: user-custom-docker - 4line(s) - (Created 2019-01-16T16:46:51.410895)
RUN conda install xeus-cling notebook openmp -c QuantStack -c conda-forge
RUN sed -i 's/"-std=c++11"/"-std=c++11"\,\n      "-fopenmp"/' /opt/conda/share/jupyter/kernels/xeus-cling-cpp11/kernel.json
RUN sed -i 's/"-std=c++14"/"-std=c++14"\,\n      "-fopenmp"/' /opt/conda/share/jupyter/kernels/xeus-cling-cpp14/kernel.json
RUN sed -i 's/"-std=c++17"/"-std=c++17"\,\n      "-fopenmp"/' /opt/conda/share/jupyter/kernels/xeus-cling-cpp17/kernel.json

ENV NB_USER gigantum
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}

# Remove gigantum specific items
ENTRYPOINT []
ENV JUPYTER_RUNTIME_DIR=${HOME}/jupyter

# run user in home directory
USER ${NB_USER}
WORKDIR ${HOME}
