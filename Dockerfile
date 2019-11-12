FROM archlinux/base:latest
COPY dkp /dkp

RUN cd /dkp && chmod +x install-dkp.sh && ./install-dkp.sh && \
    pacman -S --needed --noconfirm base-devel wget unzip && \
    pacman -S --needed --noconfirm devkitPPC wut && \
    pacman -Scc --noconfirm

# change this comment to force a docker rebuild - 4
