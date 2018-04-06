% this method return cost of order X based on one placement algorithm
function z=CostFunction(x)

    r = SatisfyPartialOrder(x);
    
    if r == true
        % here we get capacities, resources and modification rate of VNFs
        % based on the order x
        [capacities, resources, modifications] = GetCapacitiesAndResources(x);
        % you should call your placement algorithm here
        z = Placement(capacities,resources, modifications);
    else
        z = inf;
    end

end