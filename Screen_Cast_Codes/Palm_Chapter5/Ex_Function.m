function papers_out = Ex_Function(papers_in)

num_papers = length(papers_in);

for idx = 1:num_papers
    name = papers_in(idx).name;
    l = 'This is called: ';
    
    %str = [l,name];
    
    %disp(str)
    
    disp([l,name])
    
    
    
end

papers_out = papers_in;