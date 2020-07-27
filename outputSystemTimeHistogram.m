function outputSystemTimeHistogram(hospital)
    results.infected_systemtime = {};
    results.healthy_systemtime = {};
    results.all_systemtime = {};
    for i = 1 : length(hospital.patients)
       if hospital.patients{i}.status == Patient.BORED
           continue;
       end
       if hospital.patients{i}.hasCorona
           results.infected_systemtime{end+1} = hospital.patients{i}.timeInSystem;
       else
           results.healthy_systemtime{end+1} = hospital.patients{i}.timeInSystem;
       end
       results.all_systemtime{end+1} = hospital.patients{i}.timeInSystem;
    end
    subplot(3, 1, 1);
    X = cell2mat(results.all_systemtime);
    h1 = histogram(X);
    title("system time for all");
    %hold on;
    subplot(3, 1, 2);
    h2 = histogram(cell2mat(results.infected_systemtime));
    
    title("system time for infected");
    %hold on;
    subplot(3, 1, 3);
    h3 = histogram(cell2mat(results.healthy_systemtime));
    title("system time for healthy");
    %hold on;
end