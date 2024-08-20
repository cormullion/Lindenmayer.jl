using Lindenmayer, Luxor, Colors, ColorSchemes

logo = LSystem(
      [
      "F" => "[FF + F - FF + F * +++ F + FF + FF *]",
      ],
"9F+F+F+F+F+F+")

global nodes = Point[]

function f(t::Turtle)
      pos = Point(t.xpos, t.ypos)
      push!(nodes, pos)
end

Drawing(500, 500, "docs/src/assets/logo.svg")
origin()
setcolor("black")
setlinecap(:round)
circle(O, 240, :fill)
🐢 = Turtle()
Pencolor(🐢, colorant"white")
Lindenmayer.evaluate(logo, 1)
Lindenmayer.render(logo, 🐢, 25, 360/6, asteriskfunction = (🐢) -> begin
      pos = Point(🐢.xpos, 🐢.ypos)
      push!(nodes, pos)
end)

for (n, pt) in enumerate(nodes)
      setcolor([Luxor.julia_purple, Luxor.julia_red, Luxor.julia_blue, Luxor.julia_green][mod1(n, end)])
      d = distance(O, pt)
      circle(pt, rescale(d, 0, 250, 2, 30), :fill)
end
finish()
preview()