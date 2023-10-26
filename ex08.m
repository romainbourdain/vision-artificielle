addpath("lib");

pts_2D_1 = load("data/2dpts_1.txt");
pts_2D_2 = load("data/2dpts_2.txt");
pts_2D_3 = load("data/2dpts_3.txt");

% Calcul des matrices fondamentales
p1 = pts_2D_1(1:50, :);
p2 = pts_2D_2(1:50, :);
p3 = pts_2D_3(1:50, :);

F13 = get_fundamental_from_svd(p1, p3);
F23 = get_fundamental_from_svd(p2, p3);

% Estimation de la troisième image
pts_1 = pts_2D_1(50:end, :);
pts_2 = pts_2D_2(50:end, :);
pts_3 = pts_2D_3(50:end, :);

pts_3_estimated = estimate_image(pts_1, pts_2, F13, F23);

error = get_euclidian_error(pts_3_estimated, pts_3, 2);

% Avec les châteaux
castle_1 = imread("data/castle.01.jpg");
castle_2 = imread("data/castle.02.jpg");
castle_3 = imread("data/castle.03.jpg");

load("data/pts2d.mat", "pts");

% Affichage des châteaux et des points
figure("Name", "Châteaux et points");
subplot(1, 3, 1);
display_pts_in_img(castle_1, pts(:, :, 1));

subplot(1, 3, 2);
display_pts_in_img(castle_2, pts(:, :, 2));

subplot(1, 3, 3);
display_pts_in_img(castle_3, pts(:, :, 3));

% Matrices fondamentales avec les châteaux
F13_castle = get_fundamental_from_svd(pts(1:50, :, 1), pts(1:50, :, 3));
F23_castle = get_fundamental_from_svd(pts(1:50, :, 2), pts(1:50, :, 3));

e13 = F13_castle * [pts(:, :, 1) ones(size(pts, 1), 1)]';
e23 = F23_castle * [pts(:, :, 2) ones(size(pts, 1), 1)]';

figure("Name", "Châteaux et droites épipolaires");
castle_1 = draw_epipolar_line(castle_1, e13(:, 1));
castle_1 = draw_epipolar_line(castle_1, e23(:, 1));
imshow(castle_1);

function [pts_3] = estimate_image(pts_1, pts_2, F13, F23)    

    n = size(pts_1, 1);
    pts_3 = zeros(n, 2);
    for i=1:n
        p1 = [pts_1(i, :) 1]';
        p2 = [pts_2(i, :) 1]';
        p3 = cross(F23 * p2, F13 * p1)';
        p3 = p3 / p3(3);
        pts_3(i, :) = p3(:, 1:2);
    end
end

function [error] = get_euclidian_error(estimated, real, dim)
    error = sqrt(sum((estimated - real).^2, dim));
    error = mean(error);
end

function display_pts_in_img(img, pts)
    for i=1:size(pts, 1)
        img = insertMarker(img, pts(i, 1:2), "MarkerColor", "red");
    end

    imshow(img);
end

function [img] = draw_epipolar_line(img, e)
    for i=1:size(e, 2)
        a = e(1, i);
        b = e(2, i);
        c = e(3, i);
        x = 1:size(img, 2);
        y = -(a * x + c) / b;
        img = insertShape(img, "Line", [x' y'], "Color", "red");
    end
end

rmpath("lib/");