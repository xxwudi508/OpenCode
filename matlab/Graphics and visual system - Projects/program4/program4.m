%program4
%Generating different noise and comparing different noise
%reduction methods
%In this problem, you are required to write a program to
%generate different types of random noises started from the Uniform
%noise and Gaussian noise. (one of the reference may be ��Digital
%image processing using Matlab�� PP.143-150. And then add some of
%these noises to the circuit image (Circuit.tif) and investigate the
%different mean filters and order statistics as the textbook did at
%pages 344-352.

clc;
clear all;
close all;
%��ȡͼ�� 
I = imread('Circuit.tif');
[ h , w] = size(I);  
figure;subplot(2,4,1);imshow(I);

%���Ӿ�������
n_Unifrom = 0.1*(rand(h,w)-0.5);
result1 = double(I)/256 + double(n_Unifrom);
subplot(2,4,2);imshow(result1);imwrite(result1, '1.tif')

%ʹ�þ�ֵ�˲���ƽ����������ͼ��
filter = ones(3,3);
result2 = zeros(h,w);
for i = 2: h - 1
    for j = 2 : w - 1
        mask = result1(i-1:i+1, j-1:j+1);
        temp = double(mask).*double(filter)/9;
        result2(i,j) = sum(sum(temp));
    end
end
subplot(2,4,3);imshow(result2);imwrite(result2, '2.tif');

%���Ӹ�˹����
a = 0;
b = sqrt(5);
y=randn(1,h*w); 
y=y/std(y); 
y=y-mean(y); 
y2 = reshape(y,h,w);
n_gaussian = 0.1*(a + b .* y2-0.5);
result3 = double(I)/256 + double(n_gaussian);
subplot(2,4,5);imshow(result3);

%ʹ�þ�ֵ�˲���ƽ����˹����ͼ��
filter = ones(3,3);
result4 = zeros(h,w);
for i = 2: h - 1
    for j = 2 : w - 1
        mask = result3(i-1:i+1, j-1:j+1);
        temp = double(mask).*double(filter)/9;
        result4(i,j) = sum(sum(temp));
    end
end
subplot(2,4,6);imshow(result4);imwrite(result4, '4.tif');

%���ӽ�������
result5 = imnoise(double(I)/256,'salt & pepper',0.02);
subplot(2,4,7);imshow(result5);

%ʹ����ֵ�˲���ƽ����������ͼ��
filter = ones(3,3);
result6 = zeros(h,w);
for i = 2: h - 1
    for j = 2 : w - 1
        temp = result5(i-1:i+1, j-1:j+1);
        temp = temp(:);
        result6(i,j) = median(temp);
        %result6(i,j) = max(temp);  %���ֵ�˲���     
        %result6(i,j) = min(temp);  %��Сֵ�˲���       
    end
end
subplot(2,4,8);imshow(result6);imwrite(result6, '6.tif');



