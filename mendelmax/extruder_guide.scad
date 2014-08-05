module extr ()
{
    e  = 0.01;
    bh = 11.8;
    bw = 11.25;
    bd = 10;
    r  = 12;
    h  = 9;
    difference () {
        union () {
            translate ([-66, -28, 0])
                import
                    ( "jonaskuehling_gregs-wade-v3_jhead-part1.stl"
                    , convexity = 8
                    );
            translate ([0, 15.75, bh / 2 + 12 - e])
                difference () {
                    cube ([bw, bd, bh], center = true);
                    cube ([3.5, bd + 1, bh + 1], center = true);
                }
        }
        translate ([0, 0, 10])
            rotate ([0, 90, 0])
            {
                difference () {
                    cylinder (r = r, h = h - e, center = true);
                    translate ([0, 0,  h / 2])
                        cylinder (r1 = 6, r2 = 8, h = 2, center = true);
                    translate ([0, 0, -h / 2])
                        cylinder (r1 = 8, r2 = 6, h = 2, center = true);
                }
            }
        // To remove other part (but done with meshlab)
        //cube (105, center = true);
        //translate ([20, 103, 0])
        //    cube (105, center = true);
    }
}

extr ();
