I = imread('PICV.jpeg');
imshow(I);
I = rgb2gray(I);
PICV_C = edge(I,'Canny');
PICV_S = edge(I,'Sobel');
figure;
imshowpair(PICV_C, PICV_S,'montage');

    