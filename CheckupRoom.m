classdef CheckupRoom
    %CHECKUPROOM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        serviceRates;
    end
    
    methods
        function obj = CheckupRoom(serviceRates)
            %CHECKUPROOM Construct an instance of this class
            %   Detailed explanation goes here
            obj.serviceRates = serviceRates;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.serviceRates + inputArg;
        end
    end
end

