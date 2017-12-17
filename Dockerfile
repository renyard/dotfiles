FROM ubuntu:xenial

COPY ./ /root/dotfiles/

RUN apt-get update -y && \
    apt-get install -y build-essential cmake curl git ncurses-dev python python-dev tmux zsh

RUN chsh -s /bin/zsh

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

RUN git clone https://github.com/vim/vim.git && cd vim && \
    ./configure && make && make install

RUN cd ~/dotfiles && \
    DOTFILES=/root/dotfiles ./install.sh
