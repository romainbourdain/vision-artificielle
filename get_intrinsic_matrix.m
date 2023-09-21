function [intrinsic_matrix] = get_intrinsic_matrix(alpha_u, alpha_v, gamma, u_0, v_0)
    intrinsic_matrix = [alpha_u gamma u_0; 0 alpha_v v_0; 0 0 1];
end