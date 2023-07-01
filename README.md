# Zzangdol_cartographer

Based on cartographer_ros cartographer package,
This package re-defined launch file, configuration file(lua), rviz config
for zzangdol car autodrive project

Lastupdate:230701

## Info

carto_offline.launch 파일은 .bag 파일만 넣어주고 단독으로 실행해서 .bag.pbstream 파일을 얻는다.

## Quick Start : carto_slam.launch

### carto_slam.launch EXAMPLE

```bash
original:
    roslaunch cartographer_ros demo_backpack_2d.launch bag_filename:=${HOME}/Downloads/cartographer_paper_deutsches_museum.bag

ours:
    roslaunch zzangdol_bag bag_filename:=default
OR  roslaunch zzangdol_bringup zzangdol_bringup
+
    roslaunch zzangdol_cartographer carto_slam_yesmap.launch
OR  roslaunch zzangdol_cartographer carto_slam_nomap.launch
```

### carto_offline.launch EXAMPLE

```bash
original:
    roslaunch cartographer_ros offline_backpack_2d.launch bag_filenames:=${HOME}/Downloads/b2-2016-04-05-14-44-52.bag
ours:
    roslaunch zzangdol_cartographer carto_offline.launch bag_filenames:=bag_filename
    [bag_filenames 안주면 가장 최근 zzangdol_bag 파일 사용]

```

## Quick Start : carto_localization.launch

### carto_localization.launch

- original:

```bash
roslaunch cartographer_ros demo_backpack_2d_localization.launch \
load_state_filename:=${HOME}/Downloads/b2-2016-04-05-14-44-52.bag.pbstream \
bag_filename:=${HOME}/Downloads/b2-2016-04-27-12-31-41.bag
```

- ours(use bagfiles):

```bash
roslaunch zzangdol_bag bag_filename:=default
```

- ours(use live sensor data)

```bash
roslaunch zzangdol_bringup zzangdol_bring_all.launch usb_config:=true
## [load_state_filename를 안주면 가장 최근 pbstream 파일 사용]
roslaunch zzangdol_cartographer carto_localization.launch load_state_filename:=[bagpbstream_file_name]

```

즉, 기존에 bag파일만으로 진행하던 것은 bag 파일 혹은 zzangdol_bringup으로 실제 토픽을 가지고도 실행되도록 한 것이다.

### Latest Option

roslaunch 실행(rviz 실행안됩니다.)
```bash
roslaunch zzangdol_cartographer carto_localization.launch  load_state_filename:=2F_bag_2round_ver2 rviz:=false
```
zzangdol_cartographer/rviz 에 위치한 navigation_config.rviz 파일을 불러서 rviz를 따로 실행시켜야 합니다. 

```bash
rosrun rviz rviz -d navigation_config.rviz 
```