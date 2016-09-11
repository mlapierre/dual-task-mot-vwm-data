classdef VWM_Trial
    properties
        Config
        Window
        ObjectType
        Elements % Objects to be remembered
        Condition
        ValidProbe
    end % properties
    
    methods
        % Constructor
        function obj = VWM_Trial(conf, win)
            obj.Config = conf;
            obj.Window = win;
            obj.ObjectType = ObjectType.Square;
            obj.Elements = [];
            obj.Condition = [];
            obj.Elements.Positions = [];
            obj.Elements.Colours = [];
        end
        
        % Randomly assign the colour and position of numEl objects from NumVWMObjectPositions
        % possible positions evenly spaced around a circle r pixels in radius
        function elements = GetElements(obj, numEl)
            cx = obj.Window.WinCentre.x;
            cy = obj.Window.WinCentre.y;
            r = obj.Config.VWMObjectDistance;
            n = obj.Config.NumVWMObjectPositions;
            
            theta = linspace(0, 2*pi, n+1);
            rho = ones(1, n+1)*r;
            [X, Y] = pol2cart(theta, rho);
            pos(1,:) = X(1:n) + cx;
            pos(2,:) = Y(1:n) + cy;
            index = Shuffle(1:n);
            elements.Positions = pos(:, index(1:numEl));
            index = Shuffle(1:size(obj.Config.VWMObjectColours,2));
            elements.Colours = obj.Config.VWMObjectColours(:, index(1:numEl));
        end

        function [elements] = DisplayStimuli(obj, phase, stimDisplayTime)
            % Set coordinates & colour of fixation cross
            win = obj.Window;
            cx = win.WinCentre.x;
            cy = win.WinCentre.y;
            fixPos = [cx cy cx cy; cx cy cx cy]' + 1/obj.Config.DegPerPixel*[ -0.05 -0.25 0.05 0.25; -0.25 -0.05 0.25 0.05]';
            fixColor = 0*ones(3,2);

            obj.Elements = obj.GetElements(obj.Config.NumVWMObjects(phase));

            % Render the stimuli
            win.DrawDots(obj.Elements.Positions, obj.Config.DotWidth, obj.Elements.Colours);
            
            if obj.Config.ShowFixation
                win.DrawFixation(fixColor, fixPos);
            end
            win.Flip();
            WaitSecs(stimDisplayTime);
            elements = obj.Elements;
        end
        
        function [response] = DisplayProbeAndGetResponse(obj, stim)
            % Set coordinates & colour of fixation cross
            win = obj.Window;
            cx = win.WinCentre.x;
            cy = win.WinCentre.y;
            fixPos = [cx cy cx cy; cx cy cx cy]' + 1/obj.Config.DegPerPixel*[ -0.05 -0.25 0.05 0.25; -0.25 -0.05 0.25 0.05]';
            fixColor = 0*ones(3,2);

            index = Shuffle(1:size(stim.Positions,2));
            %validProbe = randi(2) == 1;
            validProbe = obj.ValidProbe;
            response.validProbe = validProbe;
            if validProbe
                % 50% chance of probing a valid object/position
                probe.Position = stim.Positions(:, index(1));
                probe.Colour = stim.Colours(:, index(1));
            else
                % Otherwise display a probe at the location of one object
                % with the colour of a different object
                probe.Position = stim.Positions(:, index(1));
                probe.Colour = stim.Colours(:, index(2));
            end

            win.DrawDots(probe.Position, obj.Config.DotWidth, probe.Colour);
            
            if obj.Config.ShowFixation
                win.DrawFixation(fixColor, fixPos);
            end
            win.DisplayMessageAt('Was this coloured dot in this position before (y/n)?', 'center', cy+120, [0 0 255], 40);
            res = win.GetYN();
            if res == validProbe
                response.correct = 1;
                message = 'Correct!';
            else
                response.correct = 0;
                message = 'Sorry, that was wrong.';
            end
            if obj.Config.ProvideVWMFeedback == 1
                message = [message '\n\nPlease press a key to continue.'];
                win.DisplayMessageAndWait(message, [0 0 255], 40);
            end
        end        
    end % methods
end % classdef
