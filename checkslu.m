function [bias,flag] = checkslu(model,slu)
bias=0;
flag=zeros(1,2);
for i=1:size(slu,1)
    for j=1:size(slu,2)
       if model.V_ablity(slu(i,j),j)<model.T_ablity(i,j)
             bias=bias+abs(model.V_ablity(slu(i,j),j)-model.T_ablity(i,j));
             flag(1)=1;
       end
    end  
     if size(unique(slu(:,2)),1)~=size(slu(:,2),1)
             bias=bias+((size(slu(:,2),1)-size(unique(slu(:,2)),1)))*0.2;
             flag(2)=1;
     end
    
end
    

end

