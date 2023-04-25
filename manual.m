v = brick.GetBattVoltage();
% brick.SetColorMode(4)

drivePowerMultiplier = 1;

InitKeyboard();

while 1 == 1
    pause(0.001);
    switch key
        case 'a'
            if drivePowerMultiplier - .05 >= 0
                drivePowerMultiplier = drivePowerMultiplier - .05;
            end
        case 'd'
            if drivePowerMultiplier + .05 <= 1
                drivePowerMultiplier = drivePowerMultiplier + .05;
            end
        case 'q'
            break
        case 'uparrow'
            brick.MoveMotor('AB', 100 * drivePowerMultiplier);
        case 'downarrow'
            brick.MoveMotor('AB', -100 * drivePowerMultiplier);
        case 'leftarrow'
            brick.MoveMotor('A', -100 * drivePowerMultiplier);
            brick.MoveMotor('B', 100 * drivePowerMultiplier);
        case 'rightarrow'
            brick.MoveMotor('A', 100 * drivePowerMultiplier);
            brick.MoveMotor('B', -100 * drivePowerMultiplier);
        case 'w'
            brick.MoveMotor('C', -100 * drivePowerMultiplier);
        case 's'
            brick.MoveMotor('C', 100 * drivePowerMultiplier);
        case 0
            brick.MoveMotor('ABC', 0);
    end
    dist = brick.UltrasonicDist(2);
    disp(dist); 

    % you must constantly get the gyro sensor's location, otherwise it
    % tends to be NaN
    brick.GyroAngle(gyroSensorPort);
end
CloseKeyboard();
brick.StopAllMotors();

disp('Done!')

disp(v);
