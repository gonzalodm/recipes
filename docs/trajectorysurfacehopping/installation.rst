.. highlight:: none
.. _tsh-install:

************
Installation
************
To run Trajectory Surface Hopping (TSH) simulations with TD-DFTB, you need to install two main programs: SHARC and DFTB+. These codes work together but have different roles. SHARC handles the nuclear dynamics, the quantum propagation of the electronic state populations, and the calculation of hopping probabilities between states. DFTB+, on the other hand, provides the electronic structure information required by SHARC, such as potential energy surfaces, energy gradients, and nonadiabatic coupling vectors.

SHARC installation
==================

The first step is to install `SHARC <https://sharc-md.org/?page_id=17>`_. Detailed installation instructions are available in the official repository. For this tutorial, please make sure to install version 3.0 of SHARC, as this is the version that has been tested and validated.

DFTB+ installation
==================

Next, you need to install `DFTB+ <https://www.dftbplus.org/download/index.html>`_. The installation process is also well documented in its official repository. During the configuration, ensure that TD-DFTB support is enabled, which requires linking against the ARPACK library. This tutorial has been tested with version 24.1 of DFTB+, however, in principle, newer versions should also work.


Interface DFTB+/SHARC
=====================

Since the DFTB+/SHARC interface is not yet included in the main SHARC repository, you will need to clone an additional repository that provides this functionality. This repository contains the interface required to run TSH simulations with DFTB+, as well as several scripts for preparing input files and analyzing the resulting trajectories.

After cloning the repository, copy the file ``SHARC_DFTB.py`` into the $SHARC/bin directory of your SHARC installation. This step ensures that SHARC can access the interface during the simulations.

