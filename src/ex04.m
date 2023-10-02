addpath("data/ex04/");

pts_mire = load("mireXY.txt");

n_img=10;
n_pts=100;

for i=1:n_img
    pts_image = load("pts2D_" + i + ".txt");
    H = get_homography(pts_mire, pts_image', n_pts);
    disp("Homography " + i + " : ")
    disp(H);
end

rmpath("data/ex04");