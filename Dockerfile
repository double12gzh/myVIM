FROM centos:centos8

WORKDIR /root
COPY vimrc /root/.vimrc

ARG GOVERSION=1.14.4
ARG PYTHONVERSION=python36

ENV LANG C.UTF-8
ENV GOPATH=/root/.go
ENV GOROOT=/usr/local/go
ENV GOPROXY=http://goproxy.cn
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
    gcc-c++                         && \
    git clone https://github.com/vim/vim.git /root/vim  && \
    cd /root/vim && ./configure --with-features=huge --enable-multibyte --enable-pythoninterp --enable-python3interp && make && make install && \
    yum install -y wget && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true && \
    mkdir -p /root/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim /root/.vim/bundle/Vundle.vim && \
    wget https://studygolang.com/dl/golang/go${GOVERSION}.linux-amd64.tar.gz -O /root/go${GOVERSION}.linux-amd64.tar.gz && \
    tar -xzvf /root/go${GOVERSION}.linux-amd64.tar.gz -C /usr/local && \
    echo "export GOPATH=/root/.go" >> /root/.bash_profile && \
    echo "export GOROOT=/usr/local/go" >> /root/.bash_profile && \
    echo "export GOPROXY=http://goproxy.cn" >> /root/.bash_profile && \
    echo "export GO111MODULE=on" >> /root/.bash_profile && \
    echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> /root/.bash_profile  && \
    export GOPATH=/root/.go && \
    export GOROOT=/usr/local/go && \
    export GOPROXY=http://goproxy.cn && \
    export GO111MODULE=on && \
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin && \
    git clone https://github.com/Valloric/YouCompleteMe.git /root/.vim/bundle/YouCompleteMe && \
    cd /root/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && python3 install.py --clang-completer --go-completer && \
    vim +PluginInstall +qall > /dev/null && vim +GoInstallBinaries +qall > /dev/null && \
    go get -u -v github.com/jstemmer/gotags && \
    cd /root && yum remove -y wget git && rm -rf /root/go${GOVERSION}.linux-amd64.tar.gz && rm -rf /root/vim

