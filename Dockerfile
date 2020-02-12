FROM jupyter/tensorflow-notebook:latest

RUN apt-get update --fix-missing && apt-get install -y wget software-properties-common && \
    add-apt-repository universe && \
    apt-get install -y tmux vim htop tmux zsh git zip unzip && \
    chsh -s $(which zsh)

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && \
   sh ~/.vim_runtime/install_awesome_vimrc.sh
   
RUN conda create -n tf python=3.6

