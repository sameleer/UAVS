function [fitness,Sol] = costfunc(slu,model)

Sol=myParslution(model,slu);
[bias,flag]=checkslu(model,Sol.vid);
Sol.flag=flag;
fitness=Sol.t+Sol.T+10000*bias;
end

% +0.0003*sum(abs(slu))