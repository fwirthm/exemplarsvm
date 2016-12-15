ind=33;
for row =1:1:size(W,1)
    for col = 1:1:size(W,2)
        W(row,col,ind)=(W(row,col,ind)+1.0)/2.0;
    end
end

ind=36;
for row =1:1:size(W,1)
    for col = 1:1:size(W,2)
        W(row,col,ind)=(W(row,col,ind)+1.0)/2.0;
    end
end

ind=40;
for row =1:1:size(W,1)
    for col = 1:1:size(W,2)
        W(row,col,ind)=(W(row,col,ind)+1.0)/2.0;
    end
end




for row =1:1:size(W,1)
    for col = 1:1:size(W,2)
        Sum(row,col)=W(row,col,33)+W(row,col,36)+W(row,col,40);
    end
end



ind=33;
for row =1:1:size(W,1)
    for col = 1:1:size(W,2)
        W(row,col,ind)=W(row,col,ind)/ Sum(row,col);
    end
end

ind=36;
for row =1:1:size(W,1)
    for col = 1:1:size(W,2)
        W(row,col,ind)=W(row,col,ind)/ Sum(row,col);
    end
end

ind=40;
for row =1:1:size(W,1)
    for col = 1:1:size(W,2)
        W(row,col,ind)=W(row,col,ind)/ Sum(row,col);
    end
end