include <SpotWelderControllerVars.scad>

module m3Hole(x,y,h)
{
	translate([x,y,0])
	union()
	{
		translate([0,0,-1])
		cylinder(d=nutM3Diameter,h=nutM3Height+1,$fn=6);
		
		translate([0,0,nutM3Height])
		cylinder(d1=nutM3Diameter,d2=screwM3Diameter,h=nutM3ConeHeight,$fn=6);
		
		cylinder(d=screwM3Diameter,h=h+1,$fn=16);
	}
}

module m3Holder(x,y)
{
	translate([x,y,baseHeight-1])
	cylinder(d=screwM3HolderDiameter,h=pcbHeight+1,$fn=32);
}

module m3Screws(holes)
{
	x1=screwM3HolderRadius;
	y1=totalWidth-screwM3HolderRadius;
	y2=thickWireHolderLength+screwM3HolderRadius;
	x3=thirdScrewHoleXPosition;
	y3=totalWidth-thirdScrewHoleYOffset;
	
	for(t=[[x1,y1],[x1,y2],[x3,y3]])
	{
		if(holes)
		{
			m3Hole(t[0],t[1],baseHeight+pcbHeight);
		}
		else
		{
			m3Holder(t[0],t[1]);
		}
	}
}

module thickWireHolderScrewHoles()
{
	x1=holderWidth/2;
	x2=totalLength-holderWidth/2;
	y1=screwM3HolderRadius;
	y2=thickWireHolderLength-screwM3HolderRadius;
	
	for(t=[[x1,y1],[x1,y2],[x2,y1],[x2,y2]])
	{
		m3Hole(t[0],t[1],thickWireHolderHeight);
	}
}

module thickWireHoles()
{
	for(t=[0,totalLength-holderWidth])
	{
		translate([t-1,thickWireHolderLength/2,thickWireHolderHeight])
		rotate([0,90,0])
		cylinder(d=thickWireDiameter,h=holderWidth+2,$fn=64);
	}
}

module transformerScrewHoles()
{
	x=totalLength-holderWidth/2;
	y1=totalWidth-transformerScrewYOffset;
	y2=thickWireHolderLength+transformerScrewYOffset;
	
	for(t=[y1,y2])
	{
		m3Hole(x,t,baseHeight);
	}
}

difference()
{
	union()
	{
		difference()
		{
			translate([0,screwM3HolderRadius,0])
			cube([totalLength,totalWidth-screwM3HolderRadius,baseHeight]);
			
			translate([holderWidth,-1,-1])
			cube([totalLength-2*holderWidth,totalWidth-holderWidth+1,baseHeight+2]);
			
			translate([-1,totalWidth-screwM3HolderRadius,-1])
			cube([screwM3HolderRadius+1,screwM3HolderRadius+1,baseHeight+2]);
		}
		
		// horizontal connector between two thick wire holder
		translate([0,(thickWireHolderLength-holderWidth)/2,0])
		cube([totalLength,holderWidth,baseHeight]);
		
		// vertical connector between two thick wire holder
		translate([thirdScrewHoleXPosition-holderWidth/2,thickWireHolderLength/2,0])
		cube([holderWidth,pcbWidth+thickWireHolderLength/2,baseHeight]);
		
		// left thick wire holder
		translate([0,screwM3HolderRadius,0])
		cube([holderWidth,thickWireHolderLength-screwM3HolderRadius,thickWireHolderHeight]);
		
		// right thick wire holder
		translate([totalLength-holderWidth,screwM3HolderRadius,0])
		cube([holderWidth,thickWireHolderLength-screwM3HolderRadius,thickWireHolderHeight]);
		
		// top pcb screw holder
		translate([screwM3HolderRadius,totalWidth-screwM3HolderRadius,0])
		cylinder(d=holderWidth,h=baseHeight,$fn=64);
		
		// bottom pcb screw holder
		translate([screwM3HolderRadius,thickWireHolderLength+screwM3HolderRadius,0])
		cylinder(d=holderWidth,h=baseHeight,$fn=64);
		
		// bottom pcb screw holder
		translate([holderWidth/2,screwM3HolderRadius,0])
		cylinder(d=holderWidth,h=thickWireHolderHeight,$fn=64);
		
		translate([totalLength-holderWidth/2,screwM3HolderRadius,0])
		cylinder(d=holderWidth,h=thickWireHolderHeight,$fn=64);
		
		m3Screws(false);
	}
	
	m3Screws(true);
	thickWireHolderScrewHoles();
	thickWireHoles();
	transformerScrewHoles();
}
	