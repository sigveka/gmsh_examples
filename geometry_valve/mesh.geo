/**
*/
//SetFactory("OpenCASCADE");


lc = 0.1;
L = 1.0;

// Centre of circle
cx0 = 0;
cy0 = 0;
cz0 = 0;
m   = 1;

Nr0 = 5;
Na0 = 7;
Nl0 = 21;


/* Define Geometry Parameters ---------------------------------------------- */
ls = 5;
R = 0.5;   // um
L = 1.0; // Length of the valve
f0 = 0.5;   // 0--1

DefineConstant [
  Flag_Unit  = {2, Choices{0="mm", 1="cm", 2="m", 3="km"},
                        Name "Input/01Unit", Highlight "Blue"}
];
 
If ( Flag_Unit == 0 )
  Printf("Scaling to unit millimeter [mm]");
  unit = 0.001;
ElseIf ( Flag_Unit == 1 )
  Printf("Scaling to unit centimeter [cm]");
  unit = 0.01;
ElseIf ( Flag_Unit == 2 )
  Printf("Scaling to unit meter [m]");
  unit = 1;
ElseIf ( Flag_Unit == 3 )
  Printf("Scaling to unit kilometer [km]");
  unit = 1000;
EndIf

DefineConstant [
  radius = {    R*unit, Name "Input/Characteristic Sizes/Radius (m)"}
  position = { f0*unit, Name "Input/Characteristic Sizes/Valve Position (%)"}
  len    = {    L*unit, Name "Input/Characteristic Sizes/Length (m)"}
  cx     = {  cx0*unit, Name "Input/Centre/x-coordinate (m)"}
  cy     = {  cy0*unit, Name "Input/Centre/y-coordinate (m)"}
  cz     = {  cz0*unit, Name "Input/Centre/z-coordinate (m)"}
  N      = {    Nl0, Name "Input/Mesh/Longditudal Layers"}
  Nrad   = {    Nr0, Name "Input/Mesh/Radial Layers"}
  Nang   = {    Na0, Name "Input/Mesh/Angular Layers"}
  Flag_Plane = {2, Choices{0="XY", 1="XZ", 2="YZ"},
                Name "Input/00Plane", Highlight "Blue"}
];


Include "geo_templates/nozzle.geo";

/* ------------------------------------------------------------------------- */

Call Valve;


N = Ceil(N/2);
Call ExtrudeValveInlet;
Call ExtrudeValveOutlet;


N = Ceil(N/2);
Call ExtrudeValveInlet;
Call ExtrudeValveOutlet;

N = Ceil(N/2);
Call ExtrudeValveInlet;
Call ExtrudeValveOutlet;


Color Cyan{ Surface{ inletfaces[] }; }
Color Gray{ Surface{ outerfaces[] }; }
Color Magenta{ Surface{ outletfaces[] }; }
Color Yellow{ Volume{ newVolumes[] }; }


Physical Surface("inlet")  = inletfaces[];
Physical Surface("outlet") = outletfaces[];
Physical Surface("walls")   = outerfaces[];
Physical Volume("volume")   = newVolumes[];

// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
