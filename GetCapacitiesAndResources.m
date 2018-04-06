function [capacities, resources, modifications] = GetCapacitiesAndResources(x)

    global VNFs;
    c = VNFs(:,1);
    r = VNFs(:,2);
    m = VNFs(:,3);
    capacities = c(x);
    resources = r(x);
    modifications = m(x);
end

