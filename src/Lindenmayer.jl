"""
An LSystem, or Lindenmayer system, is a set of rules that
can define recursive patterns.

You can define an L-System like this:

```
koch = LSystem(Dict("F" => "F+F--F+F"), "F")
```

and draw it like this:

```
drawLSystem(lsystem, forward=30, turn=45, iterations=6)
```
"""
module Lindenmayer

export drawLSystem, LSystem

using Luxor, Colors

"""
A Lindenmayer system is a set of rules that can define
recursive patterns. In Lindenmayer.jl, an LSystem consists
of:

- Rules: a dictionary of transformation rules that replace a
- character with one or more characters

- Initial state: the initial state for the system (also
- called "the Axiom")

- State: the current evolved state (initially empty, added
- when the system is evaluated)

You can define an L-System like this:

```
using Lindenmayer
koch = LSystem(Dict("F" => "F+F--F+F"), "F")
```

This says: there's just one rule; replace "F" with "F+F--F+F" for
each iteration. And start off with an initial state
consisting of just a single "F".

To draw the LSystem we use Luxor.jl's Turtle, which
interprets the characters in the rule as instructions or
commands. For example, "F" converts to "Luxor.Forward()". "+"
rotates clockwise, "-" rotates counterclockwise, and so on.

So, for this Koch LSystem, the first iteration draws four
"F" lines, and changes direction after drawing them. The
length of the lines and the angle of the turn, and other
starting parameters, can be specified when you evaluate the
LSystem.

To evaluate and draw the Lindenmayer system, use functions
like this:

```
drawLSystem(lsystem)
drawLSystem(lsystem, forward=30, turn=45, iterations=6)
drawLSystem(lsystem, filename="/tmp/lsystem.pdf")
```

Or you could do it in a single function call:

```
drawLSystem(LSystem(Dict("F" => "5F+F--F+Ftt"), "F"),
    startingx = -400,
    forward = 4,
    turn = 80,
    iterations = 6)
```

Keyword options for `drawLSystem` include:

```
forward=15,
turn=45,
iterations=3,
filename="/tmp/lsystem.pdf",
width=1000,
height=1000,
startingpen=(0.3, 0.6, 0.8), # starting color RGB
startingx=0,
startingy=0,
startingorientation=0,
showpreview=true
```

The following characters are recognized in LSystem rules.

F - step Forward
G - same as F
B - step backwards
V - same as B
f - half a step forward
b - turn 180° and take half a step forward
U - lift the pen (stop drawing)
D - pen down (start drawing)
+ - turn by angle
- - turn backwards by angle
r - turn randomly by 10° 15° 30° 45° or 60°
T - change the hue at random
t - shift the hue by 5°
c - randomize the saturation
O - choose a random opacity value
l - increase the step size by 1
s - decrease the step size by 1
5 - set line width to 5
4 - set line width to 4
3 - set line width to 3
2 - set line width to 2
1 - set line width to 1
n - set line width to 0.5
o - draw a circle with radius step/4
q - draw a square with side length step/4
[ - push the current state on the stack
] - pop the current state off the stack
* - execute a command called `Main.f(t::Luxor.turtle)`

### Arbitrary graphics

If you use the asterisk ("*") instruction, the `render()`
function looks for a function called `Main.f(t::Turtle)` and
calls it. For example, the following rule calls out to Luxor
and draws a red star whenever an asterisk is encountered in
the rule.

```
using Luxor
f(t::Turtle) = begin
    setline(0.5)
    sethue("red")
    star(t.xpos, t.ypos, 10, 5, 0.5, 0, :stroke)
end

drawLSystem(LSystem(Dict("F" => "5F+F--F+F*tt"), "F"),
    startingx = -400,
    forward=10,
    turn=89.9,
    iterations=6)
```

"""
mutable struct LSystem
    rules::Dict{String, String}
    state::Array{Int64, 1}
    initial_state::Array{Int64, 1}
    function LSystem(rules, state_as_string)
        newlsystem = new(rules, string_to_array(state_as_string), string_to_array(state_as_string))
        return newlsystem
    end
end

function string_to_array(str::String)
    return map(x -> Int(Char(x)), collect(str))
end

function array_to_string(arr::Array)
    return join(string.(Char.(collect(arr))))
end

"""
evaluate(ls::LSystem, iterations=1)

Apply the rules in the LSystem to the initial state repeatedly. The ls.state array holds
the result.

TODO This must be inefficient, creating a new copy of the state each time......? :(
"""
function evaluate(ls::LSystem, iterations=1)
    next_state = Array{Int64, 1}()
    for i in 1:iterations
        @debug println("iteration $i")
        for j in 1:length(ls.state) # each character in state
            s = string(Char(ls.state[j]))
            if haskey(ls.rules, s)
                #  replace it using the rule
                value = ls.rules[s]
                varr = string_to_array(value)
                if ! isempty(value)
                    push!(next_state, varr...)
                end
            else # keep it in
                push!(next_state, ls.state[j])
            end
        end
        @debug array_to_string(ls.state)
        ls.state = next_state
        next_state = Array{Int64, 1}()
    end
