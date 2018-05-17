d1=13;
d2=16.5;
d3=18;
h1=48;
h2=13.5;

module cp (d1=d1, d2=d2, d3=d3, h1=h1, h2=h2)
{
    cylinder (h=h1+h2, r=d1/2);
    cylinder (h=h2, r2=d2/2, r1=d3/2);
}


module fourhalves (d1=d1, d2=d2, d3=d3, h1=h1, h2=h2)
{
    difference () {
        union () {
            translate ([0, 0, 0]) rotate ([0, 90, 0])
                cp (d1=d1, d2=d2, d3=d3, h1=h1, h2=h2);

            translate ([0, 1.2*d3, 0]) rotate ([0, 90, 0])
                cp (d1=d1, d2=d2, d3=d3, h1=h1, h2=h2);

            translate ([0, 2.4*d3, 0]) rotate ([0, 90, 0])
                cp (d1=d1, d2=d2, d3=d3, h1=h1, h2=h2);

            translate ([0, 3.6*d3, 0]) rotate ([0, 90, 0])
                cp (d1=d1, d2=d2, d3=d3, h1=h1, h2=h2);
        }
        translate ([-h1-h2, -d3, -d3])
            cube ([3*(h1+h2), 3*4*d3, d3]);
    }
}

//fourhalves ($fa = 6, $fs = .5);

// bigger variant
fourhalves (d1=14, d2=17.5, d3=19, $fa = 6, $fs = .5);
