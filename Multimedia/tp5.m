close all;
clear;

I=imread('cameraman.tif');
IB = imnoise(I,'salt & pepper');
figure(1)
subplot(2,2,1)
imshow(I)
title('Original')
subplot(2,2,2)
imshow(IB)
title('Bruitée')

N = ones(3)/9;
If1 = imfilter(IB,N,"replicate");
subplot(2,2,3);
imshow(If1)
title('Moyenneur')

If2 = medfilt2(IB,[3,3])
subplot(2,2,4)
imshow(If2)
title('Median')

figure(1)
subplot(4,1,1)
stem(I(128,:),'*-')
title("ligne image originale")

subplot(4,1,2)
stem(IB(128,:),'*-')
title("ligne image bruitée")

subplot(4,1,3)
stem(If1(128,:),'*-')
title("ligne image filtrée moy")

subplot(4,1,4)
stem(If2(128,:),'*-')
title("ligne image filtrée med")

