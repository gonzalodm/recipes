.. highlight:: none

.. |S0| replace:: S\ :sub:`0`
.. |S1| replace:: S\ :sub:`1`
.. |S2| replace:: S\ :sub:`2`

**************************
Analysis of TSH simulation
**************************

In this section, we will analyze the trajectories generated in the
previous step. SHARC provides several scripts to automate this
process. However, in this tutorial we will focus on a few simple
but important analyses that help understand the photodynamics of
the system under investigation.

Inside each trajectory folder, execute the following command to 
extract the relevant information:

.. code-block:: bash

   $SHARC/data_extractor.x output.dat

This will generate the ``ouput_data`` folder, where several files
containing different types of information are stored. We can begin
the analysis using the data available in this directory.

The following command will generate an script to make some useful plots:

.. code-block:: bash

   $SHARC/make_gnuscript.py 3 0 0 > gnu.plot

Now we can plot using the following command:

.. code-block:: bash

   gnuplot gnu.plot

This command will produce different plots, here we will focus on the most relevant ones.

.. _potential_evolution:
.. figure:: ../_figures/trajectorysurfacehopping/potential_evolution.png
   :width: 80%
   :align: center
   :alt: PES evolution.

   Potential Energy Surfaces evoulution

In figure :numref:`potential_evolution` `active` represents the
potential energy surface on which the system is evolving at a given
time. We can see that the system experience the |S2| -> |S1| transition
at ~10 fs and another transition |S1| -> |S0| at ~70 fs.

These electronic transitions, or hops in the context of TSH, are reflected in the 
time evolution of the population of each electronic state, as shown below:

.. _population:
.. figure:: ../_figures/trajectorysurfacehopping/populations.png
   :width: 80%
   :align: center
   :alt: population

   Electronic Populations

The data presented in Figure :numref:`population` should not be
used to draw general conclusions about the photodynamics of the 
system, as it corresponds to a single trajectory. However, by
averaging the populations over all trajectories, it is possible to
obtain statistically meaningful results, such as the lifetimes of the different
relaxation processes:

.. _population-average:
.. figure:: ../_figures/trajectorysurfacehopping/populations_avg.png
   :width: 80%
   :align: center
   :alt: population average

   Average Electronic Populations using 200 trajectories
   (Extracted from ref `TSH-DFTB+ <https://pubs.acs.org/doi/full/10.1021/acs.jctc.4c01263>`_)

One of the most interesting questions in photochemistry is to explain which vibrational modes
drive the system toward a conical intersection. This can be investigated by analyzing the
nuclear motion during the photodynamics of the system.

.. code-block:: bash

   vmd output.xyz

By examining the time evolution of the potential energy surfaces along the trajectory and
the nuclear trajectory, it is possible to identify the key nuclear motions involved in the
deactivation mechanism, providing deeper insight into the photophysics of the system

The analyses presented here represent only a subset of the information 
available from TSH simulations (see `TSH-DFTB+ <https://pubs.acs.org/doi/full/10.1021/acs.jctc.4c01263>`_). Depending on the system 
and the processes of interest, many other analyses can be performed, 
such as identifying relaxation pathways, key nuclear motions, 
excited-state lifetimes, branching ratios, or structural changes.
The choice of analysis ultimately depends on the specific scientific
questions being addressed.



