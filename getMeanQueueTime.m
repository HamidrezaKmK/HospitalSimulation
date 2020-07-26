function meanQueueTime = getMeanQueueTime(hospital)
    results.all_timeinqueue = {};
    for i = 1 : length(hospital.patients)
        results.all_timeinqueue{end+1} = hospital.patients{i}.timeInQueue;
    end
    results.all_timeinqueue = cell2mat(results.all_timeinqueue);
    meanQueueTime = mean(results.all_timeinqueue);
end
