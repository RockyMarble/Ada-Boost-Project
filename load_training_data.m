function [training_faces, training_nonfaces] = load_training_data(data_directory)

cd(data_directory);
cd training_faces

% Get list of all BMP files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.

imagefiles = dir();      
nfiles = length(imagefiles); % Number of files found
nfiles = nfiles - 1;

training_faces = zeros(100, 100, nfiles);

for i = 3:nfiles
    currentfilename = imagefiles(i).name;
    currentimage = imread(currentfilename);
    doubleimage = im2double(currentimage);
    training_faces(:, :, i) = doubleimage;
end

cd('..')
cd training_nonfaces

% do it again but for the nonfaces

imagefiles = dir();      
nfiles = length(imagefiles); % Number of files found
nfiles = nfiles - 1;

training_nonfaces = zeros(100, 100, nfiles);

for i = 3:nfiles
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   doubleimage = im2double(currentimage);
   training_nonfaces(:, :, i) = doubleimage(1:100, 1:100);
end

cd('..')
cd('..')