function cn_blocks=Do_ColorName(im,sbin,hog_dim1,hog_dim2)
load w2c       % load the RGB to color name matrix

half_size=floor(sbin/2);     
sigma=half_size/2;

blocks_1=round(size(im,1)/sbin);
blocks_2=round(size(im,2)/sbin);

imt_padd=im;
imt_padd=imt_padd/255;
index1=im2c(imt_padd*255,w2c,-2); % compute the probability of the color names for all pixels
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





















 
