.. highlight:: none

****************************
Initial Excitation
****************************
In this section, we will compute the absorption spectrum and analyze the
molecular orbitals associated with the initial conditions. This step
provides a useful validation of the TD-DFTB approach by allowing the
calculated excitation energies and electronic transitions to be compared
with higher-level electronic structure methods and experimental data.

To begin, create a new subdirectory in the main folder named ``03_absorption``.
Inside this directory, create a separate folder for each initial condition.
For simplicity, this tutorial will demonstrate the procedure for a single
initial condition (labelad as ``0``). The same workflow can then be applied to all the
remaining initial conditions.

.. code-block:: bash
   :caption: Third step

   cd ../
   mkdir 03_absorption
   cd 03_absorption
   mkdir IC_0
   cd IC_0
   cp ../../02_initconds/geom_0.xyz geom.xyz

.. warning::
   Make sure to copy geom_X.xyz (the xyz format file) and not the geom_X

The following two inputs are needed:
[Input: `recipes/docs/trajectorysurfacehopping/data/03_absorption/`]

.. tab-set::

   .. tab-item:: dftb_in.hsd

      .. literalinclude:: data/03_absorption/dftb_in.hsd
         :caption: dftb_in.hsd
         :emphasize-lines: 17

   .. tab-item:: waveplot_in.hsd

      .. literalinclude:: data/03_absorption/waveplot_in.hsd
         :caption: modes_in.hsd
         :emphasize-lines: 28

After both calculations have completed successfully, a file named ``EXC.DAT`` will be generated.
This file contains information about the excitation energies, oscillator strengths,
and the molecular orbitals contributing to the transitions to the two lowest-lying excited states.
The calculation will also produce cube files for the relevant molecular orbitals,
which can be visualized using software such as VMD, needed for the interpretation of the electronic transitions.

[Input: `recipes/docs/trajectorysurfacehopping/data/03_absorption/`]::

  vmd -e plot_MOs.tcl

The molecular orbitals associated with the two lowest electronic transitions,
as well as the absorption spectrum obtained by averaging over all initial
conditions, are shown in the figure below:

  .. figure:: ../_figures/trajectorysurfacehopping/abs_form.png
     :height: 40ex
     :align: center

     Figure adapted from the Ref `TSH-DFTB+ <https://pubs.acs.org/doi/full/10.1021/acs.jctc.4c01263>`_.

As shown in the figure, there are noticeable differences between the spectra obtained
using TD-DFTB and MR-CISD (Multi-Reference Configuration Interaction with Single and
Double excitations). Nevertheless, TD-DFTB remains useful because it correctly captures
the molecular orbitals involved in the electronic excitations as well as the ordering
of the excited states. (`TSH-DFTB+ <https://pubs.acs.org/doi/full/10.1021/acs.jctc.4c01263>`_)
