% test quadrature rule for function Exp(x/j^\alpha)
clear
close all 
d = 1e4;%length(Data.Lambda);
Data.dstep = 1;
options = spset('RelTol', 1e-12, 'AbsTol', 1e-12, ...
                'GridType', 'gauss-patterson', ... %kronrod-patterson-normal / gauss-hermite / gauss-patterson
                'DimensionAdaptive', 'on', ...
                'DimadaptDegree', 1, ...
                'ProblemType','integration',...
                'GrowthLevel','one', ... %double / one
                'FunctionArgType', 'vector', ...
                'KeepGrid','off',...
                'KeepWeight', 'off',...
                'KeepFunctionValues','on',...
                'MinPoints', 1, ...
                'MaxPoints', min(1e3,Data.dstep*3));
            
Data.gridType = spget(options,'GridType','gauss-hermite');

range = [];
f = @test_fun_alpha3;
%% tGKP
z = spvals(f, d, range, options, Data);
visualization(z)                         
pause(2)

options = spset(options, 'MaxPoints', 1e5, 'PrevResults',z);
z = spvals(f, d, range, options, Data);
visualization(z)  

tGKP.maxLevel = z.maxLevel;
tGKP.Mean = z.Mean;
tGKP.Emean = z.Emean;
tGKP.Emeank = z.Emeank;
tGKP.nindex = z.nindex;
tGKP.allpoints = z.allpoints;
tGKP.oldpoints = z.oldpoints;

%% GK
clear z
options = spset('RelTol', 1e-12, 'AbsTol', 1e-12, ...
                'GridType', 'kronrod-patterson-normal', ... %kronrod-patterson-normal / gauss-hermite / gauss-patterson
                'DimensionAdaptive', 'on', ...
                'DimadaptDegree', 1, ...
                'ProblemType','integration',...
                'GrowthLevel','one', ... %double / one
                'FunctionArgType', 'vector', ...
                'KeepGrid','off',...
                'KeepWeight', 'off',...
                'KeepFunctionValues','on',...
                'MinPoints', 1, ...
                'MaxPoints', min(1e3,Data.dstep*3));

Data.gridType = spget(options,'GridType','gauss-hermite');

z = spvals(f, d, range, options, Data);
visualization(z)                         
pause(2)

options = spset(options, 'MaxPoints', 1e5, 'PrevResults',z);
z = spvals(f, d, range, options, Data);
visualization(z)  

GK.maxLevel = z.maxLevel;
GK.Mean = z.Mean;
GK.Emean = z.Emean;
GK.Emeank = z.Emeank;
GK.nindex = z.nindex;
GK.allpoints = z.allpoints;
GK.oldpoints = z.oldpoints;

%% GH2
clear z
options = spset('RelTol', 1e-12, 'AbsTol', 1e-12, ...
                'GridType', 'gauss-hermite', ... %kronrod-patterson-normal / gauss-hermite / gauss-patterson
                'DimensionAdaptive', 'on', ...
                'DimadaptDegree', 1, ...
                'ProblemType','integration',...
                'GrowthLevel','double', ... %double / one
                'FunctionArgType', 'vector', ...
                'KeepGrid','off',...
                'KeepWeight', 'off',...
                'KeepFunctionValues','on',...
                'MinPoints', 1, ...
                'MaxPoints', min(1e3,Data.dstep*3));

Data.gridType = spget(options,'GridType','gauss-hermite');            
z = spvals(f, d, range, options, Data);
visualization(z)                         
pause(2)

options = spset(options, 'MaxPoints', 1e5, 'PrevResults',z);
z = spvals(f, d, range, options, Data);
visualization(z)  

GH2.maxLevel = z.maxLevel;
GH2.Mean = z.Mean;
GH2.Emean = z.Emean;
GH2.Emeank = z.Emeank;
GH2.nindex = z.nindex;
GH2.allpoints = z.allpoints;
GH2.oldpoints = z.oldpoints;

%% GH1 
clear z
options = spset('RelTol', 1e-12, 'AbsTol', 1e-12, ...
                'GridType', 'gauss-hermite', ... %kronrod-patterson-normal / gauss-hermite / gauss-patterson
                'DimensionAdaptive', 'on', ...
                'DimadaptDegree', 1, ...
                'ProblemType','integration',...
                'GrowthLevel','one', ... %double / one
                'FunctionArgType', 'vector', ...
                'KeepGrid','off',...
                'KeepWeight', 'off',...
                'KeepFunctionValues','on',...
                'MinPoints', 1, ...
                'MaxPoints', min(1e3,Data.dstep*3));

Data.gridType = spget(options,'GridType','gauss-hermite');            
z = spvals(f, d, range, options, Data);
visualization(z)                         
pause(2)

options = spset(options, 'MaxPoints', 1e5, 'PrevResults',z);
z = spvals(f, d, range, options, Data);
visualization(z)  

GH1.maxLevel = z.maxLevel;
GH1.Mean = z.Mean;
GH1.Emean = z.Emean;
GH1.Emeank = z.Emeank;
GH1.nindex = z.nindex;
GH1.allpoints = z.allpoints;
GH1.oldpoints = z.oldpoints;

%%
save QuadExpAlpha3 tGKP GK GH1 GH2

%%
