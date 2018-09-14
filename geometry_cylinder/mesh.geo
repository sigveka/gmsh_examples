/*
  @brief   Circle
  @author  Sigve Karolius
*/
// SetFactory("OpenCASCADE");


/* Define Geometry Parameters ---------------------------------------------- */
R = 0.5;        // Radius of the tube
DR = 0.5*R;     // Shell radius

lc = 0.1;
N0  = 3;
N0a = 5;
N0r = 7;
L = 1.0;

// Centre of circle
cx0 = 0;
cy0 = 0;
cz0 = 0;
m   = 1;
dir = 1;

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
  len    = { dir*L*unit, Name "Input/Characteristic Sizes/Length"}
  cx     = {   cx0*unit, Name "Input/Centre/x-coordinate"}
  cy     = {   cy0*unit, Name "Input/Centre/y-coordinate"}
  cz     = {   cz0*unit, Name "Input/Centre/z-coordinate"}
  N      = {      N0, Name "Input/Mesh/Layers"}
  Nang   = {     N0a, Name "Input/Mesh/Angular"}
  Nrad   = {     N0r, Name "Input/Mesh/Radial"}
];


inlets  = {}; // Bottom of the cylinder
outlets = {}; // Top of the cylinder
volumes = {};
walls   = {};

Include "../geo_templates/circle_topology_OH.geo";
// !!! ---------------- do not edit below this line -------------------- !!! //

Call OHCircle;
inlets += surfaces[];


Call LinearExtrusionOHCircle;
volumes += newVol[];
walls   += outerwalls[];
outlets += surfaces[];

/* Define Groups of Geometric Entities -------------------------------------- */

Color Cyan{ Surface{ inlets[] }; }
Color Gray{ Surface{ walls[] }; }
Color Magenta{ Surface{ outlets[] }; }

// Generate surface patches with string labels.
// Base patch types (patch, wall, symmetryPlane, empty, wedge, cyclic) can be
// specified by second words of the string labels. If omitted the type
// defaults to patch. If a surface is generated inside of the volume it will be
// recognized as a faceZone/faceSet.

// You can also use numbers for physical region definition. The name will be
// named "patch<number>"
Physical Surface("inlet, patch") = inlets[];
Physical Surface("outlet, patch")    = outlets[];
Physical Surface("walls, wall")  = walls[];

// Generate volume with cellZone/cellSet definition.
// Don't forget to make the entire volume defined because Gmsh writes only
// parts of the mesh where physical regions are defined.
Physical Volume("volume")  = volumes[];

Transfinite Surface "*";
Recombine Surface "*";
Transfinite Volume "*";

// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
//+
