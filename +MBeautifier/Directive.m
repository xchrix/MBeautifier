classdef (Abstract) Directive < handle

    properties(SetAccess = protected)
        Values
    end

    properties(Abstract, SetAccess = immutable)
        Name
    end

    methods(Abstract, Access = protected)
        [success, toBeGarbageCollected] = tryToupdateFromValue(obj, value)
    end

    methods(Sealed)
        function [success, toBeGarbageCollected] = updateFromValue(obj, value)
            [success, toBeGarbageCollected] = obj.tryToupdateFromValue(value);
            if ~success
                warning('MBeautifier:Directive:InvalidValue', ['The value "', char(value), '" is not a valid directive value for directive "', obj.Name, '".']);
            end
        end
    end
end
