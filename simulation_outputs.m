


results.all_timeinsystem = [];
results.infected_timeinsystem = [];
results.healthy_timeinsystem = [];
results.all_timeinqueue = [];
results.infected_timeinqueue = [];
results.healthy_timeinqueue = [];
results.is_bored = [];

qq = PriorityQueue();

for i = 1 : patient_count
    if hospital.patients{i}.hasCorona
        results.infected_timeinsystem(end+1) = hospital.patients{i}.timeInSystem;
        results.infected_timeinqueue(end+1) = hospital.patients{i}.timeInQueue;
    else
        results.healthy_timeinsystem(end+1) = hospital.patients{i}.timeInSystem;
        results.healthy_timeinqueue(end+1) = hospital.patients{i}.timeInQueue;
    end
    results.all_timeinsystem(end+1) = hospital.patients{i}.timeInSystem;
    results.all_timeinqueue(end+1) = hospital.patients{i}.timeInQueue;
    
    % handle is bored:
    results.is_bored(end+1) = (hospital.patients{i}.status == Patient.BORED);
    
    % handle number of patients in system plot
    qq.insert([hospital.patients{i}.beginTimeInSystem, 1]);
    qq.insert([hospital.patients{i}.beginTimeInSystem + hospital.patients{i}.timeInSystem, -1]);
end

results.numberInSystemPlot.X = {0};
results.numberInSystemPlot.Y = {0};

while qq.size() > 0
    pk = qq.peek();
    results.numberInSystemPlot.X{end+1} = pk(1);
    results.numberInSystemPlot.Y{end+1} = results.numberInSystemPlot.Y{end};
    results.numberInSystemPlot.X{end+1} = pk(1);
    ad = pk(2);
    qq.remove();
    results.numberInSystemPlot.Y{end+1} = results.numberInSystemPlot.Y{end} + ad;
end
results.numberInSystemPlot.X = cell2mat(results.numberInSystemPlot.X);
results.numberInSystemPlot.Y = cell2mat(results.numberInSystemPlot.Y);
figure(3);
plot(results.numberInSystemPlot.X, results.numberInSystemPlot.Y), xlabel("time"), ylabel("number of patients in system"), title("number of patients in system");
