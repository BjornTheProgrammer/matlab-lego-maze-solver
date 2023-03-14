global key;
InitKeyboard();

v = brick.GetBattVoltage();
% brick.SetColorMode(4)

drivePowerMultiplier = 1;

brick.TouchPressed(1);
while brick.TouchPressed(1) == 0
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
            brick.MoveMotor('AB', 100);
        case 'downarrow'
            brick.MoveMotor('AB', -100);
        case 'leftarrow'
            brick.MoveMotor('A', 100);
            brick.MoveMotor('B', -100);
        case 'rightarrow'
            brick.MoveMotor('A', -100);
            brick.MoveMotor('B', 100);
        case 'w'
            brick.MoveMotor('C', 100);
        case 's'
            brick.MoveMotor('C', -100);
        case 0
            brick.MoveMotor('ABC', 0);
    end
    dist = brick.UltrasonicDist(2);
    disp(dist); 
end
CloseKeyboard();
brick.StopAllMotors();

disp('Done!')

disp(v);
