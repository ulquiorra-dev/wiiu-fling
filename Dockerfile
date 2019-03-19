FROM archlinux/base:latest
COPY dkp /dkp

RUN cd /dkp && chmod +x install-dkp.sh && ./install-dkp.sh && \
    pacman -S --needed --noconfirm base-devel wget unzip && \
    pacman -S --needed --noconfirm devkitPPC wut && \
    pacman -U --noconfirm https://archive.archlinux.org/packages/c/cmake/cmake-3.13.4-1-x86_64.pkg.tar.xz && \
    pacman -Scc --noconfirm

# change this comment to force a docker rebuild - 1
