FROM tensorflow/tensorflow:latest-jupyter

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget software-properties-common && \
    add-apt-repository universe && \
    apt-get install -y tmux vim htop tmux zsh git zip unzip && \
    chsh -s $(which zsh)

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && \
   sh ~/.vim_runtime/install_awesome_vimrc.sh

# Install Anaconda
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda2-2019.10-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN conda install pytorch torchvision cpuonly -c pytorch

RUN conda create -n pytorch python=3.6 pytorch=1.3
RUN conda create -n tf python=3.6

EXPOSE 8888
EXPOSE 3000
EXPOSE 22
