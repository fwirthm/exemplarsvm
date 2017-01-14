function [I, scale] = Imread_resize(ImPath, maxEdgeLen)
    
    switch nargin
        case 1
            maxEdgeLen = 500;
    end

    try
      I = imread(ImPath);
      info = imfinfo(ImPath);
    catch
      try
        I = imread([ImPath, '.jpeg']);
        info = imfinfo([ImPath, '.jpeg']);
      catch
        fprintf(1,'Cannot load image: %s\n',ImPath);
        I = zeros(0,0,3);
        info = struct('Width', 0, 'Height', 0);
      end
    end

    
    w = info.Width;
    h = info.Height;

    if (w >= h)
        scale = double(w)/maxEdgeLen;
    elseif (w < h)
        scale = double(h)/maxEdgeLen;
    else
        error('something went wrong');
    end

    I = imresize(I, (1.0/scale));
end



