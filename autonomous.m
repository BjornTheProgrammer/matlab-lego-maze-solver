loop = 0;
directions = string([]);

InitKeyboard();
brick.TouchPressed(1);
while key ~= 'q'
    pause(0.001);
    disp("Starting auto");

    helpers.moveTillIntersection(-30, 50, 60);

    brick.MoveMotor(leftMotorPort, -80);
    brick.MoveMotor(rightMotorPort, -80);

    pause(.5);

    brick.StopAllMotors();

    distances = helpers.getAllDistances(80)
    
    absangle = brick.GyroAngle(gyroSensorPort);

    if distances(3) >= 40
        helpers.rotateDegrees(80, absangle - 90);
        directions = [directions, "left"];
    elseif distances(2) >= 40
        % helpers.rotateDegrees(80)
        % Do nothing
        directions = [directions, "straight"];
    elseif distances(3)
        helpers.rotateDegrees(80, absangle + 90);
        directions = [directions, "right"];
    else
        helpers.rotateDegrees(80, absangle - 180);
        directions = [directions, "backwards"];
    end

    brick.MoveMotorAngleRel(leftMotorPort, 80, 360 * 2, 'Break');
    brick.MoveMotorAngleRel(rightMotorPort, 80, 360 * 2, 'Break');

    brick.WaitForMotor(leftMotorPort);
    brick.WaitForMotor(rightMotorPort); 

    color = brick.ColorCode(colorSensorPort)
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

    directions

    % while String(directions "left", directions "backwards"){
    %     directions = [directions, "straight"]
        
    %    }


    % loop = loop + 1;
    % if loop == 3
        % break;
    % end

    % break;
end
brick.StopAllMotors();
CloseKeyboard();

voltage = brick.GetBattVoltage();
output = fprintf("voltage: %.4f", voltage);
disp(output);

