clear
clc
inames = ["p_up_Input 1 _ScopePower0_Sweep(0-0-0)_PolarizationNone.csv",...
    "p_up_Copy (14) of Input 1 _ScopePower0_Sweep(0-0-0)_PolarizationNone_Copy14.csv",...
    "I_out_Input 1  (X polarization)_ScopePower0_Sweep(0-0-0)_PolarizationX.csv",...
    "I_out_Input 1  (X polarization)_ScopePhase0_Sweep(0-0-0)_PolarizationX.csv",...
    ];
qnames = ["q_up_Input 1 _ScopePower0_Sweep(0-0-0)_PolarizationNone.csv",...
    "q_up_Copy (13) of Input 1 _ScopePower0_Sweep(0-0-0)_PolarizationNone_Copy13.csv",...
    "Q_out_Input 1  (X polarization)_ScopePower0_Sweep(0-0-0)_PolarizationX.csv",...
    "Q_out_Input 1  (X polarization)_ScopePhase0_Sweep(0-0-0)_PolarizationX.csv",...
    ];
outnames = ["out_Input 1  (X polarization)_ScopePower0_Sweep(0-0-0)_PolarizationX.csv",...
    "out_Input 1  (X polarization)_ScopePhase0_Sweep(0-0-0)_PolarizationX.csv",...
    ];

for i=1:4
    spec = readtable(inames(i));
    time = table2array(spec(:,1));
    p = table2array(spec(:,2));
    if i==1
        x=1;
        subplot(3,4,x)
        plot(time,p,'c','DisplayName','I up')
        xlabel('Time (ns)')
        ylabel('Voltage (V)')
        ylim([-11,1])
        title('I excitation')
    elseif i==2
        hold on
        plot(time,p,'r','DisplayName','I low')
        hold off
        legend
    elseif i==3
        x = 5;
        subplot(3,4,x)
        plot(time,p,'g')
        xlabel('Time (ns)')
        ylabel('Power ({\mu}W)')
        ylim([0,450])
        title('I power')
    elseif i==4
        x = 9;
        subplot(3,4,x)
        plot(time,p,'g')
        xlabel('Time (ns)')
        ylabel('Phase (º)')
        ylim([-200,200])
        title('I phase')
    end
end

for i=1:4
    spec = readtable(qnames(i));
    time = table2array(spec(:,1));
    p = table2array(spec(:,2));
    if i==1
        x=2;
        subplot(3,4,x)
        plot(time,p,'c','DisplayName','Q up')
        xlabel('Time (ns)')
        ylabel('Voltage (V)')
        ylim([-11,1])
        title('Q excitation')
    elseif i==2
        hold on
        plot(time,p,'r','DisplayName','Q low')
        hold off
        legend
    elseif i==3
        x = 6;
        subplot(3,4,x)
        plot(time,p,'b')
        xlabel('Time (ns)')
        ylabel('Power ({\mu}W)')
        ylim([0,450])
        title('Q power')
    elseif i==4
        x = 10;
        subplot(3,4,x)
        plot(time,p,'b')
        xlabel('Time (ns)')
        ylabel('Phase (º)')
        ylim([-200,200])
        title('Q phase')
    end
end

%% 
for i=1:2
    spec = readtable(outnames(i));
    time = table2array(spec(:,1));
    p = table2array(spec(:,2));
    if i==1
        x=[7,8];
        subplot(3,4,x)
        plot(time,p,'m')
        xlabel('Time (ns)')
        ylabel('Power ({\mu}W)')
        ylim([0,450])
        title('Output power')
    elseif i==2
        x=[11,12];
        subplot(3,4,x)
        plot(time,p,'m')
        xlabel('Time (ns)')
        ylabel('Phase (º)')
        ylim([-200,200])
        title('Output phase')
    end
end

%%

spec = readtable(outnames(1));
power= table2array(spec(:,2));
indexes = [];
for i=1:length(p)
    pow = power(i);
    if pow>=259 && pow<=259.5
        indexes(end+1)=i;
    end
end
fdraw = p(indexes);
pdraw = power(indexes);
subplot(3,4,[3,4])
polarplot(fdraw*3.1416/180,pdraw,'o','MarkerSize',2,'MarkerEdgeColor','m','MarkerFaceColor','m')
title('Polar representation')