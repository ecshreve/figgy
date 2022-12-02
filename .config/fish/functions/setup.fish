function setup
    log-line-colored "~~~ STARTING setup ~~~" blue

    # Check system type
    set system_type (system-type)
    if test $system_type = unknown
        echo "Unsupported OS"
        exit 1
    end

    # Set local config variables based on input and var file.
    log-line-colored "Setting up on $system_type" blue

    setup-locals

    set -l locals_count (count < ~/locals.fish)
    set -l example_locals_count (count < ~/locals.fish.example)

    if test ! -f ~/locals.fish || test $locals_count -ne $example_locals_count
        log-line-colored "... local variables do not match example file" red
    end

    log-line-colored "... done setting up locals" green


    # SSH
    if has-setup-option setup_ssh_primary
        setup-ssh-key
        log-line-colored "... done setting up ssh" green
    end


    # DEV-TOOLS
    if has-setup-option setup_development_tools
        function _has_recent_git
            git --version | grep -e 2.2 -e 2.3 1>/dev/null 2>&1
        end
        function _install_git_on_apt
            sudo apt-add-repository ppa:git-core/ppa
            sudo apt-get update
            sudo apt-get install git
        end
        install-package --name git --versioncheck _has_recent_git --apt function:_install_git_on_apt

        install-package --name direnv
        install-package --name entr
        install-package --name rlwrap
        install-package --name shellcheck
        install-package --name thefuck
        install-package --name unzip

        log-line-colored "... done setting up dev tools" green
    end


    # FANCY-TOOLS
    if has-setup-option setup_fancy_cli_tools
        function _install-fzf-on-apt-system
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install

            set -g fzf_fd_opts --hidden --no-ignore --exclude=.git
        end


        function _install-diff-fancy-apt
            sudo add-apt-repository ppa:aos1/diff-so-fancy
            sudo apt-get update
            sudo apt-get install diff-so-fancy
        end

        # official debian package is borked 9 ways to sunday, just grab the binary
        function _install-exa-apt
            wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip
            unzip exa-linux-x86_64-v0.10.0.zip
            mv exa-linux-x86_64-v0.10.0/bin/exa /usr/local/bin/exa
            mv exa-linux-x86_64-v0.10.0/completions/exa.fish ~/.config/fish/completions/exa.fish

            if test ! -d ~/.local/man/man1
                mkdir -p ~/.local/man/man1
            end
            mv exa-linux-x86_64-v0.10.0/man/exa.1 ~/.local/man/man1/exa.1

            if test ! -d ~/.local/man/man5
                mkdir -p ~/.local/man/man5
            end
            mv exa-linux-x86_64-v0.10.0/man/exa.5 ~/.local/man/man5/exa.5
        end

        install-package --name autojump
        install-package --name bash
        install-package --name bat
        install-package --name diff-so-fancy --apt function:_install-diff-fancy-apt
        install-package --name fd --apt fd-find
        install-package --name fzf --apt function:_install-fzf-on-apt-system
        install-package --name htop
        install-package --name jq
        install-package --name ncdu
        install-package --name rg --apt ripgrep
        install-package --name tree
        install-package --name exa --apt function:_install-exa-apt

        sudo ln -s /usr/bin/batcat /usr/bin/bat
        sudo ln -s /usr/bin/fdfind /usr/bin/fd

        log-line-colored "... done setting up cli" green
    end


    # TMUX
    if has-setup-option use_tmux
        install-package --name tmux

        log-line-colored "... done setting up tmux" green
    end


    # NET-TOOLS
    if has-setup-option setup_network_tools
        install-package --name drill --apt ldnsutils
        install-package --name iftop
        install-package --name mosh
        install-package --name mtr
        install-package --name prettyping

        log-line-colored "... done setting up net tools" green
    end


    # TODO: change this to use versioncheck
    #
    # * GOLANG
    # This function has only been tested on my ubuntu install right now.
    if has-setup-option setup_golang_environment
        if test $system_type = macos
            log-line-colored "SKIPPING GO INSTALLATION ON MACOS..." red
            return
        end

        # Only try to install if go isn't already installed.
        #
        # TODO: put this version in a const file somewhere.
        if not is-installed go || test (go version) != "go version go1.19.3 linux/amd64"
            wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
            rm -rf /usr/local/go
            tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
            fish_add_path /usr/local/go/bin
            rm go1.19.3.linux-amd64.tar.gz*
        else
            set v (go version)
            log-line-colored "SKIPPING GO INSTALL -- ALREADY INSTALLED VERSION: $v" purple
        end

        if test -z (go version)
            log-line-colored "ERROR INSTALLING GO..." red
            log-line-colored "SKIPPING GO TOOLS INSTALL..." red
        else
            set -gx GO111MODULE on

            function _install_go_tool --argument-names invocation repo
                if ! is-installed $invocation
                    go install $repo@latest
                end
            end

            log-line-colored "INSTALLING GO TOOLS..." purple

            # TODO: audit these go tools
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


    # PYTHON
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


    # NODE
    if has-setup-option setup_node_environment
        install-package --name node --macport nodejs14 --apt nodejs
        install-package --name npm --macport npm8 --apt SKIP

        log-line-colored "... done setting up node" green
    end

    if has-setup-option setup_fish_plugins
        if ! is-installed fisher
            log-line-colored "installing fisher" magenta
            curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
        end

        log-line-colored "updating fisher plugins" magenta
        fisher update
        log-line-colored "... done setting up fish plugins" green
    end


    log-line-colored "~~~ DONE with setup ~~~" blue
end
