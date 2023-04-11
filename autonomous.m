loop = 0;

brick.TouchPressed(1);
while brick.TouchPressed(1) == 0
    pause(0.001);
    disp("Starting auto");

    helpers.moveTillIntersection(-80, 30, 40);
    distances = helpers.getAllDistances(80)
    
    absangle = brick.GyroAngle(gyroSensorPort);

    if distances(3) >= 40
        helpers.rotateDegrees(80, absangle - 90);
    elseif distances(2) >= 40
        % helpers.rotateDegrees(80)
        % Do nothing
    elseif distances(3)
        helpers.rotateDegrees(80, absangle + 90);
    else
        helpers.rotateDegrees(80, absangle - 180);
    end

    brick.MoveMotorAngleRel(leftMotorPort, 80, 360 * 2, 'Break');
    brick.MoveMotorAngleRel(rightMotorPort, 80, 360 * 2, 'Break');

    brick.WaitForMotor(leftMotorPort);
    brick.WaitForMotor(rightMotorPort); 


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


    % loop = loop + 1;
    % if loop == 3
        % break;
    % end
end

brick.StopAllMotors();

voltage = brick.GetBattVoltage();
output = fprintf("voltage: %.4f", voltage);
disp(output);

