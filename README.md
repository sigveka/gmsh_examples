
# Usage

The directory `geo_templates` contains parameterised topologies for geometries that are used in order to create a _structured mesh_ in the `geometry_<NAME>` directories.

The respective directories may contain several files, but the main file is **always** named `mesh.geo`. 
The geometry can be viewed by opening this file in [GMSH] as follows:

* Open a terminal in the desired `geometry_<NAME>` directory
* Type `gmsh mesh.geo` and hit the `[ENTER]` key.


# Dependencies

* [GMSH] (3D finite element grid generator) 

[GMSH]: http://gmsh.info

## Linux

Using the "aptitude" package manager

```
sudo apt install gmsh
```


# Bibliography

Geuzaine, C. and Remacle, J.-F. (2009). Gmsh: A 3-d finite element mesh generator with built-in pre- and post-processing facilities. _International Journal for Numerical Methods in Engineering_, 79(11):1309--1331.

