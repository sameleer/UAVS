%___________________________________________________________________%
%  INproved Grey Wolf Optimizer (GWO) source codes version 1.0      %
%                                                                   %
%  Developed in MATLAB R2019b(7.13)                                 %
%                                                                   %
%  Author and programmer: Wang yu                                   %
%                                                                   %
%         e-Mail: 1796431186@qq.com                                 %           
%                                                                   
%___________________________________________________________________%

% Grey Wolf Optimizer
%% Problem Definition
function [BestCost,slu]=IGWO(it,pop)
model = CreatModel();  % Create UAVstaskallocation Model

CostFunction = @(x) costfunc(x, model);  % Objective Function

nVar = model.dim;     % Number of Decision Variables
VarSize = [1 nVar];   % Decision Variables Matrix Size

VarMin = 1;                % Lower Bound of Decision Variables
VarMax =model.Nu+1-0.000001;     % Upper Bound of Decision Variables

MaxIt=it;      % Maximum Number of Iterations

nPop=pop;        % Population Size (Swarm Size)
%initlize the population
empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Sol=[];

empty_Best.Position=[];
empty_Best.Cost=inf;
empty_Best.Sol=[];
particle = repmat(empty_particle,nPop,1);
Best=repmat(empty_Best,3,1);
% Main loop
for i=1:nPop
      particle(i).Position =unifrnd(VarMin,VarMax,VarSize);
      [particle(i).Cost, particle(i).Sol]=CostFunction(particle(i).Position);
     
     if particle(i).Cost<Best(1).Cost
                Best(1).Cost=particle(i).Cost;
                Best(1).Position=particle(i).Position;
                Best(1).Sol=particle(i).Sol;% Update alpha
     end
      if (particle(i).Cost> Best(1).Cost) && (particle(i).Cost< Best(2).Cost)
               Best(2).Cost=particle(i).Cost; % Update beta
               Best(2).Position=particle(i).Position;
               Best(2).Sol=particle(i).Sol;
      end
     if particle(i).Cost>Best(1).Cost && particle(i).Cost>Best(2).Cost &&  particle(i).Cost<Best(3).Cost
                Best(3).Cost=particle(i).Cost; % Update Delta
                Best(3).Position=particle(i).Position;
                Best(3).Sol=particle(i).Sol;
     end
end
l=0;% Loop counter

acu=0.001;
w=0.05*(VarMax-VarMin);
r=0.01*((log10(w)-log10(acu)));
BestCost=zeros(MaxIt,1);
while l<MaxIt
        window=-(w/(1+(w/acu-1)*exp((l+1)*(-r))))+(w+acu);
        a=2-l*((2)/MaxIt); % a decreases linearly fron 2 to 0
        b=power(10,(-l/nPop));
    % Congestion control
    for i=1:nPop
         distance=sum((particle(i).Position-Best(1).Position).^2).^0.5;
         if distance<window
             particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
         end
              X=repmat(empty_particle,3,1);
             for j=1:3

                 r1=rand(size(particle(i).Position));
                 r2=rand(size(particle(i).Position));
                 A=2*a*r1-a;
                 C=2*r2;
                 X(j).Position=Best(j).Position-A.*(C.*abs((Best(j).Position-particle(i).Position)+b));
             end
             particle(i).Position=(X(1).Position+X(2).Position+X(3).Position)./3;
            Flag4ub=particle(i).Position>VarMax;
            Flag4lb=particle(i).Position<VarMin;
            particle(i).Position=(particle(i).Position.*(~(Flag4ub+Flag4lb)))+(VarMin+rand*(VarMax-VarMin)).*Flag4ub+(VarMin+rand*(VarMax-VarMin)).*Flag4lb; 

            [particle(i).Cost, particle(i).Sol] = CostFunction(particle(i).Position);
         if particle(i).Cost<Best(1).Cost

                    Best(1).Cost=particle(i).Cost;
                    Best(1).Position=particle(i).Position;
                    Best(1).Sol=particle(i).Sol;
         end
          if particle(i).Cost> Best(1).Cost && particle(i).Cost< Best(2).Cost
                    Best(2).Cost=particle(i).Cost; % Update beta
                    Best(2).Position=particle(i).Position;
                    Best(2).Sol=particle(i).Sol;
          end
          if particle(i).Cost>Best(1).Cost && particle(i).Cost>Best(2).Cost &&  particle(i).Cost<Best(3).Cost
                    Best(3).Cost=particle(i).Cost; % Update beta
                    Best(3).Position=particle(i).Position;
                    Best(3).Sol=particle(i).Sol;
          end
    end

      ind=randperm(nVar);
  % globel best search
      for p = ind(1:nVar)
            
            d=VarMax-VarMin;
            k=rand();
            new=Best(1).Position;
            new(p)=new(p)+(2*k-1)*d;
            Flag4ub=new(p)>VarMax;
            Flag4lb=new(p)<VarMin;
            new=(new.*(~(Flag4ub+Flag4lb)))+(VarMin+rand*(VarMax-VarMin)).*Flag4ub+(VarMin+rand*(VarMax-VarMin)).*Flag4lb; 
           [fit, sol] = CostFunction(new);
            if fit<Best(1).Cost
                Best(1).Position(p)=new(p);
                Best(1).Cost=fit;
                Best(1).Sol=sol;
            end
                
       end

        BestCost(l+1)=Best(1).Cost;
        if Best(1).Sol.flag(1)==1&&Best(1).Sol.flag(2)==0
            fl='ablity unfesiable';
        end
        if Best(1).Sol.flag(2)==1&&Best(1).Sol.flag(1)==0
            fl='atack unfesiable';
        end
        if Best(1).Sol.flag(2)==1&&Best(1).Sol.flag(1)==1
            fl='boss unfesiable';
        end
         if Best(1).Sol.flag(2)==0&&Best(1).Sol.flag(1)==0
            fl='fesiable';
        end
        
        disp(['Iteration ' num2str(l+1) ': Best Cost = ' num2str(BestCost(l+1)),fl,mat2str(Best(1).Position,2)]);
        l=l+1;
       slu=Best(1).Sol;
        
    end
end


