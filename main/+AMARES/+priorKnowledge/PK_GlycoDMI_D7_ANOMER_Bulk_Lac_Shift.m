function outStruct = PK_GlycoDMI_D7_ANOMER_Bulk_Lac_Shift()

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
% Govindaraju et al.(2007)

%% Bounds
Glu_lb = 0;
Glu_ub = 30;
fields.Bounds = {
'peakName',                        'chemShift',     'linewidth',   'amplitude',    'phase',     'chemShiftDelta',   'amplitudeRatio'};
values.boundsCellArray = {...
{'Water'},                         [4.6, 5.0],       [0,25],          [0,inf],     [-180,180],      [],                [];
{'Glucose_alpha_1'},               [5.216, 5.216],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                [];
{'Glucose_alpha_2'},               [3.519, 3.519],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_alpha_3'},               [3.698, 3.698],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_alpha_4'},               [3.395, 3.395],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_alpha_5'},               [3.822, 3.822],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_alpha_6'},               [3.826, 3.826],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_alpha_7'},               [3.749, 3.749],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                [];
{'Glucose_beta_1'},                [4.630, 4.630],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                [];
{'Glucose_beta_2'},                [3.230, 3.230],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_beta_3'},                [3.473, 3.473],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_beta_4'},                [3.387, 3.387],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_beta_5'},                [3.450, 3.450],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_beta_6'},                [3.882, 3.882],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                []; 
{'Glucose_beta_7'},                [3.707, 3.707],   [Glu_lb,Glu_ub], [0,inf],     [-180,180],      [],                [];
{'Glx'},                           [2.2, 2.6],       [0,25],          [0,inf],     [-180,180],      [],                [];
{'Lactate'},                       [8.2, 8.4],       [0,25],          [0,inf],     [-180,180],      [],                [];
% {'Lipid'},                         [0.7, 1.1],       [1,100],        [0,inf],     [-180,180],      [],                [];
};

%% initialValues
GA1 = 1;
GA2 = 1;
GL1 = 10;
GL2 = 10;
add_lw = [];
fields.IV = {
'peakName',                         'chemShift',     'linewidth',   'amplitude',    'phase', 'addlinewidth'};
values.IVCellArray = {...
{'Water'},                           4.8,            10,           1,                0,         add_lw;
{'Glucose_alpha_1'},                 5.216,          GL1,          GA1,              0,         add_lw;
{'Glucose_alpha_2'},                 3.519,          GL1,          GA1,              0,         add_lw;
{'Glucose_alpha_3'},                 3.698,          GL1,          GA1,              0,         add_lw;
{'Glucose_alpha_4'},                 3.395,          GL1,          GA1,              0,         add_lw;
{'Glucose_alpha_5'},                 3.822,          GL1,          GA1,              0,         add_lw;
{'Glucose_alpha_6'},                 3.826,          GL1,          GA1,              0,         add_lw;
{'Glucose_alpha_7'},                 3.749,          GL1,          GA1,              0,         add_lw;
{'Glucose_beta_1'},                  4.630,          GL2,          GA2,              0,         add_lw;
{'Glucose_beta_2'},                  3.230,          GL2,          GA2,              0,         add_lw;
{'Glucose_beta_3'},                  3.473,          GL2,          GA2,              0,         add_lw;
{'Glucose_beta_4'},                  3.387,          GL2,          GA2,              0,         add_lw;
{'Glucose_beta_5'},                  3.450,          GL2,          GA2,              0,         add_lw;
{'Glucose_beta_6'},                  3.882,          GL2,          GA2,              0,         add_lw;
{'Glucose_beta_7'},                  3.707,          GL2,          GA2,              0,         add_lw;
{'Glx'},                             2.4,            10,           1,                0,         add_lw;
{'Lactate'},                         8.3,            10,           1,                0,         add_lw;
% {'Lipids'},                          0.9,            30,           1,                 0,          add_lw;
};

%% 
glu_b_lw = [];%14.34493086/7;
fields.PK = {
'peakName',                         'multiplet',     'chemShiftDelta',   'amplitudeRatio',    'G_linewidth',   'G_amplitude',    'G_phase'   ,'RelPhase',  'G_chemShiftDelta',  'G_ChemShift', 'RelChemShift', 'base_linewidth', 'refPeak'};
values.PKCellArray = {...
{'Water'},                          [],            [],                    [],                    [],         [],            [],            [],           [],                   1,              0,             [],                  1;
{'Glucose_alpha_1'},                [],            [],                    [],                     2,          2,             2,            [],           [],                   1,              0.416,         glu_b_lw,            0;
{'Glucose_alpha_2'},                [],            [],                    [],                     2,          2,             3,            [],           [],                   1,              -1.281,        glu_b_lw,            0;
{'Glucose_alpha_3'},                [],            [],                    [],                     2,          2,             3,            [],           [],                   1,              -1.102,        glu_b_lw,            0;
{'Glucose_alpha_4'},                [],            [],                    [],                     2,          2,             3,            [],           [],                   1,              -1.405,        glu_b_lw,            0;
{'Glucose_alpha_5'},                [],            [],                    [],                     2,          2,             3,            [],           [],                   1,              -0.978,        glu_b_lw,            0;
{'Glucose_alpha_6'},                [],            [],                    [],                     2,          2,             3,            [],           [],                   1,              -0.974,        glu_b_lw,            0;
{'Glucose_alpha_7'},                [],            [],                    [],                     2,          2,             3,            [],           [],                   1,              -1.051,        glu_b_lw,            0;
{'Glucose_beta_1'},                 [],            [],                    [],                     2,          9,             2,            [],           [],                   1,              -0.17,         glu_b_lw,            0;
{'Glucose_beta_2'},                 [],            [],                    [],                     2,          9,             3,            [],           [],                   1,              -1.57,         glu_b_lw,            0;
{'Glucose_beta_3'},                 [],            [],                    [],                     2,          9,             3,            [],           [],                   1,              -1.327,        glu_b_lw,            0;
{'Glucose_beta_4'},                 [],            [],                    [],                     2,          9,             3,            [],           [],                   1,              -1.413,        glu_b_lw,            0;
{'Glucose_beta_5'},                 [],            [],                    [],                     2,          9,             3,            [],           [],                   1,              -1.35,         glu_b_lw,            0;
{'Glucose_beta_6'},                 [],            [],                    [],                     2,          9,             3,            [],           [],                   1,              -0.918,        glu_b_lw,            0;
{'Glucose_beta_7'},                 [],            [],                    [],                     2,          9,             3,            [],           [],                   1,              -1.093,        glu_b_lw,            0;
{'Glx'},                            [],            [],                    [],                     [],        [],             [],           [],           [],                   1,              -2.4,          [],                  0;
{'Lactate'},                        [],            [],                    [],                     [],        [],             [],           [],           [],                   1,              3.5,          [],                  0;
% {'Lipids'},                         [],            [],                    [],                     [],              [],              [],          [],           [],                 0;
};


%% Pass to the function which assembles the constraints into structs and saves them
outStruct = AMARES.priorKnowledge.preparePriorKnowledge(fields,values,'quiet',1);
% outStruct.svnVersion = '$Rev: 7662 $';
% outStruct.svnHeader = '$Header: https://cardiosvn.fmrib.ox.ac.uk/repos/crodgers/FromJalapeno/MATLAB/RodgersSpectroToolsV2/main/+AMARES/+priorKnowledge/PK_7T_Cardiac.m 7662 2014-05-07 13:26:32Z will $';