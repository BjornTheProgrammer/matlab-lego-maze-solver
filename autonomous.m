loop = 0;

brick.TouchPressed(1);
while brick.TouchPressed(1) == 0
    pause(0.001);
    disp("Starting auto");
    
    % brick.playTone(100, 300, 500);
    % distances = helpers.getAllDistances(brick, leftMotorPort, rightMotorPort, gyroSensorPort, ultrasonicSensorPort, 70);
    
    % brick.playTone(100, 300, 500);
    
    % index = 1;
    % if (distances(1) > 60)
    %     index = 1;
    % elseif (distances(2) > 60)
    %     index = 2;
    % elseif (distances(3) > 60)
    %     index = 3;
    % else
    %     index = 4;
    % end

    % newDirection = index * 90 - 90;
    % helpers.rotateDegrees(brick, leftMotorPort, rightMotorPort, gyroSensorPort, 40, newDirection);
    
    % brick.playTone(100, 300, 500);
    % helpers.moveTillDistance(brick, leftMotorPort, rightMotorPort, gyroSensorPort, ultrasonicSensorPort, -60, 30);

    % color = brick.ColorCode(colorSensorPort);
    % angle = brick.GyroAngle(gyroSensorPort);

    helpers.moveTillIntersection(-80, 30, 40);
    % brick.MoveMotorAngleAbs

    color = brick.ColorCode(colorSensorPort);
    disp(color);
    if (color == 2) 
        brick.playTone(100, 300, 500);
        pause(.7);
        brick.playTone(100, 300, 500);
        break;
    elseif (color == 3)
        brick.playTone(100, 300, 500);
        pause(.7);
        brick.playTone(100, 300, 500);
        pause(.7);
        brick.playTone(100, 300, 500);
        break;
    elseif (color == 5)
        pause(2);
    end

    break;
end

brick.StopAllMotors();

voltage = brick.GetBattVoltage();
output = fprintf("voltage: %.4f", voltage);
disp(output);

