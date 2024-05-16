function outStruct = PK_Phantom()

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
fields.Bounds = {
'peakName',                        'chemShift',     'linewidth',   'amplitude',    'phase',     'chemShiftDelta',   'amplitudeRatio'};
values.boundsCellArray = {...
{'Water'},                         [4.6, 5.0],       [1,60],        [0,inf],     [-180,180],      [],                [];
{'Glucose'},                       [3.2, 4.0],       [1,60],        [0,inf],     [-180,180],      [],                []; 
{'Acetate'},                       [1.5, 1.9],       [1,60],        [0,inf],     [-180,180],      [],                [];
};

%% initialValues
fields.IV = {
'peakName',                                   'chemShift',     'linewidth',   'amplitude',    'phase'};
values.IVCellArray = {...
{'Water'},                                      4.7,            15,          1,               0;
{'Glucose'},                                    3.8,            35,          1,               0;     
{'Acetate'},                                    1.8,            20,          1,               0;   
};

%% 
fields.PK = {
'peakName',                                 'multiplet',     'chemShiftDelta',   'amplitudeRatio',    'G_linewidth',   'G_amplitude',    'G_phase'   ,'RelPhase',  'G_chemShiftDelta',   'refPeak'};
values.PKCellArray = {...
{'Water'},                                      [],            [],                    [],                     [],            [],            [],          [],           [],                 0;
{'Glucose'},                                    [],            [],                    [],                     [],            [],            [],          [],           [],                 0;
{'Acetate'},                                    [],            [],                    [],                     [],            [],            [],          [],           [],                 0;
};


%% Pass to the function which assembles the constraints into structs and saves them
outStruct = AMARES.priorKnowledge.preparePriorKnowledge(fields,values,'quiet',1);
% outStruct.svnVersion = '$Rev: 7662 $';
% outStruct.svnHeader = '$Header: https://cardiosvn.fmrib.ox.ac.uk/repos/crodgers/FromJalapeno/MATLAB/RodgersSpectroToolsV2/main/+AMARES/+priorKnowledge/PK_7T_Cardiac.m 7662 2014-05-07 13:26:32Z will $';
