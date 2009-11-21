difference ()
{
    cube (50);
    rotate (-45, [1, 0, 0])
        translate ([0, -50, 0])
            cube ([75, 50, 75]);
    rotate (45, [0, 1, 0])
        translate ([-50, 0, 0])
            cube ([50, 75, 75]);
}
