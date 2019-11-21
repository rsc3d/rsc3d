
include <MCAD/boxes.scad>

e = 0.01; // epsilon

clearance = 0.7;

lm8uu_diameter=15+clearance;
lm8uu_length=24+clearance;
lm8uu_support_thickness=3;
m8_diameter = 9;

lm8uu_end_diameter=m8_diameter+1.5;

m3_nut_thickness = 2.5;
zip_width = 3 + clearance;
zip_thickness = 1.5 + clearance;

lm8uu_holder_width=lm8uu_diameter+2*lm8uu_support_thickness;
lm8uu_holder_length=lm8uu_length+2*lm8uu_support_thickness;
lm8uu_holder_height=lm8uu_diameter*0.6+lm8uu_support_thickness*0.5 + m3_nut_thickness +clearance;
lm8uu_holder_gap=(lm8uu_holder_length-6*lm8uu_support_thickness)/2.0;
roundrad = 5;

lhw = lm8uu_holder_width;
lhh = lm8uu_holder_height;
lhl = lm8uu_holder_length;
lhd = lm8uu_diameter;
st  = lm8uu_support_thickness;
led = lm8uu_end_diameter;

module ziptie()
{
    off = 5;

    difference() {
        translate([0,0,(lhh-5)/2])
            cube([lhw+e, zip_width, lhh+5], center=true);
      
        difference() {
            translate([0,0,zip_thickness+off/2])
                cube([lhw-zip_thickness*2, zip_width+1, off], center=true);
            for (rpt=[-13,13]) {
                translate([rpt,0,2])
                    rotate([0,45,0])
                        cube([10,10,10], center = true);
            }
        }
        translate([0,0,zip_thickness+off])
        difference() {
            rotate([90,0,0])
                cylinder(h = 5, r=lhw/2.0-zip_thickness, center=true);
            translate([0,0,-50])
                cube([100,100,100],center=true);
        }
    }
}

module lm8uu_holder()
{
    shift = (lhl-zip_width*2)/6.0+zip_width/2;

    difference()
    {
        translate([0,0,(lhh-roundrad-5)*0.5])
            roundedBox([lhw,lhl,lhh+roundrad+5], roundrad, false);
        translate([0,0,-lhh*0.5-1])
            cube([lhw*2,lhl*2,lhh], center = true);
      
        translate([0, 0, lhd*.5 + st*0.5 + clearance + m3_nut_thickness])
        {
            rotate([90,0,0]) {
                cylinder(r=lhd*0.5, h=lm8uu_length, center=true);
                translate([0,5,0])
                    cube([lhd*0.98, 10, lm8uu_length], center=true);
            }

            rotate([-90,0,0]) {
                cylinder(r=led/2,h=lhl+2, center=true);
                translate([0,-led*.5,0])
                    cube([led, led, lhl+2], center=true);
            }
        }
        
        // m3 nut
        translate([0,0,st*.5])
            rotate([0,0,90])
                cylinder(r=6.2/2, h=10, $fn=6);
        cylinder(r=1.5+clearance/2.0,h=20, center=true, $fn=10);
        
        translate([0,shift,0])
            ziptie();
        translate([0,-shift,0])
            ziptie();
    }
}

for (x=[-lm8uu_holder_width-3, 0]) {
    for (y=[-lm8uu_holder_length-3, 0]) {
        translate ([x, y, 0])
            lm8uu_holder($fa=3, $fs=0.5);
    }
}
