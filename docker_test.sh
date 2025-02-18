docker image build --tag neovim-config .
docker run -it --rm -v .:/root/.config/nvim/ neovim-config
