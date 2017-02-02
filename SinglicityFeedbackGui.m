function varargout = SinglicityFeedbackGui(varargin)
% SINGLICITYFEEDBACKGUI MATLAB code for SinglicityFeedbackGui.fig
%      SINGLICITYFEEDBACKGUI, by itself, creates a new SINGLICITYFEEDBACKGUI or raises the existing
%      singleton*.
%
%      H = SINGLICITYFEEDBACKGUI returns the handle to a new SINGLICITYFEEDBACKGUI or the handle to
%      the existing singleton*.
%
%      SINGLICITYFEEDBACKGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINGLICITYFEEDBACKGUI.M with the given input arguments.
%
%      SINGLICITYFEEDBACKGUI('Property','Value',...) creates a new SINGLICITYFEEDBACKGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SinglicityFeedbackGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SinglicityFeedbackGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SinglicityFeedbackGui

% Last Modified by GUIDE v2.5 02-Feb-2017 10:51:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SinglicityFeedbackGui_OpeningFcn, ...
                   'gui_OutputFcn',  @SinglicityFeedbackGui_OutputFcn, ...
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


% --- Executes just before SinglicityFeedbackGui is made visible.
function SinglicityFeedbackGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SinglicityFeedbackGui (see VARARGIN)

if ~exist('PicoMotor', 'class')
    error(['The PicoMotor class can not be found in the Matlab search path. ' ...
        'Please add the class to your search path and try again.']);
end

% Choose default command line output for SinglicityFeedbackGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SinglicityFeedbackGui wait for user response (see UIRESUME)
% uiwait(handles.mainWindow);


% --- Outputs from this function are returned to the command line.
function varargout = SinglicityFeedbackGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in tbConnect.
function tbConnect_Callback(hObject, eventdata, handles)
% hObject    handle to tbConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbConnect

if get(hObject,'Value')
    % initialize the PicoMotor object
    PM = PicoMotor('debug', 3);
    handles.PM = PM;
    handles.Connected = 1;
    set(hObject, 'String', 'Disconnect');
else
    % delete the PicoMotor object
    handles.PM.delete;
    handles.Connected = 0;
    set(hObject, 'String', 'Connect');
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in pmSelectAxis.
function pmSelectAxis_Callback(hObject, eventdata, handles)
% hObject    handle to pmSelectAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pmSelectAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pmSelectAxis
if handles.Connected
    contents = cellstr(get(hObject,'String'));
    handles.PM.setMotor(contents{get(hObject,'Value')});
else
    warndlg('Please connect to the PicoMotor controller first');
end


% --- Executes during object creation, after setting all properties.
function pmSelectAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmSelectAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbPlus1.
function pbPlus1_Callback(hObject, eventdata, handles)
% hObject    handle to pbPlus1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.Connected
    handles.PM.rel(1);
    handles.PM.go;
else
    warndlg('Please connect to the PicoMotor controller first');
end


% --- Executes on button press in pbMinus1.
function pbMinus1_Callback(hObject, eventdata, handles)
% hObject    handle to pbMinus1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.Connected
    handles.PM.rel(-1);
    handles.PM.go;
else
    warndlg('Please connect to the PicoMotor controller first');
end


function edPath_Callback(hObject, eventdata, handles)
% hObject    handle to edPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edPath as text
%        str2double(get(hObject,'String')) returns contents of edPath as a double


% --- Executes during object creation, after setting all properties.
function edPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbSelectFolder.
function pbSelectFolder_Callback(hObject, eventdata, handles)
% hObject    handle to pbSelectFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathSelect = uigetdir;
if pathSelect
    set(handles.edPath, 'String', pathSelect);
end


% --- Executes on button press in tbEnableFeedback.
function tbEnableFeedback_Callback(hObject, eventdata, handles)
% hObject    handle to tbEnableFeedback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edPrefix_Callback(hObject, eventdata, handles)
% hObject    handle to edPrefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edPrefix as text
%        str2double(get(hObject,'String')) returns contents of edPrefix as a double


% --- Executes during object creation, after setting all properties.
function edPrefix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edPrefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edMinNum_Callback(hObject, eventdata, handles)
% hObject    handle to edMinNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edMinNum as text
%        str2double(get(hObject,'String')) returns contents of edMinNum as a double


% --- Executes during object creation, after setting all properties.
function edMinNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edMinNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to edThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edThreshold as text
%        str2double(get(hObject,'String')) returns contents of edThreshold as a double


% --- Executes during object creation, after setting all properties.
function edThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edAtomNumber_Callback(hObject, eventdata, handles)
% hObject    handle to edAtomNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edAtomNumber as text
%        str2double(get(hObject,'String')) returns contents of edAtomNumber as a double


% --- Executes during object creation, after setting all properties.
function edAtomNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edAtomNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edFraction_Callback(hObject, eventdata, handles)
% hObject    handle to edFraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edFraction as text
%        str2double(get(hObject,'String')) returns contents of edFraction as a double


