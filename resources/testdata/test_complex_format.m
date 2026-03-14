% Test file for MBeautifier - Complex formatting scenarios
% Tests strings, comments, operators, and special cases

function test_complex()
% Function with various syntax elements

% String handling
str1 = 'hello world';
str2 = "hello world";
str3 = 'it''s a test';
str4 = "he said ""hello""";

% Cell arrays
cell1 = {'a', 'b', 'c'};
cell2 = {1, 2, 3; 4, 5, 6};

% Matrix operations
A = [1, 2, 3; 4, 5, 6];
B = [1, 2, 3; 4, 5, 6];

% Operator spacing
x = 1 + 2;
y = 1 - 2;
z = 1 * 2;
w = 1 / 2;
v = 1^2;

% Unary operators
a = +1;
b = -1;
c = +(-1);

% Anonymous functions
f1 = @(x) x + 1;
f2 = @(x, y) x + y;

% Nested functions
    function inner()
        disp('inner');
end

    % Try-catch
    try
        x = 1;
    catch err
        disp(err.message);
    end

end
