$fn=120;

// face plate thick
fpt=0.80;
// face plate height
fph=14;
// face plate width
fpw=28;
// switch plate width
spw=28;
// face plate corner rad
fpc=1.0   ;
// slot thick
st=2.10;
// usb high
uh=1.60;
// board width
bw=20.80;
// board height
bh=25.10;
// usb dims
usbh=3.43; usbw=9.36; usbr=1.4;
// switch hole square
sh=7.45;
// switch hole depth
shd=1.55;
// switch body square
sb=9.78;

translate([-25, 0, 0]) difference() {
    union() {
        // switch plate front
        linear_extrude(fpt) hull() {
            translate([fpc, fpc, 0]) circle(fpc);
            translate([-fpc+spw, fpc, 0]) circle(fpc);
            translate([fpc, -fpc+fph, 0]) circle(fpc);
            translate([-fpc+spw, -fpc+fph, 0]) circle(fpc);
        }
        
        // slot rectangle
        translate([fpc, fpc, fpt]) cube([spw-fpc*2, fph-fpc*2, st]);
        
        // switch plate back
        translate([0, 0, fpt+st]) linear_extrude(fpt) hull() {
            translate([fpc, fpc, 0]) circle(fpc);
            translate([-fpc+spw, fpc, 0]) circle(fpc);
            translate([fpc, -fpc+fph, 0]) circle(fpc);
            translate([-fpc+spw, -fpc+fph, 0]) circle(fpc);
        }
        
        // switch support
        translate([(spw-sb-2)/2, (fph-sb-2)/2, shd]) cube([sb+2, sb+2, 6]);
    }
    
    // switch cavity
    translate([(spw-sh)/2, (fph-sh)/2, -1]) cube([sh, sh, 99]);
    translate([(spw-sb)/2, (fph-sb)/2, shd]) cube([sb, sb, 99]);
}

difference() {
    union() {
        // face plate front
        linear_extrude(fpt) hull() {
            translate([fpc, fpc, 0]) circle(fpc);
            translate([-fpc+fpw, fpc, 0]) circle(fpc);
            translate([fpc, -fpc+fph, 0]) circle(fpc);
            translate([-fpc+fpw, -fpc+fph, 0]) circle(fpc);
        }
        
        // slot rectangle
        translate([fpc, fpc, fpt]) cube([fpw-fpc*2, fph-fpc*2, st]);
        
        // face plate back
        translate([0, 0, fpt+st]) linear_extrude(fpt) hull() {
            translate([fpc, fpc, 0]) circle(fpc);
            translate([-fpc+fpw, fpc, 0]) circle(fpc);
            translate([fpc, -fpc+fph, 0]) circle(fpc);
            translate([-fpc+fpw, -fpc+fph, 0]) circle(fpc);
        }
    }
    
    // usb-c connector
    translate([(fpw-usbw)/2, (fph-usbh)/2, -1]) linear_extrude(99) hull() {
        translate([usbr, usbr, 0]) circle(usbr);
        translate([-usbr+usbw, usbr, 0]) circle(usbr);
        translate([usbr, -usbr+usbh, 0]) circle(usbr);
        translate([-usbr+usbw, -usbr+usbh, 0]) circle(usbr);
    }

    // board cavity
    translate([(fpw-bw)/2, -1.5+(fph-usbh)/2, uh]) cube([bw, 99, 99]);

    // debug
    //translate([0, 0, -1]) cube(5);
}

// board frame
aj=0.4+(fph-10)/2;
translate([-1.0+(fpw-bw)/2, fpc+aj, uh]) cube([1, 3.1, bh]);
translate([(fpw-bw)/2, fpc+aj, uh]) cube([1, 0.8, bh]);
translate([(fpw-bw)/2, fpc+2.3+aj, uh]) cube([1, 0.8, bh]);

translate([(fpw+bw)/2, fpc+aj, uh]) cube([1, 3.1, bh]);
translate([-1.0+(fpw+bw)/2, fpc+aj, uh]) cube([1, 0.8, bh]);
translate([-1.0+(fpw+bw)/2, fpc+2.3+aj, uh]) cube([1, 0.8, bh]);

// screw columns
c1=1.6;
c2=0.9;
translate([-1.9+(fpw-bw)/2, fpc+aj+1.5, uh]) difference() {
    cylinder(bh, c1, c1);
    cylinder(bh+1, c2, c2);
}
translate([1.9+(fpw+bw)/2, fpc+aj+1.5, uh+2]) difference() {
    cylinder(bh-2, c1, c1);
    cylinder(bh+1, c2, c2);
}
translate([-18, fpc+aj+1.5, uh]) difference() {
    cylinder(bh, c1, c1);
    cylinder(bh+1, c2, c2);
}
echo(-1.9+(fpw-bw)/2, 1.9+(fpw+bw)/2, -18);
