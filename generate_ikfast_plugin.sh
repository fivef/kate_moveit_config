#!/usr/bin/env bash
source ~/groovy_rosbuild_workspace/setup.bash
roscd kurtana_moveit_config/config
rosrun xacro xacro.py /home/sp/groovy_rosbuild_workspace/kurt_driver/kurt_description/robots/kurtana.urdf.xacro > kurtana.urdf
rosrun collada_urdf urdf_to_collada kurtana.urdf kurtana.dae
python /usr/lib/python2.7/dist-packages/openravepy/_openravepy_0_8/ikfast.py --robot=kurtana.dae --iktype=translationdirection5d --baselink=10 --eelink=16 --savefile=ikfast61.cpp
rosrun moveit_ikfast create_ikfast_moveit_plugin.py kurtana arm kurtana_moveit_config ikfast61.cpp
roscd ~/groovy_catkin_workspace
catkin_make
roscd kurtana_moveit_config/config
