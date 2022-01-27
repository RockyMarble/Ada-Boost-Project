function ratio = ratio_of_skin_pixels(skin_detection_result)

[row, col] = size(skin_detection_result);
number_skin_pixels = 0.0;
total_number_of_pixels = row * col;
    
for r = 1:row
    for c = 1:col
        if skin_detection_result(r, c) > 0.005
            number_skin_pixels = number_skin_pixels + 1.0;
        end
    end
end

ratio = number_skin_pixels / total_number_of_pixels;