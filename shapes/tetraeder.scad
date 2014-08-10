alpha = acos (1/3);

module tetraeder (len) {
    difference() {
        cube([len, len, len]);
        translate([len,0,0])
            rotate(30,[0,0,1])
                rotate(-(90-alpha),[0,1,0])
                    translate([0,0,-len*0.3])
                        cube([len*1.6, len*1.6, len*1.6]);
        rotate(-30,[0,0,1])
            rotate(90-alpha,[0,1,0])
                translate([-len*1.6,0,-len*0.3])
                    cube([len*1.6, len*1.6, len*1.6]);
        rotate(-(90-alpha),[1,0,0])
            translate([0,-len*1.6,0])
                cube([len*1.6, len*1.6, len*1.6]);
    }
}

tetraeder(80);
