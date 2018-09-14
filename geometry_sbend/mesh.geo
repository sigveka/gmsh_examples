/*
  @brief   Circle
  @author  Sigve Karolius
*/


/* Define Geometry Parameters ---------------------------------------------- */
R = 0.2;        // Radius of the tube
DR = R + R*0.35;   // Shell radius

lc = 0.1;
N0 = 13;
N0a = 7;
N0r = 5;
L = 1;

// Centre of circle
cx0 = 0; cy0 = 0; cz0 = 0;


DefineConstant [
  Flag_Plane = {1, Choices{0="XY", 1="XZ", 2="YZ"},
                Name "Input/00Plane", Highlight "Blue"}
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
  radius = {     R*unit, Name "Input/Characteristic Sizes/Radius"}
  dr     = {    DR*unit, Name "Input/Characteristic Sizes/Shell Thickness"}
  len    = {     L*unit, Name "Input/Characteristic Sizes/Length"}
  cx     = {   cx0*unit, Name "Input/Centre/x-coordinate"}
  cy     = {   cy0*unit, Name "Input/Centre/y-coordinate"}
  cz     = {   cz0*unit, Name "Input/Centre/z-coordinate"}
  N      = {         N0, Name "Input/Mesh/Layers"}
  Nrad   = {        N0r, Name "Input/Mesh/Radial"}
  Nang   = {        N0a, Name "Input/Mesh/Angular"}
];


// Declare lists
inlets  = {};
volumes = {};
outlets = {};
walls   = {};


x_length = 0;
y_length = 0;
z_length = 0;

Include "../geo_templates/circle_topology_OH.geo";
/* ------------------------------------------------------------------------- */

Flag_Plane = 1; // X-Z plane
Call OHCircle;
inlets  = surfaces[];                           // Declare surfaces as "inlets"

Call LinearExtrusionOHCircle;
walls += outerwalls;
volumes += newVol[];

Flag_Plane_Bend = 0;
start = len;
stop = len;
Call ElbowExtrusionOHCircle; // now we are in the X-Y plane

Call LinearExtrusionOHCircle;
walls += outerwalls;
volumes += newVol[];

Flag_Plane_Bend = 1;
Call ElbowExtrusionOHCircle;

Call LinearExtrusionOHCircle;
walls += outerwalls;
volumes += newVol[];

outlets = surfaces[];

/* Define Groups of Geometric Entities ------------------------------------- */

Physical Surface("inlet")  = inlets[];
Physical Surface("outlet") = outlets[];
Physical Volume("volume")  = volumes[];
Physical Surface("walls")  = walls[];

Transfinite Surface "*";
Recombine Surface "*";

// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
