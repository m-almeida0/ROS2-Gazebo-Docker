FROM ros:humble

# Create a workspace
WORKDIR /ros2_humble_ws/src

# Copy the package(s) to the workspace
COPY ../ $WORKDIR

# install ros package
RUN apt-get update && apt-get install -y \
      ros-${ROS_DISTRO}-demo-nodes-cpp \
      ros-${ROS_DISTRO}-demo-nodes-py && \
    rm -rf /var/lib/apt/lists/*

# launch ros package
#CMD ["ros2", "launch", "demo_nodes_cpp", "talker_listener.launch.py"]

RUN chmod +x init.sh

CMD [ "./init.sh"]