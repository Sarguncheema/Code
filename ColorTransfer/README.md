# Color Transfer between images

This is a matlab/c++  script implementing the method described in
reference [1].


## Citations

For any use of this approach cite [1,2] 

## Usage


First compile the Superpixel code in the SCALP directory:

mex -O CFLAGS="\$CFLAGS -Wall -Wextra -W -std=c99" SCALP_v1.c -outdir ./

Then run in Matlab

test_color_transfer_nonconvex



## License

This software is governed by the CeCILL license under French law and
abiding by the rules of distribution of free software. You can use,
modify and/ or redistribute the software under the terms of the CeCILL
license as circulated by CEA, CNRS and INRIA at the following URL
"http://www.cecill.info".
As a counterpart to the access to the source code and rights to copy,
modify and redistribute granted by the license, users are provided only
with a limited warranty and the software's author, the holder of the
economic rights, and the successive licensors have only limited
liability.
In this respect, the user's attention is drawn to the risks associated
with loading, using, modifying and/or developing or reproducing the
software by the user in light of its specific status of free software,
that may mean that it is complicated to manipulate, and that also
therefore means that it is reserved for developers and experienced
professionals having in-depth computer knowledge. Users are therefore
encouraged to load and test the software's suitability as regards their
requirements in conditions enabling the security of their systems and/or
data to be ensured and, more generally, to use and operate it in the
same conditions as regards security.
The fact that you are presently reading this means that you have had
knowledge of the CeCILL license and that you accept its terms.

## References

[1] Non-convex relaxation of optimal transport for color transfer, NIPS
Workshop 2014, Rabin and Papadakis

[2] SCALP: Superpixels with Contour Adherence using Linear Path, ICPR 2016,
Giraud, Ta, Papadakis
