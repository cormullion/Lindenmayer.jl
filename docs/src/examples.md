# Examples

## Stack use

This example shows the use of the `[` and `]` stack push and pop commands.

```@example
using Lindenmayer, Luxor, Colors # hide
simple = LSystem(["F" => "F[t+FoF-F]"], "F")
drawLSystem(simple,
   forward=40,
   turn=90,
   iterations=6,
   startingx=0,
   startingy=-100)
```

## Koch

>The Koch snowflake (also known as the Koch curve, Koch star, or Koch island) is a fractal curve and one of the earliest fractals to have been described. It is based on the Koch curve, which appeared in a 1904 paper titled "On a Continuous Curve Without Tangents, Constructible from Elementary Geometry" by the Swedish mathematician Niels Fabian Helge von Koch.

(Wikipedia)

```@example
using Lindenmayer, Luxor, Colors # hide
koch = LSystem(["F" => "F-F++F-F"], "3F") # use turn of 60°
drawLSystem(koch,
   forward     = 8,
   turn        = 60,
   iterations  = 4,
   startingx   = -300,
   startingy   = 0,
   width       = 800,
   height      = 500,
   filename    = :png)
```

```@example
using Lindenmayer, Luxor, Colors # hide
# turn angle = 90°
quadratic_koch = LSystem([
   "F" => "F+F-F-FFF+F+F-F"
   ], 
   "8F+F+F+F")
drawLSystem(quadratic_koch,
   forward=20,
   iterations=2,
   startingx=-220,
   startingy=-75,
   startingpen=(0, 1, 1),
   width=800,
   height=800,
   turn=90,
   filename=:png)
```

```@example
using Lindenmayer, Luxor, Colors # hide
koch_snowflake = LSystem(["F" => "F-F+F+F-F"], "2F")
drawLSystem(koch_snowflake,
   forward=3,
   iterations=5,
   startingx = -350,
   startingy = 150,
   turn=90,
   height=500,
   filename=:svg)
```

## Peano

The Peano curve is the first example of a space-filling curve to be discovered, by Giuseppe Peano in 1890.

```@example
using Lindenmayer, Luxor, Colors # hide
peano = LSystem(["F" => "TF+F-F-toF-F+F+F+F-F"], "3F")
drawLSystem(peano,
   forward=25,
   turn=90,
   iterations=3,
   startingx=-350,
   filename=:png)
```

## Peano Gosper

The Peano-Gosper curve is a plane-filling function originally called a "flowsnake" by Bill Gosper and Martin Gardner. The name was invented by Benoit Mandelbrot.

This example uses `t` to advance the hue by 5° each step.

```@example
using Lindenmayer, Luxor, Colors # hide
peano_gosper = LSystem([
      "X" => "X+YF++YF-tFX--FXFX-YF+",
      "Y" => "-FX+YFYF++YF+FX--FX-Y"],
   "4FX")  # turn 60°

drawLSystem(peano_gosper,
   forward=12,
   turn=60,
   iterations=4,
   startingpen=(0, 0.8, 0.2),
   startingorientation = -π/2,
   startingx=-300,
   startingy=-100,
   filename=:png)
```

## 32 segments

```@example
using Lindenmayer, Luxor, Colors # hide

thirty_two_segment = LSystem([
   "F" => "t-F+F-F-F+F+FF-F+F+FF+F-F-FF+FF-FF+F+F-FF-F-F+FF-F-F+F+F-F+"],
   "2F+F+F+F")

drawLSystem(thirty_two_segment,
   forward=5,
   iterations=2,
   startingx = -150,
   startingy = -150,
   turn=90,
   filename=:png)
```

## Sierpinski

```@example
using Lindenmayer, Luxor, Colors # hide
sierpinski_triangle = LSystem([
      "F" => "G+F+Gt",
      "G" => "F-G-F"],
   "2G") # 60°

drawLSystem(sierpinski_triangle,
   forward=6,
   startingx=-380,
   startingy=350,
   turn=60,
   iterations=7,
   filename=:png)
```

