function outputMeanQueueAndSystemTime(hospital)
    results.all_timeinsystem = {};
    results.infected_timeinsystem = {};
    results.healthy_timeinsystem = {};
    results.all_timeinqueue = {};
    results.infected_timeinqueue = {};
    results.healthy_timeinqueue = {};
    results.is_bored = {};
    for i = 1 : length(hospital.patients)
        if hospital.patients{i}.hasCorona
            results.infected_timeinsystem{end+1} = hospital.patients{i}.timeInSystem;
            results.infected_timeinqueue{end+1} = hospital.patients{i}.timeInQueue;
        else
            results.healthy_timeinsystem{end+1} = hospital.patients{i}.timeInSystem;
            results.healthy_timeinqueue{end+1} = hospital.patients{i}.timeInQueue;
        end
        results.all_timeinsystem{end+1} = hospital.patients{i}.timeInSystem;
        results.all_timeinqueue{end+1} = hospital.patients{i}.timeInQueue;

        % handle is bored:
        results.is_bored{end+1} = (hospital.patients{i}.status == Patient.BORED);

    end
    results.all_timeinsystem = cell2mat(results.all_timeinsystem);
    results.infected_timeinsystem = cell2mat(results.infected_timeinsystem);
    results.healthy_timeinsystem = cell2mat(results.healthy_timeinsystem);
    results.all_timeinqueue = cell2mat(results.all_timeinqueue);
    results.infected_timeinqueue = cell2mat(results.infected_timeinqueue);
    results.healthy_timeinqueue = cell2mat(results.healthy_timeinqueue);
    results.is_bored = cell2mat(results.is_bored);
    fprintf("mean time in system for all: %f, for infected: %f, for healthy: %f\n", mean(results.all_timeinsystem), mean(results.infected_timeinsystem), mean(results.healthy_timeinsystem));
    fprintf("mean time in system for all: %f, for infected: %f, for healthy: %f\n", mean(results.all_timeinqueue), mean(results.infected_timeinqueue), mean(results.healthy_timeinqueue));
    fprintf("average number of bored patients: %f\n" , mean(results.is_bored));
    
end