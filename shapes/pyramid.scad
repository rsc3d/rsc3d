// desc     | Louvre a=35m | Herodot:          | Cheops      | Chephren
//          | h_p=21.6m    | h_p²=h_s*a/2      | (440/280)   | (410/275)
//          |              |                   | a=230.33m   | a=215.29m
//          |              |                   | h_p=146.59m | h_p=143.87
// ---------+--------------+-------------------+-------------+--------------
// phi      | 50.99        | 51.82             | 51.84       | 53.30
// k (edge) | 0.94 * a     | a*sqrt(sqrt(5)+5))| 0.96 * a    | 0.97 * a
//          |              | /sqrt(8)          |             |
// h_s      | 0.79 * a     | a*sqrt(sqrt(5)+3))| 0.82 * a    | 0.84 * a
//          |              | /sqrt(8)          |             |
// h_p      | 0.62 * a     | a*sqrt(sqrt(5)+1))| 0.64 * a    | 0.67 * a
//          |              | /sqrt(8)          |             |

// desc  | equilateral | equilateral | h_p=a       | equilateral |  max V(A)   
//       | triangle    | from side   |             | over edge   |             
//-------+-------------+-------------+-------------+-------------+-------------
// phi   | 54.74       | 60          | 63.43       | 67.79       | 70.53       
//k(edge)| a           | a*sqrt(5)/2 | a*sqrt(3/2) | a*sqrt(2)   | a*sqrt(5/2) 
// h_s   | a*sqrt(3)/2 | a           | a*sqrt(5)/2 | a*sqrt(7)/2 | a*3/2       
// h_p   | a*sqrt(2)/2 | a*sqrt(3)/2 | a           | a*sqrt(3/2) | a*sqrt(2)   

// Cheops:  2620 - 2580 b.C.
// Herodot:  490 -  424 b.C. (about)

// a: length of side
// h_a: height (h_p in table above) in units of a
module pyramid (a, h_a)
{
    phi = atan (2*h_a);
    dphi = 90 - phi;
    //echo (phi);
    difference () {
        translate ([0, 0, 1.5*a])
            cube ([a, a, 3*a], center = true);
        translate ([a/2, 0, 0])
            rotate ([0, -dphi, 0])
                translate ([2*a, 0, 4*a])
                    cube ([4*a, 4*a, 8*a], center = true);
        translate ([-a/2, 0, 0])
            rotate ([0, dphi, 0])
                translate ([-2*a, 0, 4*a])
                    cube ([4*a, 4*a, 8*a], center = true);
        translate ([0, a/2, 0])
            rotate ([dphi, 0, 0])
                translate ([0, 2*a, 4*a])
                    cube ([4*a, 4*a, 8*a], center = true);
        translate ([0, -a/2, 0])
            rotate ([-dphi, 0, 0])
                translate ([0, -2*a, 4*a])
                    cube ([4*a, 4*a, 8*a], center = true);
    }
}

pyramid (50, 7/11);          // Cheops
//pyramid (50, 55/82);        // Chephren
//pyramid (50, sqrt (2) / 2); // equilateral triangle
//pyramid (50, sqrt (3) / 2); // equilateral seen from side
//pyramid (50, 1.0);          // equilateral seen from side
//pyramid (50, sqrt (3 / 2)); // equilateral seen from edge
//pyramid (50, sqrt (2));     // max volume
