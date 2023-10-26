addpath("lib/");

pts_mire = load("data/mireXY.txt");

n_img=10;
n_pts=100;

B=zeros(2*n_img, 6);

for i=1:n_img
    pts_image = load("data/pts2D_" + i + ".txt")';
    H = get_homography(pts_mire, pts_image);

    disp("Homography " + i + " : ");
    disp(H);

    B(2*i-1,:) = [
        H(1,1)^2-H(1,2)^2
        2*(H(1,1)*H(2,1)-H(1,2)*H(2,2))
        2*(H(1,1)*H(3,1)-H(1,2)*H(3,2))
        H(2,1)^2-H(2,2)^2
        2*(H(2,1)*H(3,1)-H(2,2)*H(3,2))
        H(3,1)^2-H(3,2)^2
        ];

    B(2*i,:) = [
        H(1,1)*H(1,2)
        H(1,2)*H(2,1) + H(1,1)*H(2,2)
        H(1,2)*H(3,1) + H(1,1)*H(3,2)
        H(2,1)*H(2,2)
        H(2,2)*H(3,1) + H(2,1)*H(3,2)
        H(3,1)*H(3,2)
        ];
end

[~, ~, V] = svd(B);

V = V(:, end);

Omega = [
    V(1) V(2) V(3);
    V(2) V(4) V(5);
    V(3) V(5) V(6);
];

disp("Omega : ");
disp(Omega);


% Erreur sur cette ligne
A = inv(chol(Omega, 'lower')');

[R, t] = get_intrinsic_parameters(A, H);


disp("R : ");
disp(R);

disp("t : ");
disp(t);

rmpath("lib/");

function [R, t] = get_intrinsic_parameters(A, H)
    lambda = 1 / norm(A \ H(:, 1));
    r_1 = lambda * (A \ H(:, 1));
    r_2 = lambda * (A \ H(:, 2));
    R = [r_1 r_2 r_1*r_2];
    t_1 = lambda * (A \ H(:, 3));
    t = -R' * t_1;
end