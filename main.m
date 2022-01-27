[test_cropped_faces, test_face_photos, test_nonfaces] = load_testing_data(data_directory);

% for each img in test_cropped_faces
    % feed it into boosted_detector_with_skin_detection

negative_histogram = read_double_image('negatives.bin');
positive_histogram = read_double_image('positives.bin');

number_correct_face = 0;
total_number_face = 0;
number_correct_nonface = 0;
total_number_nonface = 0;

threshold = 8.5;



for i = 3:size(test_cropped_faces)
    img = test_cropped_faces(:, :, i);
    [result] = boosted_detector(img, 1:0.5:3., ...
        boosted_classifier, weak_classifiers, [100, 100], 1);
    
    test_cropped_faces_values(i) = result(5);

    if (result(5) > threshold)
        number_correct_face = number_correct_face + 1;
    end

    total_number_face = total_number_face + 1;

end

for i = 3:size(test_face_photos, 2)
    % convert image to grayscale
    currentimage = test_face_photos{i};
    doubleimage = im2double(currentimage);
    grayscaleimage = double_gray(doubleimage);
    img = grayscaleimage;

    [image, result] = boosted_detector_demo(img, 1:0.5:3., ...
        boosted_classifier, weak_classifiers, [100, 100], 1);

    imshow(image, []);
    
    test_face_photos_values(i) = result(5);

    if (result(5) > threshold)
        number_correct_face = number_correct_face + 1;
    end

    total_number_face = total_number_face + 1;


end

for i = 3:size(test_nonfaces, 2)
    % convert image to grayscale
    currentimage = test_nonfaces{i};
    doubleimage = im2double(currentimage);
    grayscaleimage = double_gray(doubleimage);
    img = grayscaleimage;

    [result] = boosted_detector(img, 1:0.5:3., ...
        boosted_classifier, weak_classifiers, [100, 100], 1);

    test_nonfaces_values(i) = result(5);

    if (result(5) < threshold)
        number_correct_nonface = number_correct_nonface + 1;
    end

    total_number_nonface = total_number_nonface + 1;
end

percent_correct_face = number_correct_face / total_number_face
percent_correct_nonface = number_correct_nonface / total_number_nonface

% for each img in test_face_photos
    % translate to doubles
    % translate to greyscale
    % feed it into boosted_detector_with_skin_detection

% for each img in test_nonfaces
    % translate to doubles
    % translate to greyscale
    % feed it into boosted_detector_with_skin_detection

"done"
