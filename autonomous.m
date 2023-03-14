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

    distances = getAllDistances(brick, leftMotorPort, rightMotorPort, gyroSensorPort, ultrasonicSensorPort, 20);
    
    [maxDistance, maxIndex] = max(distances);

    rotateDegrees(brick, leftMotorPort, rightMotorPort, gyroSensorPort, 20, maxIndex * 90 - 90);

    moveTillDistance(brick, leftMotorPort, rightMotorPort, ultrasonicSensorPort, -20, 20);


    color = brick.ColorCode(colorSensorPort);
    angle = brick.GyroAngle(gyroSensorPort);

    output = "";
    for distance = distances
        output = output + fprintf("%.2fcm ", distance);
    end
    output = output + fprintf("- color: %d - degrees: %.2f", color, angle);
    disp(output);

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


function moveTillDistance(brick, leftMotorPort, rightMotorPort, distanceSensorPort, speed, target)
    distance = brick.UltrasonicDist(distanceSensorPort);
    while target < distance
        brick.MoveMotor(leftMotorPort, speed);
        brick.MoveMotor(rightMotorPort, speed);

        distance = brick.UltrasonicDist(distanceSensorPort);
    end

    brick.StopMotor(leftMotorPort, 'Coast');
    brick.StopMotor(rightMotorPort, 'Coast');
end

function distances = getAllDistances(brick, leftMotorPort, rightMotorPort, gyroPort, ultrasonicSensorPort, speed)
    distances = [brick.UltrasonicDist(ultrasonicSensorPort) 0 0 0];
    
    for degree = 90:90:360
        rotateDegrees(brick, leftMotorPort, rightMotorPort, gyroPort, speed, degree);
        distances(round(degree / 90) + 1) = brick.UltrasonicDist(ultrasonicSensorPort);
    end
end
