include <SpotWelderControllerVars.scad>

module thickWireHolderScrewHoles()
{
	y1=screwM3HolderRadius;
	y2=thickWireHolderLength-screwM3HolderRadius;
	
	for(t=[y1,y2])
	{
		translate([holderWidth/2,t,-1])
		cylinder(d=screwM3Diameter,h=thickWireHolderCoverHeight+2,$fn=16);
	}
}

module thickWireHole()
{
	translate([-1,thickWireHolderLength/2,thickWireHolderCoverHeight])
	rotate([0,90,0])
	cylinder(d=thickWireDiameter,h=holderWidth+2,$fn=64);
}

difference()
{
	union()
	{
		translate([0,screwM3HolderRadius,0])
		cube([holderWidth,thickWireHolderLength-screwM3HolderRadius,thickWireHolderCoverHeight]);
		
		translate([holderWidth/2,screwM3HolderRadius,0])
		cylinder(d=holderWidth,h=thickWireHolderCoverHeight,$fn=64);
	}
	
	thickWireHolderScrewHoles();
	thickWireHole();
}
	