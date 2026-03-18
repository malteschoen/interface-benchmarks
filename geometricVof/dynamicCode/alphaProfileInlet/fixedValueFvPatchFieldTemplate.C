/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | www.openfoam.com
     \\/     M anipulation  |
-------------------------------------------------------------------------------
    Copyright (C) 2019-2021 OpenCFD Ltd.
    Copyright (C) YEAR AUTHOR, AFFILIATION
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "fixedValueFvPatchFieldTemplate.H"
#include "addToRunTimeSelectionTable.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "surfaceFields.H"
#include "unitConversion.H"
#include "PatchFunction1.H"

//{{{ begin codeInclude

//}}} end codeInclude


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * Local Functions * * * * * * * * * * * * * * //

//{{{ begin localCode

//}}} end localCode


// * * * * * * * * * * * * * * * Global Functions  * * * * * * * * * * * * * //

// dynamicCode:
// SHA1 = bc727741639b5d5fdd54eec5006571ff03bbb56a
//
// unique function name that can be checked if the correct library version
// has been loaded
extern "C" void alphaProfileInlet_bc727741639b5d5fdd54eec5006571ff03bbb56a(bool load)
{
    if (load)
    {
        // Code that can be explicitly executed after loading
    }
    else
    {
        // Code that can be explicitly executed before unloading
    }
}

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

makeRemovablePatchTypeField
(
    fvPatchScalarField,
    alphaProfileInletFixedValueFvPatchScalarField
);

} // End namespace Foam


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::
alphaProfileInletFixedValueFvPatchScalarField::
alphaProfileInletFixedValueFvPatchScalarField
(
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF
)
:
    parent_bctype(p, iF)
{
    if (false)
    {
        printMessage("Construct alphaProfileInlet : patch/DimensionedField");
    }
}


Foam::
alphaProfileInletFixedValueFvPatchScalarField::
alphaProfileInletFixedValueFvPatchScalarField
(
    const alphaProfileInletFixedValueFvPatchScalarField& rhs,
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    parent_bctype(rhs, p, iF, mapper)
{
    if (false)
    {
        printMessage("Construct alphaProfileInlet : patch/DimensionedField/mapper");
    }
}


Foam::
alphaProfileInletFixedValueFvPatchScalarField::
alphaProfileInletFixedValueFvPatchScalarField
(
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF,
    const dictionary& dict
)
:
    parent_bctype(p, iF, dict)
{
    if (false)
    {
        printMessage("Construct alphaProfileInlet : patch/dictionary");
    }
}


Foam::
alphaProfileInletFixedValueFvPatchScalarField::
alphaProfileInletFixedValueFvPatchScalarField
(
    const alphaProfileInletFixedValueFvPatchScalarField& rhs
)
:
    parent_bctype(rhs),
    dictionaryContent(rhs)
{
    if (false)
    {
        printMessage("Copy construct alphaProfileInlet");
    }
}


Foam::
alphaProfileInletFixedValueFvPatchScalarField::
alphaProfileInletFixedValueFvPatchScalarField
(
    const alphaProfileInletFixedValueFvPatchScalarField& rhs,
    const DimensionedField<scalar, volMesh>& iF
)
:
    parent_bctype(rhs, iF)
{
    if (false)
    {
        printMessage("Construct alphaProfileInlet : copy/DimensionedField");
    }
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::
alphaProfileInletFixedValueFvPatchScalarField::
~alphaProfileInletFixedValueFvPatchScalarField()
{
    if (false)
    {
        printMessage("Destroy alphaProfileInlet");
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void
Foam::
alphaProfileInletFixedValueFvPatchScalarField::updateCoeffs()
{
    if (this->updated())
    {
        return;
    }

    if (false)
    {
        printMessage("updateCoeffs alphaProfileInlet");
    }

//{{{ begin code
    #line 32 "/shared/interface-benchmarks/geometricVof/0/alpha.melt/boundaryField/inlet"
const vectorField& Cf = this->patch().Cf();


        scalarField alpha(Cf.size(), 0.0);
		
            	forAll(Cf, faceI)					
            	{
		scalar z = Cf[faceI].z();

		    if (z > 0)
		    {
		        alpha[faceI] = 1.0;
		    }
		    else
		    {
		        alpha[faceI] = 0.0;
		    }
		}

        operator==(alpha);
//}}} end code

    this->parent_bctype::updateCoeffs();
}


// ************************************************************************* //

