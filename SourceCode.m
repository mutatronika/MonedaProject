%%Visualizador Inteligente de Datos Estadísticos
% La interface debe permitir que el usuario seleccione la información a procesar y visualizar
% https://la.mathworks.com/help/matlab/ref/uigetfile.html
%%% a. La interface debe permitir cargar la base de datos en Excel desde cualquier ruta (uigetfile)
[file,path] = uigetfile({ ...
    '*.m;*.mlx;*.fig;*.mat;*.slx;*.mdl',...
    'MATLAB Files (*.m,*.mlx,*.fig,*.mat,*.slx,*.mdl)';
   '*.m;*.mlx','Code files (*.m,*.mlx)'; ...
   '*.fig','Figures (*.fig)'; ...
   '*.mat','MAT-files (*.mat)'; ...
   '*.mdl;*.slx','Models (*.slx, *.mdl)'; ...
   '*.pdf','Adobe Reader (*.pdf)';...
   '*.xlsx', 'DataBases (*.xlsx,*.xls,*.csv)'
   '*.*',  'All Files (*.*)'}, ...
   'Select a File');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
    %disp(['User selected ', fullfile(path, file), ...
     %  ' and filter index: ', num2str(indx)])
end
%% b. Debe permitir procesar el libro seleccionado para obtener la información almacenada 
% en la mismo y permitirle al usuario seleccionar la información a mostrar y sobre la cuál operar.
dolar = xlsread ('1.1.1.TCM_Serie historica IQY.xlsx',-1);
[num,txt,raw] = xlsread ('1.1.1.TCM_Serie historica IQY.xlsx');
euro = xlsread ('Datos históricos EUR_COP.csv',-1);
[num,txt,raw] = xlsread('Datos históricos EUR_COP.csv');
%%% Utilizar readtable
dolardb = readtable ('1.1.1.TCM_Serie historica IQY.xlsx');
eurodb = readtable ('Datos históricos EUR_COP.csv');
vars = ["Fecha","Último","Apertura","Máximo","Mínimo","Vol.","% var."];

fig = uifigure;
uit = uitable(fig,"Data",eurodb,"Position",[20 20 350 300]);
%dolar = xlsread ('DB Datos.xlsx',-1);
%[num,txt,raw] = xlsread('HistoricoDolar.xlsx');
