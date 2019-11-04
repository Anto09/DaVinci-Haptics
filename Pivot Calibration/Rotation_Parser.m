% Polaris matlab code
% 1/23/2013 for biorobot course homework

tool = 'Sample_Tracker_Data.txt';   %tool's data file directory
T0=importdata(tool);
T1=T0.data;
% Hz=30;      %sampling frequency
% tm=10;       %time
T=zeros(4,4,300);
for i=1:300  %line no.

    w=T1(i,2);
    x=T1(i,3);
    y=T1(i,4);
    z=T1(i,5);
    %following conversion code from wiki
    %http://en.wikipedia.org/wiki/Rotation_matrix#Quaternion
Nq = w^2 + x^2 + y^2 + z^2;
if Nq > 0.0
    s = 2/Nq;
else s = 0.0;
end
X = x*s; Y = y*s; Z = z*s;
wX = w*X; wY = w*Y; wZ = w*Z;
xX = x*X; xY = x*Y; xZ = x*Z;
yY = y*Y; yZ = y*Z; zZ = z*Z;
% rotation matrix conversion:
% [ 1.0-(yY+zZ)       xY-wZ        xZ+wY  ]
% [      xY+wZ   1.0-(xX+zZ)       yZ-wX  ]
% [      xZ-wY        yZ+wX   1.0-(xX+yY) ]
    R(1,1)=1.0-(yY+zZ);
    R(2,1)=xY+wZ;
    R(3,1)=xZ-wY;
    R(1,2)=xY-wZ;
    R(2,2)=1.0-(xX+zZ);
    R(3,2)=yZ+wX;
    R(1,3)=xZ+wY;
    R(2,3)=yZ-wX;
    R(3,3)=1.0-(xX+yY);

T(:,:,i)=[R,[T1(i,6),T1(i,7),T1(i,8)]';0,0,0,1];
        
end