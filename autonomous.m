loop = 0;
directions = string([]);

InitKeyboard();
brick.TouchPressed(1);
while key ~= 'q'
    pause(0.001);
    disp("Starting auto");

    % helpers.rotateDegrees(80, 90);

    helpers.moveTillIntersection(-30, 50, 60);

    brick.MoveMotor(leftMotorPort, -80);
    brick.MoveMotor(rightMotorPort, -80);

    pause(.5);

    brick.StopAllMotors();

    distances = helpers.getAllDistances(80)
    
    absangle = brick.GyroAngle(gyroSensorPort)

    d = 90;
    absangle = round(absangle./d).*d

    if distances(3) >= 40
        disp("rotate left");
        helpers.rotateDegrees(90, absangle - 90);
        directions = [directions, "left"];
    elseif distances(2) >= 40
        disp("rotate straight");
        % Do nothing
        directions = [directions, "straight"];
    elseif distances(3)
        disp("rotate right");
        helpers.rotateDegrees(90, absangle + 90);
        directions = [directions, "right"];
    else
        disp("rotate back");
        helpers.rotateDegrees(90, absangle - 180);
        directions = [directions, "backwards"];
    end

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

