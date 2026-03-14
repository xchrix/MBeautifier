% Test keyword padding - try/catch
function result = test_try_catch(x)
try
result = x+1;
catch err
result = err.identifier;
end
end
