function [u, v] = project(proj_mat, pts)
    n_pts = size(pts, 1);
    pts_1 = [pts ones(n_pts, 1)];
    projection = proj_mat*pts_1';
    u = projection(1, :);
    v = projection(2, :);
end