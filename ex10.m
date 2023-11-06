addpath("lib/");

I = imread("data/checker.pgm");

h_u = [
  -1 0 1; 
  -1 0 1; 
  -1 0 1
];

h_v = [
  -1 -1 -1;
  0 0 0;
  1 1 1;
];

I_u = conv2(I, h_u);
I_v = conv2(I, h_v);

sigma = 7;
dim = 5;
G = fspecial('gaussian', [dim dim], sigma);
A = conv2(I_u.^2, G);
B = conv2(I_u.*I_v, G);
C = conv2(I_v.^2, G); 

C_mat = [A B; B C];

alpha = 0.04;
det = A.*C - B.^2;
trace = A + C;

H = det - alpha*(trace.^2);
H_s = (median(H(:)) + max(H(:))) / 2^7;

imshow(I);
hold on;
[y, x] = find(H >= H_s);
plot(x, y, "r.");
hold off;