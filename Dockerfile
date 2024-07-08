FROM codercom/enterprise-base:ubuntu
USER root
# Install dependencies (git, curl, terraform, packer, ansible, azure cli)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    jq \
    python3-pip \
    ssh \
    sshpass \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && pip3 install --upgrade pip \
    && pip3 install ansible \
    && wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install -y \
    terraform \
    packer \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && curl -sL https://aka.ms/InstallAzureCLIDeb | bash
USER coder