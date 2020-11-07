function [] = export_shape_vtk(data,fname)
% EXPORT_VTK(data,fname,funname) save a fshape structure into a .vtk file
%
%Input
%   data : struct with fields 'x','G' and 'f'. (the field 'f' may be optional)
%   fname : name of the output file


if size(data.x,2)<=2
    data.x = [data.x,zeros(size(data.x,1),3-size(data.x,2))];
end


% open file
fid = fopen(fname,'w');

% header
fprintf(fid,'# vtk DataFile Version 3.0\n');
fprintf(fid,'vtk generated by fshapesTk\n');

fprintf(fid,'%s\n','ASCII');
fprintf(fid,'DATASET POLYDATA\n');

%points
fprintf(fid,'POINTS %u float\n', size(data.x,1));

x = repmat('%G ',1,size(data.x,2)-1);
fprintf(fid,[x,'%G\n'], data.x');



%edges
if size(data.G,2) == 3
    type = 'POLYGONS';
elseif size(data.G,2) == 2
    type = 'LINES';
elseif size(data.G,2) == 1
    type = 'VERTICES';
elseif size(data.G,2) == 4
    type = 'POLYGONS';
end
fprintf(fid,['\n%s %u %u\n'], type,size(data.G,1),(size(data.G,2)+1).*size(data.G,1));

x = [num2str(size(data.G,2)),' ',repmat('%u ',1,size(data.G,2)-1)];
fprintf(fid,[x,'%u\n'], (data.G-1)');


end
