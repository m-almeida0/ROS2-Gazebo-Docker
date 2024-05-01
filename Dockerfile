FROM ros:humble

ENV DEBIAN_FRONTEND=noninteractive

# ROS2
# Create a workspace
WORKDIR /ros2_humble_ws/src

# Copy the package(s) to the workspace
COPY ./packages/* $WORKDIR

# install ros package
RUN apt-get update && apt-get install -y \
      ros-${ROS_DISTRO}-demo-nodes-cpp \
      ros-${ROS_DISTRO}-demo-nodes-py && \
    rm -rf /var/lib/apt/lists/*


# Gazebo Fortress
# Set the working directory
WORKDIR /root


# Install the necessary packages
RUN apt-get update && apt-get install -y \ 
    lsb-release \ 
    wget \ 
    gnupg \
    x11-apps \
    libxext-dev \
    libxrender-dev \
    libxtst-dev 

RUN sudo apt-get install  -y ros-humble-ros-gz

#RUN wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg 
#RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
#    | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null

#RUN apt-get update  
#RUN apt-get install -y ignition-fortress 

COPY ./init.sh /root/init.sh
RUN chmod +x /root/init.sh

CMD [ "/root/init.sh"]