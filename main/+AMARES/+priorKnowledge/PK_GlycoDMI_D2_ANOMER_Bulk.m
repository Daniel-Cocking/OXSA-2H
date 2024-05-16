function outStruct = PK_GlycoDMI_D2_ANOMER_Bulk()

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

% Values for chemical shift estimates are taken from:
% Govindaraju et al.(2000)

%% Bounds
Glu_lb = 0;
Glu_ub = 25;
fields.Bounds = {
'peakName',                        'chemShift',     'linewidth',   'amplitude',    'phase',     'chemShiftDelta',   'amplitudeRatio'};
values.boundsCellArray = {...
{'Water'},                         [4.6, 5.0],       [0,25],          [0,inf],     [-180,180],      [],                [];
{'Glucose_alpha_6'},               [3.826, 3.826],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_alpha_7'},               [3.749, 3.749],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_beta_6'},                [3.882, 3.882],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_beta_7'},                [3.707, 3.707],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                [];
{'Glx'},                           [2.2, 2.6],       [0,30],          [0,inf],     [-180,180],      [],                [];
{'Lactate'},                       [1.1, 1.5],       [0,30],          [0,inf],     [-180,180],      [],                [];
% {'Lipid'},                         [0.7, 1.1],       [1,100],        [0,inf],     [-180,180],      [],                [];
};

%% initialValues
GA1 = 0;
GA2 = 0;
GL1 = 2;
GL2 = 2;
add_lw = [];
fields.IV = {
'peakName',                         'chemShift',     'linewidth',   'amplitude',    'phase', 'addlinewidth'};
values.IVCellArray = {...
{'Water'},                           4.8,            10,           1,                0,         add_lw;
{'Glucose_alpha_6'},                 3.826,          GL1,          GA1,              0,         add_lw;
{'Glucose_alpha_7'},                 3.749,          GL1,          GA1,              0,         add_lw;
{'Glucose_beta_6'},                  3.882,          GL2,          GA2,              0,         add_lw;
{'Glucose_beta_7'},                  3.707,          GL2,          GA2,              0,         add_lw;
{'Glx'},                             2.4,            10,           0,                0,         add_lw;
{'Lactate'},                         1.3,            10,           0,                0,         add_lw;
% {'Lipids'},                          0.9,            30,           1,                 0,          add_lw;
};

%% 
glu_b_lw = [];%14.34493086/7;
fields.PK = {
'peakName',                         'multiplet',     'chemShiftDelta',   'amplitudeRatio',    'G_linewidth',   'G_amplitude',    'G_phase'   ,'RelPhase',  'G_chemShiftDelta',  'G_ChemShift', 'RelChemShift', 'base_linewidth', 'refPeak'};
values.PKCellArray = {...
{'Water'},                          [],            [],                    [],                    [],         [],            [],            [],           [],                   1,              0,             [],                  1;
{'Glucose_alpha_6'},                [],            [],                    [],                     2,          2,             2,            [],           [],                   1,              -0.974,        glu_b_lw,            0;
{'Glucose_alpha_7'},                [],            [],                    [],                     2,          2,             2,            [],           [],                   1,              -1.051,        glu_b_lw,            0;
{'Glucose_beta_6'},                 [],            [],                    [],                     2,          4,             2,            [],           [],                   1,              -0.918,        glu_b_lw,            0;
{'Glucose_beta_7'},                 [],            [],                    [],                     2,          4,             2,            [],           [],                   1,              -1.093,        glu_b_lw,            0;
{'Glx'},                            [],            [],                    [],                     [],        [],             [],           [],           [],                   1,              -2.4,          [],                  0;
{'Lactate'},                        [],            [],                    [],                     [],        [],             [],           [],           [],                   1,              -3.5,          [],                  0;
% {'Lipids'},                         [],            [],                    [],                     [],              [],              [],          [],           [],                 0;
};


%% Pass to the function which assembles the constraints into structs and saves them
outStruct = AMARES.priorKnowledge.preparePriorKnowledge(fields,values,'quiet',1);
% outStruct.svnVersion = '$Rev: 7662 $';
% outStruct.svnHeader = '$Header: https://cardiosvn.fmrib.ox.ac.uk/repos/crodgers/FromJalapeno/MATLAB/RodgersSpectroToolsV2/main/+AMARES/+priorKnowledge/PK_7T_Cardiac.m 7662 2014-05-07 13:26:32Z will $';