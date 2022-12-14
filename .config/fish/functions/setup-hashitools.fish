function setup-hashitools
    log-line-colored "~~~ STARTING HASHITOOLS SETUP ~~~" blue

    sudo apt-get update -y
    sudo apt-get install -y \
        curl \
        wget \
        gnupg \
        software-properties-common

    wget -O- https://apt.releases.hashicorp.com/gpg | \
        gpg --dearmor | \
        sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg


    gpg --no-default-keyring \
        --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
        --fingerprint

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
        https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
        sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt-get update -y
    sudo apt-get install -y \
        boundary \
        consul \
        nomad \
        packer \
        terraform \
        vault \
        vagrant \
        waypoint

    log-line-colored "~~~ DONE HASHITOOLS SETUP ~~~" blue
end