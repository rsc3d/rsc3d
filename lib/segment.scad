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
        translate ([-r, -2 * r, -th])
            cube ([2 * r, 2 * r, 3 * th]);
    }
}

// cut out a segment from a sphere, the part will stand on its tip
module sphere_segment (chord, h, alpha)
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
    difference () {
        translate ([0, 0, y])
            sphere (r = r);
        for (xx = [-1:2:1]) {
            rotate ([0, xx * 45, 0])
                translate ([xx*2*r, 0, -r + 2*(r+y)])
                    cube (4*r, center = true);
        }
    }
}
