function x = esvm_features(I, sbin)

%% original code
% %Return the current feature function
% 
% if nargin == 0
%   x = 31;
%   return
% end
% 
% x = features_pedro(I,sbin);
% %x = features_raw(I,sbin);


%% new code
%Return the current feature function

if nargin == 0
  x = 43;
  return
end

x = features_cnhog(I,sbin);

if((size(x,1)<1) || (size(x,2)<1))
feats2=x(:,:,1:11);
else
%     feats2=Do_MyColorName(I,sbin,size(x,1),size(x,2));
    feats2=Do_ColorName(I,sbin,size(x,1),size(x,2));
end
x=cat(3,(x(:,:,1:end-1)),(feats2(:,:,1:end)),x(:,:,32));
