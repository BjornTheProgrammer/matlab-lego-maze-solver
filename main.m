v = brick.GetBattVoltage() ;


brick.TouchPressed(1) 
disp('Push the button.')
while brick.TouchPressed(1) == 0
 brick.playTone(100, 300, 500);
 pause(0.75);
end

disp('Done!')

disp(v);