% --- Executes during object creation, after setting all properties.
function edFraction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edFraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edStepSize_Callback(hObject, eventdata, handles)
% hObject    handle to edStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edStepSize as text
%        str2double(get(hObject,'String')) returns contents of edStepSize as a double


% --- Executes during object creation, after setting all properties.
function edStepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tbPolarity.
function tbPolarity_Callback(hObject, eventdata, handles)
% hObject    handle to tbPolarity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbPolarity


% --- Executes when selected object is changed in btgrpMotorResolution.
function btgrpMotorResolution_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btgrpMotorResolution 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.PM.setResolution(upper(hObject.String));


% --- Executes on button press in pbSetCamControlFolder.
function pbSetCamControlFolder_Callback(hObject, eventdata, handles)
% hObject    handle to pbSetCamControlFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

todayPath = winqueryreg('HKEY_CURRENT_USER', 'SOFTWARE\ExperimentWizard\Control', 'SavePath');
set(handles.edPath, 'String', [todayPath '\Singlicity\']);


% --- Executes on button press in pbLoadImage.
function pbLoadImage_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = loadImages(hObject, handles);
atomInfo(hObject, handles);

function atomInfo(hObject, handles)
% plot linesum
ls = sum(handles.I, 2);
lsNorm = (ls-min(ls(:)))/(max(ls(:))-min(ls(:)));
plot(handles.axes2, lsNorm, 1:size(handles.I,1));
xlim(handles.axes2, [0 1])
ylim(handles.axes2, [1 size(handles.I,1)])
a = handles.axes2;
a.YDir = 'reverse';
a.YTickLabel = '';
a.XTickLabel = '';
a.XColor = [1 1 1];
a.YColor = [1 1 1];
a.Box = 'on';

% get atom number 
handles.edAtomNumber.String = num2str(sum(ls(:)*(str2double(handles.edPixelSize.String))^2),2);

% perform triple gaussian fit
[xData, yData] = prepareCurveData( (1:size(handles.I,1))', lsNorm );

% Set up fittype and options.
ft = fittype( 'a1*exp(-0.5*(x-x0)^2/w^2)+a2*exp(-0.5*(x-x0+dx)^2/w^2)+a3*exp(-0.5*(x-x0-dx)^2/w^2)+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 0 0 10 0 0];
opts.Robust = 'Bisquare';
opts.StartPoint = [1 0.1 0.1 0 30 20 size(handles.I,1)/2];
opts.Upper = [1 0.5 0.5 0.1 100 50 size(handles.I,1)];

% Fit model to data.
[fitresult, ~] = fit( xData, yData, ft, opts );

% calculate number of atoms in left and right and center strangely normalized.
Nc = sqrt(2*pi)*fitresult.a1*fitresult.w;
Nl = sqrt(2*pi)*fitresult.a2*fitresult.w;
Nr = sqrt(2*pi)*fitresult.a3*fitresult.w;
Na = Nc+Nl+Nr;
% relative number of atoms in each peak.
nc = Nc/Na;
nl = Nl/Na;
nr = Nr/Na;
nnc = nl+nr;

% set actual atom ratio
handles.edFraction.String = num2str(nnc*100,2);

a1 = fitresult.a1;
a2 = fitresult.a2;
a3 = fitresult.a3;
w = fitresult.w;
c = fitresult.c;
dx = fitresult.dx;
x0 = fitresult.x0;

% plot fitresult
hold(handles.axes2, 'on');
xx = 1:size(handles.I,1);
plot(handles.axes2, a1*exp(-0.5*(xx-x0).^2/w^2)+c, xx, '-');
plot(handles.axes2, a2*exp(-0.5*(xx-x0+dx).^2/w^2)+c, xx, '--');
plot(handles.axes2, a3*exp(-0.5*(xx-x0-dx).^2/w^2)+c, xx, '--');

% get and plot thresholds 
th = (str2double(handles.edThreshold.String)/100)*(1-fitresult.c);
plot(handles.axes2, (th+fitresult.c)*[1, 1], [1,size(handles.I,1)]);

hold(handles.axes2, 'off');

function I = loadImages(hObject, handles)
basePath = get(handles.edPath, 'String');
prefix = get(handles.edPrefix, 'String');

listOfFiles = dir([basePath prefix '*.png']);
[~, sortIndex] = sort([listOfFiles(:).datenum],'descend');
I = imread([basePath listOfFiles(sortIndex(1)).name]);
handles.I = I;
imagesc(handles.axes1, handles.I)
set(handles.axes1, 'XTick', '', 'YTick', '');
caxis([ 0 30e12]);
guidata(hObject, handles);



% --- Executes on selection change in lsProtocol.
function lsProtocol_Callback(hObject, eventdata, handles)
% hObject    handle to lsProtocol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lsProtocol contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lsProtocol


% --- Executes during object creation, after setting all properties.
function lsProtocol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lsProtocol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edPixelSize_Callback(hObject, eventdata, handles)
% hObject    handle to edPixelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edPixelSize as text
%        str2double(get(hObject,'String')) returns contents of edPixelSize as a double


% --- Executes during object creation, after setting all properties.
function edPixelSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edPixelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
