function [Sol] = myParslution(model,slu)
 [~,seq]=sort(slu(end-model.Nt+1:end));
 mt=floor(slu(1:end-model.Nt));
 Uid=unique(mt);
 vid=reshape(mt,[model.nTask,model.Nt]);
 vid=vid';
 voidV.PTui=[];
 V=repmat(voidV,model.Nu,1);
for t=1:model.nTask
    for n=seq
        u=vid(n,t);
        V(u).PTui(:,end+1)=[n;t];
    end
end
t=zeros(model.Nt,model.nTask);
for  j=1: model.nTask
   for i=seq
     u=vid(i,j);
     if(size(V(u).PTui,1)==1||(V(u).PTui(1,1)==i&&V(u).PTui(2,1)==j))
         if j==1
         t(i,j)=model.diss(1,i+1)/model.V+model.T_time(j);
         else
          t(i,j)=max(model.diss(1,i+1)/model.V,t(i,j-1))+model.T_time(j);
         end
     else
         index=find(V(u).PTui(1,:)==i&V(u).PTui(2,:)==j);
         if j~=1
         t(i,j)=max(t(V(u).PTui(1,index-1),V(u).PTui(2,index-1))+model.diss(V(u).PTui(1,index-1)+1,i+1)/model.V,t(i,j-1))+model.T_time(j);  
         else
         t(i,j)=t(V(u).PTui(1,index-1),V(u).PTui(2,index-1))+model.diss(V(u).PTui(1,index-1)+1,i+1)/model.V+model.T_time(j);
         end
     end
   end
end
Sol.t=max(max(t));
Sol.tm=t;
T=zeros(1,max(Uid));
for u=Uid
    for i=1:size(V(u).PTui,2)-1
        T(u)=T(u)+model.diss(V(u).PTui(1,i)+1,V(u).PTui(1,i+1)+1)/model.V;
    end
        T(u)=T(u)+model.diss(1,V(u).PTui(1,1)+1)/model.V;
end
Sol.T=sum(T);
Sol.vid=vid;
Sol.V=V;
Sol.slu=slu;
Sol.ttable=t;
end