addpath("data/ex00/");
output_path = "output/ex00/";

proj_mat = load('proj_mat1.txt');
pts_3d = load('3dpts.txt');

[u, v] = project(proj_mat, pts_3d);

save(output_path+"u.txt", "u", "-ascii");
save(output_path+"v.txt", "v", "-ascii");

plot(u, v, 'r*');

rmpath("data/ex00/");