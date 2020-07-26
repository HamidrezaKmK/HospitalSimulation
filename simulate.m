
function hospital = simulate(simulationInput)
    ENTER_HOSPITAL = 0;
    CHECKIN = 1;
    ASSIGN_ROOM = 2;
    ENTER_ROOM = 3;
    CHECKUP = 4;
    EXIT_HOSPITAL = 5;
    GOT_BORED = 6;
    
    M = simulationInput.M;
    lambda = simulationInput.lambda;
    alpha = simulationInput.alpha;
    mu = simulationInput.mu;
    hospital.reception = CheckupRoom(mu);
    hospital.rooms = {};
    for i = 1:M
        hospital.rooms{i} = CheckupRoom(simulationInput.rates{i});
    end

    patient_count = simulationInput.patient_count;

    clock = 0;
    E = PriorityQueue(1);
    % Events pattern: [time, type, patientId, roomId, workerId]


    T_accumulated = 0;
    for i = 1:patient_count
        dt = exprnd(1/lambda);
        T_accumulated = T_accumulated + dt;
        boredDuration = exprnd(alpha);
        entrance_event = [T_accumulated, ENTER_HOSPITAL, i, -1, -1];
        E.insert(entrance_event);
        bored_event = [T_accumulated + boredDuration, GOT_BORED, i, -1, -1];
        E.insert(bored_event);
        hospital.patients{i} = Patient(boredDuration, T_accumulated);
    end

    hospital.reception.setHospital(hospital);
    for i = 1 : M
        hospital.rooms{i}.setHospital(hospital);
    end

    while (E.size() > 0)
        event = E.remove();
        clock = event(1);
        type = event(2);
        patientId = event(3);
        roomId = event(4);
        workerId = event(5);
        %disp(event);
        switch type
            case ENTER_HOSPITAL
                %disp('Enter hospital');
                patient = hospital.patients{patientId};
                patient.enterHospital(clock);
                if (hospital.reception.add(patientId, patient.hasCorona, clock) > 0)
                    % Start checkin if possible
                    E.insert([clock, CHECKIN, -1, -1, -1]);
                end
            case CHECKIN
                %disp('Checkin');
                [duration, success, patientId, workerId] = hospital.reception.checkIn(clock);           
                if (success == 0)
                    continue
                end
                patient = hospital.patients{patientId};
                if (patient.status == Patient.BORED)
                    E.insert([clock, CHECKIN, -1, -1, -1]);
                    continue
                end
                patient.checkin(clock);
                E.insert([clock + duration, ASSIGN_ROOM, patientId, -1, -1])
            case ASSIGN_ROOM
                %disp('Assign room');

                % Find best room
                cnt = 1;
                bestRoomIds = {1};
                for i = 2:M
                    bestRoomScore = hospital.rooms{bestRoomIds{1}}.length();
                    thisRoomScore = hospital.rooms{i}.length();
                    disp(bestRoomScore);
                    disp(thisRoomScore);
                    if (bestRoomScore > thisRoomScore)
                        bestRoomIds = {i};
                        cnt = 1;
                    elseif (bestRoomScore == thisRoomScore)
                        cnt = cnt + 1;
                        bestRoomIds{cnt} = i;
                    end
                end
                bestRoomId = bestRoomIds{randi(cnt)};

                % Free reception worker
                hospital.reception.free(1);
                E.insert([clock, CHECKIN, -1, -1, -1]);

                % Enter patient to room
                E.insert([clock, ENTER_ROOM, patientId, bestRoomId, -1])
            case ENTER_ROOM
                %disp('Move to room queue');
                %disp(patientId);
                patient = hospital.patients{patientId};
                patient.enterRoom(clock);
                room = hospital.rooms{roomId};
                if (room.add(patientId, patient.hasCorona, clock) > 0)
                    E.insert([clock, CHECKUP, -1, roomId, -1])
                end
                patient.renewBoredTime(clock)
                E.insert([patient.boredTime, GOT_BORED, patientId, roomId, -1])
            case CHECKUP
                room = hospital.rooms{roomId};
                [duration, success, patientId, workerId] = room.checkIn(clock);
                if (success == 0)
                    continue
                end
                %disp('Checkup patient');
                %disp(patientId);
                if (patient.status == Patient.BORED)
                    E.insert([clock, CHECKUP, -1, roomId, -1]);
                    continue
                end
                patient = hospital.patients{patientId};
                patient.checkup(clock);
                %disp(patientId);
                E.insert([clock + duration, EXIT_HOSPITAL, patientId, roomId, workerId]);
            case EXIT_HOSPITAL
                %disp('Leaveing happy');
                %disp(patientId);
                %disp('DEBUG2: ------------------------------')
                %disp(workerId)
                patient = hospital.patients{patientId};
                room = hospital.rooms{roomId};
                room.free(workerId);
                E.insert([clock, CHECKUP, -1, roomId, -1]);
                patient.exitHospital(clock);
            case GOT_BORED
                patient = hospital.patients{patientId};
                if (clock ~= patient.boredTime)
                    continue
                end
                if (roomId == -1)
                    if (patient.status == Patient.IN_RECEPTION_QUEUE)
                        hospital.reception.patientGetsBored(clock);
                    end
                elseif (patient.status == Patient.IN_ROOM_QUEUE)
                    room = hospital.rooms{roomId};
                    room.patientGetsBored(clock);
                else
                    continue
                end
                % disp('Leaveing sad');
                patient.bored(clock);
        end
    end
end