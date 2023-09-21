function [alpha_u, alpha_v, gamma, u_0, v_0] = get_intrinsic_parameters(intrinsic_matrix)
    alpha_u = intrinsic_matrix(1, 1);
    alpha_v = intrinsic_matrix(2, 2);
    gamma = intrinsic_matrix(1, 2);
    u_0 = intrinsic_matrix(1, 3);
    v_0 = intrinsic_matrix(2, 3);
end