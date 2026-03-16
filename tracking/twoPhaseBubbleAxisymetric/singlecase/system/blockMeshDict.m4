/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM Extend Project: Open Source CFD        |
|  \\    /   O peration     | Version:  1.6-ext                               |
|   \\  /    A nd           | Web:      www.extend-project.de                 |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       dictionary;
    location    "constant/polyMesh";
    object      blockMeshDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
// M4

changecom(//)changequote([,])
define(calc, [esyscmd(perl -e 'printf ($1)')])
define(pi, 3.14159265358979323844)
define(rad, [calc($1*pi/180.0)])
define(VCOUNT, 0)
define(vlabel, [[// ]Vertex $1 = VCOUNT define($1, VCOUNT)
define([VCOUNT], incr(VCOUNT))])

// INPUT: GEOMETRY
define(R, 0.02)                 // cylinder
// define(R, 0.0375)                 // cylinder
define(r, 0.000725)               // bubble
define(L, 0.0005)                 // length

//define(s, 2)                 // Refining the mesh (use integer values)

// Mesh setting for air
define(nbRad, 50) // Nb. of cells in radial direction
define(nbTan, 20)  // Nb. of cells in tangential direction

define(nbAx, 1)  // Nb. of cells in axial direction
define(grA, 100) //rate of growth in radial direction
// define(grA, 120) //rate of growth in radial direction

//Mesh setting for droplet
define(nbTanB, 10) //nb of cells in tan direction for bubble
define(nbRadB, 10) //nb of cells in rad direction for bubble
define(grD, 3) // growth in radial direction


define(sin20, calc(sin(rad(20))))
define(cos20, calc(cos(rad(20))))
define(sin45, calc(sin(rad(45))))
define(cos45, calc(cos(rad(45))))
define(sin67_5, calc(sin(rad(67.5))))
define(cos67_5, calc(cos(rad(67.5))))
define(sin22_5, calc(sin(rad(22.5))))
define(cos22_5, calc(cos(rad(22.5))))
define(x, calc(r/1.75))
define(X, calc((cos45*x+x)/1.5))
define(m, calc((x+X)/2))


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //


vertices
(
// Slab

    //Plane A:
    (0                R              calc(L/2) ) vlabel(A0)
    (R                0              calc(L/2) ) vlabel(A1)
    (0               -R              calc(L/2) ) vlabel(A2)

    //Plane A:
    (0                r              calc(L/2) ) vlabel(A3)
    (r                0              calc(L/2) ) vlabel(A4)
    (0               -r              calc(L/2) ) vlabel(A5)

    //Plane A:
    (0                R              -calc(L/2) ) vlabel(A6)
    (R                0              -calc(L/2) ) vlabel(A7)
    (0               -R              -calc(L/2) ) vlabel(A8)

    //Plane A:
    (0                r              -calc(L/2) ) vlabel(A9)
    (r                0              -calc(L/2) ) vlabel(A10)
    (0               -r              -calc(L/2) ) vlabel(A11)

//bubble

    //Plane A:
    (0   	     r   	    -calc(L/2) ) vlabel(R1)
    (calc(r*cos45)   calc(r*sin45)  -calc(L/2) ) vlabel(R2)
    (r   	     0   	    -calc(L/2) ) vlabel(R3)
    (calc(r*cos45)   calc(-r*sin45) -calc(L/2) ) vlabel(R4)
    (0   	     -r   	    -calc(L/2) ) vlabel(R5)

    (0  	     x  	    -calc(L/2) ) vlabel(s1)
    (calc(X*cos45)   calc(X*sin45)  -calc(L/2) ) vlabel(s2)
    (x  	     0  	    -calc(L/2) ) vlabel(s3)
    (calc(X*cos45)   calc(-X*sin45) -calc(L/2) ) vlabel(s4)
    (0               -x             -calc(L/2) ) vlabel(s5)

    (0   	     r   	     calc(L/2) ) vlabel(R6)
    (calc(r*cos45)   calc(r*sin45)   calc(L/2) ) vlabel(R7)
    (r   	     0   	     calc(L/2) ) vlabel(R8)
    (calc(r*cos45)   calc(-r*sin45)  calc(L/2) ) vlabel(R9)
    (0   	     -r   	     calc(L/2) ) vlabel(R10)

    (0               x               calc(L/2) ) vlabel(s6)
    (calc(X*cos45)   calc(X*sin45)   calc(L/2) ) vlabel(s7)
    (x  	     0  	     calc(L/2) ) vlabel(s8)
    (calc(X*cos45)   calc(-X*sin45)  calc(L/2) ) vlabel(s9)
    (0  	     -x  	     calc(L/2) ) vlabel(s10)

    (0  	     0              -calc(L/2) ) vlabel(C1)
    (0  	     0  	     calc(L/2) ) vlabel(C2)


);

blocks
(
    //Air blocks
    hex (A3 A9 A6 A0 A4 A10 A7 A1)  (1 nbRad nbTan)     simpleGrading (1 grA 1)
    hex (A4 A10 A7 A1 A5 A11 A8 A2) (1 nbRad nbTan)     simpleGrading (1 grA 1)

    //Droplet blocks outer
    hex (R1 s1 s2 R2 R6 s6 s7 R7)   (nbRadB nbTanB 1)   simpleGrading (grD 1 1)
    hex (R2 s2 s3 R3 R7 s7 s8 R8)   (nbRadB nbTanB 1)   simpleGrading (grD 1 1)
    hex (R3 s3 s4 R4 R8 s8 s9 R9)   (nbRadB nbTanB 1)   simpleGrading (grD 1 1)
    hex (R4 s4 s5 R5 R9 s9 s10 R10) (nbRadB nbTanB 1)   simpleGrading (grD 1 1)

    //Droplet blocks inner
    hex (s1 C1 s3 s2 s6 C2 s8 s7)   (nbRadB nbRadB 1)   simpleGrading (1 1 1)
    hex (C1 s5 s4 s3 C2 s10 s9 s8)  (nbRadB nbRadB 1)   simpleGrading (1 1 1)
);

edges
(
//Air arcs
 arc A0 A1 (calc(R*0.7071) calc(R*0.7071) calc(L/2) )
 arc A6 A7 (calc(R*0.7071) calc(R*0.7071) -calc(L/2) )
 arc A1 A2 (calc(R*0.7071) calc(-R*0.7071) calc(L/2) )
 arc A7 A8 (calc(R*0.7071) calc(-R*0.7071) -calc(L/2) )
 arc A3 A4 (calc(r*0.7071) calc(r*0.7071) calc(L/2) )
 arc A9 A10 (calc(r*0.7071) calc(r*0.7071) -calc(L/2) )
 arc A4 A5 (calc(r*0.7071) calc(-r*0.7071) calc(L/2) )
 arc A10 A11 (calc(r*0.7071) calc(-r*0.7071) -calc(L/2) )


 //Droplet outer arcs
 arc R1 R2 (calc(r*cos67_5) calc(r*sin67_5) -calc(L/2) )
 arc R2 R3 (calc(r*cos22_5) calc(r*sin22_5) -calc(L/2) )
 arc R3 R4 (calc(r*cos22_5) calc(-r*sin22_5) -calc(L/2) )
 arc R4 R5 (calc(r*cos67_5) calc(-r*sin67_5) -calc(L/2) )

 arc R6 R7 (calc(r*cos67_5) calc(r*sin67_5) calc(L/2) )
 arc R7 R8 (calc(r*cos22_5) calc(r*sin22_5) calc(L/2) )
 arc R8 R9 (calc(r*cos22_5) calc(-r*sin22_5) calc(L/2) )
 arc R9 R10 (calc(r*cos67_5) calc(-r*sin67_5) calc(L/2) )

 //Droplet inner arcs
 //arc s1 s2 (calc(m*cos67_5) calc(m*sin67_5) -calc(L/2) )
 //arc s2 s3 (calc(m*cos22_5) calc(m*sin22_5) -calc(L/2) )
 //arc s3 s4 (calc(m*cos22_5) calc(-m*sin22_5) -calc(L/2) )
 //arc s4 s5 (calc(m*cos67_5) calc(-m*sin67_5) -calc(L/2) )

 //arc s6 s7 (calc(m*cos67_5) calc(m*sin67_5) calc(L/2) )
 //arc s7 s8 (calc(m*cos22_5) calc(m*sin22_5) calc(L/2) )
 //arc s8 s9 (calc(m*cos22_5) calc(-m*sin22_5) calc(L/2) )
 //arc s9 s10 (calc(m*cos67_5) calc(-m*sin67_5) calc(L/2) )


);

boundary
(
    space
    {
        type patch;
        faces
        (
	    (A0 A1 A7 A6)
	    (A1 A2 A8 A7)
        );
    }

    freeSurface
    {
        type patch;
        faces
        (
	    (A3 A9 A10 A4)
	    (A4 A10 A11 A5)
        );
    }
    freeSurfaceShadow
    {
        type patch;
        faces
        (
	    (R1 R6 R7 R2)
	    (R2 R7 R8 R3)
	    (R3 R8 R9 R4)
	    (R9 R10 R5 R4)
        );
    }
    axisPlane
    {
    	type patch;
    	faces
    	(
    	    (A0 A6 A9 A3)
    	    (A5 A11 8 A2)
	    (R6 R1 s1 s6)
    	    (s6 s1 C1 C2)
    	    (C2 C1 s5 s10)
    	    (s10 s5 R5 R10)
    	);
    }
    wedge_pos
    {
        type patch;
        faces
	(
            //Front wedge side
            (A0 A3 A4 A1)
            (A4 A5 A2 A1)
            (R7 R6 s6 s7)
            (R8 R7 s7 s8)
            (R9 R8 s8 s9)
            (R10 R9 s9 s10)
            (s7 s6 C2 s8)
            (C2 s10 s9 s8)
	);
    }
    wedge_neg
    {
        type patch;
        faces
	(
            //Back wedge side
            (A6 A7 A10 A9)
            (A7 A8 A11 A10)
            (R1 R2 s2 s1)
            (R2 R3 s3 s2)
            (R3 R4 s4 s3)
            (R4 R5 s5 s4)
            (s1 s2 s3 C1)
            (C1 s3 s4 s5)
	);
    }
);

mergePatchPairs
(
);

// ************************************************************************* //
