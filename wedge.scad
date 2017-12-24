module wedge (h1 = 25, h2 = 15, l=65, w=40)
{
    alpha = atan ((h1 - h2) / l);
    difference () {
        cube ([l, w, h1]);
        translate ([0, 0, h1])
            rotate ([0, alpha, 0])
                translate ([-l, -w, 0])
                    cube ([3*l, 3*w, h1]);
    }
}

rotate ([90, 0, 0])
    wedge ();
