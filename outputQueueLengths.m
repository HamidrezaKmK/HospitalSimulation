function outputQueueLengths(hospital)
    figure(1);
    X = cell2mat(hospital.reception.queueHistory.time);
    Y = cell2mat(hospital.reception.queueHistory.lengths);
    plot(X, Y), xlabel("time"), ylabel("queue length"), title("queue length of reception during time");
    deltaT = hospital.reception.queueHistory.time{end};
    fprintf("average queue length of reception: %f\n", trapz(X, Y) / deltaT);
    figure(2);
    M = length(hospital.rooms);
    for i = 1 : M
        subplot(1, M, i);
        X = cell2mat(hospital.rooms{i}.queueHistory.time);
        Y = cell2mat(hospital.rooms{i}.queueHistory.lengths);
        plot(X, Y), xlabel("time"), ylabel("queue length"), title(sprintf("queue length of room no.%d during time", i));
        deltaT = hospital.rooms{i}.queueHistory.time{end};
        fprintf("average queue length of room no.%d: %f\n", i, trapz(X, Y) / deltaT);
    end
end
