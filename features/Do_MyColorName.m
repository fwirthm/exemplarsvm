function cn_blocks=Do_MyColorName(im,sbin,hog_dim1,hog_dim2)
load w2c       % load the RGB to color name matrix

global TestMat;

half_size=floor(sbin/2);     
sigma=half_size/2;

blocks_1=round(size(im,1)/sbin);
blocks_2=round(size(im,2)/sbin);

imt_padd=im;
imt_padd=imt_padd/255;
%index1=im2c(imt_padd*255,w2c,-2); % compute the probability of the color names for all pixels

index1 = zeros(size(im,1), size(im,2), 11);

for row = 1:1:size(im,1)
    for col = 1:1:size(im,2)
        %red chanel
        index1(row, col,9) = im(row, col, 1);
        %green chanel
        index1(row, col,5) = im(row, col, 2);
        %blue chanel
        index1(row, col,2) = im(row, col, 3);
    end
end




index2=index1(sbin+1:(blocks_1-1)*sbin,sbin+1:(blocks_2-1)*sbin,:);
if(sigma~=0)
     index2=color_gauss(index2,sigma,0,0);
end
out=mat2cell(index2,ones((hog_dim1),1)*sbin,ones((hog_dim2),1)*sbin,11);

cn_blocks_tmp=zeros(size(out,1),size(out,2),11);
for i=1:size(out,1)
    for j=1:size(out,2)        
        cct=out{i,j};
        cct1=reshape(cct,size(cct,1)*size(cct,2),11);
        cct1_norm=cct1./size(cct1,1);
        cn_blocks_tmp(i,j,:)=sum(cct1_norm,1);        
    end
end
cn_blocks=cn_blocks_tmp;


global IM;
global Sbin;
global Hog_dim1;
global Hog_dim2;
IM = im;
Sbin= sbin;
Hog_dim1 = hog_dim1;
Hog_dim2 = hog_dim2;


%cn_blocks=randi(20, hog_dim1, hog_dim2, 11);
%cn_blocks(1,1,1)=40;
%cn_blocks=ones(hog_dim1, hog_dim2, 11)*20;
%cn_blocks(1,1,1)=100;
TestMat= cn_blocks;























 
