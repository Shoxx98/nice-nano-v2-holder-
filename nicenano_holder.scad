// len: x
nicenanoLength = 33;
nicenanoWidth = 18;
nicenanoHeight = 1.5;

pinLineCutoutWidth = 2.5;

dimpleLen = 3;
dimpleWidth = 2;
dimpleLenOff = 8;
dimpleWidthOff = 4;

outerWallWidth = 2;
groundheight = outerWallWidth;

pinoepelWidth = pinLineCutoutWidth;
pinoepelLen = outerWallWidth*2;
pinoepelHeight = nicenanoHeight*2+2;
pinoepelLatchCapLen = sqrt(pinoepelLen^2 + pinoepelHeight^2);
pinoepelLatchCapDiffCubeAngle = atan(pinoepelLen/(pinoepelHeight/2));

pinoepelCutoutWidth = pinoepelWidth*2;
pinoepelCutoutHeight = nicenanoHeight;

module pinHoleCutout() {
    cube(size = [nicenanoLength, pinLineCutoutWidth, groundheight]);
}

module latch(){

        difference() {
            cube(size = [pinoepelLen, pinoepelWidth, pinoepelHeight], center = false);
            translate([(pinoepelLen-1)/2,0,0]) cube(size = [(pinoepelLen+1)/2, pinoepelWidth,pinoepelHeight/2]);
            translate([.5,0,.5])translate([pinoepelLen,0,pinoepelHeight/2]) rotate(a = [0,-(pinoepelLatchCapDiffCubeAngle),0]) cube(size = [pinoepelLen, pinoepelWidth,pinoepelLatchCapLen]);

            }
    }

// translate([-10,-10,0]) polyhedron(points = [[0,0,0],
//                                             [0.5,0,0],
//                                             [0,0.5,0],
//                                             [0.5,0.5,0],
//                                             [0.5,0.5,nicenanoHeight],
//                                             [0.5,0,nicenanoHeight],
//                                             [0.5,1,nicenanoHeight],
//                                             [1,0,nicenanoHeight],
//                                             [0,0,nicenanoHeight*2],
//                                             [0,0.5,nicenanoHeight*2],
//                                             ], faces = [[3,1,0,2],
//                                                         [0,3,7,8]]);
//


// translate([-5,-5,0]){
//     latch();
// }
union() {
    difference() {
        cube(size = [nicenanoLength + outerWallWidth*2, nicenanoWidth + outerWallWidth*2, outerWallWidth + nicenanoHeight]);
        translate([0, outerWallWidth, groundheight]) cube(size = [nicenanoLength+outerWallWidth, nicenanoWidth, nicenanoHeight]);
        translate([outerWallWidth, outerWallWidth, 0]) pinHoleCutout();
        translate([outerWallWidth, nicenanoWidth-pinLineCutoutWidth+outerWallWidth, 0]) pinHoleCutout();
        translate([nicenanoLength+outerWallWidth,(outerWallWidth*2+nicenanoWidth)/2-pinoepelCutoutWidth/2,groundheight]) cube(size=[outerWallWidth,pinoepelWidth*2,nicenanoHeight]);
        translate([outerWallWidth+dimpleLenOff-1.5,nicenanoWidth+outerWallWidth*2-(dimpleWidthOff+dimpleWidth+outerWallWidth)+.5,0]) cube(size=[dimpleLen,dimpleWidth,groundheight]);
    }
    translate([0,outerWallWidth+pinLineCutoutWidth-pinoepelWidth+1,groundheight])latch();
    translate([0,nicenanoWidth+outerWallWidth-pinLineCutoutWidth-1,groundheight])latch();
    translate([pinoepelLen/2, pinoepelWidth,0]) translate([nicenanoLength+outerWallWidth,(outerWallWidth*2+nicenanoWidth)/2-pinoepelWidth/2,groundheight]) rotate(a=[0,0,180])latch();
}
