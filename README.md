# Spatial Pattern Formation Models

This repo contains the codes to simulate some spatial models, these are based in the following papers:

1. A. J. Koch and H. Meinhardt [Biological pattern formation: from basic mechanisms to complex structures](https://journals.aps.org/rmp/abstract/10.1103/RevModPhys.66.1481)

2. Turing A. [The Chemical Basis of Morphogenesis](http://www.dna.caltech.edu/courses/cs191/paperscs191/turing.pdf)

3. B. Peña and C. Pérez-García [Stability of Turing patterns in the Brusselator model](https://journals.aps.org/pre/abstract/10.1103/PhysRevE.64.056213)

## Parameters

The laplace operatur used was:

![equation1](http://latex2png.com/output//latex_461714ff355f1e8ccbb273ce8bb3e987.png)

and the time derivative was approximated as 

![equation2](http://latex2png.com/output//latex_6311a2384add92126d25cb8f12c96b12.png)

### Activator-Inhibitor 

Parameters:

| alpha  |   D   | rho   | mu    | sigma | kappa |
| ------ |:-----:| -----:|:------|-------|-------|
| a      | 0.005 | 0.01  | 0.01  |  0.0  | 0.0   |
| h      | 0.200 | 0.02  | 0.02  |   -   |  -    |

kappa_a was varied from 0.0 to 0.25

![deltas](http://latex2png.com/output//latex_72882b258a9c60e7a925b584f8fa5119.png)

![results1](results/activ_inhib_200g.png "Image 1")


### Activator-Substrate 


![equation3](http://latex2png.com/output//latex_a98f1cbe6b58a2b777d1e0a8d1012b12.png)
![equation4](http://latex2png.com/output//latex_b6d0c6172b6fd44b1af56767a0b9edfc.png)

Parameters:

| alpha  |   D   | rho   | mu    | sigma | kappa |
| ------ |:-----:| -----:|:------|-------|-------|
| a      | 0.005 | 0.01  | 0.01  |  0.0  | 0.0   |
| s      | 0.200 | 0.02  |   -   |  0.02 |  -    |

kappa_a was varied from 0.0 to 0.07 in steps of size 0.1

![deltas](http://latex2png.com/output//latex_72882b258a9c60e7a925b584f8fa5119.png)

![results_2](results/activ_subs_11500_00.png "Image 2")

## Results

### Activator-Inhibitor Video

[![video1](results/activ_inhib_gu_1400.png)](https://youtu.be/Q_eaAH4DsCA)
(Click on the image to be directed to the video)

### Activator-Substrate Video
[![video2](results/activ_subu1000g.png)](https://youtu.be/Q_eaAH4DsCA)
(Click on the image to be directed to the video)
