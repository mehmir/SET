function result = SatisfyPartialOrder(x)

    n = numel(x);
    xm = zeros(n);
    for i=1:n
        xi = x(i);
        for j=1:n
            xj = x(j);
            if i < j
                xm(xi,xj) = -1;
            elseif i > j
                xm(xi,xj) = 1;
            end
        end
    end
    
    result = 1;
    global po;
    for i=1:n
        if result == -1
            break;
        end
        for j=1:n
            if po(i,j) == 1 && xm(i,j) ~= 1
                result = -1;
                break;
            end
        end
    end
end

