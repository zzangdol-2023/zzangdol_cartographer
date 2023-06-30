-- backpack_2d_localization.lua 개조 파일
-- include를 풀어서 한 눈에 보기 쉽게 해놓았다.

include "zzangdol_mapping.lua"

TRAJECTORY_BUILDER.pure_localization_trimmer = {
  max_submaps_to_keep = 2,
}
POSE_GRAPH.optimize_every_n_nodes = 1 --90
MAP_BUILDER.num_background_threads = 6 -- 4
-- POSE_GRAPH.global_sampling_ratio = 0.001 -- 0.003
-- POSE_GRAPH.constraint_builder.sampling_ratio = 0.1 --0.3
POSE_GRAPH.constraint_builder.min_score = 0.50 -- 0.55


TRAJECTORY_BUILDER_2D.voxel_filter_size = 0.1 -- 0.025


TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 2 -- 10
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 30


return options
