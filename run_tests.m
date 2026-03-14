% MBeautifier Test Script
% Run this script to test MBeautifier functionality

fprintf('=== MBeautifier Test Suite ===\n\n');

% Add MBeautifier to path
mbeaut_path = fileparts(mfilename('fullpath'));
addpath(mbeaut_path);
addpath(fullfile(mbeaut_path, '+MBeautifier'));

fprintf('Test 1: Basic File Formatting\n');
try
    input_file = fullfile(mbeaut_path, 'resources', 'testdata', 'test_basic_format.m');
    output_file = fullfile(mbeaut_path, 'resources', 'testdata', 'test_basic_format_formatted.m');

    % Read original
    fid = fopen(input_file, 'r');
    original = fread(fid, '*char')';
    fclose(fid);

    % Format file
    MBeautify.formatFileNoEditor(input_file, output_file);

    % Read formatted
    fid = fopen(output_file, 'r');
    formatted = fread(fid, '*char')';
    fclose(fid);

    fprintf('  PASS: Basic formatting completed\n');

    % Compare
    if ~strcmp(original, formatted)
        fprintf('  PASS: File was modified (formatting applied)\n');
    else
        fprintf('  INFO: File unchanged (may already be formatted)\n');
    end
catch err
    fprintf('  FAIL: %s\n', err.message);
end

fprintf('\nTest 2: Complex File Formatting\n');
try
    input_file = fullfile(mbeaut_path, 'resources', 'testdata', 'test_complex_format.m');
    output_file = fullfile(mbeaut_path, 'resources', 'testdata', 'test_complex_format_formatted.m');

    MBeautify.formatFileNoEditor(input_file, output_file);
    fprintf('  PASS: Complex formatting completed\n');
catch err
    fprintf('  FAIL: %s\n', err.message);
end

fprintf('\nTest 3: Path Traversal Protection\n');
try
    % Create a test file outside MBeautifier directory
    test_file_outside = fullfile(mbeaut_path, '..', 'test_traversal_attack.m');
    fid = fopen(test_file_outside, 'w');
    fprintf(fid, '%% Test file\nx = 1;\n');
    fclose(fid);

    % Try to format it using path traversal
    malicious_path = fullfile(mbeaut_path, '..', 'test_traversal_attack.m');
    output_file = fullfile(mbeaut_path, 'resources', 'testdata', 'test_output.m');

    MBeautify.formatFileNoEditor(malicious_path, output_file);
    fprintf('  FAIL: Path traversal not blocked\n');

    % Cleanup
    if exist(test_file_outside, 'file'), delete(test_file_outside); end
catch err
    if contains(err.message, 'PathTraversal')
        fprintf('  PASS: Path traversal blocked - %s\n', err.message);
    else
        fprintf('  INFO: Error occurred - %s\n', err.message);
    end
    % Cleanup
    if exist(test_file_outside, 'file'), delete(test_file_outside); end
end

fprintf('\nTest 4: Configuration Loading\n');
try
    config = MBeautify.getConfiguration();
    fprintf('  PASS: Configuration loaded successfully\n');

    % Check special rules
    indent_strategy = config.specialRule('Indentation_Strategy').Value;
    fprintf('    Indentation Strategy: %s\n', indent_strategy);
catch err
    fprintf('  FAIL: %s\n', err.message);
end

fprintf('\nTest 5: formatFiles Directory Processing\n');
try
    test_dir = fullfile(mbeaut_path, 'resources', 'testdata');
    MBeautify.formatFiles(test_dir, 'test_*.m', false, false);
    fprintf('  PASS: Directory processing completed\n');
catch err
    fprintf('  FAIL: %s\n', err.message);
end

fprintf('\n=== Test Suite Complete ===\n');

% Cleanup
if exist(output_file, 'file')
    delete(output_file);
end
