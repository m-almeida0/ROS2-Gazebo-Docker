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

RUN export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:/ros2_humble_ws/description/models

RUN apt install -y vim

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source /ros2_humble_ws/install/setup.bash" >> ~/.bashrc

# An alias to source the bashrc file
RUN  echo "alias sb='source ~/.bashrc'" >> ~/.bashrc

WORKDIR /ros2_humble_ws/src

RUN git clone https://github.com/gazebosim/ros_gz.git -b ros2 & \
    cd .. & \
    rosdep install -r --from-paths src -i -y --rosdistro humble & \
    export MAKEFLAGS="-j 1" & \
    colcon build --parallel-workers=1 --executor sequential

CMD [ "/ros2_humble_ws/src/init.sh"]
