function [u, v] = project(proj_mat, pts_3d)
    n_pts = size(pts_3d, 1);
    projection = proj_mat*[pts_3d ones(n_pts, 1)]';
    u = projection(1, :);
    v = projection(2, :);
end