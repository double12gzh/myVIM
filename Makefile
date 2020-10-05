.PHONY: local-setup default clean build-image push-image direnv-setup

DOCKER_REPO ?= double12gzh/centos_with_vim
GOVERSION ?= 1.15.2
PYTHONVERSION ?= python36

GIT := $(shell git rev-parse --short HEAD)
DOCKER_TAG := master-$(GIT)

default: build-image

build-image:
	docker build --no-cache -t ${DOCKER_REPO}:${DOCKER_TAG} --build-arg GOVERSION=${GOVERSION} --build-arg PYTHONVERSION=${PYTHONVERSION} .

push-image: build-image
	docker push ${DOCKER_REPO}:${DOCKER_TAG}

local-setup: clean
	chmod a+x ./setup_for_centos8.sh
	$(shell sh setup_for_centos8.sh)

clean:
	$(warning "Start to do cleanup...")
	
	rm -rf ${HOME}/.vim
	rm -rf /usr/local/go
	rm -rf ${HOME}/.go
	rm -rf ${HOME}/go${goversion}.linux-amd64.tar.gz
	rm -rf ${HOME}/.cache/go-build
	rm -rf ${HOME}/.zshrc
	rm -rf ${HOME}/.oh-my-zsh
	rm -rf /root/vim
	rm -rf ${HOME}/.dircolors
	yum remove -y zsh wget highlight
	sed -i "/^zsh/d" ~/.bashrc

	$(info "Successfully cleanup!")

set-go-venv:
ifndef CODE_PATH
	$(error CODE_PATH is not set)
else
	rm -rf ${CODE_PATH}/.envrc
	echo "layout go" > ${CODE_PATH}/.envrc
endif

clean-go-venv:
ifndef CODE_PATH
	$(error CODE_PATH is not set)
else
	rm -rf ${CODE_PATH}/.envrc
	rm -rf ${CODE_PATH}/.direnv
endif

set-py-venv:
ifndef CODE_PATH
	$(error CODE_PATH is not set)
else
	rm -rf ${CODE_PATH}/.envrc
	echo "layout python" > ${CODE_PATH}/.envrc
endif

clean-py-venv:
ifndef CODE_PATH
	$(error CODE_PATH is not set)
else
	rm -rf ${CODE_PATH}/.envrc
	rm -rf ${CODE_PATH}/.direnv
endif

