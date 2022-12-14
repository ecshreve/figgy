function setup-docker
    log-line-colored "~~~ STARTING DOCKER SETUP ~~~" blue
    # https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

    if is-installed docker 
        log-line-colored "...docker already installed, exiting" red
        return
    end

    # remove old packages related to docker
    sudo apt-get remove -y \
        docker \
        docker.io \
        containerd \
        runc \
        1>/dev/null 2>&1

    # install packages required by docker
    sudo apt-get update -y
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    # add docker gpg key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
    # setup docker repository
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # install docker
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    sudo apt-get update -y
    sudo apt-get install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-compose-plugin

    # create docker group and add user (non-root access)
    # 
    # better to do this manually rather than as part of a script
    # sudo groupadd docker 1>/dev/null 2>&1
    # sudo usermod -aG docker $USER
    # newgrp docker

    log-line-colored "~~~ DONE SETTING UP DOCKER ~~~" blue
end