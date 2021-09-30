clear
clc


x = rand(100,1);

saved_number = realmax;
for idx = 1:length(x)
    current_number = x(idx);
    if current_number < saved_number
        saved_number = current_number;
    end
end


saved_number
