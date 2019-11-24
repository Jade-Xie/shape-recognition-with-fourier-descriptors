function [ PP, initrow,initcol ] = trace_boundary( BinaryImage, CCImage, i )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% d -> 0 (East) 1(North) 2(West) 3(South)
P = [];
d = 3;  % initial search direction (South)
isBnd = 0;

isExit = 0;
for k=1:size(CCImage,1)
    if (isExit)
        break;
    end
    for l=1:size(CCImage,2)
        if (CCImage(k,l)==i)
            isExit = 1;
            break;
        end
    end
end

initrow = k; initcol=l;

% for k=initrow:size(BinaryImage,1)
%     for l=initcol:size(BinaryImage,2)
% if (~isBnd)
%     if (BinaryImage(k,l)==1)
        counter = 1;
        P(counter,:) = [k l];
        %         n = 1;
        %d = mod(d+3,4);
        while(~isBnd)
            if(counter>2)
             if (sum(P(end,:)==P(2,:))==2 && sum(P(end-1,:)==P(1,:))==2)    % stop condition
                %if (P(end,1)==P(1,1) && P(end,2)==P(1,2))
                    isBnd = 1;
                    PP = P(1:end-1,:);  % remove last two points, they are same as first 2 pts
                    break;
                end
            end
            d = mod(d+3,4);
            switch d
                case 0
                    if (l+1<=size(BinaryImage,2) && BinaryImage(k,l+1)==1)
                        counter = counter + 1;
                        P(counter,:) = [k l+1];
                        l = l+1;
                        d = 0;
                    elseif (k-1>=1 && BinaryImage(k-1,l)==1)
                        counter = counter + 1;
                        P(counter,:) = [k-1 l];
                        k = k-1;
                        d = 1;
                    elseif (l-1>=1 && BinaryImage(k,l-1)==1)
                        counter = counter + 1;
                        P(counter,:) = [k l-1];
                        l = l-1;
                        d = 2;
                    elseif (k+1<=size(BinaryImage,1) && BinaryImage(k+1,l)==1)
                        counter = counter + 1;
                        P(counter,:) = [k+1 l];
                        k = k+1;
                        d = 3;
                    end
                    
                case 1
                    if (k-1>=1 && BinaryImage(k-1,l)==1)
                        counter = counter + 1;
                        P(counter,:) = [k-1 l];
                        k = k-1;
                        d = 1;
                    elseif (l-1>=1 && BinaryImage(k,l-1)==1)
                        counter = counter + 1;
                        P(counter,:) = [k l-1];
                        l = l-1;
                        d = 2;
                    elseif (k+1<=size(BinaryImage,1) && BinaryImage(k+1,l)==1)
                        counter = counter + 1;
                        P(counter,:) = [k+1 l];
                        k = k+1;
                        d = 3;
                    elseif (l+1<=size(BinaryImage,2) && BinaryImage(k,l+1)==1)
                        counter = counter + 1;
                        P(counter,:) = [k l+1];
                        l = l+1;
                        d = 0;
                    end
                    
                    
                case 2
                    if (l-1>=1 && BinaryImage(k,l-1)==1)
                        counter = counter + 1;
                        P(counter,:) = [k l-1];
                        l = l-1;
                        d = 2;
                    elseif (k+1<=size(BinaryImage,1) && BinaryImage(k+1,l)==1)
                        counter = counter + 1;
                        P(counter,:) = [k+1 l];
                        k = k+1;
                        d = 3;
                    elseif (l+1<=size(BinaryImage,2) && BinaryImage(k,l+1)==1)
                        counter = counter + 1;
                        P(counter,:) = [k l+1];
                        l = l+1;
                        d = 0;
                    elseif (k-1>=1 && BinaryImage(k-1,l)==1)
                        counter = counter + 1;
                        P(counter,:) = [k-1 l];
                        k = k-1;
                        d = 1;
                    end
                case 3
                    if (k+1<=size(BinaryImage,1) && BinaryImage(k+1,l)==1)
                        counter = counter + 1;
                        P(counter,:) = [k+1 l];
                        k = k+1;
                        d = 3;
                    elseif (l+1<=size(BinaryImage,2) && BinaryImage(k,l+1)==1)
                        counter = counter + 1;
                        P(counter,:) = [k l+1];
                        l = l+1;
                        d = 0;
                    elseif (k-1>=1 && BinaryImage(k-1,l)==1)
                        counter = counter + 1;
                        P(counter,:) = [k-1 l];
                        k = k-1;
                        d = 1;
                    elseif (l-1>=1 && BinaryImage(k,l-1)==1)
                        counter = counter + 1;
                        P(counter,:) = [k l-1];
                        l = l-1;
                        d = 2;
                    end
            end
        end
%     end
% end

end





