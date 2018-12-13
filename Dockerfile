FROM base/archlinux:latest
COPY dkp /dkp

RUN cd /dkp && chmod +x install-dkp.sh && ./install-dkp.sh && \
    pacman -S --needed --noconfirm base-devel wget unzip && \
    pacman -Scc --noconfirm

# change this comment to force a docker rebuild - 2
