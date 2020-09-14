%%
%   First image
A = imread("iris2.gif");
A_gauss = imgaussfilt(A, 3);
BW_A = edge(A_gauss, 'canny');
subplot(1,2,1);
imshow(A);

%draw circles in image
[centers_A, radii_A] = imfindcircles(BW_A, [30 45], 'ObjectPolarity', 'bright', 'Sensitivity',0.95);
%imshow(A);
h_A = viscircles(centers_A,radii_A, 'EdgeColor', 'r');

%brighter region i.e. iris
[centersB_A, radiiB_A] = imfindcircles(BW_A, [60 120], 'ObjectPolarity', 'bright', 'Sensitivity',0.95, 'EdgeThreshold',0.1);
hB_A = viscircles(centersB_A, radiiB_A,'EdgeColor','b');

%black out pixels outisde the iris region by creating a mask
mask_A = createCirclesMask(A,centersB_A,radiiB_A);
subplot(1,2,2);
imshow(mask_A)

%use snakes code to determine region of remaining iris circle that is
%covered by the eyelid and remove it

snake_jpg(A);

[theta, rho] = cart2pol(centersB_A, centers_A)

[M, N] = size(A);

%function imP = ImToPolar (imR, rMin, rMax, M, N)
imP = ImToPolar(A, 0, 0.8,M, N);
imshow(imP);
