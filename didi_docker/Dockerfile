# http://wiki.ros.org/docker/Tutorials/GUI
# https://github.com/osrf/docker_images

FROM osrf/ros:indigo-desktop-full
MAINTAINER Chih-Chuan Chan "dincoco@gmail.com"

# IMPORTANT:
# Update uid, gid to your primary computer user id and group id
# On OSX use `id -u` and `id -g` to find the correct values
ENV UID 1000
ENV GID 1000
ENV USERNAME didi

# add new user with sudo permission
RUN useradd -m $USERNAME && \
    echo "$USERNAME:$USERNAME" | chpasswd && \

    usermod --shell /bin/bash $USERNAME && \
    usermod -aG sudo $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \

    usermod  --uid $UID $USERNAME && \
    groupmod --gid $GID $USERNAME

# vboxsf permissions
RUN echo "vboxsf:x:998:$USERNAME" >> /etc/group

USER $USERNAME
ENV HOME /home/$USERNAME

RUN echo "export QT_X11_NO_MITSHM=1" >> /home/$USERNAME/.bashrc
#RUN echo "export QT_GRAPHICSSYSTEM=native" >> /home/$USERNAME/.bashrc
RUN echo "source /opt/$USERNAME/indigo/setup.bash" >> /home/$USERNAME/.bashrc

# create workspace
RUN mkdir -p /home/$USERNAME/catkin_ws/src

