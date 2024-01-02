# Zzangdol_cartographer

Based on cartographer_ros cartographer package,
This package re-defined launch file, configuration file(lua), rviz config
for zzangdol car autodrive project

Last Update : 23.12.23  
Last Updated by : GeonhaPark ( Seunmul )

## 00. Important Issue

**zzangdol-ai-car은 차량 내 모터 엔코더가 없는 관계로, SLAM 기반의 Mapping(맵 생성) 및 Navigation 시 위치추정 모두 Cartographer를 사용한다.**

설치방법은 아래 사이트를 참조.
- Dependency : Google Cartographer
- https://google-cartographer-ros.readthedocs.io/en/latest/

빌드 중간에 xml 파일에서 라인 하나를 지워줘야 한다.(package dependency 에러 발생.)

**주의**   
Install 시 catkin_make_isolated를 활용하여 외부 소스에 설치하고   
``` bash
source [파일 빌드위치]/devel_isolated/setup.bash (혹은 .zsh) --extend
```
와 같이 --extend 옵션을 주어 다른 패키지들과 별도로 관리해야한다.


## 01. Quick Start

```bash
roslaunch zzangdol_cartographer carto_localization.launch load_state_filename:=2F_bag_2round_ver2 rviz:=false
```

- load_stat_filename : pbstream 폴더 안에 위치, 해당 폴더의 .pbstream을 읽어 들인 다음 cartographer 코어에서 submap matching 알고리즘이 동작된다.
- rviz : true 옵션을 주면 rviz와 함께, false 옵션을 주면 rviz 없이 실행된다.

## 02. Info

### 1) Configuration_files

cartographer 파라미터 조절을 위한 lua file.

### 2) pbstream

cartographer 형식의 맵 데이터. SLAM 시 .pbstream 파일 형태로 데이터를 저장한다. online SLAM 동작 시 .pbstream 파일을 불러와 submap matching을 시도.

### 3) rviz

rviz 사용을 위한 설정 파일이다. rviz:=true 시 해당 스크립트에 저장된 rviz 컴포넌트들이 자동으로 로드된다.

## 03. 차량 구동순서
```bash
roslaunch zzangdol_bringup zzangdol_bring_all.launch usb_config:=false # 시스템 브링업

roslaunch zzangdol_cartographer carto_localization.launch load_state_filename:=2F_bag_2round_ver2 rviz:=false # (현재 단계) 위치추정 노드 실행

roslaunch zzangdol_navigation move_base_test.launch rviz:=false # navigation stack 실행

roslaunch zzangdol_navigation move_base_only_view.launch # rviz view 확인

# 이동명령 실행
cd /home/zzangdol/catkin_ws/src/zzangdol_navigation/src
python3 goal_publisher_actionlib_IT1_2nd_floor.py # 폴더 위치 이동 및 명령 스크립트 실행
```

## [DEPRECATED WARN] BELOW COMMANDS IS NOT USED NOW (Maybe not work.. ). Just Check It.

### Info

carto_offline.launch 파일은 .bag 파일만 넣어주고 단독으로 실행해서 .bag.pbstream 파일을 얻는다.

### Quick Start : carto_slam.launch

#### carto_slam.launch EXAMPLE

```bash
# original:
    roslaunch cartographer_ros demo_backpack_2d.launch bag_filename:=${HOME}/Downloads/cartographer_paper_deutsches_museum.bag

# ours:
    roslaunch zzangdol_bag bag_filename:=default
    roslaunch zzangdol_cartographer carto_slam_yesmap.launch
# OR
    roslaunch zzangdol_bag bag_filename:=default
    roslaunch zzangdol_cartographer carto_slam_nomap.launch
```

#### carto_offline.launch EXAMPLE

```bash
# original:
    roslaunch cartographer_ros offline_backpack_2d.launch bag_filenames:=${HOME}/Downloads/b2-2016-04-05-14-44-52.bag
# ours:
    roslaunch zzangdol_cartographer carto_offline.launch bag_filenames:=bag_filename
    # [bag_filenames 안주면 가장 최근 zzangdol_bag 파일 사용]

```

### Quick Start : carto_localization.launch

#### carto_localization.launch

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

#### Latest Option

roslaunch 실행(rviz 실행안됩니다.)

```bash
roslaunch zzangdol_cartographer carto_localization.launch  load_state_filename:=2F_bag_2round_ver2 rviz:=false
```

zzangdol_cartographer/rviz 에 위치한 navigation_config.rviz 파일을 불러서 rviz를 따로 실행시켜야 합니다.

```bash
rosrun rviz rviz -d navigation_config.rviz
```
