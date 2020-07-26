function outputNumberOfPatientsInSystem(hospital)
    qq = PriorityQueue();

    for i = 1 : length(hospital.patients)
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
    figure(1);
    plot(results.numberInSystemPlot.X, results.numberInSystemPlot.Y), xlabel("time"), ylabel("number of patients in system"), title("number of patients in system");

end