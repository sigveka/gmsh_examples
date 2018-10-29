/**
 * @author  Sigve Karolius
 *
 */

ll0x = 0; ll0y = 0; ll0z = 0;
gridsize = 0.1;

L0 = 1;
W0 = 1;
N0 = 5;                                      // Number of "layers" in extrusion
E0 = 0.1;                                            // Length of the extrusion

DefineConstant [
  Flag_Plane = {0, Choices{0="XY", 1="XZ", 2="YZ"}, Name "Input/00Plane", Highlight "Blue"}
  Flag_Unit  = {2, Choices{0="mm", 1="cm", 2="m", 3="km"}, Name "Input/01Unit", Highlight "Blue"}
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
  Len      = {  L0*unit, Name "Input/Characteristic Sizes/Length"}
  Width    = {  W0*unit, Name "Input/Characteristic Sizes/Width"}
  len      = {  E0*unit, Name "Input/Characteristic Sizes/Thickness"}
  llx = {ll0x*unit, Name "Input/Centre/x-coordinate"}
  lly = {ll0y*unit, Name "Input/Centre/y-coordinate"}
  llz = {ll0z*unit, Name "Input/Centre/z-coordinate"}
  N        = {   N0, Name "Input/Mesh/Layers"}
  Nwidth   = {   N0, Name "Input/Mesh/Width"}
];

// View "comments" {
//   // Add a text string in window coordinates, 10 pixels from the left and 10
//   // pixels from the bottom, using the StrCat function to concatenate strings:
//   T2(10, -10, 0 ){ StrCat("Created on ", Today, " with Gmsh") };
// };

inlets  = {};
outlets = {};
volumes = {};
vol_Ge  = {};
vol_Si  = {};
walls   = {};
interfaces = {};


Include "../geo_templates/square.geo";
// !!! ---------------- Do not edit below this line -------------------- !!! //

Call Square;
inlets += surfaces[];

For i In {1:8}
  Call SquareLinearExtrusion;
  surfaces = top[];
  walls   += {right, left, front, back};
  If ( i != 8 )
    // Physical Surface( Sprintf("Ge_%g_to_Si_%g patch", i, i - 1) ) = surfaces[];
  EndIf
  If (i % 2) // Odd number
    Physical Volume( Sprintf("Si_%g", i)) = newVol[];
    vol_Si += newVol[];
  ElseIf (!(i % 2)) // Even number
    Physical Volume( Sprintf("Ge_%g", i)) = newVol[];
    vol_Ge += newVol[];
  EndIf
EndFor

outlets += surfaces[];

/* Define Groups of Geometric Entities -------------------------------------- */

Color Blue{ Volume{ vol_Si[] }; }
Color Red{ Volume{ vol_Ge[] }; }

Color Cyan{ Surface{ inlets[] }; }
Color Magenta{ Surface{ outlets[] }; }
Color Gray{ Surface{ walls[] }; }
// +---------------+----------------------------------------------------+
// | Selection Key | Description                                        |
// +---------------+----------------------------------------------------+
// | patch         | generic patch                                      |
// | symmetryPlane | plane of symmetry                                  |
// | empty         | front and back planes of a 2D geometry             |
// | wedge         | wedge front and back for an axi-symmetric geometry |
// | cyclic        | cyclic plane                                       |
// | wall          | wall - used for wall functions in turbulent flows  |
// | processor     | inter-processor boundary                           |
// +---------------+----------------------------------------------------+

Physical Surface("inlet patch")      = inlets[];
Physical Surface("outlet patch")     = outlets[];
Physical Surface("walls wall")      = walls[];
//Physical Surface("interfaceWall") = interfaces[];

Transfinite Surface "*";
Recombine Surface "*";

// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

