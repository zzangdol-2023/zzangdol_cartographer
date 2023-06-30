-- backpack_2d_localization.lua 개조 파일
-- include를 풀어서 한 눈에 보기 쉽게 해놓았다.

include "zzangdol_mapping_original.lua"

TRAJECTORY_BUILDER.pure_localization_trimmer = {
  max_submaps_to_keep = 3,
}
POSE_GRAPH.optimize_every_n_nodes = 20

return options
