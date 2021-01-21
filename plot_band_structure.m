clear       
NPOTS = 240;

data=importdata('BAND.dat'); 
data_double = str2double(data.textdata);

K_PATH = data.textdata(:,1);                        
Energy = data.textdata(:,2);
[m,n]=size(Energy);    
j = 1;
k = 1;

for i = 1:m
    if Energy(i)== "Band-Index" 
        x = str2double(K_PATH(i+1:i+NPOTS));
        y = str2double(Energy(i+1:i+NPOTS));
        band_structure = plot(x,y,'blue');
        hold on
        i=i+1;
    end
end

for i = 1:m
    if  data_double(i,2) > 0
        conduction(j) = data_double(i,2);
        j = j+1;
    else if data_double(i,2) < 0
       valence(k) = data_double(i,2);
        k = k+1;
        end
    end
end

conduction_bottom = min(conduction);
valence_top = max(valence);
bandgap = conduction_bottom - valence_top;
xlabel('K-PATH');
ylabel('Energy(eV)');
text(3,0.2,['禁带宽度：',num2str(bandgap)]);
title('Band Structure');
axis([0,5,-6,4]);
%plot([0,5],[0,0],'r','linewidth',1)   %绘制费米能