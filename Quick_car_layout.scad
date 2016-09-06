//Quick 3D car body design
//The dimensions of the side view must fit in a bounding
//box 100mm wide by 24.1
//The dimensions of the front view must fit in a bounding
//box 50mm wide by 24.1 
Body_length = 100;
Body_width = 50;
PCB = 1.6;															//PCB thickness
Body_thickness = 2;												//Thickness of car walls
Scale = .7;															//scale model from 0.5 to 2
Xscale = (Body_length-2*Body_thickness/Scale)/100;		//Car wall thickness calculations
Yscale = (Body_length-Body_thickness/Scale)/100;
Zscale = (Body_length-4*Body_thickness/Scale)/100;

module body()
{
	intersection(){	
		linear_extrude (height=Body_width)
		import(file = "side.dxf");

		rotate([0,90,0])translate([-Body_width,0,0])linear_extrude (height=Body_length)
		import(file = "front.dxf");
	}
}

module car()
{
	difference(){
		body();
		translate([Body_thickness/Scale,0,Body_thickness/Scale])	//Hollow body out
		scale([Xscale,Yscale,Zscale])body();
		linear_extrude (height=50)
		import(file = "side_windows.dxf");					//add windows and wheel wells
		rotate([0,0,90])translate([0,-20,0])cylinder(h=50,r= 10,$fn=100);
		rotate([0,0,90])translate([0,-80,0])cylinder(h=50,r= 10,$fn=100);
	}
}
rotate([90,0,0])scale([Scale,Scale,Scale])car();
