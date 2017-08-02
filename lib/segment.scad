// Circle segment

// Specify circle segment by its length (chord) and arc height
// th is the thickness (height of the resulting cylinder)
module circle_segment (chord, h, th)
{
    v = chord / 2;
    r = (v*v + h*h) / (2 * h);
    difference () {
        translate ([0, -(r - h), 0])
            cylinder (r = r, h = th);
        translate ([-chord, -2 * chord, -th])
            cube ([2 * chord, 2 * chord, 3 * th]);
    }
}
