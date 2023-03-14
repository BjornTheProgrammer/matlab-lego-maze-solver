ultrasonicSensorPort = 2;
colorSensorPort = 4;
gyroSensorPort = 3;
leftMotorPort = 'A';
rightMotorPort = 'B';
clawMotorPort = 'C';

brick.SetColorMode(colorSensorPort, 2);
brick.GyroCalibrate(gyroSensorPort);

brick.TouchPressed(1);
while brick.TouchPressed(1) == 0
    pause(0.001);
    
    dist = brick.UltrasonicDist(ultrasonicSensorPort);
    color = brick.ColorCode(colorSensorPort);
    angle = brick.GyroAngle(gyroSensorPort);
    
    for degree = 90:90:360
        rotateDegrees(brick, leftMotorPort, rightMotorPort, gyroSensorPort, 20, degree)

        output = fprintf("dist: %.2fcm - color: %d - degrees: %.2f", dist, color, angle);
        disp(output);
    end

    break;
end

brick.StopAllMotors();

voltage = brick.GetBattVoltage();
output = fprintf("voltage: %.4f", voltage);
disp(output);

function rotateDegrees(brick, leftMotorPort, rightMotorPort, gyroPort, speed, amount)
    degree = brick.GyroAngle(gyroPort);
    while degree ~= amount
        if degree - amount > 0
            brick.MoveMotor(leftMotorPort, speed);
            brick.MoveMotor(rightMotorPort, -speed);
        else
            brick.MoveMotor(leftMotorPort, -speed);
            brick.MoveMotor(rightMotorPort, speed);
        end

        degree = brick.GyroAngle(gyroPort);
    end

    brick.StopMotor(leftMotorPort, 'Coast');
    brick.StopMotor(rightMotorPort, 'Coast');
end
