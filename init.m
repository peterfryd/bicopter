fileNameBlade = "bicopter/blade.stl";

h = 0.15;
L = 0.25;

h2 = 0.05;
WingShoulderLinkLength = L+0.1;
WingShoulderLinkWidth = 0.07;
ArmJointLinkWidth = 0.04;
ArmJointRadius = 0.05;
RotorLinkWidth = 0.04;

propellerOffset = 0.05;

RED = [1 0 0];

%% axis %% 
% size = 3;
% x_ax = sim3d.Actor(ActorName='x_ax', ...
%     Mobility=sim3d.utils.MobilityTypes.Movable);
% add(World,x_ax,Actor);
% createShape(x_ax, 'box', [size size size]);
% x_ax.Translation = [10 0 0];
% x_ax.Color = [100 0 0];
% 
% y_ax = sim3d.Actor(ActorName='y_ax', ...
%     Mobility=sim3d.utils.MobilityTypes.Movable);
% add(World,y_ax,Actor);
% createShape(y_ax, 'box', [size size size]);
% y_ax.Translation = [0 10 0];
% y_ax.Color = [0 100 0];
% 
% z_ax = sim3d.Actor(ActorName='z_ax', ...
%     Mobility=sim3d.utils.MobilityTypes.Movable);
% add(World,z_ax,Actor);
% createShape(z_ax, 'box', [size size size]);
% z_ax.Translation = [0 0 10];
% z_ax.Color = [0 0 100];

%% BODY %%
% Body

Body = sim3d.Actor(ActorName='Body', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,Body,Actor);
createShape(Body, 'box', [0.25 0.25 0.2]);
Body.Color = [1 0 0];


%% RIGHT %%
% Shoulder link right
RWingShoulderLink = sim3d.Actor(ActorName='RWingShoulderLink', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,Body,Actor);
createShape(RWingShoulderLink, 'box', [WingShoulderLinkLength, WingShoulderLinkWidth, WingShoulderLinkWidth]);
RWingShoulderLink.Color = RED;
RWingShoulderLink.Parent = Body;

RWingShoulderLink.Translation = [L/2 0 0];


% shoulder right
RWingShoulder = sim3d.Actor(ActorName='RWingShoulder', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,Body,Actor);

RWingShoulder.Color = RED;
RWingShoulder.Parent = Body;
RWingShoulder.Translation = [L 0 0];


% Arm joint link right
RArmJointLink = sim3d.Actor(ActorName='RArmJointLink', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,Body,Actor);
createShape(RArmJointLink, 'cylinder', [ArmJointLinkWidth, ArmJointLinkWidth, h]);

RArmJointLink.Color = RED;
RArmJointLink.Parent = RWingShoulder;
RArmJointLink.Translation = [0 0 h/2];


% Arm joint right
RArmJoint = sim3d.Actor(ActorName='RArmJoint', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,Body,Actor);
createShape(RArmJoint, 'sphere', [ArmJointRadius, ArmJointRadius ArmJointRadius]);

RArmJoint.Color = RED;
RArmJoint.Parent = RWingShoulder;
RArmJoint.Translation = [0 0 h];


% Arm joint link right
RRotorLink = sim3d.Actor(ActorName='RRotorLink', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,RRotorLink,Actor);
createShape(RRotorLink, 'cylinder', [RotorLinkWidth, RotorLinkWidth, h2+propellerOffset]);

RRotorLink.Color = RED;
RRotorLink.Parent = RArmJoint;
RRotorLink.Translation = [0 0 h2/2 + propellerOffset/2];


% Rotor blade right
RRotor = sim3d.Actor(ActorName='RRotor', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,RRotor,Actor);
load(RRotor, fileNameBlade,[1 1 1]*0.1);

RRotor.Parent = RArmJoint;
RRotor.Color = RED;
RRotor.Rotation = [-1/2*pi 0 0];
RRotor.Translation = [0 0 h2];


%% LEFT %%
% Shoulder link left
LWingShoulderLink = sim3d.Actor(ActorName='LWingShoulderLink', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,Body,Actor);
createShape(LWingShoulderLink, 'box', [WingShoulderLinkLength, WingShoulderLinkWidth, WingShoulderLinkWidth]);

LWingShoulderLink.Parent = Body;
LWingShoulderLink.Color = RED;
LWingShoulderLink.Translation = [-L/2 0 0];


% shoulder left
LWingShoulder = sim3d.Actor(ActorName='LWingShoulder', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,Body,Actor);

LWingShoulder.Parent = Body;
LWingShoulder.Color = RED;
LWingShoulder.Translation = [-L 0 0];


% Arm joint link left
LArmJointLink = sim3d.Actor(ActorName='LArmJointLink', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,Body,Actor);
createShape(LArmJointLink, 'cylinder', [ArmJointLinkWidth, ArmJointLinkWidth, h]);

LArmJointLink.Parent = LWingShoulder;
LArmJointLink.Color = RED;
LArmJointLink.Translation = [0 0 h/2];


% Arm joint left
LArmJoint = sim3d.Actor(ActorName='LArmJoint', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,Body,Actor);
createShape(LArmJoint, 'sphere', [ArmJointRadius, ArmJointRadius, ArmJointRadius]);

LArmJoint.Parent = LWingShoulder;
LArmJoint.Color = RED;
LArmJoint.Translation = [0 0 h];


% Arm joint link left
propellerOffset = 0.05;

LRotorLink = sim3d.Actor(ActorName='LRotorLink', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,LRotorLink,Actor);
createShape(LRotorLink, 'cylinder', [RotorLinkWidth, RotorLinkWidth, h2+propellerOffset]);

LRotorLink.Parent = LArmJoint;
LRotorLink.Color = RED;
LRotorLink.Translation = [0 0 h2/2 + propellerOffset/2];


% Rotor blade left
LRotor = sim3d.Actor(ActorName='LRotor', ...
    Mobility=sim3d.utils.MobilityTypes.Movable);
add(World,LRotor,Actor);
load(LRotor, fileNameBlade,[1 1 1]*0.1);

LRotor.Parent = LArmJoint;
LRotor.Color = RED;
LRotor.Rotation = [-1/2*pi 0 0];
LRotor.Translation = [0 0 h2];