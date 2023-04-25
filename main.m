global brick;

global ultrasonicSensorPort;
global colorSensorPort;
global gyroSensorPort;
global touchSensorPort;
global leftMotorPort;
global rightMotorPort;
global clawMotorPort;
global distanceMotorPort;
global key;

ultrasonicSensorPort = 2;
colorSensorPort = 3;
gyroSensorPort = 1;
touchSensorPort = 4;
leftMotorPort = 'A';
rightMotorPort = 'B';
clawMotorPort = 'C';
distanceMotorPort = 'D';

brick.SetColorMode(colorSensorPort, 2);
brick.GyroCalibrate(gyroSensorPort);
brick.ResetMotorAngle(distanceMotorPort);

while 1 == 1
    manual;
    autonomous;
end

disp(brick.GyroAngle(gyroSensorPort))
