function outputQueueTimeHistogram(hospital)
    results.infected_timeinqueue = {};
    results.healthy_timeinqueue = {};
    results.all_timeinqueue = {};
    for i = 1 : length(hospital.patients)
       if hospital.patients{i}.hasCorona
           results.infected_timeinqueue{end+1} = hospital.patients{i}.timeInQueue;
       else
           results.healthy_timeinqueue{end+1} = hospital.patients{i}.timeInQueue;
       end
       results.all_timeinqueue{end+1} = hospital.patients{i}.timeInQueue;
    end
    subplot(3, 1, 1);
    h1 = histogram(cell2mat(results.all_timeinqueue));
    
    %h1.BinWidth = 0.3;
    title("queue time for all");
    %hold on;
    subplot(3, 1, 2);
    h2 = histogram(cell2mat(results.infected_timeinqueue));
    %h2.BinWidth = 0.3;
    title("queue time for infected");
    %hold on;
    subplot(3, 1, 3);
    h3 = histogram(cell2mat(results.healthy_timeinqueue));
    %h3.BinWidth = 0.3;
    title("queue time for healthy");
    %hold on;
end