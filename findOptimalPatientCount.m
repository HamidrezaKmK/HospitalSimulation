function best_patient_count = findOptimalPatientCount(input)
    % use binary search to find the best patient count
    L = 0;
    R = 1000;
    for i = 1 : 20
        mid = round((L+R)/2);
        input.patient_count = mid;
        accuracy = calcSimulationAccuracy(input);
        if (accuracy < 0.95)
            L = mid;
        else
            R = mid;
        end
    end
    best_patient_count = L;
end