classdef Patient
    %PARIENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        status;
        hasCorona;
    end
    
    methods
        function obj = Patient()
            obj.status = 'in checkin queue';
            obj.hasCorona = rand(1, 1) > 0.9;
        end
         
        function bored(obj)
            obj.status = 'bored';
        end
    end
end

