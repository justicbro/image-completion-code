clc
clear
T = double(imread('5498.jpg'));
% T=x*255;
T_image = T;
T_image1 = T;
T_gray = rgb2gray(uint8(T));
BW = edge(T_gray, 'canny');
BWT(:,:,1) = edge(T(:,:,1), 'canny');
BWT(:,:,2) = edge(T(:,:,2), 'canny');
BWT(:,:,3) = edge(T(:,:,3), 'canny');
% BWT(:,:,1) = BW;
% BWT(:,:,2) = BW;
% BWT(:,:,3) = BW;
T_edge = T.*BWT;
%%
addpath('./private');
patch_size = 12;
figure(1), hold off, imshow(uint8(T ));
[x, y] = ginput ;
target_mask = poly2mask(x, y, size(T,1), size(T,2));
imwrite(target_mask,'0.jpg');
tol = 0.0001;
inpainted_img = hole_filling_crimnisi(T_edge, target_mask, patch_size, tol);

%%
Omega2(:,:,1) = ~target_mask;
Omega2(:,:,2) = ~target_mask;
Omega2(:,:,3) = ~target_mask;
T(Omega2==0)=1;
X = T(Omega2==0).*inpainted_img(Omega2==0);
T(Omega2==0)=X;
Omega1 =T>0;
%% TRNNMmyself
tic
[z1,RC,RE] = TRNNMmyself(T/255,Omega1,Omega2,0.1,1,10);
toc
figure,imshow(z1);

% newx = yang_completion(z1, target_mask, inpainted_img, 21);
% subplot(1,2,1),imshow(mat2gray(z1));subplot(1,2,2),imshow(mat2gray(newx));
