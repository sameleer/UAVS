function []=plotGantta(Sol,path1,path2) 
model=CreatModel();
if model.id==1
    c=4;
end
if model.id==2
    c=2;
end
if model.id==3
    c=1;
end
slu=Sol.slu;
t=Sol.ttable;
[~,seq]=sort(slu(end-model.Nt+1:end));
 mt=floor(slu(1:end-model.Nt));
 vid=reshape(mt,[model.Nt,model.nTask]);
VN=unique(vid);
color=hsv(64);  
time=repmat(struct(),model.Nu,1);
for i =1:model.Nt
 str=['T',num2str(i)];
 plot(1,1,'Color',color(i*c,:),'DisplayName',str);
 hold on
end
for i =VN'
     time(i).index=Sol.V(i).PTui;
     time(i).tasktype=time(i).index(2,:);
     time(i).tasknum=time(i).index(1,:);
     time(i).tasknum(1);
     time(i).starttime=round(t(time(i).index(1))-model.diss(1,time(i).tasknum(1)+1)/model.V-model.T_time(time(i).tasktype(1)),4);
      time(i).sequence= [time(i).starttime];
     for r =1:size(time(i).index,2)
          time(i).sequence= [ time(i).sequence t(time(i).index(1,r),time(i).index(2,r))];
     end
     
    for j=2:numel(time(i).sequence)
        txt=sprintf('%d,%d',time(i).tasknum(j-1),time(i).tasktype(j-1));
        rec(1)=time(i).sequence(j-1);
        rec(2)=i-0.25;
        rec(3)=time(i).sequence(j)-rec(1);
        rec(4)=0.5;
        rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-','FaceColor',color(c*time(i).tasknum(j-1),:))
        text(rec(1),rec(2)+0.25,txt,'FontSize',10)
        hold on
       
    end
end
ylabel("number of UAVS")
xlabel("time")
legend('location','northeastoutside')
saveas(gcf ,path1)
saveas(gcf ,path2)
hold off
end