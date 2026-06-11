##########################
Trajectory Surface Hopping
##########################

The study of photochemical and photophysical properties of molecules requires understanding how a system evolves after the absorption of light. To describe these processes, one can employ Trajectory Surface Hopping (TSH), a widely used technique in this field. TSH allows access to key information such as the different pathways of non-radiative transitions, the lifetimes of excited states, and the probabilities of forming various photoproducts, along with many other properties relevant to the system under investigation.

In this tutorial, we will demonstrate how to perform TSH simulations with time-dependent density functional tight-binding (TD-DFTB) using DFTB+ code. TSH is a computationally demanding approach, as it requires running many trajectories and, depending on the complexity of the phenomenon under study, often long simulation times. In this context, tight-binding methods are particularly attractive because they are significantly more computationally efficient than time-dependent density functional theory (TD-DFT), while still providing qualitatively similar results.


.. toctree::
   :maxdepth: 1

   tshtheory.rst
   installation.rst
   introduction.rst
   initialconditions.rst
   initialexcitation.rst
   namd.rst
   analysis.rst
