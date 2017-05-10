FROM centos:7

ARG S2I_VERSION=1.1.5-4dd7721
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
	yum makecache fast -y && \
	yum install -y docker-ce git make && \
	yum clean all -y && \
    os=$(uname -s | tr '[:upper:]' '[:lower:]'); \ 
    arch=$(uname -m | sed 's/x86_/amd/' | tr -d 'i' | sed 's/686/386/'); \
    version=$(echo "${S2I_VERSION}" | cut -f1 -d-); \
    sha=$(echo "${S2I_VERSION}" | cut -f2 -d-); \
    curl -L https://github.com/openshift/source-to-image/releases/download/v${version}/source-to-image-v${version}-${sha}-${os}-${arch}.tar.gz -o- | tar -f- -xzC /usr/local/bin/
