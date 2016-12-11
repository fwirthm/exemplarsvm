function x = esvm_features(I, sbin)
%Return the current feature function

if nargin == 0
  %%x = 31;
  x = 43;
  return
end

%x = features_pedro(I,sbin);
%x = features_raw(I,sbin);
x = features_cnhog(I,sbin);