function [model] = CreatModel()
i=3;
model.id=i;
%example1
if i==1
model.Nu=8;%number of uavs
model.Nt=5;%number of task
model.nTask=3;%task type
% uavs ability
model.V_ablity=[0.9,0.1,0.6;
                0.2,0.6,0.8;
                0.5,0.6,0.7;
                0.8,0.8,0.2;
                0.1,0.9,0.9;
                0.7,0.3,0.6;
                0.2,0.6,0.8;
                0.7,0.2,0.8];
% task need ability
model.T_ablity=[0.7,0.4,0.5;
                0.3,0.5,0.4;
                0.3,0.7,0.3;
                0.5,0.2,0.5;
                0.1,0.6,0.6];
model.T_value=[];
%task position
model.Start_POS=[0,0;99,57;13,26;68,52;97,42;57,24];
model.T_time=[10,5,10];
model.dim=model.Nt*model.nTask+model.Nt;
model.diss=dist(model.Start_POS');
%speed
model.V=10;
end
%example 2
if i==2
model.Nu=15;
model.Nt=10;
model.nTask=3;
model.V_ablity=[0.8,0.2,0.5;
                0.9,0.8,0.3;
                0.5,0.7,0.6;
                0.7,0.8,0.1;
                0.5,0.2,0.8;
                0.6,0.6,0.5;
                0.7,0.2,0.8;
                0.8,0.7,0.2;
                0.6,0.6,0.4;
                0.8,0.6,0.6;
                0.1,0.7,0.7;
                0.8,0.4,0.7;
                0.5,0.6,0.8;
                0.1,0.7,0.5;
                0.7,0.8,0.7;];
model.T_ablity=[0.6,0.5,0.4;
                0.6,0.5,0.3;
                0.5,0.3,0.5;
                0.6,0.3,0.6;
                0.8,0.3,0.2;
                0.5,0.2,0.2;
                0.6,0.7,0.3;
                0.5,0.5,0.3;
                0.4,0.8,0.4;
                0.3,0.3,0.6];
model.T_value=[];
model.Start_POS=[0,0;18,18;35,119;166,84;94,81;239,45;283,51;142,12;293,103;293,134;284,245];
model.T_time=[10,5,10];
model.dim=model.Nt*model.nTask+model.Nt;
% model.dim=model.Nt*model.nTask;
model.diss=dist(model.Start_POS');
model.V=10;
end
example 3
% if i==3
load uvdata
model.Nu=NU;%
model.Nt=NT;%
model.nTask=3;
model.V_ablity=Ub;
model.T_ablity=Tb;
model.T_value=[];
model.Start_POS=[0,0; Pos];
model.T_time=[10,5,10];
model.dim=model.Nt*model.nTask+model.Nt;
model.diss=dist(model.Start_POS');
model.V=10;
end
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
