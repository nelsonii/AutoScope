use <SatisfyingGears1.6.scad>;

HighQuality=true;//for final rendering
Ghost=false; // for fast design. Cylinders at pitch diameters instead of gears.
$fn = HighQuality ? 30 : $fn; 
AngularResolution = HighQuality ? 5 : 10; 
slices = HighQuality ? 15 : 4; 

GearAExists=true;
GearBExists=true;

//Ron Nelson : Added more variables
// On my AmScope the X knob (smaller) is 23mm
// On my AmScope the Y knob (larger) is 26mm
// On my AmScope the Z knob (focus) is 35mm
GearHeight=7; //mm -- to fit in the motor housing; 5 gives more space
GearAHub=5.25; // mm -- added 0.25 to compensate for my printer
GearBHub=27.25; //mm -- added 1.25 to compensate for my printer

//Ron Nelson : This tooth and pitch combo gives
//a Gear A to B center distance of 30mm, which works
//on my AmScope stage with the other printed parts.
TeethA=10;
TeethB=36;
DiametralPitch=0.8;

PressureAngle=20;//degree

//New Improved with Backlash
Backlash=0.3; //mm off of each tooth the pitch circle. Narrows the teeth


//Calculate the center distance between the gears. This is necessary for parametric design. New function in Ver1.1
OurCenterDistanceNamedBob = CalcCenterDistance(TeethA,TeethB,DiametralPitch,PressureAngle);


//NOTE: Play with the debug and existance flags. Adjust quality settings. The first example below has all of the module arguments. These all have defaults so you only need to add the ones that modify it for your purposes. GOOD LUCK!


difference(){
PairGears(AngularResolution =AngularResolution,M=10000,slices=slices,TeethA=TeethA,TeethB=TeethB,BacklashA=Backlash/2,BacklashB=Backlash/2,PressureAngle=PressureAngle,DiametralPitch=DiametralPitch,ToothPhaseA=0,Thickness=GearHeight,HelixFaceAngle=15,Layers=1,AltLayerToothPhase=0,ChamferThickness=1,InnerChamfers=false,Rescale=1,AddendumA=0,AddendumB=0,GearAExists=true,GearBExists=true,GearBCentered=false,GearAGhost=Ghost,GearBGhost=Ghost,debug=false);  //FullFat

union(){
  if (GearAExists){
      //For a rectangular hub, found on 28BYJ-48 stepper
      translate([0,0,-GearHeight/2]){
        cube([3, 5, GearHeight*2],center=true);
        }      
      //Use cylinder if you want a circular hub
      //cylinder(h=GearHeight+2,d=GearAHub,$fn=60,center=true);
  }//GearAExists
  
  if (GearBExists){
    //The +2 adds a little more height for the hole -- coincident faces
    //$fn = fragments for cylinder -- setting to 60 gives smoother hub
    translate([OurCenterDistanceNamedBob,0,0]){
    cylinder(h=GearHeight+2,d=GearBHub,$fn=60,center=true);
  }
}//GearBExists
}
}

//Gear Parameters
//TeethA=14; //Teeth on first gear (Gear A)
//TeethB=30; //Teeth on second gear (Gear B)
//BacklashA=0;// Added Backlash in millimeters along the pitch circle on Gear A. This narrows the teeth and loosens the fit of the gears. Use this instead of the old Rescale parameter. 
//BacklashB=0;// Added Backlash in millimeters along the pitch circle on Gear B. This narrows the teeth and loosens the fit of the gears. Use this instead of the old Rescale parameter. 
//PressureAngle=20; //degrees (Is common to both gears)
//DiametralPitch=0.6; // =Teeth/PitchDiameter (Determines tooth size and together with Teeth determines Pitch diameter. Common to both gears)
//ToothPhaseA=0; //Rotate the first Gear (Gear A) by X of a tooth, 1 is unity. The tooth is centered on the +X axis. Gear B is advanced by 0.5 and rotated 180 gegrees to enguage GearA
//Thickness=10 //The Thickness of the Gears.
//HelixFaceAngle=15 // You can angle the teeth of the gears to create helical gears. Combined with additional layers you can make double, tripple etc.. helical gears, Odd Layers reverse the helix. You still get a meshed pair.
//Layers=1 Additional Layers of the gear are added so you can make double, tripple, etc... helical gears.
//AltLayerToothPhase=0 You can shift the Tooth phase of the odd layers on multi layered gears (Usually Helical Gears) For Reasons???
//ChamferThickness=1 Select how deep you want the Chamfer at the Tooth edges. Zero Means no chamfer on tooth edges.
//InnerChamfers=true // Existance Flag for the chamfers between layers of multi layered gears.
//Rescale=1; // Use BacklashA and BacklashB instead. This is a legacy parameter to that is a Scalar to shrink gears if they printing too tight or loose.(1=normal full size)(Does not scale Z but you have your own scale command)(center distance will remain uneffected) 
//AddendumA=0 Zero is automatic! Set to zero for default of 1/DiametralPitch. This is the distance between the pitch diameter and the outer end of the tooth, on the first gear (Gear A)(This is only for the more studied gearer)
//AddendumB=0 Zero is automatic! Set to zero for default of 1/DiametralPitch. This is the distance between the pitch diameter and the outer end of the tooth, on the second gear (Gear B)(This is only for the more studied gearer)
//GearAExists=true //Existance Flag for GearA. (For generating loose parts)
//GearBExists=true //Existance Flag for GearB. (For generating loose parts)
//GearBCentered=false // Bring GearB to the center(for using on parts)
//debug=false; //Debug mode places colored cylender at PitchDiaiameter of the gears. This mihgt be good for seting up your model without wasting calculation time.
//Example: 
//PolygonPairGears(TeethA=15,TeethB=30,PressureAngle=20,ToothPhaseA=0.5);
