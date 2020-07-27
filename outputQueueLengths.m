function outputQueueLengths(hospital)
    figure(1);
    subplot(3, 1, 1);
    X = cell2mat(hospital.reception.queueHistory.time{1});
    Y = cell2mat(hospital.reception.queueHistory.lengths{1});
    plot(X, Y), xlabel('time'), ylabel('queue length'), title('queue length of reception during time for all');
    deltaT = hospital.reception.queueHistory.time{1}{end};
    fprintf('average queue length of reception: %f\n', trapz(X, Y) / deltaT);
    
    subplot(3, 1, 2);
    X = cell2mat(hospital.reception.queueHistory.time{2});
    Y = cell2mat(hospital.reception.queueHistory.lengths{2});
    plot(X, Y), xlabel('time'), ylabel('queue length'), title('queue length of reception during time for infected');
    deltaT = hospital.reception.queueHistory.time{2}{end};
    fprintf('average queue length of reception for infected: %f\n', trapz(X, Y) / deltaT);
   
    subplot(3, 1, 3);
    X = cell2mat(hospital.reception.queueHistory.time{3});
    Y = cell2mat(hospital.reception.queueHistory.lengths{3});
    plot(X, Y), xlabel('time'), ylabel('queue length'), title('queue length of reception during time for healthy');
    deltaT = hospital.reception.queueHistory.time{3}{end};
    fprintf('average queue length of reception for healthy: %f\n', trapz(X, Y) / deltaT);
   
    
    figure(2);
    M = length(hospital.rooms);
    for i = 1 : M
        subplot(3, M, i);
        X = cell2mat(hospital.rooms{i}.queueHistory.time{1});
        Y = cell2mat(hospital.rooms{i}.queueHistory.lengths{1});
        plot(X, Y), xlabel('time'), ylabel('queue length'), title(sprintf('room %d', i));
        deltaT = hospital.rooms{i}.queueHistory.time{1}{end};
        if deltaT
            fprintf('average queue length of room no.%d: %f\n', i, trapz(X, Y) / deltaT);
        end
        
        subplot(3, M, i + M);
        X = cell2mat(hospital.rooms{i}.queueHistory.time{2});
        Y = cell2mat(hospital.rooms{i}.queueHistory.lengths{2});
        plot(X, Y), xlabel('time'), ylabel('queue length'), title(sprintf('room %d (with Corona)', i));
        deltaT = hospital.rooms{i}.queueHistory.time{2}{end};
        if deltaT
            fprintf('average queue length of room no.%d (with Corona): %f\n', i, trapz(X, Y) / deltaT);
        end
        
        subplot(3, M, i + M + M);
        X = cell2mat(hospital.rooms{i}.queueHistory.time{3});
        Y = cell2mat(hospital.rooms{i}.queueHistory.lengths{3});
        plot(X, Y), xlabel('time'), ylabel('queue length'), title(sprintf('room %d (without Corona)', i));
        deltaT = hospital.rooms{i}.queueHistory.time{3}{end};
        if deltaT
            fprintf('average queue length of room no.%d (without Corona): %f\n', i, trapz(X, Y) / deltaT);
        end
    end
end
