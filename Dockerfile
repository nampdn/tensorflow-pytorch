FROM ubuntu:bionic

USER root

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y wget software-properties-common curl

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda2-2019.10-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc


RUN conda create -n tf python=3.6 tensorflow jupyter

RUN apt-get install -y tmux vim htop tmux zsh git zip unzip

RUN /bin/sh -c "conda update conda && conda init zsh"
RUN /bin/zsh -c "source /root/.zshrc && conda activate tf"
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && \
   sh ~/.vim_runtime/install_awesome_vimrc.sh

EXPOSE 8888

ENTRYPOINT ["/bin/zsh", "-c"]
CMD ["export SHELL=/bin/zsh && conda init zsh && source /root/.zshrc && conda activate tf && jupyter notebook --no-browser --port=8888 --ip=0.0.0.0 --allow-root --config=/root/.jupyter/jupyter_notebook_config.json"]
