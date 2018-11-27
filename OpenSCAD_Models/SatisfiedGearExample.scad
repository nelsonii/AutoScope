use <SatisfyingGears1.6.scad>;

//NOTE: Play with the debug and existance flags. Adjust quality settings. The first example below has all of the module arguments. These all have defaults so you only need to add the ones that modify it for your purposes. GOOD LUCK!


//Quality:
//AngularResolution =.1; //step size for the parameterized involute function// smaller is sharper but more points in the model
//$fn=60;
//M=10000; //Magnify then shrink factor to prevent point culling on the involute gear polygon
//slices=10 The number of slices used in the linear extrusions. More makes it sharper but more points in the model.


//Quality:
//AngularResolution =.1; //step size for the parameterized involute function// smaller is sharper but more points in the model
//$fn=60;
//M=10000; //Magnify then shrink factor to prevent point culling on the involute gear polygon
//slices=10 The number of slices used in the linear extrusions. More makes it sharper but more points in the model.

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
PairGears(AngularResolution =5,M=10000,slices=5,TeethA=12,TeethB=20,BacklashA=0,BacklashB=0,PressureAngle=20,DiametralPitch=.6,ToothPhaseA=0,Thickness=20,HelixFaceAngle=15,Layers=1,AltLayerToothPhase=0,ChamferThickness=1,InnerChamfers=true,Rescale=1,AddendumA=0,AddendumB=0,GearAExists=true,GearBExists=true,GearBCentered=false,GearAGhost=false,GearBGhost=false,debug=false);
 //FullFat


translate([120,0,0]){
PairGears(TeethA=12,TeethB=20,PressureAngle=14.6,Thickness=10,HelixFaceAngle=0,Layers=1,ChamferThickness=0.5,GearAExists=false,GearBExists=false,GearBCentered=false,debug=true);
}

translate([-120,0,0]){
//Helix mode
PairGears(TeethA=18,TeethB=30,PressureAngle=20,Thickness=30,HelixFaceAngle=25,Layers=2,ChamferThickness=0.5,GearAExists=true,GearBExists=true,GearBCentered=false,GearAGhost=true,debug=false);
}



TeethA=18;
TeethB=23;
PressureAngle=30;
DiametralPitch=0.6;
// **** ALL NEW in Ver1.1 :D
//Calculate the center distance between the gears. This is necessary for parametric design.
CenterDistanceWhoooo = CalcCenterDistance(TeethA,TeethB,DiametralPitch,PressureAngle);


translate([0,120,0]){
//Helix mode
difference(){  
PairGears(TeethA=TeethA,TeethB=TeethB,PressureAngle=PressureAngle,DiametralPitch=DiametralPitch,Thickness=50,HelixFaceAngle=25,Layers=4,AltLayerToothPhase=0.5,ChamferThickness=0.5,GearAExists=true,GearBExists=true,GearAGhost=true,GearBGhost=true,GearBCentered=false,debug=false);
union(){//axel holes
  cylinder(h=60,d=5,center=true,$fn=20);
translate([CenterDistanceWhoooo,0,0]){ //Note CenterDistanceWhoooo was calculated before hand with the CalcCenterDistance function (new in Ver.1.1). It's also displayed in the console with an echo command.
  cylinder(h=60,d=5,center=true,$fn=20);
}
}
}
}