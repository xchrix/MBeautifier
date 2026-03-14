% Test keyword padding on same line
function result = test_padding(x)
if (x > 0) result = 1; end
for (i = 1:10) result = i; end
try (x + 1) result = 1; end
catch (err) result = 0; end
end
