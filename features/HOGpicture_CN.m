function [im,im2] = HOGpicture_CN(w, bs)
%%% w should not be folded by HOG
%%% color information should be in bins 32:42
% HOGpicture(w, bs)
% Make picture of positive HOG weights.
% order of color names: black ,   blue   , brown       , grey       , green   , orange   , pink     , purple  , red     , white    , yellow
if(0)
    color_values =     {  [0 0 0] , [0 0 1] , [.5 .4 .25] , [.5 .5 .5] , [0 1 0] , [1 .8 0] , [1 .5 1] , [1 0 1] , [1 0 0] , [1 1 1 ] , [ 1 1 0 ] };
elseif(0) % use mean color name from data set
    load CN_mean
    for ii=1:11
        color_values{ii}=CN_mean(ii,:)/255;
    end
else % use average color_name color
    
    load w2c.txt
    [max1, max_index]=max(w2c(:,4:end),[],2);
    rgb=w2c(:,1:3);
    for ii=1:11
        mask=(max_index==ii);
        color_values{ii}=mean(rgb(mask,:))/255;
        
    end
end
method=1; %%% do max of the CN =1; mean=2

% construct a "glyph" for each orientaion
bim1 = ones(bs, bs);
% bim1(:,round(bs/2):round(bs/2)+1) = 1;
% bim = zeros([size(bim1) 11]);
% bim(:,:,1) = bim1;
for i = 1:11,
    bim{i}(:,:,1) = color_values{i}(1)*bim1;
    bim{i}(:,:,2) = color_values{i}(2)*bim1;
    bim{i}(:,:,3) = color_values{i}(3)*bim1;
end

% make pictures of positive weights bs adding up weighted glyphs
s = size(w);
% w(w < 0) = 0;
im = zeros(bs*s(1), bs*s(2),3);
im2 = zeros(bs*s(1), bs*s(2));
if(method ==1)
    for i = 1:s(1),
        iis = (i-1)*bs+1:i*bs;
        for j = 1:s(2),
            jjs = (j-1)*bs+1:j*bs;
            %     for k = 1:11,
            [max1 , max_val]=max(w(i,j,32:42));
            %       im(iis,jjs,1) = im(iis,jjs,1) + bim(:,:,k) * w(i,j,k+31);
            % max_val
            im(iis,jjs,:) =  bim{max_val};
            %     end
        end
    end
end

if(method ==2)
    color_values2=reshape(cell2mat(color_values),3,11);
    bim2=bim1;
    for i = 1:s(1),
        iis = (i-1)*bs+1:i*bs;
        for j = 1:s(2),
            jjs = (j-1)*bs+1:j*bs;
            %                 for k = 1:11,
            w_pos=max(w(i,j,32:42),0);
            %              w_pos=max(w(i,j,1:11),0);
            mean_color=color_values2*reshape(w_pos,11,1);
            bim2(:,:,1) = mean_color(1)*bim1;
            bim2(:,:,2) = mean_color(2)*bim1;
            bim2(:,:,3) = mean_color(3)*bim1;
            im(iis,jjs,:) =  bim2;
            im2(iis,jjs) =  bim1*sum(reshape(w(i,j,32:42),11,1));
            %           im2(iis,jjs) =  bim1*sum(reshape(w(i,j,1:11),11,1));
            %                 end
        end
    end
end

if(method ==3)
    color_values2=reshape(cell2mat(color_values),3,11);
    bim2=bim1;
    w(w > 0) = 0;
    for i = 1:s(1),
        iis = (i-1)*bs+1:i*bs;
        for j = 1:s(2),
            jjs = (j-1)*bs+1:j*bs;
            %                 for k = 1:11,
            %             w_pos=max(w(i,j,32:42),0);
            mean_color=color_values2*reshape(w(i,j,32:42),11,1);
            bim2(:,:,1) = mean_color(1)*bim1;
            bim2(:,:,2) = mean_color(2)*bim1;
            bim2(:,:,3) = mean_color(3)*bim1;
            im(iis,jjs,:) =  -bim2;
            im2(iis,jjs) =  bim1*sum(reshape(w(i,j,32:42),11,1));
            %                 end
        end
    end
end
