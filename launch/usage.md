carto_offline.launch 파일은 .bag 파일만 넣어주고 단독으로 실행해서 .bag.pbstream 파일을 얻는다.

carto_slam.launch, carto_localization.launch는 


@@carto_slam.launch EXAMPLE@@
original:    
    roslaunch cartographer_ros demo_backpack_2d.launch bag_filename:=${HOME}/Downloads/cartographer_paper_deutsches_museum.bag

ours:
    roslaunch zzangdol_bag bag_filename:=default 
OR  roslaunch zzangdol_bringup zzangdol_bringup
+
    roslaunch zzangdol_slam carto_slam_yesmap.launch 
OR  roslaunch zzangdol_slam carto_slam_nomap.launch 


@@carto_offline.launch EXAMPLE@@
original: 
    roslaunch cartographer_ros offline_backpack_2d.launch bag_filenames:=${HOME}/Downloads/b2-2016-04-05-14-44-52.bag
ours:
    roslaunch zzangdol_slam carto_offline.launch bag_filenames:=bag_filename
    [bag_filenames 안주면 가장 최근 zzangdol_bag 파일 사용]



@@carto_localization.launch EXAMPLE@@
original: 
    roslaunch cartographer_ros demo_backpack_2d_localization.launch \
    load_state_filename:=${HOME}/Downloads/b2-2016-04-05-14-44-52.bag.pbstream \
    bag_filename:=${HOME}/Downloads/b2-2016-04-27-12-31-41.bag
ours:
    roslaunch zzangdol_bag bag_filename:=default
OR  roslaunch zzangdol_bringup zzangdol_bringup
+
    roslaunch zzangdol_slam carto_localization.launch load_state_filename:=bagpbstream_file_name
	[load_state_filename를 안주면 가장 최근 pbstream 파일 사용]



즉, 기존에 bag파일만으로 진행하던 것은 bag 파일 혹은 zzangdol_bringup으로 실제 토픽을 가지고도 실행되도록 한 것이다.
