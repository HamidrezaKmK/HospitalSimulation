classdef Patient
    %PARIENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        status;
        hasCorona;
    end
    
    methods
        function obj = Patient()
            obj.status = "in checkin queue";
            obj.hasCorona = rand(1, 1) > 0.9;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes heres
            outputArg = obj.status + inputArg;
        end
    end
end

