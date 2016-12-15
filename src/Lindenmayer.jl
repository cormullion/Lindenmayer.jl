__precompile__()

module Lindenmayer

export drawLSystem, LSystem

using Luxor, Colors

type LSystem
    rules::Dict{String, String}
    state::Array{Int64, 1}
    initial_state::Array{Int64, 1}
    function LSystem(rules, state_as_string)
        newlsystem = new(rules, string_to_array(state_as_string), string_to_array(state_as_string))
        return newlsystem
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

Apply the rules in the LSystem to the initial state repeatedly. The ls.state array holds
the result.

This must be inefficient, creating a new copy of the state each time......? :(
"""
function evaluate(ls::LSystem, iterations=1; debug=false)
    for i in 1:iterations
        debug && println("iteration $i")
        the_state = Array{Int64, 1}()
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

Once the LSystem has been evaluated, the LSystem.state can be drawn.
"""
function render(ls::LSystem, t::Turtle, stepdistance, rotangle; debug=false)
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
           iterations=3,
           filename="/tmp/lsystem.pdf",
           debugging=false,
           width=1000,
           height=1000,
           startingpen=(0.3, 0.6, 0.8), # starting color RGB
           startingx=0,
           startingy=0,
           startingorientation=0,
           showpreview=true

Draw a Lindenmayer system. `lsystem` is the definition of a L-System (rules followed by initial state).

For example:

    newsystem = LSystem(Dict("F" => "AGCFCGAT", "G" => "CFAGAFC"), "F")

You can change or add rules like this:

    newsystem.rules["F"] = "OFO"
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
    println("starting to evaluate LSystem...")
    evaluate(lsystem, iterations, debug=debugging)
    println("...evaluated LSystem, now starting to render to file $(filename)...")
    counter = render(lsystem, t, forward, turn, debug=debugging)
    println("...carried out $counter graphical instructions")
    finish()
    println("...finished, saved in file $(filename)...")
    if showpreview == true
        preview()
    end
end

end # module
