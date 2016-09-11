classdef ObjectState
    properties (Constant)
        Distractor = 0;
        Target = 1;
        Selected = 2;
        Correct = 4;
        Incorrect = 8;
        TargetA = 16;
        TargetB = 32;
        DistractorA = 64;
        DistractorB = 128;
    end
end