addpath("lib/");

pts_image = load("data/pts2dimage.txt");
pts_scene = load("data/pts2dscene.txt");
n = size(pts_image, 1)/2;

% estimation
pts_scene_estimation = pts_scene(1:n, :);
pts_image_estimation = pts_image(1:n, :);

H = get_homography(pts_scene_estimation, pts_image_estimation);

disp(H);

% verification
pts_scene_verification = pts_scene(n+1:end, :);
pts_image_verification = pts_image(n+1:end, :);

mat_scene_verification = [pts_scene_verification ones(n, 1)];
pts_image_estime = (H*mat_scene_verification')';
pts_image_estime = pts_image_estime./pts_image_estime(:, 3);
pts_image_estime = pts_image_estime(:, 1:2);

erreur = norm(pts_image_estime - pts_image_verification);

disp(['Erreur euclidienne : ', num2str(erreur)]);

rmpath("lib/")