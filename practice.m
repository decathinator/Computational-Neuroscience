%a = [1:20; 101:120];
%c = sum(a, 1);
%d = sum(a, 2);
%b = sum(a);

% Comment using this
%% but this creaates a section and bolds

%% S Spade, 6/2014: branchExample.m MATLAB R2014a: Illustrate branching
for trial = 1:5
    userNumber = input('Pick a number: ');
    if userNumber <0
        disp('Square root is not real')
    else
        sqrt(userNumber)
    end
    userAgain = input('Another [y/n]?', 's');
    if userAgain ~= 'y'
        break;
    end
end
if trial == 5
    disp('Sorry, only 5 per customer')
elseif userAgain == 'n'
    disp('Bye!')
else
    disp('Sorry, I did not understand that.')
end

%% Nesting
nrows = 3; ncols = 4;
a = zeros(nrows,ncols);
for theRow = 1:nrows
    for theCol = 1:ncols
        a(theRow, theCol) = theRow^2 + theCol^3;
    end
end

%% Loading data


%% Graphing
num_points = 20;
x_list = linspace(0,4,num_points);
y_list = x_list.^2;
plot(x_list, y_list);

if size(x_list) == size(y_list)
    plot(x_list,y_list)
else
    disp('Error: x_list and y_list are not the same size')
end   

t = 0:(pi/50):(10*pi);
plot3(sin(t),cos(t),t);
title('My first plot');

x = linspace(0, 1, 50);
y1 = exp(x); y2 = x.^2;
plot(x, y1, x, y2);

num_curves = 3;
x = linspace(0, 1, 50);
y = zeros(num_curves, size(x,2));
for whichCurve = 1:num_curves,
y(whichCurve,:) = sin(whichCurve*x*2*pi);
end
plot(x,y);

%% Is member
A = [5 3 4 2]; 
B = [2 4 4 4 6 8];


Lia = ismember(A,B);
length(Lia);


