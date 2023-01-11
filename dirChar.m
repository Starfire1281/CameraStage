        function [channel,direction] = dirChar(directionChar)
            %Define direction
            switch directionChar
                case "u"
                    channel = 1;
                    direction = 1;
                case "d"
                    channel = 1;
                    direction = 2;
                case "l"
                    channel = 0;
                    direction = 2;
                case "r"
                    channel = 0;
                    direction = 1;
            end
        end