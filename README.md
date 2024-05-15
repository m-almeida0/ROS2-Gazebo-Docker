# ROS2-Gazebo-Docker
Docker to run ROS2 Humble and Gazebo Fortress


```
docker-compose build 
xhost +local:docker
docker-compose up
```

## ros2_humble_ws

This file's got the init.sh script and the ROS2 packages in it. We only want to run these packages inside the docker container, so there's no need to put them in a /src folder. That's because our docker-compose setup is set to create a shared folder between ./ros2_humble_ws and the container, mapping ./ros2_humble_ws/src inside.

## Project folder template

see https://gazebosim.org/docs/fortress/ros_gz_project_template_guide

### Oh, Permissions problems.

run
```
sudo chown -R <users> *
```

## Be careful with containers that still up

When you run docker-compose up it does not necessarily drop the container that is already running. So if you are facing an weird bug drop the containers and try again

```
docker rm -v -f $(docker ps -qa)
```