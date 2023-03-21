classdef helpers
    methods(Static)
        function x = adjustSpeed(degree, target, speed)
            x = (abs(degree - target) .^ 3 / 900000 + .2) * speed;
        end

        function rotateDegrees(brick, leftMotorPort, rightMotorPort, gyroPort, speed, amount)
            degree = brick.GyroAngle(gyroPort);
            while degree ~= amount
                updatedSpeed = helpers.adjustSpeed(degree, amount, speed);
                if degree - amount > 0
                    brick.MoveMotor(leftMotorPort, updatedSpeed);
                    brick.MoveMotor(rightMotorPort, -updatedSpeed);
                else
                    brick.MoveMotor(leftMotorPort, -updatedSpeed);
                    brick.MoveMotor(rightMotorPort, updatedSpeed);
                end
        
                degree = brick.GyroAngle(gyroPort);
            end
        
            brick.StopMotor(leftMotorPort, 'Coast');
            brick.StopMotor(rightMotorPort, 'Coast');
        end
        
        
        function moveTillDistance(brick, leftMotorPort, rightMotorPort, gyroPort, distanceSensorPort, speed, target)
            distance = brick.UltrasonicDist(distanceSensorPort);
            beginningDegree = brick.GyroAngle(gyroPort);

            while target < distance
                currentDegree = brick.GyroAngle(gyroPort);
                updatedSpeed = helpers.adjustSpeed(currentDegree, target, .8);
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
        
                distance = brick.UltrasonicDist(distanceSensorPort);
            end
        
            brick.StopMotor(leftMotorPort, 'Coast');
            brick.StopMotor(rightMotorPort, 'Coast');
        end
        
        function distances = getAllDistances(brick, leftMotorPort, rightMotorPort, gyroPort, ultrasonicSensorPort, speed)
            distances = [brick.UltrasonicDist(ultrasonicSensorPort) 0 0 0];
            
            for degree = 90:90:270
                helpers.rotateDegrees(brick, leftMotorPort, rightMotorPort, gyroPort, speed, degree);
                distances(round(degree / 90) + 1) = brick.UltrasonicDist(ultrasonicSensorPort);
            end
        end
    end
end
