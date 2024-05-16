function outStruct = PK_GlycoDMI_D2()

%% .M file to assemble the bounds, priorKnowledge and initialValues structs for the matlab implementation of AMARES

%Each of B, PK and IV is a 1xN struct, where N is the number of peaks. Note
%multiplets are counted as one peak.
%The fields are as follows:
%bounds           initialValues          priorKnowledge

%peakName         peakName               peakName
%chemShift        chemShift              multiplet
%linewidth        linewidth              chemShiftDelta
%amplitude        amplitude              amplitudeRatio
%phase            phase                  G_linewidth
%chemShiftDelta                          G_amplitude
%amplitudeRatio                          G_phase
%                                        G_chemShiftDelta
%                                        refPeak

%% 7T file
% This is adapted from version 7 from PK_7T_Cardiac, attempted to implent 
% on DMI 7T.


%% Bounds

% Glucose Linewidth: 25 for D2, 40 for D7
fields.Bounds = {
'peakName',                        'chemShift',     'linewidth',   'amplitude',    'phase',     'chemShiftDelta',   'amplitudeRatio'};
values.boundsCellArray = {...
{'Water'},                         [4.6, 5.0],       [0,20],        [0,inf],     [-180,180],      [],                [];
{'Glucose'},                       [3.6, 4.0],       [0,25],        [0,inf],     [-180,180],      [],                []; 
{'Glx'},                           [2.2, 2.6],       [0,20],        [0,inf],     [-180,180],      [],                [];
{'Lactate'},                       [1.1, 1.5],       [0,20],        [0,inf],     [-180,180],      [],                [];
% {'Lipids'},                        [0.7, 1.1],       [1,100],        [0,inf],     [-45,45],      [],                [];
};

%% initialValues
fields.IV = {
'peakName',                                   'chemShift',     'linewidth',   'amplitude', 'phase'};
values.IVCellArray = {...
{'Water'},                                      4.8,            5,          1,           0;
{'Glucose'},                                    3.8,            5,          1,           0;     
{'Glx'},                                        2.4,            5,          1,           0;   
{'Lactate'},                                    1.3,            5,          1,           0;   
% {'Lipids'},                                     0.9,            30,          1,           0;   
};


%% 
fields.PK = {
'peakName',                                 'multiplet',     'chemShiftDelta',   'amplitudeRatio',    'G_linewidth',   'G_amplitude',    'G_phase'   ,'RelPhase',  'G_chemShiftDelta',  'G_ChemShift', 'RelChemShift', 'refPeak'};
values.PKCellArray = {...
{'Water'},                                      [],            [],                    [],                     [],            [],            [],          [],           [],                1,            0,             1;
{'Glucose'},                                    [],            [],                    [],                     [],            [],            [],          [],           [],                1,            -1,            0;
{'Glx'},                                        [],            [],                    [],                     [],            [],            [],          [],           [],                1,            -2.4,          0;
{'Lactate'},                                    [],            [],                    [],                     [],            [],            [],          [],           [],                1,            -3.5,          0;
% {'Lipids'},                                     [],            [],                    [],                     [],            [],            [],          [],           [],                 0;
};


%% Pass to the function which assembles the constraints into structs and saves them
outStruct = AMARES.priorKnowledge.preparePriorKnowledge(fields,values,'quiet',1);
% outStruct.svnVersion = '$Rev: 7662 $';
% outStruct.svnHeader = '$Header: https://cardiosvn.fmrib.ox.ac.uk/repos/crodgers/FromJalapeno/MATLAB/RodgersSpectroToolsV2/main/+AMARES/+priorKnowledge/PK_7T_Cardiac.m 7662 2014-05-07 13:26:32Z will $';