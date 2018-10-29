FROM base/archlinux:latest
COPY dkp /dkp

RUN cd /dkp && chmod +x install-dkp.sh && ./install-dkp.sh && \
    pacman -S --needed --noconfirm base-devel && \
    pacman -Scc --noconfirm
