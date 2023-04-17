classdef testImageProcessing < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
        ImProc = ImageProcessing();
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function checkIfImproc(testCase)
            ImProc.assertInstanceOf(ImageProcessing);
        end
        function unimplementedTest(testCase)
            ImProc.assertInstanceOf(ImageProcessing);
        end
    end

end