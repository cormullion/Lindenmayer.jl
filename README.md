# Lindenmayer (L-systems)

L-systems were introduced and developed in 1968 by Aristid Lindenmayer, a
Hungarian theoretical biologist and botanist at the University of Utrecht.
Lindenmayer used L-systems to describe the behaviour of plant cells and to model
the growth processes of plant development. L-systems have also been used to
model the morphology of a variety of organisms and can be used to generate
self-similar fractals such as iterated function systems.

<img src="examples/branch.png" alt="branch" title="L-System" width="200" />
<img src="examples/penrose.png" alt="penrose" title="L-System" width="200" />
<img src="examples/plant.png" alt="plant" title="L-System" width="200" />
<img src="examples/sierpinski-triangle.png" alt="sierpinski" title="L-System" width="200" />
<img src="examples/peano-gosper.png" alt="peano-gosper" title="L-System" width="200" />
<img src="examples/koch.png" alt="koch" title="L-System" width="200" />
<img src="examples/plant1.png" alt="plant1" title="L-System" width="200" />
<img src="examples/hilbert_curve2.png" alt="hilbert_curve2" title="L-System" width="200" />
<img src="examples/32segments.png" alt="32segments" title="L-System" width="200" />
<img src="examples/simple.png" alt="simple" title="L-System" width="200" />
<img src="examples/peano.png" alt="peano" title="L-System" width="200" />
<img src="examples/hilbert.png" alt="hilbert" title="L-System" width="200" />
<img src="examples/dragon_curve.png" alt="dragon_curve" title="L-System" width="200" />
<img src="examples/quadratic_koch.png" alt="quadratic_koch" title="L-System" width="200" />
<img src="examples/hilbert_curve.png" alt="hilbert_curve" title="L-System" width="200" />

In this module, a Lindenmayer System (LSystem) object consists of:

- Rules
    a dictionary of transformation rules that
    replace a character with one or more

- Initial state
    the initial state for the system (also called "the Axiom")

- State
    the current evolved state (initially empty, added when the system is evaluated)

You  can define an L-System like this:

    koch = LSystem(Dict("F" => "F+F--F+F"), "F")

The State is actually stored as an array of integers (I thought it would
probably be faster than very long strings — about half a million is typical —
although I didn't test it), but the rules and initial state are stored as
strings.

To draw the LSystems, we can use a Turtle, as in Turtle Graphics. Each individual
character used is assigned a sequence of one or more graphics commands. For
example, "F" converts to "Forward()". This way, the LSystem's current state can
be drawn once it's evaluated. The graphics dictionary is common to all LSystems.

Graphics are currently provided by Luxor.jl.

To evaluate and draw a Lindenmayer system, use one of the following forms:

    drawLSystem(lsystem::LSystem)
    drawLSystem(lsystem::LSystem, forward=30, turn=45, iterations=6)
    drawLSystem(lsystem::LSystem, filename="/tmp/lsystem.pdf")

— there are lots of options...

Another example:

    hilbert = LSystem(Dict(
        "L" => "+RF-LFL-FR+",
        "R" => "-LF+RFR+FL-"),
        "L")
    drawLSystem(hilbert, forward=5, turn=90, iterations=6, filename="/tmp/hilbert.pdf")
