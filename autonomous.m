ultrasonicSensorPort = 2;
colorSensorPort = 4;
gyroSensorPort = 3;
leftMotorPort = 'A';
rightMotorPort = 'B';
clawMotorPort = 'C';

brick.SetColorMode(colorSensorPort, 2);
brick.GyroCalibrate(gyroSensorPort);

loop = 0;

brick.TouchPressed(1);
while brick.TouchPressed(1) == 0
    pause(0.001);

    brick.playTone(100, 300, 500);
    distances = helpers.getAllDistances(brick, leftMotorPort, rightMotorPort, gyroSensorPort, ultrasonicSensorPort, 70);
    
    brick.playTone(100, 300, 500);
    [maxDistance, maxIndex] = max(distances);

    helpers.rotateDegrees(brick, leftMotorPort, rightMotorPort, gyroSensorPort, 40, maxIndex * 90 - 90);
    brick.playTone(100, 300, 500);

    helpers.moveTillDistance(brick, leftMotorPort, rightMotorPort, ultrasonicSensorPort, -60, 20);
    brick.playTone(100, 300, 500);

    color = brick.ColorCode(colorSensorPort);
    angle = brick.GyroAngle(gyroSensorPort);

    output = "";
    for distance = distances
        output = output + fprintf("%.2fcm ", distance);
    end
    output = output + fprintf("- color: %d - degrees: %.2f", color, angle);
    disp(output);

    loop = loop + 1;
    % if loop == 3
    %     break;
    % end
    break;
end

brick.StopAllMotors();

voltage = brick.GetBattVoltage();
output = fprintf("voltage: %.4f", voltage);
disp(output);

