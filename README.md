# Spiking Network Examples in Julia
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
- [Description and Motivation](#Description)
- [Example Outputs](#Example-Outputs)
- [Getting started](#getting-started)
	- [Install the Julia module](#Install-the-Julia-module)


## Description
Julia has enough tools to support fitting spiking neural network models to data. Python speed necessitates external simulators to do network simulation. As much as possible it would be nice to do fast, efficient data fitting of spike trains to network models in one language, lets try to do that here.
### Motivation
[Previous work](https://github.com/russelljjarvis/BluePyOpt/blob/neuronunit_reduced_cells/examples/neuronunit/OptimizationMulitSpikingIzhikevichModel.ipynb) in data-driven optimization of spiking neurons was implemented in Python. The Python implementation of reduced model simulation sometimes called external simulation, and overall my previous implementation of reduced model optimization was slower and more complex than it needed to be, for language and tool specific reasons.

Reduced model spiking neurons models have compact equations, and they should be fast to simulate, but Python often calls external codes and programes (C,C++,NEURON,brian2,NEST,PyNN) to achieve a speedup for network simulations, however, approaches for speeding up network simulations are not necessarily efficient or convenient for running single-cell simulations, as me be required for single cell optimizations.  This strategy of calling external code causes an intolerable code complexity and intolerable run-time cost for single neuron simulations. The Python tool numba JIT partially remedies this problem, however, code from the Python optimization framework DEAP/BluePyOpt also induces an additional overhead. An almost pure Julia SNN optimization routine is a better solution to efficiently optimizing Reduced SNN models. In this package, two other packages: Evolutionary.jl, and Metaheuristics provide genetic algorithms used to optimize spiking neural networks.
 
The loss function is constructed by computing Spike Distance between all pairs of neurons
Networks are optimized using pair wise spike-distance metric on each pair of neurons
Pythons NetworkUnit package is used to perform a posthoc evaluation of the optimized network.


### Example Outputs
See the figure below where local variation and firing rates are compared against every neuron between two model networks.

#### Network optimization
For example this is a ground truth model versus an optimized model t-test of firing rates:
```
Student's t-test
	datasize: 200 	 200
	t = 11.811 	 p value = 1.82e-25
```
#### Single Cell optimization
Note for perspective 86% of spike times are matched in some of the best, model fitting competitions.
![https://github.com/russelljjarvis/SpikeNetOpt.jl/blob/main/img/single_cell_spike_time_fit.png](https://github.com/russelljjarvis/SpikeNetOpt.jl/blob/main/img/single_cell_spike_time_fit.png)


### Getting Started
# Install the Julia module
This is not yet an official package, so the package would need to be added in developer mode:
```
git clone https://github.com/russelljjarvis/SpikeNetOpt.jl
```

```
julia
using Pkg;
Pkg.activate(".")
or Pkg.develop()
```
##Entry Points

Optimize a spiking neural network by exploring effect of parameter that controls connectome graph structure:
```
cd examples
julia sdo_network.jl
```

Single cell data fitting against spike times:
```
cd test
julia single_cell_opt_adexp.jl 
julia single_cell_opt_izhi.jl
```
### Development Plans
# DONE

- [x] Used spike distance and genetic algorithms to optimize network spike raster activity.
- [x] Used pythons NetworkUnit to validate results
- [x] NetworkUnit t-tests of results
- [x] Created single cell model fitting to Allen Brain Observatory Spike Train Data.
- [x] Implemented multi-threading
## TODO
- [ ] Ability to toggle between simulator backends (AStupid bear vs https://github.com/darsnack/SpikingNN.jl)
- [ ] Implemented multi-processing of feature extraction/spike distance (sort of)
- [ ] Animation of Genetic Algorithm Convergence (sort of)
- [ ] Different Spiking Neural Network Backends (WaspNet.jl,SpikingNN.jl)
- [ ] Multiprocessing as opposed to multi-threading
- [ ] NeuroEvolution
- [ ] ADAM-Opt predictions using evolved population.
- [ ] Read in and optimize against FPGA Event Stream Data AEDAT

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://russelljjarvis.github.io/home/"><img src="https://avatars.githubusercontent.com/u/7786645?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Russell Jarvis</b></sub></a><br /><a href="https://github.com/russelljjarvis/SpikeNetOpt.jl/commits?author=russelljjarvis" title="Code">💻</a> <a href="https://github.com/russelljjarvis/SpikeNetOpt.jl/commits?author=russelljjarvis" title="Documentation">📖</a> <a href="#ideas-russelljjarvis" title="Ideas, Planning, & Feedback">🤔</a> <a href="#design-russelljjarvis" title="Design">🎨</a> <a href="#infra-russelljjarvis" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
