function setup
    log-line-colored "~~~ STARTING setup ~~~" blue
    set system_type (system-type)
    if test $system_type = unknown
        echo "Unsupported OS"
        exit 1
    end

    echo Setting up on $system_type

    setup-locals

    if has-setup-option setup_ssh_primary
        setup-ssh-key
        log-line-colored "... done setting up ssh" green
    end

    if has-setup-option setup_development_tools
        function _has_recent_git
            git --version | grep -e 2.2 -e 2.3 1>/dev/null 2>&1
        end
        function _install_git_on_apt
            sudo apt-add-repository ppa:git-core/ppa
            sudo apt-get update
            sudo apt-get install git
        end
        install-package --name git --versioncheck _has_recent_git

        # install-package --name gls --macport coreutils --apt SKIP --freebsdpkg SKIP # not sure why I need this on macos... exa?
        install-package --name direnv
        install-package --name entr
        # install-package --name gh --apt SKIP
        # install-package --name dot --macport SKIP --apt SKIP # graphviz --apt graphviz --freebsdpkg graphviz
        install-package --name rlwrap
        install-package --name shellcheck

        log-line-colored "... done setting up dev tools" green
    end

    if has-setup-option setup_fancy_cli_tools
        function _install-fzf-on-apt-system
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install
        end

        install-package --name autojump
        install-package --name bash
        install-package --name bat
        # install-package --name exa SKIP
        install-package --name fd --apt fd-find
        install-package --name fzf --apt function:_install-fzf-on-apt-system
        install-package --name htop
        install-package --name jq
        install-package --name ncdu
        install-package --name ripgrep
        install-package --name tree

        log-line-colored "... done setting up cli" green
    end

    if has-setup-option use_tmux
        install-package --name tmux

        log-line-colored "... done setting up tmux" green
    end

    if has-setup-option setup_network_tools
        install-package --name drill --apt ldnsutils
        install-package --name iftop
        install-package --name iotop --macport SKIP --freebsdpkg SKIP
        install-package --name mosh
        install-package --name mtr
        install-package --name prettyping

        log-line-colored "... done setting up net tools" green
    end

    # * GOLANG
    # This function is special cased to my ubuntu install right now.
    if has-setup-option setup_golang_environment
        if ! is-installed go || test (go version) != "go version go1.19.3 linux/amd64"
            wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
            rm -rf /usr/local/go
            tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
            fish_add_path /usr/local/go/bin
            rm go1.19.3.linux-amd64.tar.gz*
        end

        if test -z (go version)
            log-line-colored "ERROR INSTALLING GO..." red
            log-line-colored "SKIPPING GO TOOLS INSTALL..." orange
        else
            set -gx GO111MODULE on

            function _install_go_tool --argument-names invocation repo
                if ! is-installed $invocation
                    go install $repo@latest
                end
            end

            _install_go_tool gore github.com/x-motemen/gore/cmd/gore
            _install_go_tool gocode github.com/stamblerre/gocode
            _install_go_tool godoc golang.org/x/tools/cmd/godoc
            _install_go_tool goimports golang.org/x/tools/cmd/goimports
            _install_go_tool gorename golang.org/x/tools/cmd/gorename
            _install_go_tool guru golang.org/x/tools/cmd/guru
            _install_go_tool gotests github.com/cweill/gotests/gotests
            _install_go_tool gomodifytags github.com/fatih/gomodifytags

            log-line-colored "... done setting up golang" green
        end
    end

    # * PYTHON
    if has-setup-option setup_python_environment
        if ! is-installed pip3
            echo Installing pip3
            install-package --name python3-pip
        end

        function _install_pip3 --argument-names name
            if ! pip3 show $name 1>/dev/null 2>&1
                echo Installing $name from pip3
                pip3 install $name
            end
        end

        _install_pip3 black
        _install_pip3 pyflakes
        _install_pip3 isort
        _install_pip3 pipenv
        _install_pip3 pytest
        _install_pip3 nose

        log-line-colored "... done setting up python" green
    end

    # * NODE
    if has-setup-option setup_node_environment || has-setup-option setup_neovim
        install-package --name node --macport nodejs14 --apt nodejs
        install-package --name npm --macport npm8 --apt SKIP


        log-line-colored "... done setting up node" green
    end

    # * MARKDOWN 
    if has-setup-option setup_markdown_environment
        install-package --name pandoc
        install-package --name tex --macport texlive-latex-recommended

        log-line-colored "... done setting up markdown" green
    end

    log-line-colored "~~~ DONE with setup ~~~" blue
end
