% load all the training images

[training_faces, training_nonfaces] = load_training_data(data_directory);

% for each image, generate it's integral image
for i = 1:size(training_faces, 3)
    training_faces_integral(:, :, i) = integral_image(training_faces(:, :, i));
end

for i = 1:size(training_nonfaces, 3)
    training_nonfaces_integral(:, :, i) = integral_image(training_nonfaces(:, :, i));
end
    
% generate 1000 weak classifiers
[face_vertical, face_horizontal] = size(training_faces(:, :, 3));

number = 1000;
weak_classifiers = cell(1, number);
for i = 1:number
    weak_classifiers{i} = generate_classifier(face_vertical, face_horizontal);
end

% evaluate all of the weak classifiers
example_number = size(training_faces, 3) + size(training_nonfaces, 3);
labels = zeros(example_number, 1);
labels (1:size(training_faces, 3)) = 1;
labels((size(training_faces, 3)+1):example_number) = -1;
examples = zeros(face_vertical, face_horizontal, example_number);
examples(:, :, 1:size(training_faces, 3)) = training_faces_integral;
examples(:, :, (size(training_faces, 3) + 1):example_number) = training_nonfaces_integral;

classifier_number = numel(weak_classifiers);

responses = zeros(classifier_number, example_number);

for example = 1:example_number
    integral = examples(:, :, example);
    for feature = 1:classifier_number
        classifier = weak_classifiers {feature};
        responses(feature, example) = eval_weak_classifier(classifier, integral);
    end
end

boosted_classifier = AdaBoost(responses, labels, 15);
save boosted15 boosted_classifier