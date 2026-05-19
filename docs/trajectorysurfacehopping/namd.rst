.. highlight:: none

.. |S0| replace:: S\ :sub:`0`
.. |S1| replace:: S\ :sub:`1`
.. |S2| replace:: S\ :sub:`2`

******************************************
Non Adiabatic Molecular Simulations (NAMD)
******************************************

In this section, we will explain how to set up the files required
to run a NAMD simulation using TSH copuled with TD-DFTB. To begin,
create a directory named ``namd`` and navigate into it::

   mkdir namd

   cd namd

Inside this directory, we need to generate a separate folder for 
each initial condition used in the TSH simulations. These folders
should be named ``TRAJ_X`` where ``X`` ranges from 0 to 100.::

   mkdir TRAJ_0 TRAJ_1 ... TRAJ_100

Now, copy the geometry and velocity files generated previously. 
Make sure to copy the right files into its respective directory::

   cp ../geom_0 TRAJ_0/geom
   cp ../veloc_0 TRAJ_0/veloc
          .
          .
          .
   cp ../geom_100 TRAJ_100/geom
   cp ../veloc_100 TRAJ_100/veloc

Next, we need to prepare the input files for the TSH dynamics 
within each ``TRAJ_X`` directory:

.. literalinclude:: data/input
   :emphasize-lines: 7-9, 11, 14, 15

Most of keywords used in this input file are described in detail
in the SHARC documentation, which we strongly recommend consulting.
Here, we highlight the most important ones for this tutorial:

``nstates 10 0 0``: This keyword defines the total number of 
electronic states included in the calculation. The three numbers
correspond to singlests, doublets and triplets, respectively. In
this case, we compute 10 singlets states only.

``actstates 3 0 0``: This specifies the number of `active` states
that the system is allowed to explore during the dynamics. Here,
we restrict the dynamics to 3 singlet states (|S0|, |S1|, |S2|).
It is common practice to compute more states than those included
in the dynamics to ensure a more accurate description of the system.

``state 3 mch``: This defines the initial electronic state of the
simulation. Electronic states are indexed starting from 1 (electronic state),
so this keyword corresponds to the second excited state (|S2|).

``rngseed``: This sets the seed for the random number generator.
Since TSH is a stochastic method, each trajectory should use a 
different seed to ensure statistically independent simulations.

``tmax``: This is the total simulation time, given in fs.

``stepsize``: This defines the time step of the simulation, also in fs. 

Next, inside each ``TRAJ_X`` directory, we need to create two 
subdirectories::
   
   mkdir restart scratch QM

The ``restart`` folder is used to store restart files generated 
during the simulation. The ``scratch`` folder will be used by DFTB+
to run every single point. The ``QM`` folder contains the input 
templates for the DFTB+ calculations. The following two input files
are required inside the ``QM`` folder:

.. tab-set::

   .. tab-item:: DFTB.template

      .. literalinclude:: data/DFTB.template
         :caption: DFTB.template

   .. tab-item:: DFTB.resources

      .. literalinclude:: data/DFTB.resources
         :caption: DFTB.resources
         :emphasize-lines: 2, 3


As you can see in the ``DFTB.template`` file, there is no explicit
information about the excited states. This is because this section
is generated at each time step during the simulation. In the
``DFTB.resources`` file, make sure to update the paths
accordingly to match with the initial condition that you are going to run.

You also need to create the following script, named ``runQM.sh``, place
it inside the ``QM`` folder, and make it executable::

   #!/bin/bash
   cd QM

   $SHARC/SHARC_DFTB.py QM.in >> QM.log 2>> QM.err
   err=$?

   exit $err

Now, inside the main ``TRAJ_X`` directory, we need to create the
main script used to run the simulation::

   #!/bin/bash

   # SHARC
   source /home/user/python/environment/bin/activate
   export SHARCHOME=/home/user/sharcHome
   export SHARC=$SHARCHOME/bin
   export LD_LIBRARY_PATH=$SHARCHOME/lib:$LD_LIBRARY_PATH
   export PATH=$SHARCHOME/bin:$PATH

   # DFTB+
   export DFTBFOLDER=/home/user/DFTB
   export DFTBHOME=$DFTBFOLDER/bin
   export LD_LIBRARY_PATH=$DFTBFOLDER/lib:$LD_LIBRARY_PATH
   export PATH=$DFTBHOME:$PATH

   # Number Of processors and threads
   export OMP_NUM_THREADS=1
   export MPI_NUM_TASK=1
   export CALCS_SAME_TIME=3

   # Directory of the run
   PRIMARY_DIR=${PWD}
   cd $PRIMARY_DIR

   # Run
   $SHARC/sharc.x input

At this point, the directory is fully set up to run the simulation. Your ``TRAJ_X`` folder
should look like the following::

   $ pwd
   /home/user/namd/TRAJ_X

   $ ls
   input geom veloc run.sh QM/ restart/ scratch/

   $ ls QM/
   DFTB.template DFTB.resources runQM.sh

