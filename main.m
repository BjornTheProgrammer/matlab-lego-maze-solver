v = brick.GetBattVoltage() ;
% brick.SetColorMode(4)

brick.TouchPressed(1) 
while brick.TouchPressed(1) == 0
 brick.MoveMotor('A', 100);
 dist = brick.UltrasonicDist(2);
 disp(dist); 
end

brick.StopAllMotors();

disp('Done!')

disp(v);