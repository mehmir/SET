clc;
clear;
close all;

%% Initialization

% Initialize VNFs
% The first column is capacities, the second is resources, and the third is
% modification rate
global VNFs;
VNFs = [5000 5 1; 5000 5 1; 5000 5 1; 5000 5 1; 5000 5 1];
%VNFs = [3000 2 1; 5000 4 1];

%[ VNF capacity, VNF requirment, VNF modification rate]
% here the VNF capacity should not be less than flows load 
nVNF = size(VNFs,1)


% Initialize Partial Ordering of VNFs
global po;                                % Partial Order Matrix  
po = zeros(nVNF);
 SetPartialOrder(1,2);
 SetPartialOrder(1,3);
 SetPartialOrder(1,4);
 SetPartialOrder(2,3);                     % it means 2<3
 SetPartialOrder(2,4);
 SetPartialOrder(3,4);
% if 2<3 and 1<2, then we should manually add 1<3

% Initialize of Tabu Search
ActionList=CreatePermActionList(nVNF);    % Action List
nAction=numel(ActionList); 
MaxIt=20;                                % Maximum Number of Iterations
TL=round(0.5*nAction);

% Create Initial Solution
sol.Position= randperm(nVNF);
sol.Cost=CostFunction(sol.Position);

% Initialize Best Solution Ever Found
BestSol=sol;

% Array to Hold Best Costs
BestCost=zeros(MaxIt,1);

% Initialize Action Tabu Counters
TC=zeros(nAction,1);


%% Tabu Search Main Loop

for it=1:MaxIt
    
    bestnewsol.Cost=inf;
    
    % Apply Actions
    for i=1:nAction
        if TC(i)==0
            newsol.Position=DoAction(sol.Position,ActionList{i});
            newsol.Cost=CostFunction(newsol.Position);
            newsol.ActionIndex=i

            if newsol.Cost<=bestnewsol.Cost
                bestnewsol=newsol;
            end
        end
    end
    
    % Update Current Solution
    sol=bestnewsol
    
    % Update Tabu List
    for i=1:nAction
        if i==bestnewsol.ActionIndex
            TC(i)=TL;               % Add To Tabu List
        else
            TC(i)=max(TC(i)-1,0);   % Reduce Tabu Counter
        end
    end
    
    % Update Best Solution Ever Found
    if sol.Cost<=BestSol.Cost
        BestSol=sol;
    end
    
    % Save Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % If Global Minimum is Reached
    if BestCost(it)==0
        break;
    end
    
end

BestCost=BestCost(1:it);

%% Results

BestSol
figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');


