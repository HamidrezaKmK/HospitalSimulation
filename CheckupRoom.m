classdef CheckupRoom
    %CHECKUPROOM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        serviceRates;
        queue;
        busy;
    end
    
    methods
        function obj = CheckupRoom(serviceRates)
            %CHECKUPROOM Construct an instance of this class
            %   Detailed explanation goes here
            obj.serviceRates = serviceRates;
            obj.queue = PriorityQueue();
            obj.busy = zeros(1, length(serviceRates));
        end
        
        function sz = add(obj, patientId, hasCorona, time)
            % Returns number of free workers
            score = time;
            if (hasCorona == 1)
                score = -1 / time;
            end
            obj.queue.insert([score, time, patientId]);
            sz = length(obj.busy) - nnz(obj.busy);
        end
        
        function [duration, success, patientId, workerId] = checkIn(obj)
            % 1st: Duration to check
            % 2nd: is anyone to check
            % 3rd: patient to check
            % 4th: worker to check
            duration = 0;
            success = 0;
            patientId = 0;
            workerId = 0;
            % TODO remove bored people
            if (obj.queue.size() == 0)
                return
            end
            freeWorkers = find(~obj.busy);
            workerId = freeWorkers(randi(length(freeWorkers)));
            obj.busy(workerId) = 1;
            duration = poissrnd(obj.serviceRates(workerId));
            success = 1;
            patientId = obj.queue.remove();
            patientId = patientId(3);
            
        end
        
        function free(obj, workerId)
            obj.busy(workerId) = 0;
        end
    end
end

