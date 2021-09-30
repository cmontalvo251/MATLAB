function students_out = Compute_Grades(students_in)
%%THis function will compute the average grade of all students

%%%%Loops

num_students = length(students_in);

%vec = 1:1:num_students;

for idx = 1:1:num_students
    grades_idx = students_in(idx).grades;
    avg = mean(grades_idx);
    %%%MAke a field
    students_in(idx).Average = avg;
    
    %%%I want to know who is passing (Passing is a average grade above 60)
    name_idx = students_in(idx).name;
    if avg >= 60   %%% > , < , >= , <= , ==
        str = [name_idx,' is passing'];
    else
        str = [name_idx,' is not passing'];
    end
    disp(str)
    %%Added a field passfail
    students_in(idx).passfail = str;
    
    
end


%%Pass the input back to the workspace
students_out = students_in;