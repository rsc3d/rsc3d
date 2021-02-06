// Circle segment

// Specify cylinder segment by its length (chord) and arc height
// th is the thickness (height of the resulting cylinder)
module cylinder_segment (chord, h, th, keep_cylinder=false)
{
    v = chord / 2;
    r = (v*v + h*h) / (2 * h);
    difference () {
        translate ([0, -(r - h), 0])
            cylinder (r = r, h = th);
        if (!keep_cylinder) {
            translate ([-2 * r, -4 * r, -th])
                cube ([4 * r, 4 * r, 3 * th]);
        }
    }
}

// Used internally, see below
module _sphere_segment (r, y, alpha)
{
    difference () {
        translate ([0, 0, y])
            sphere (r = r);
        for (xx = [-1:2:1]) {
            rotate ([0, xx * alpha / 2, 0])
                translate ([xx*2*r, 0, -r + 2*(r+y)])
                    cube (4*r, center = true);
        }
    }
}

// cut out a segment from a sphere, the part will stand on its tip
// Think of a watermelon slice not necessaryly sliced to the middle.
// Height h is from tip to side not to the middle of the slice.
// Useful when you want to align the part.
// 
module sphere_segment1 (chord, h, alpha)
{
    v = chord / 2;
    y = - ( sqrt (v*v + cos (alpha) * h) * (pow (v, 5) - pow (h, 4) * v)
          + sqrt (cos (alpha) + 1) * (pow (h, 6) - h*h * pow (v, 4))
          )
        / ( sqrt (2) * h * pow (v, 4)
          + sqrt (2) * cos (alpha) * h*h * v*v
          - sqrt(2) * (cos (alpha) + 1) * pow (h, 5)
          );
    r = sqrt
      ( pow
        ( (-( sqrt (v*v + cos (alpha) * h) * (pow (v, 5) - pow (h, 4) * v)
            + sqrt (cos (alpha) + 1) * (pow (h, 6) - h*h * pow (v, 4))
            )
          / ( sqrt (2) * h * pow (v, 4)
            + sqrt (2) * cos (alpha) * h*h * v*v
            + (-sqrt (2) * cos (alpha) - sqrt(2)) * pow (h, 5)
            )
          - ( sqrt (cos (alpha) + 1) * h) / sqrt (2)
          )
        , 2
        ) + ((1 - cos (alpha)) * h*h) / 2
      );
    _sphere_segment (r, y, alpha);
}

// Cut out a segment from a sphere, the part will stand on its tip
// Think of a watermelon slice not necessaryly sliced to the middle.
// Height h is from tip to round top.
module sphere_segment (chord, h, alpha)
{
    v = chord / 2;
    r = (h * h + v * v) / (2 * h);
    y = (h - r);
    _sphere_segment (r, y, alpha);
}

// Cut out a segment from a sphere, the part will stand on its tip
// Think of a watermelon slice not necessaryly sliced to the middle.
// We chose parameters so that the outer edge of the segment has
// inclination incl (through the middle of the slice).
module sphere_segment_incl (chord, incl, alpha)
{
    v = chord / 2;
    y = v / incl;
    r = sqrt (v * v + y * y);
    _sphere_segment (r, -y, alpha);
}
