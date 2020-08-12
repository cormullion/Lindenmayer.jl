# Lindenmayer (L-systems)

L-systems were introduced and developed in 1968 by Aristid Lindenmayer, a
Hungarian theoretical biologist and botanist at the University of Utrecht.
Lindenmayer used L-systems to describe the behaviour of plant cells and to model
the growth processes of plant development. L-systems have also been used to
model the morphology of a variety of organisms and can be used to generate
self-similar fractals such as iterated function systems.

<img src="docs/src/assets/figures/plant.png" alt="plant" title="Plant" width="800" />

```
using Lindenmayer

plant  = LSystem(Dict("F" => "F[-F]cF[+F][F]"), "F")

drawLSystem(plant,
    forward              = 6, 
    startingpen          = (0, 0.8, 0.3),
    startingx            = 0,
    startingy            = 400,
    startingorientation  = -π/2,
    turn                 = 17,
    iterations           = 6,
    filename             = "plant.png")

```
