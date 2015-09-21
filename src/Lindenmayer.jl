VERSION >= v"0.4.0-dev+6641" && __precompile__()

module Lindenmayer

export drawLSystem, LSystem

using Luxor, Colors

type LSystem
    rules::Dict{String, String}
    state::Array{Int64, 1}
    initial_state::Array{Int64, 1}
    function LSystem(rules, state_as_string)
        newlsystem = new(rules, string_to_array(state_as_string), string_to_array(state_as_string))
    end
end

function string_to_array(str::String)
    temp = Array{Int64, 1}()
    for c in str
        push!(temp, Int(c))
    end
    return temp
end

function array_to_string(arr::Array)
    temp = ""
    for c in arr
        temp = string(temp, Char(abs(c)))
    end
    return temp
end

"""
    evaluate(ls::LSystem, iterations=1)

    Apply the rules in the LSystem to the initial state repeatedly and simultaneously.
    The ls.state array holds the result.

"""

function evaluate(ls::LSystem, iterations=1; debug=false)
    for i in 1:iterations
        println("iteration $i" )
        the_state = Int64[]
        for j in 1:length(ls.state) # each character in state
            s = string(Char(ls.state[j]))
            if haskey(ls.rules, s)
                #  replace it using the rule
                value = ls.rules[s]
                varr = string_to_array(value)
                if ! isempty(value)
                    push!(the_state, varr...)
                end
            else # keep it in
                push!(the_state, ls.state[j])
            end
        end
        ls.state = the_state
        debug == true ? println(array_to_string(ls.state)) : print("")
    end
end

"""
    render(ls::LSystem)

    Once the LSystem has been evaluated, the LSystem.state can be drawn, by
    looking up the graphics command(s) for each 'letter' in the `graphics` dictionary.

"""

function render(ls::LSystem; debug=false)
    counter = 1
    # set the color before we start
    Pencolor(t, t.pencolor...)
    for a in ls.state
        # convert from number to letter: string(Char(70))
        if haskey(graphics, string(Char(a))) # ignore non-graphical elements
            c = graphics[string(Char(a))]
            debug == true && println(c)
            if length(c) > 1    # might have an entry with more than one command
                for e in c
                    eval(e)
                end
            else                # single command
                eval(c[1])
            end
        end
        # draw text counter for debugging
        #  debug == true && eval(:(Text(t, $(string(counter)))))
        counter += 1
    end
    counter
end

"""
This dictionary contains the graphical commands that match the symbols in the
LSystem alphabet. They're currently calling Luxor graphics commands.

free variables that do nothing X Y P Q M N, often used as placeholders in
complex L-systems
"""

const graphics = Dict{String, Array{Expr, 1}}(
# forward while drawing, we need two sometimes...
"F" => [:(Forward(t, stepdistance))],
"G" => [:(Forward(t, stepdistance))],

# back
"B" => [:(Turn(t, 180)), :(Forward(t, stepdistance)), :(Turn(t, 180))],
"V" => [:(Turn(t, 180)), :(Forward(t, stepdistance)), :(Turn(t, 180))],

# half forward and half back
"f" => [:(Forward(t, stepdistance/2))],
"b" => [:(Turn(t, 180)), :(Forward(t, stepdistance/2))],

# pen up and down
"U" => [:(Penup(t))],
"D" => [:(Pendown(t))],

# rotations
"+" => [:(Turn(t, rotangle))],
"-" => [:(Turn(t, -rotangle))],
"r" => [:(rotangle = [10, 15, 30, 45, 60][rand(1:end)])],

# tint and color - (color/hue)
"T" => [:(randomhue())],
"t" => [:(HueShift(t, 5))], # shift hue round the Hue scale (0-360)
"c" => [:(Randomize_saturation(t))], # shift saturation
"O" => [:(Pen_opacity_random(t))],

# change forward size
"l" => [:(stepdistance = stepdistance + 1)], # larger
"s" => [:(stepdistance = stepdistance - 1)], # smaller

# change pen thickness
"8" => [:(Penwidth(t, 8))],
"5" => [:(Penwidth(t, 5))],
"4" => [:(Penwidth(t, 4))],
"3" => [:(Penwidth(t, 3))],
"2" => [:(Penwidth(t, 2))],
"1" => [:(Penwidth(t, 0.5))],

# shapes
"o" => [:(Circle(t, stepdistance/4))],
"q" => [:(Rectangle(t, stepdistance/4, stepdistance/4))],

# stack
"["  => [:(Push(t))], # push
"]"  => [:(Pop(t))]   # pop
)

"""
    To draw a Lindenmayer system, use drawLSystem()

    drawLSystem(lsystem::LSystem ; forward=30, turn=45, iterations=6)

    where `lsystem` is the definition of a L-System; rules followed by initial state

        newsystem = LSystem(Dict("F" => "AGCFCGAT", "G" => "CFAGAFC"), "F")

    You can change or add rules like this:

        koch.rules["F"] = "OFO"
"""

function drawLSystem(
      lsystem::LSystem ;
        # optional settings:
        forward=15,
        turn=45,
        iterations=3,
        filename="/tmp/lsystem.pdf",
        debugging=false,
        width=1000,
        height=1000,
        startingpen=(0.3, 0.6, 0.8), # starting color RGB
        startingx=0,
        startingy=0,
        startingorientation=0 # -pi/2 means turtle points North on the page (although that's negative y...)
        )
    global t, stepdistance=forward, rotangle=turn
    # use the stored initial state, because the state will grow
    lsystem.state = lsystem.initial_state
    t = Turtle(0, 0, true, startingorientation, startingpen)
    Drawing(width, height, "$filename")
    origin()
    background("black")
    setline(2)
    setlinecap("round")
    setopacity(0.9)
    fontsize(2)
    translate(startingx, startingy)
    evaluate(lsystem, iterations, debug=debugging)
    println("evaluated LSystem, now starting to render to file $(filename)...")
    count = render(lsystem, debug=debugging)
    println("carried out $count graphical instructions")
    finish()
    preview()
end

end # module
