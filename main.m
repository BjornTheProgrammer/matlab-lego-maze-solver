global brick;

global ultrasonicSensorPort;
global colorSensorPort;
global gyroSensorPort;
global leftMotorPort;
global rightMotorPort;
global clawMotorPort;
global distanceMotorPort;
global key;

ultrasonicSensorPort = 2;
colorSensorPort = 4;
gyroSensorPort = 3;
leftMotorPort = 'A';
rightMotorPort = 'B';
clawMotorPort = 'C';
distanceMotorPort = 'D';

brick.SetColorMode(colorSensorPort, 2);
brick.GyroCalibrate(gyroSensorPort);
brick.ResetMotorAngle(distanceMotorPort);

manual;
autonomous;

disp(brick.GyroAngle(gyroSensorPort))