end

"""
    render(ls::LSystem)

Once the LSystem has been evaluated, the LSystem.state can
be drawn.
"""
function render(ls::LSystem, t::Turtle, stepdistance, rotangle)
    counter = 1
    # set the color before we start
    Pencolor(t, t.pencolor...)
    for a in ls.state
        command = string(Char(a))
        if command =="F"
            Forward(t, stepdistance)
        elseif command =="G"
            Forward(t, stepdistance)
        elseif command =="B"
            Turn(t, 180)
            Forward(t, stepdistance)
            Turn(t, 180)
        elseif command =="V"
            Turn(t, 180)
            Forward(t, stepdistance)
            Turn(t, 180)
        elseif command =="f"
            Forward(t, stepdistance/2)
        elseif command =="b"
            Turn(t, 180)
            Forward(t, stepdistance/2)
        elseif command =="U"
            Penup(t)
        elseif command =="D"
            Pendown(t)
        elseif command =="+"
            Turn(t, rotangle)
        elseif command =="-"
            Turn(t, -rotangle)
        elseif command =="r"
            rotangle = [10, 15, 30, 45, 60][rand(1:end)]
        elseif command =="T"
            randomhue()
        elseif command =="t"
            HueShift(t, 5) # shift hue round the Hue scale (0-360)
        elseif command =="c"
            Randomize_saturation(t) # shift saturation
        elseif command =="O"
            Pen_opacity_random(t)
        elseif command =="l"
            stepdistance = stepdistance + 1 # larger
        elseif command =="s"
            stepdistance = stepdistance - 1 # smaller
        elseif command =="5"
            Penwidth(t, 5)
        elseif command =="4"
            Penwidth(t, 4)
        elseif command =="3"
            Penwidth(t, 3)
        elseif command =="2"
            Penwidth(t, 2)
        elseif command =="1"
            Penwidth(t, 1)
        elseif command =="n"
            Penwidth(t, 0.5)
        elseif command =="o"
            Circle(t, stepdistance/4)
        elseif command =="q"
            Rectangle(t, stepdistance/4, stepdistance/4)
        elseif command =="["
            Push(t) # push
        elseif command =="]"
            Pop(t)   # pop
        elseif command =="*"
            Main.f(t::Luxor.Turtle)
        else
        end
        counter += 1
    end
    counter
end

"""
drawLSystem(lsystem::LSystem ;
       # optional settings:
       forward=15,
       turn=45,
       iterations=10,
       filename="/tmp/lsystem.png",
       width=800,
       height=800,
       startingpen=(0.3, 0.6, 0.8), # starting color RGB
       startingx=0,
       startingy=0,
       startingorientation=0,
       showpreview=true)

Draw a Lindenmayer system. `lsystem` is the definition of a
L-System (rules followed by initial state).

For example:

```
newsystem = LSystem(Dict("F" => "AGCFCGAT", "G" => "CFAGAFC"), "F")
```

You can change or add rules like this:

```
newsystem.rules["F"] = "OFO"
```

You can vary the line width using Turtle commands "1", "2",
"3", "4", "5" to select the appropriate line width in
points, or "n" to choose a narrow 0.5.

To debug:

```
ENV["JULIA_DEBUG"] = Lindenmayer
```
"""
function drawLSystem(
      lsystem::LSystem ;
        # optional settings:
        forward=15,
        turn=45,
        iterations=10,
        filename="/tmp/lsystem.png",
        width=800,
        height=800,
        startingpen=(0.3, 0.6, 0.8), # starting color RGB
        startingx=0,
        startingy=0,
        startingorientation=0, # -pi/2 means turtle points North on the page (although that's negative y...)
        showpreview=true
        )
    # use the stored initial state, because the state will grow
    lsystem.state = lsystem.initial_state
    t = Turtle(0, 0, true, startingorientation, startingpen)
    Drawing(width, height, "$filename")
    origin()
    background("black")
    setline(1)
    setlinecap("round")
    setopacity(0.9)
    fontsize(2)
    translate(startingx, startingy)
    @debug "starting to evaluate LSystem..."
    evaluate(lsystem, iterations)
    @debug "...evaluated LSystem, now starting to render to file $(filename)..."
    counter = render(lsystem, t, forward, turn)
    @debug "...carried out $counter graphical instructions"
    finish()
    @debug "...finished, saved in file $(filename)..."
    showpreview && preview()
end

end # module
