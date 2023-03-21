ultrasonicSensorPort = 2;
colorSensorPort = 4;
gyroSensorPort = 3;
leftMotorPort = 'A';
rightMotorPort = 'B';
clawMotorPort = 'C';

brick.SetColorMode(colorSensorPort, 2);
brick.GyroCalibrate(gyroSensorPort);

lastDirection = 0;

loop = 0;

brick.TouchPressed(1);
while brick.TouchPressed(1) == 0
    pause(0.001);

    brick.playTone(100, 300, 500);
    distances = helpers.getAllDistances(brick, leftMotorPort, rightMotorPort, gyroSensorPort, ultrasonicSensorPort, 70);
    
    brick.playTone(100, 300, 500);
    
    index = 1;
    if (distances(1) > 60)
        index = 1;
    elseif (distances(2) > 60)
        index = 2;
    elseif (distances(3) > 60)
        index = 3;
    else
        index = 4;
    end

    newDirection = index * 90 - 90;
    helpers.rotateDegrees(brick, leftMotorPort, rightMotorPort, gyroSensorPort, 40, newDirection);
    
    brick.playTone(100, 300, 500);
    helpers.moveTillDistance(brick, leftMotorPort, rightMotorPort, gyroSensorPort, ultrasonicSensorPort, -60, 30);

    color = brick.ColorCode(colorSensorPort);
    angle = brick.GyroAngle(gyroSensorPort);


    loop = loop + 1;
    if loop == 3
        break;
    end

    lastDirection = newDirection;
end

brick.StopAllMotors();

voltage = brick.GetBattVoltage();
output = fprintf("voltage: %.4f", voltage);
disp(output);

