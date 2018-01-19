clc;
x=imread('E:\images\leena.jpg');
x=rgb2gray(x);
x=double(x);
tot=0;
[a,b]=size(x);
y=zeros(a,b);
for i=1:a
    for j=1:b
        y(i,j)=0;
    end
end

for i=1:a
    for j=1:b
        tot=tot+x(i,j);
    end
end
thr=tot/(a*b);
disp(thr);
for i=1:a
    for j=1:b
        if x(i,j) > thr
            y(i,j)=0;
        else
            y(i,j)=1;
        end
    end
end
figure;
imshow(y);
%--------------------------------------------------
%generates two shares
[share1, share2, share12] = VisCrypt(y);

%Outputs
figure;imshow(share1);title('Share 1');
figure;imshow(share2);title('Share 2');

figure;imshow(share12);title('Overlapping Share 1 & 2');

imwrite(share1,'Share1.bmp');
imwrite(share2,'Share2.bmp');
imwrite(share12,'Overlapped.bmp');