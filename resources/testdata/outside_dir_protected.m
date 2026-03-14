% Test file for path traversal protection
% This file should NOT be accessible via path traversal

function result = protected_function(data)
    result = data * 2;
end
