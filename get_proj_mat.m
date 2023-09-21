function [proj_mat] = get_proj_mat(intrinsic_matrix, R, t)
    proj_mat = intrinsic_matrix * [R -R*t];
end