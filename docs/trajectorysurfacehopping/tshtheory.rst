.. highlight:: none

**************************
Trajectory Surface Hopping
**************************

Trajectory Surface Hopping (TSH) is a mixed quantum–classical method used to simulate molecular dynamics after photoexcitation. In this approach, the electrons are treated quantum mechanically, while the nuclei are propagated using classical mechanics on a single potential energy surface at a time. 

The electronic dynamics is governed by the time-dependent Schrödinger equation:

.. math:: i\hbar \dfrac{\partial}{\partial t}\Psi(t) = \hat{H}_{el} \Psi(t)
   :label: TDSE

The electronic wavefunction is expanded in a basis of adiabatic states, and its time evolution determines how the populations of these states change during the dynamics. 

.. math:: \dot{c}_i(t) = -\dfrac{i}{\hbar} E_i c_i(t) -\sum_j c_j(t) \overrightarrow{\sigma}_{ij} \overrightarrow{v}
   :label: POPE

The nuclei are propagated classically on the current (or active) electronic state i:

.. math:: M \dfrac{d^2R}{dt^2} = - \nabla E_i(R)
   :label: NEWT

When two electronic states come close in energy, nonadiabatic couplings allow population transfer between them. At each time step, a hopping probability is computed, and the system may switch from one electronic state to another according to the following equation: 

.. math:: P_{ij} = \dfrac{2\operatorname{Re}(c_i^*c_j\overrightarrow{\sigma}_{ij}\overrightarrow{v})}{|c_i|^2} \Delta t
   :label: PROB

This probability is then compared with a random number to see if the system will remain on the potential energy surface i or it will switch to another state j. If a hop occurs, the nuclear velocities are adjusted to conserve total energy.

For further details on the methodology, the reader is referred to Ref `TSH <https://wires.onlinelibrary.wiley.com/doi/10.1002/wcms.64>`_.

By averaging over many trajectories, TSH provides access to observables such as excited-state lifetimes, relaxation pathways, and photoproduct distributions.
