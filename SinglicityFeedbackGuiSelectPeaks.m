function varargout = SinglicityFeedbackGuiSelectPeaks(varargin)
% SINGLICITYFEEDBACKGUISELECTPEAKS MATLAB code for SinglicityFeedbackGuiSelectPeaks.fig
%      SINGLICITYFEEDBACKGUISELECTPEAKS, by itself, creates a new SINGLICITYFEEDBACKGUISELECTPEAKS or raises the existing
%      singleton*.
%
%      H = SINGLICITYFEEDBACKGUISELECTPEAKS returns the handle to a new SINGLICITYFEEDBACKGUISELECTPEAKS or the handle to
%      the existing singleton*.
%
%      SINGLICITYFEEDBACKGUISELECTPEAKS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINGLICITYFEEDBACKGUISELECTPEAKS.M with the given input arguments.
%
%      SINGLICITYFEEDBACKGUISELECTPEAKS('Property','Value',...) creates a new SINGLICITYFEEDBACKGUISELECTPEAKS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SinglicityFeedbackGuiSelectPeaks_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SinglicityFeedbackGuiSelectPeaks_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SinglicityFeedbackGuiSelectPeaks

% Last Modified by GUIDE v2.5 09-Mar-2017 11:15:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SinglicityFeedbackGuiSelectPeaks_OpeningFcn, ...
                   'gui_OutputFcn',  @SinglicityFeedbackGuiSelectPeaks_OutputFcn, ...
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


% --- Executes just before SinglicityFeedbackGuiSelectPeaks is made visible.
function SinglicityFeedbackGuiSelectPeaks_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SinglicityFeedbackGuiSelectPeaks (see VARARGIN)


% style gui
set(handles.axes1, 'XTick', '', 'YTick', '');
mainHandles = getappdata(0,'mainHandles');

ls = sum(mainHandles.I, 2);
lsNorm = (ls-min(ls(:)))/(max(ls(:))-min(ls(:)));
plot(handles.axes1, lsNorm, 1:size(mainHandles.I,1));
xlim(handles.axes1, [0 1])
ylim(handles.axes1, [1 size(mainHandles.I,1)])
a = handles.axes1;
a.YDir = 'reverse';
a.XTickLabel = '';
a.XColor = [1 1 1];
a.Box = 'on';
a.YGrid = 'on';

[x, y] = getpts(handles.axes1);

for i = 1:numel(x)
    if i == 1
        handles.edFirstPeak.String = [num2str(x(i),2) '/' num2str(y(i),2)];
    elseif i == 2
        handles.edSecondPeak.String = [num2str(x(i),2) '/' num2str(y(i),2)];
    elseif i == 3
        handles.edThirdPeak.String = [num2str(x(i),2) '/' num2str(y(i),2)];
    end
end

handles.pbFinish.Enable = 'on';

% Choose default command line output for SinglicityFeedbackGuiSelectPeaks
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SinglicityFeedbackGuiSelectPeaks wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SinglicityFeedbackGuiSelectPeaks_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on button press in pbFinish.
function pbFinish_Callback(hObject, eventdata, handles)
% hObject    handle to pbFinish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rmappdata(0,'mainHandles');
delete(get(hObject,'parent'));

function edFirstPeak_Callback(hObject, eventdata, handles)
% hObject    handle to edFirstPeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edFirstPeak as text
%        str2double(get(hObject,'String')) returns contents of edFirstPeak as a double


% --- Executes during object creation, after setting all properties.
function edFirstPeak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edFirstPeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edSecondPeak_Callback(hObject, eventdata, handles)
% hObject    handle to edSecondPeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edSecondPeak as text
%        str2double(get(hObject,'String')) returns contents of edSecondPeak as a double


% --- Executes during object creation, after setting all properties.
function edSecondPeak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edSecondPeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edThirdPeak_Callback(hObject, eventdata, handles)
% hObject    handle to edThirdPeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edThirdPeak as text
%        str2double(get(hObject,'String')) returns contents of edThirdPeak as a double


% --- Executes during object creation, after setting all properties.
function edThirdPeak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edThirdPeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
