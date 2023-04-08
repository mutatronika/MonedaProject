function varargout = moneda(varargin)
% MONEDA MATLAB code for moneda.fig
%      MONEDA, by itself, creates a new MONEDA or raises the existing
%      singleton*.
%
%      H = MONEDA returns the handle to a new MONEDA or the handle to
%      the existing singleton*.
%
%      MONEDA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONEDA.M with the given input arguments.
%
%      MONEDA('Property','Value',...) creates a new MONEDA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before moneda_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to moneda_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help moneda

% Last Modified by GUIDE v2.5 26-Mar-2023 21:20:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @moneda_OpeningFcn, ...
                   'gui_OutputFcn',  @moneda_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before moneda is made visible.
function moneda_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to moneda (see VARARGIN)

% Choose default command line output for moneda
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes moneda wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = moneda_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in opendb.
function opendb_Callback(hObject, eventdata, handles)
% hObject    handle to opendb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile({'*.xlsx;*.xls;*.csv;*.txt', 'DataBase (*.xlsx,*.xls,*.csv,*.txt)'
   '*.*',  'All Files (*.*)'},'Select a File');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end
%%% Seleccionar la data
filedb = file;
database = xlsread (file,-1);
[num,txt,raw] = xlsread(file);
%%% Mostrar tabla con fechas
db = readtable(filedb);
fig1 = uifigure('Name','Tabla de Datos');
fig1.Position = [500 500 370 270];
fig1.WindowStyle = 'modal';
uit = uitable(fig1,"Data",db);

%%% Extrae las fechas de la primera y última fila
    primera_fecha = raw{9, 1};
    ultima_fecha = raw{11432, 1}; 
%%% Extrae los precios de la primera y última fila
    primer_valor = raw{9, 2}; 
    ultimo_valor = raw{end, 2}; 
%%% Muestra las fechas en la ventana de comandos
        disp(['La primera fecha tomada fue: ', primera_fecha]);
        fprintf('Y el precio del dolar era:  %.2f\n', primer_valor);
        disp(['La última fecha tomada fue: ', ultima_fecha]);
        fprintf('Y el precio del dolar era:  %.2f\n', ultimo_valor);

        xlswrite('DB Datos.xlsx',{'Primer Valor';'Primera Fecha';'Ultimo Valor';'Ultima Fecha'},'Estadísticas','A2')
        xlswrite('DB Datos.xlsx',[primer_valor;primera_fecha;ultimo_valor;ultima_fecha],'Estadísticas','B2')


% --- Executes during object creation, after setting all properties.
function fileout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Nombre del archivo
set(handles.fileout,filedb);


% --- Executes on button press in calc.
function calc_Callback(hObject, eventdata, handles)
% hObject    handle to calc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%calcular = 



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over fileout.
function fileout_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fileout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in fig1.
function fig1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to fig1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function fig1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fig1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%%% Tabla sin Fechas
db2 = xlsread(filedb);
fig2 = uifigure('Name','Tabla de Datos 2');
fig2.Position = [500 500 370 270];
fig2.WindowStyle = 'modal';
uit = uitable(fig2,"Data",db2);
