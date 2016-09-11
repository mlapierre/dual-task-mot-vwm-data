classdef Condition
    properties (Constant)
        LearnedSame = 1;
        LearnedOpposite = 2;
        New = 3;
        Bilateral = 4;
        Unilateral = 5;
        OriginalSame = 6;
        OriginalOpposite = 7;
        MirroredSame = 8;
        MirroredOpposite = 9;
        NewSame = 10;
        NewOpposite = 11;
        Mirrored = 12;
        Excluded = 13;
        SingleTask = 15;
        DualTask = 16;
        Left = 17;
        Right = 18;
        Above = 19;
        Below = 20;
        PerformTaskA = 21;
        PerformTaskB = 22;
        PerformBoth = 23;
        PriorityA = 24;
        PriorityB = 25;
        PriorityEqual = 26;
        PriorityNA = 27;
        SingleSet = 28;
        FullField = 29;
        NA = 30;
        MOTvMOT = 14;
        MOTvVWM = 31;
        VWMTask1st = 32;
        MOTResponse1st = 33;
        VWMResponse1st = 34;
        MOTTask1st = 35;
    end
    
    methods (Static)
        function names = GetNames(conditions)
            names = [];
            for i=1:size(conditions,2)
                names = [names ' ' Condition.GetName(conditions(i))]; 
            end
        end
        
        function name = GetName(condition)
           switch condition
               case Condition.LearnedSame
                    name = 'LearnedSame';
               case Condition.LearnedOpposite
                    name = 'LearnedOpposite';
               case Condition.New
                    name = 'New';
               case Condition.NewSame
                    name = 'NewSame';
               case Condition.NewOpposite
                    name = 'NewOpposite';
               case Condition.Bilateral
                    name = 'Bilateral';
               case Condition.Unilateral
                    name = 'Unilateral';
               case Condition.OriginalSame
                    name = 'OriginalSame';
               case Condition.OriginalOpposite
                    name = 'OriginalOpposite';
               case Condition.MirroredSame
                    name = 'MirroredSame';
               case Condition.MirroredOpposite
                    name = 'MirroredOpposite';
               case Condition.Excluded
                    name = 'Excluded';
               case Condition.MOTvMOT
                    name = 'MOTvMOT';
               case Condition.SingleTask
                    name = 'SingleTask';
               case Condition.DualTask
                    name = 'DualTask';
               case Condition.Left
                    name = 'Left';
               case Condition.Right
                    name = 'Right';
               case Condition.Above
                    name = 'Above';
               case Condition.Below
                    name = 'Below';
               case Condition.PerformTaskA
                    name = 'PerformTaskA';
               case Condition.PerformTaskB
                    name = 'PerformTaskB';
               case Condition.PerformBoth
                    name = 'PerformBoth';
               case Condition.PriorityA
                    name = 'PriorityA';
               case Condition.PriorityB
                    name = 'PriorityB';
               case Condition.PriorityEqual
                    name = 'PriorityEqual';
               case Condition.PriorityNA
                    name = 'PriorityNA';
               case Condition.SingleSet
                    name = 'SingleSet';
               case Condition.NA
                    name = 'NA';
               case Condition.FullField
                    name = 'FullField';
               case Condition.MOTvVWM
                    name = 'MOTvVWM';
               case Condition.VWMTask1st
                    name = 'VWMTask1st';
               case Condition.MOTResponse1st
                    name = 'MOTResponse1st';
               case Condition.VWMResponse1st
                    name = 'VWMResponse1st';
               case Condition.MOTTask1st
                    name = 'MOTTask1st';
           end
        end
    end
end