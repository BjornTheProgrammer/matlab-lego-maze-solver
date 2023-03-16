classdef helpers
    methods(Static)
        function rotateDegrees(brick, leftMotorPort, rightMotorPort, gyroPort, speed, amount)
            degree = brick.GyroAngle(gyroPort);
            while degree ~= amount
                adjustedSpeed = (abs(degree - amount) .^ 3 / 900000 + .2) * speed;
                if degree - amount > 0
                    brick.MoveMotor(leftMotorPort, adjustedSpeed);
                    brick.MoveMotor(rightMotorPort, -adjustedSpeed);
                else
                    brick.MoveMotor(leftMotorPort, -adjustedSpeed);
                    brick.MoveMotor(rightMotorPort, adjustedSpeed);
                end
        
                degree = brick.GyroAngle(gyroPort);
            end
        
            brick.StopMotor(leftMotorPort, 'Coast');
            brick.StopMotor(rightMotorPort, 'Coast');
        end
        
        
        function moveTillDistance(brick, leftMotorPort, rightMotorPort, distanceSensorPort, speed, target)
            distance = brick.UltrasonicDist(distanceSensorPort);
            while target < distance
                brick.MoveMotor(leftMotorPort, speed);
                brick.MoveMotor(rightMotorPort, speed);
        
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
