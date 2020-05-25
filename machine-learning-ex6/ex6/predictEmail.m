function predict = predictEmail(model, filenames)
% this function takes as arguments the trained model 'model'
% and emails saved as a text files unter 'filenames'
% filenames should be a cell array


if exist('filenames') == 0',
    % we define a sample filenames cell array
    filenames = {'spamSample1.txt', 'spamSample2.txt', 'emailSample1.txt',...
        'emailSample2.txt', 'ownEmail1.txt', 'ownEmail2.txt', 'ownEmail3.txt'};
end

flen = length(filenames);

predict = zeros(1,flen);

for i = 1:flen,
    filename = filenames{i};

    % Read and predict
    file_contents = readFile(filename);
    word_indices  = processEmail(file_contents);
    x             = emailFeatures(word_indices);
    p          = svmPredict(model, x);
    predict(i) = p;

    fprintf('\nProcessed %s\n\nSpam Classification: %d\n', filename, p);
    fprintf('(1 indicates spam, 0 indicates not spam)\n\n');
end
