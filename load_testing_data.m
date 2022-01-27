function [test_cropped_faces, test_face_photos, test_nonfaces] = load_testing_data(data_directory)

cd(data_directory);
cd test_cropped_faces

% Get list of all BMP files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.

imagefiles = dir();      
nfiles = length(imagefiles); % Number of files found
nfiles = nfiles - 1;
test_cropped_faces = zeros(100, 100, nfiles);

for i = 3:nfiles
    currentfilename = imagefiles(i).name;
    currentimage = imread(currentfilename);
    doubleimage = im2double(currentimage);
    % skin detection is not necessary, because the images in this direcrory
    % are already 100x100
    test_cropped_faces(:, :, i) = doubleimage;
end

cd('..')
cd test_face_photos

imagefiles = dir();      
nfiles = length(imagefiles); % Number of files found
nfiles = nfiles - 1;

for i = 3:nfiles
    currentfilename = imagefiles(i).name;
    currentimage = imread(currentfilename);

    test_face_photos{i} = currentimage;
end

cd('..')
cd test_nonfaces

imagefiles = dir();      
nfiles = length(imagefiles); % Number of files found
nfiles = nfiles - 1;

for i = 3:nfiles
    currentfilename = imagefiles(i).name;
    currentimage = imread(currentfilename);

    test_nonfaces{i} = currentimage;
end

cd('..')
cd('..')