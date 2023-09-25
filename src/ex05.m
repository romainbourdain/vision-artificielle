addpath("data/ex05/");
output_path = "output/ex05/";

pts_2D_1 = load("2dpts_1.txt");
pts_2D_2 = load("2dpts_2.txt");
pts_3D = load("3dpts.txt");


% Question 1
M_1 = get_proj_mat(pts_3D, pts_2D_1);
M_2 = get_proj_mat(pts_3D, pts_2D_2);

save(output_path+"M_1.txt", "M_1", "-ascii");
save(output_path+"M_2.txt", "M_2", "-ascii");

% Question 2
scene_1 = load("2dpts-scene_1.txt");
scene_2 = load("2dpts-scene_2.txt");

scene = construct_3d_scene(M_1, scene_1, M_2, scene_2);

figure;
scatter3(scene(:, 1),scene(:, 2), scene(:, 3), 'r');

save(output_path+"scene.txt", "scene", "-ascii");

rmpath("data/ex05/");