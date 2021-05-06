clear 
clc
names = ["I_Input 1  (X polarization)_ScopePower0_Sweep(0-0-0)_PolarizationX.csv",...
     "Q_Input 1  (X polarization)_ScopePower0_Sweep(0-0-0)_PolarizationX.csv",...
     "out_Input 1  (X polarization)_ScopePower0_Sweep(0-0-0)_PolarizationX.csv",...
     "I_Input 1  (X polarization)_ScopePhase0_Sweep(0-0-0)_PolarizationX.csv",...
     "Q_Input 1  (X polarization)_ScopePhase0_Sweep(0-0-0)_PolarizationX.csv",...
     "out_Input 1  (X polarization)_ScopePhase0_Sweep(0-0-0)_PolarizationX.csv"];
titles = ["I power","Q power","Output power","I phase","Q phase","Output phase"];

n = 6;
dpowers = [];
dphases = [];

for i = 1:n
    x = i;
    spec = readtable(names(i));
    time = table2array(spec(:,1));
    p = table2array(spec(:,2));
    if i>=4
        x=i+2;
    end
    subplot(2,5,x)
    
    if i==4
        p = p+159;
    elseif i==5
        p = p+159-360
    else
        p = p;
    end
    
    if i==1 || i ==4
        plot(time,p,'g','LineWidth',2)
    elseif i==2 || i ==5
            plot(time,p,'b','LineWidth',2)
    else
        plot(time,p,'m','LineWidth',2)
    end
    cx = time(0.4*length(time));
    cy = p(0.4*length(p));
    hold on
    plot(cx,cy,'o','MarkerEdgeColor','black','MarkerSize',2,'MarkerFaceColor','black')
    hold off
    letters = num2str(p(0.4*length(p)));
    text(cx,cy+20,letters)
    title(titles(i))
    xlabel('Time (ns)')
    if i>=4
        ylabel('Phase (º)')
        ylim([-200 200])
        text(cx,cy+20,[letters,'º'])
        dphases(:,i-3)=p;
    else 
        ylabel('Power ({\mu}W)')
        ylim([0 400])
        text(cx,cy+20,[letters,'{\mu}W']);
        dpowers(:,i)=p;
    end
    grid on
end
leg = ["I","Q","output"];
col = ['g','b','m'];
for i=1:3
    subplot(1,5,[4 5]);
    polarplot(dphases(500:end,i)*3.1416/180,dpowers(500:end,i),'o','MarkerSize',2,'MarkerEdgeColor',col(i),'MarkerFaceColor',col(i),'DisplayName',leg(i))
    hold on
end
title('I = -1 & Q = 1')
hold off