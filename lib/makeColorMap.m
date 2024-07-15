function myColorMap = makeColorMap(topColor, bottomColor, middleColor, N)
    % makeColorMap - Generate a colormap with specified top, middle, and bottom colors.
    %
    % Syntax:
    %   myColorMap = makeColorMap(topColor, bottomColor, middleColor, N)
    %
    % Inputs:
    %   - topColor: RGB values for the top color (1x3 vector).
    %   - bottomColor: RGB values for the bottom color (1x3 vector).
    %   - middleColor: RGB values for the middle color (1x3 vector).
    %   - N: Number of points in the colormap (optional, default is 200).
    %
    % Outputs:
    %   - myColorMap: The generated colormap (Nx3 matrix).

    % Default number of points in the colormap
    if nargin < 4
        N = 200;
    end

    % Adjust top color to ensure it's not brighter than white
    % topColor = topColor + (1 - max(topColor));

    % Adjust bottom color to ensure it's not brighter than white
    % bottomColor = bottomColor + (1 - max(bottomColor));

    % Middle color (not adjusted)

    % Generate color channels for the colormap
    R = vertcat(linspace(bottomColor(1), middleColor(1), N/2)', linspace(middleColor(1), topColor(1), N/2)');
    G = vertcat(linspace(bottomColor(2), middleColor(2), N/2)', linspace(middleColor(2), topColor(2), N/2)');
    B = vertcat(linspace(bottomColor(3), middleColor(3), N/2)', linspace(middleColor(3), topColor(3), N/2)');

    % Combine color channels horizontally to create the colormap
    myColorMap = horzcat(R, G, B);

    % Uncomment the line below if you want to set this colormap globally
    % colormap(myColorMap)
end