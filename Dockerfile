FROM ros:humble

ENV DEBIAN_FRONTEND=noninteractive

# ROS2
# Create a workspace
WORKDIR /ros2_humble_ws/src

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

RUN sudo apt-get install  -y ros-${ROS_DISTRO}-ros-gz

CMD [ "/ros2_humble_ws/init.sh"]
