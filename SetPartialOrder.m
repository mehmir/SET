function SetPartialOrder(i,j)

    global po;
    po(i,j) = -1;
    po(j,i) = 1;

end

