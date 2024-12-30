FROM alpine:latest
RUN apk add --no-cache bash neovim

# Git is required for bootstrap (Packer)
RUN apk add --no-cache git

# Mason requirements
RUN apk add --no-cache unzip wget curl gzip perl

# External tools
RUN apk add --no-cache clang-dev fd gcc ripgrep

# External tools
RUN apk add --no-cache python3 py3-pynvim

WORKDIR "/root/.config/nvim"
ENTRYPOINT ["bash"]
