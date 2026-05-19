.. highlight:: none

****************************
Initial Conditions
****************************

Since TSH is a stochastic method that requires many independent simulations, 
the first step is to generate a set of initial conditions. These initial 
conditions consist of nuclear positions and velocities that represent an 
ensemble of the system at the target experimental temperature. 
In this tutorial we will use the Wigner distribution.

The first step is to obtain the optimized structure of the system 
in its electronic ground state. The keywords required for this type
of calculation in DFTB+ were introduced in a previous section (:ref:`first`).

The input file used in this tutorial is shown below::

   Geometry = xyzFormat {
         6

         C   -0.00000220531796     -0.00011946224255      0.00824776387043
         N   -0.00000103715068      0.00011691219994      1.29471395800124
         H    0.95304286586587     -0.00032942928012     -0.53285864298005
         H    0.87408459944882      0.00009862593430      1.83976048187255
         H   -0.87408532560582      0.00034268856534      1.83976697683496
         H   -0.95303889724023     -0.00010933517691     -0.53286332659912
   }
   Driver = GeometryOptimization {
      Optimizer = Rational {}
      OutputPrefix = "geom_trj"
      AppendGeometries = Yes
      MaxSteps = 100
   }
   Hamiltonian {
      DFTB {
         SCC = Yes
         SCCTolerance = 1e-08
         Charge = 1.0
         MaxAngularMomentum {
         N = "p"
         C = "p"
         H = "s"
      }
      SlaterKosterFiles {
         Type2FileNames {
            Prefix = "/home/user/slakos/origin/mio-1-1/"
            Separator = "-"
            Suffix = ".skf"
         }
      }
      }
   }
   ParserOptions {
      ParserVersion = 12
   }
   Parallel {
      UseOmpThreads = Yes
   }
   Analysis {
      CalculateForces = Yes
   }
   Options {
      WriteAutotestTag = Yes
   }

Using the optimized geometry, we next compute the vibrational 
frequencies and normal modes (see section :ref:`preparing-md`). 

For this step, two inputs files are required:

.. tab-set::

   .. tab-item:: dftb_in.hsd

      .. literalinclude:: data/dftb_in.hsd
         :caption: dftb_in.hsd

   .. tab-item:: modes_in.hsd

      .. literalinclude:: data/modes_in.hsd
         :caption: modes_in.hsd

Once these calculations have completed successfully, we proceed to
generate a `Molden` file. This can be done by running the following
script (provided in the repository downloaded earlier, see :ref:`tsh-install`)::

   dftb_mode.py -g geom_opt.xyz -v vibrations.tag

Once the script has run successfully, a file named ``freq.out.molden`` should be generated. We can then use this file to produce 100 initial conditions at 300 K::

   $SHARC/wigner.py freq.out.molden -n 100 -t 300 -x

   split.py initconds

At this point, you should have a set of initial conditions in SHARC format, consisting of position files (``geom_X``) and velocity files (``veloc_X``), with ``X`` ranging from 0 to 100.

.. tip::

   It is always good practice to verify that the initial conditions
   have been properly generated. One way to do this is by 
   computing the absorption spectra of the ensmble. In addition, 
   the results obtained with TD-DFTB can be compared with those from
   higher-level electronic structure methods. Information about the
   molecular orbitals involved in the electronic transitions can
   also provided valuable insight into the photodynamics.
