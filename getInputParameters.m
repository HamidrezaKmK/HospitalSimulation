function simulationInput = getInputParameters()
    disp('-------Hospital Simulation-------');
    disp('Please Enter M/lambda/alpha/mu');

    simulationInput.M =  input('Enter M (The number of rooms): ');
    simulationInput.lambda = input('Enter lambda (Average patients arrival): ');
    simulationInput.alpha = input('Enter alpha (Average time of patients fatigue): ');
    simulationInput.mu = input('Enter mu (The service rate of reception): ');
    simulationInput.rates = {};
    for i = 1:simulationInput.M
        simulationInput.rates{i} = input(sprintf("Enter service rates of room no. %d as a vector: ", i));
    end
    simulationInput.patient_count = input('Enter the number of patients: ');
end