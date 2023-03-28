classdef helpers
    methods(Static)
        function x = adjustSpeed(degree, target, speed)
            x = (abs(degree - target) .^ 3 / 900000 + .2) * speed;
        end

        function rotateDegrees(speed, amount)
            global brick;
            global colorSensorPort;
            global gyroSensorPort;
            global leftMotorPort;
            global rightMotorPort;

            degree = brick.GyroAngle(gyroSensorPort);
            while degree ~= amount
                color = brick.ColorCode(colorSensorPort);
                updatedSpeed = helpers.adjustSpeed(degree, amount, speed);
                if (color == 2 | color == 3 | color == 5) 
                    brick.StopMotor(leftMotorPort, 'Coast');
                    brick.StopMotor(rightMotorPort, 'Coast');
                    return;
                end
                if degree - amount > 0
                    brick.MoveMotor(leftMotorPort, updatedSpeed);
                    brick.MoveMotor(rightMotorPort, -updatedSpeed);
                else
                    brick.MoveMotor(leftMotorPort, -updatedSpeed);
                    brick.MoveMotor(rightMotorPort, updatedSpeed);
                end
        
                degree = brick.GyroAngle(gyroSensorPort);
            end
        
            brick.StopMotor(leftMotorPort, 'Coast');
            brick.StopMotor(rightMotorPort, 'Coast');
        end
        
        
        function moveTillDistance(speed, target)
            global brick;
            global colorSensorPort;
            global gyroSensorPort;
            global leftMotorPort;
            global rightMotorPort;
            global ultrasonicSensorPort;

            distance = brick.UltrasonicDist(ultrasonicSensorPort);
            beginningDegree = brick.GyroAngle(gyroSensorPort);

            while target < distance
                currentDegree = brick.GyroAngle(gyroSensorPort);
                updatedSpeed = helpers.adjustSpeed(currentDegree, target, .8);

                color = brick.ColorCode(colorSensorPort);
                
                if (color == 2 | color == 3 | color == 5) 
                    brick.StopMotor(leftMotorPort, 'Coast');
                    brick.StopMotor(rightMotorPort, 'Coast');
                    return;
                end

                if (currentDegree > beginningDegree)
                    brick.MoveMotor(leftMotorPort, speed - updatedSpeed);
                    brick.MoveMotor(rightMotorPort, speed);
                elseif (currentDegree < beginningDegree)
                    brick.MoveMotor(leftMotorPort, speed);
                    brick.MoveMotor(rightMotorPort, speed - updatedSpeed);
                else
                    brick.MoveMotor(leftMotorPort, speed);
                    brick.MoveMotor(rightMotorPort, speed);
                end
        
                distance = brick.UltrasonicDist(ultrasonicSensorPort);
            end
        
            brick.StopMotor(leftMotorPort, 'Coast');
            brick.StopMotor(rightMotorPort, 'Coast');
        end
        
        function distances = getAllDistances(speed)
            global brick;
            global colorSensorPort;
            global ultrasonicSensorPort;

            distances = [brick.UltrasonicDist(ultrasonicSensorPort) 0 0 0];
            
            for degree = 90:90:270
                helpers.rotateDegrees(speed, degree);
                distances(round(degree / 90) + 1) = brick.UltrasonicDist(ultrasonicSensorPort);
            end
        end
    end
end
