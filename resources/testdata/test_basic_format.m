% Test file for MBeautifier - Basic Formatting
% This file tests various formatting scenarios

function y = test_function(x)
% Simple function with poor formatting

x = 1;
y = x + 2;

if x > 0
    y = x * 2;
else
    y = x / 2;
end

for i = 1:10
    y = y + i;
end

while x < 100
    x = x + 1;
end

switch x
    case 1
        y = 1;
    case 2
        y = 2;
    otherwise
        y = 0;
end

end