```@example
using Lindenmayer, Luxor, Colors # hide
square_curve = LSystem([
   "X" => "XF-F+F-XF+F+XtF-F+F-X"],
   "F +XF +F +XF +F +XF")

drawLSystem(square_curve,
   forward=0.8,
   startingx=0,
   startingy=-330,
   turn=60,
   iterations=5,
   height = 800, 
   filename=:png)
```

## Dragon curves

```@example
using Lindenmayer, Luxor, Colors # hide
dragon_curve = LSystem([
      "F" => "F+G+t",
      "G" => "-F-G"],
   "3F") #  90 degrees

drawLSystem(dragon_curve,
   forward=14,
   turn=90,
   startingx = -70,
   startingy = -180,
   iterations=10,
   filename=:png)
```

## Hilbert curves

A Hilbert curve (also known as a Hilbert space-filling curve) is a continuous fractal space-filling curve first described by the German mathematician David Hilbert in 1891, as a variant of the space-filling Peano curves discovered by Giuseppe Peano in 1890.

```@example
using Lindenmayer, Luxor, Colors # hide
hilbert_curve = LSystem([
      "L" => "+RF-LFL-tFR+",
      "R" => "-LF+RFR+FL-"],
   "4L") # 90°

drawLSystem(hilbert_curve,
   forward=30,
   turn=90,
   iterations=4,
   startingx=-220,
   startingy=-220,
   filename=:png)
```

```@example
using Lindenmayer, Luxor, Colors # hide
hilbert = LSystem([
      "L" => "+RF-LFL-FR+",
      "R" => "-LF+RFR+FL-t"],
   "9L")

drawLSystem(hilbert,
   forward=20,
   turn=90,
   iterations=5,
   startingx=-320,
   startingy=-320,
   filename=:png)
```

```@example
using Lindenmayer, Luxor, Colors # hide
hilbert_curve2 = LSystem([
      "X" => "XFYFX+F+YFXFY-F-XFYFX",
      "Y" => "YFXFY-F-XFYFX+F+YFXFY"
   ],
   "2X")

drawLSystem(hilbert_curve2,
   forward=8,
   turn=90,
   iterations=4,
   startingx=-320,
   startingy=-320,
   filename=:png)
```

## Plants

```@example
using Lindenmayer, Luxor, Colors # hide

plant = LSystem([
      "F" => "F[-F]cF[+F][F]"],
   "F") # use turn eg 17° or 23°

drawLSystem(plant,
   forward=7,
   startingpen=(0, 0.8, 0.3),
   startingx=0,
   startingy=460,
   startingorientation=-pi / 2,
   turn=23,
   iterations=6,
   height=1000,
   filename=:png)
```

```@example
using Lindenmayer, Luxor, Colors # hide
plant1 = LSystem([
      "F" => "FF",
      "X" => "F−[[cX]+X]+F[+FX]−X"
   ],
   "&1X")

drawLSystem(plant1,
   forward=3,
   turn=13,
   iterations=7,
   startingpen=(0, 0.8, 0.2),
   startingorientation=-pi / 2,
   startingx=-50,
   startingy=450,
   width=800,
   height=1000,
   filename=:png)
```

```@example
using Lindenmayer, Luxor, Colors # hide
branch = LSystem([
      "F" => "FF-[F+F+Fc]+[+F-F-F][+++F+F-F---][---F+F-F---]"
   ],
   "1FFFF")

drawLSystem(branch,
   forward=15,
   turn=20,
   iterations=3,
   startingpen=(0, 0.9, 0.2),
   startingorientation= -π / 2,
   startingx=0,
   startingy=400,
   filename=:png)
```

## Penrose tiling

```@example
using Lindenmayer, Luxor, Colors # hide
penrose = LSystem([
      "X" => "PM++QM----YM[-PM----XM]++",
      "Y" => "+PM--QM[---XM--YM]+",
      "P" => "-XM++YM[+++PM++QM]-",
      "Q" => "t--PM++++XM[+QM++++YM]--YM",
      "M" => "F",
      "F" => ""
   ],
   "1[Y]++[Y]++[Y]++[Y]++[Y]") # 36 degrees

drawLSystem(penrose,
   forward=20,
   turn=36,
   iterations=7,
   startingpen=(0.5, 0.8, 0.2),
   startingorientation=-π / 2,
   startingx=0,
   startingy=0,
   filename=:png)
```

