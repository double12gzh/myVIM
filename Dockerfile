FROM centos:centos8

WORKDIR /root

COPY vimrc /root/.vimrc
COPY zshrc /opt/zshrc

ARG GOVERSION=1.15.2
ARG PYTHONVERSION=python36

ARG USR_LOCAL_PATH="/usr/local"
ARG GO_PATH="/root/.go"
ARG GO_ROOT="${USR_LOCAL_PATH}/go"
ARG GO_PROXY="http://goproxy.cn"

ENV LANG C.UTF-8
ENV GOPATH=${GO_PATH}
ENV GOROOT=${GO_ROOT}
ENV GOPROXY=${GO_PROXY}
ENV GO111MODULE=on

ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

RUN yum clean all && yum makecache  && \
    yum install -y ${PYTHONVERSION}.x86_64  \
    git                             \
    ctags                           \
    gcc                             \
    make                            \
    ncurses                         \
    ncurses-devel                   \
    ${PYTHONVERSION}-devel.x86_64   \
    cmake                           \
    zsh                             \
    highlight.x86_64                \
    curl                            \
    gcc-c++                         && \
    curl -sfL https://direnv.net/install.sh | bash || true && \
    git clone https://github.com/vim/vim.git /root/vim  && \
    cd /root/vim && ./configure --with-features=huge --enable-multibyte --enable-pythoninterp --enable-python3interp && make && make install && \
    yum install -y wget && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    mkdir -p /root/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim /root/.vim/bundle/Vundle.vim && \
    wget https://studygolang.com/dl/golang/go${GOVERSION}.linux-amd64.tar.gz -O /root/go${GOVERSION}.linux-amd64.tar.gz && \
    tar -xzvf /root/go${GOVERSION}.linux-amd64.tar.gz -C ${USR_LOCAL_PATH} && \
    cp -rf /opt/zshrc /root/.zshrc                      && \
    echo "export GOPATH=${GO_PATH}" >> /root/.zshrc     && \
    echo "export GOROOT=${GO_ROOT}" >> /root/.zshrc     && \
    echo "export GOPROXY=${GO_PROXY}" >> /root/.zshrc   && \
    echo "export GO111MODULE=on" >> /root/.zshrc        && \
    echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> /root/.zshrc && \
    export GOPATH=${GO_PATH}                            && \
    export GOROOT=${GO_ROOT}                            && \
    export GOPROXY=${GO_PROXY}                          && \
    export GO111MODULE=on                               && \
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin           && \
    git clone https://github.com/Valloric/YouCompleteMe.git /root/.vim/bundle/YouCompleteMe && \
    cd /root/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && python3 install.py --clang-completer --go-completer && \
    vim +PluginInstall +qall > /dev/null && vim +GoInstallBinaries +qall > /dev/null && \
    go get -u -v github.com/jstemmer/gotags             && \
    cd /root && yum remove -y wget && rm -rf /root/go${GOVERSION}.linux-amd64.tar.gz && rm -rf /root/vim && rm -rf /root/.dircolors && touch /root/.dircolors