
| **Documentation**                       | **Build Status**                          | **Code Coverage**               |
|:---------------------------------------:|:-----------------------------------------:|:-------------------------------:|
| [![][docs-stable-img]][docs-stable-url] | [![Build Status][travis-img]][travis-url] | [![][codecov-img]][codecov-url] |
| [![][docs-latest-img]][docs-latest-url] | [![Build Status][appvey-img]][appvey-url] |                                 |


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



[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: http://cormullion.github.io/Lindenmayer.jl/latest/

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: http://cormullion.github.io/Lindenmayer.jl/stable/

[pkgeval-link]: http://pkg.julialang.org/?pkg=Lindenmayer

[pkg-0.5-img]: http://pkg.julialang.org/badges/Lindenmayer_0.5.svg
[pkg-0.5-url]: http://pkg.julialang.org/detail/Lindenmayer.html

[pkg-0.6-img]: http://pkg.julialang.org/badges/Lindenmayer_0.6.svg
[pkg-0.6-url]: http://pkg.julialang.org/detail/Lindenmayer.html

[pkg-0.7-img]: http://pkg.julialang.org/badges/Lindenmayer_0.7.svg
[pkg-0.7-url]: http://pkg.julialang.org/?pkg=Lindenmayer&ver=0.7

[travis-img]: https://travis-ci.org/cormullion/Lindenmayer.jl.svg?branch=master
[travis-url]: https://travis-ci.org/cormullion/Lindenmayer.jl

[appvey-img]: https://ci.appveyor.com/api/projects/status/jfa9e54lv92rqd3m?svg=true
[appvey-url]: https://ci.appveyor.com/project/cormullion/lindenmayer-jl/branch/master

[codecov-img]: https://codecov.io/gh/cormullion/Lindenmayer.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/cormullion/Lindenmayer.jl
