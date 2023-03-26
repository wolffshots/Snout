import Toybox.Graphics; 
import Toybox.Lang;

class Coordinate
{
    public var X;
    public var Y;

    function initialize(x, y)
    {
        X = x;
        Y = y;
    }

    // function drawHorizontalLine(dc, width, length)
    // {
    //     dc.setPenWidth(width);
    //     dc.drawLine(X, Y, X + length, Y);
    // }

    // function drawVerticalLine(dc, width, length)
    // {
    //     dc.setPenWidth(width);
    //     dc.drawLine(X, Y, X, Y + length);
    // }
}