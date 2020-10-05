#!/usr/bin/env bash
set -e

GOVERSION="1.15.2"
PYVERSION="python36"

GO_PATH="${HOME}/.go"
GO_ROOT="/usr/local/go"
GO_PROXY="http://goproxy.cn"

RED='\033[0;31m'
LIGHT_CYAN='\033[0;36m'
GREEN='\033[1;32m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`

function OSCheck()
{
    OS_CHECK=`cat /etc/redhat-release | grep "CentOS Linux release 8." && echo "success" || echo "false"`
    echo ${OS_CHECK}
}

function Clean()
{
    echo -e "${LIGHT_CYAN}[4/10]Start to remove files...${NC}"
    rm -rf ${HOME}/.vim                                 \
            ${GO_ROOT}                                  \
            ${HOME}/.go                                 \
            ${HOME}/go${goversion}.linux-amd64.tar.gz   \
            ${HOME}/.cache/go-build                     \
            ${HOME}/.zshrc                              \
            ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
    echo -e "${LIGHT_CYAN}Remove Done!${NC}"

    echo -e "${LIGHT_CYAN}[5/10]Start to uninstall zsh...${NC}"
    yum remove -y zsh
    echo -e "${LIGHT_CYAN}Successfully uninstall zsh!${NC}"
}

function ParseArgs()
{
    while [ "$1" != "" ]; do
        case $1 in
            -g | --golangverison)
                shift
                goversion="$1"
                ;;
            -p | --pythonversion)
                shift
                pyversion="$1"
                ;;
            -f | --force)
                shift
                pyversion="$1"
                ;;
            -h | --help )
                usage
                exit
                ;;
            * )
                usage
                exit 1
        esac
        shift
    done
}

echo -e "${LIGHT_CYAN}[1/10]Start to check OS...${NC}"
OS_CHECK=$(OSCheck)
if [[ -z ${force} ]]; then
    if [[ ${OS_CHECK} == "false" ]];then
        echo -e "${RED}[Error]Unsupported OS. If force continue, please offer args: '-f'"
        exit -1
    fi
else
    if [[ ${OS_CHECK} == "false" ]];then
        echo -e "${BLUE}[Warning]Force to setup for unsupported OS. Errors might occurred.${NC}"
    fi
fi
echo -e "${LIGHT_CYAN}[2/10]OS check passed!${NC}"

# Get args from command line.
ParseArgs

if [[ -z ${goversion} ]];then
    echo -e "${BLUE}[Warning] Not any offered version for GoLang, default: 1.15.2${NC}"
    goversion=${GOVERSION}
fi

if [[ -z ${pyversion} ]];then
    echo -e "${BLUE}[Warning] Not any offered version for Python, default: python36${NC}"
    pyversion=${PYVERSION}
fi

echo -e "${GREEN}GoLang version: ${goversion}${NC}"
echo -e "${GREEN}Python version: ${pyversion}${NC}"

echo -e "${LIGHT_CYAN}[3/10]Prepare .vimrc${NC}"
cp ${SCRIPTPATH}/vimrc ${HOME}/.vimrc

# clean vim
Clean

echo -e "${LIGHT_CYAN}[6/10]Setup env for GoLang/Python!${NC}"
export GOVERSION=goversion
export PYTHONVERSION=pyversion
export LANG=C.UTF-8
export GOPATH=${GO_PATH}
export GOROOT=${GO_ROOT}
export GOPROXY=${GO_PROXY}
export GO101MODULE=on
export PATH=$PATH:${GO_ROOT}/bin:${GO_PATH}/bin

echo -e "${LIGHT_CYAN}[7/10]Install all packages!${NC}"
yum clean all && yum makecache  && \
    yum install -y ${pyversion}.x86_64  \
    git                             \
    ctags                           \
    gcc                             \
    make                            \
    ncurses                         \
    ncurses-devel                   \
    ${pyversion}-devel.x86_64       \
    cmake                           \
    zsh                             \
    curl                            \
    wget                            \
    gcc-c++                         \
    highlight.x86_64                && \
    curl -sfL https://direnv.net/install.sh | bash || true && \
    git clone https://github.com/vim/vim.git ${HOME}/vim  && \
    cd ${HOME}/vim && ./configure --with-features=huge --enable-multibyte --enable-pythoninterp --enable-python3interp && make && make install && \
    yum install -y wget && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    mkdir -p ${HOME}/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim ${HOME}/.vim/bundle/Vundle.vim && \
    wget https://studygolang.com/dl/golang/go${goversion}.linux-amd64.tar.gz -O ${HOME}/go${goversion}.linux-amd64.tar.gz && \
    tar -xzvf ${HOME}/go${goversion}.linux-amd64.tar.gz -C /usr/local && \
    cp ${SCRIPTPATH}/zshrc ${HOME}/.zshrc && \
    echo "export GOPATH=${GO_PATH}" >> ${HOME}/.zshrc && \
    echo "export GOROOT=${GO_ROOT}" >> ${HOME}/.zshrc && \
    echo "export GOPROXY=${GO_PROXY}" >> ${HOME}/.zshrc && \
    echo "export GO101MODULE=on" >> ${HOME}/.zshrc && \
    echo "export PATH=$PATH:${GO_ROOT}/bin:${GO_PATH}/bin" >> ${HOME}/.zshrc  && \
    export GOPATH=${GO_PATH} && \
    export GOROOT=${GO_ROOT} && \
    export GOPROXY=${GO_PROXY} && \
    export GO101MODULE=on && \
    export PATH=$PATH:${GO_ROOT}/bin:${GO_PATH}/bin && \
    git clone https://github.com/Valloric/YouCompleteMe.git ${HOME}/.vim/bundle/YouCompleteMe && \
    cd ${HOME}/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && python3 install.py --clang-completer --go-completer && \
    vim +PluginInstall +qall > /dev/null && vim +GoInstallBinaries +qall > /dev/null && \
    go get -u -v github.com/jstemmer/gotags && \
    cd ${HOME} && yum remove -y wget && rm -rf ${HOME}/go${goversion}.linux-amd64.tar.gz && rm -rf ${HOME}/vim && rm -rf ${HOME}/.dircolors && touch ${HOME}/.dircolors

echo -e "${LIGHT_CYAN}[8/10]Prepare zshrc!${NC}"

echo -e "${LIGHT_CYAN}[9/10]Setup default sh with zsh!${NC}"
sed -i "/^zsh/d" ~/.bashrc
echo "zsh" >> ~/.bashrc

echo -e "${GREEN}[10/10]Successfully setup! Please re-login.${NC}"