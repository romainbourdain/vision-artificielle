proj_mat = load('data/proj_mat1.txt');
pts_3d = load('data/3dpts.txt');

n_pts = size(pts_3d, 1);
    projection = proj_mat*[pts_3d ones(n_pts, 1)]';
    u = projection(1, :);
    v = projection(2, :);

plot(u, v, 'r*');