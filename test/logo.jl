using Lindenmayer, Luxor, Colors, ColorSchemes

crystal = LSystem(Dict(
   "F" => "9F[F-]+*",
   ),
   "F")

plant = LSystem(Dict(
  "A" => "UBB8D", # initialize
  "X" => "*[-F*X*]+F*X"),
  "AX")

global x = 0
function f(t::Turtle)
      pos = Point(t.xpos, t.ypos)
      if x == 0
            # we'll just do this at the very start
            sethue("black")
            circle(O, 245, :clip)
            paint()
      end

      d = distance(pos, boxbottomcenter(BoundingBox()))
      setcolor([Luxor.julia_purple, Luxor.julia_red,  Luxor.julia_green][rand(1:end)])
      circle(pos, 10, :fill)
      global x += 1
end

drawLSystem(plant,
      forward = 70,
      turn = 17,
      iterations=4,
      #startingx=-250,
      #startingy=250,
      startingorientation = -π/2,
      startingpen = (1, 1, 1),
      width=500,
      height=500,
      asteriskfunction = f,
      filename="docs/src/assets/logo.png",
      backgroundcolor = RGBA(1, 1, 1, 0))
