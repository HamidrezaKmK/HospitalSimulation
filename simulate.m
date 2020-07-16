disp("-------Hospital Simulation-------");
disp("Please Enter M/lambda/alpha/mu");
M = input("Enter M (The number of rooms): ");
lambda = input("Enter lambda (Average patients arrival): ");
alpha = input("Enter alpha (Average time of patients' fatigue): ");
mu = input("Enter mu (The service rate of checkin): ");
    
hospital.rooms = {};
for i = 1:M
    hospital.rooms{i} = CheckupRoom(input("Enter service rates of room as a vector"));
end

clock = 0;
E = PriorityQueue(1);

patient_count = input("Enter the number of patients: ");
T_accumulated = 0;
for i = 1:patient_count
    dt = exprnd(1/lambda);
    T_accumulated = T_accumulated + dt;
    entrance_event = [T_accumulated, 0, i, -1];
    E.insert(entrance_event);
    bored_event = [T_accumulated + exprnd(1/alpha), 0, i, -1];
    E.insert(bored_event);
    hospital.patients{i} = Patient();
end