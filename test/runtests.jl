using Lindenmayer
using Base.Test

simple                = LSystem(Dict("F" => "F[t+FoF-F]"), "F")
koch                  = LSystem(Dict("F" => "F+F-"), "F") # use turn of 60 degrees
koch                  = LSystem(Dict("F" => "F+F--F+F"), "F") # 4 # 60 degrees
koch_snowflake        = LSystem(Dict("F" => "F+F--F+F"), "F-F-F")
peano                 = LSystem(Dict("F" => "TF+F-F-toF-F+F+F+F-F"), "3F")
peano_gosper          = LSystem(Dict("X" => "X+YF++YF-tFX--FXFX-YF+", "Y" => "-FX+YFYF++YF+FX--FX-Y" ), "FX" )  # turn 60 degree
quadratic_Koch        = LSystem(Dict("F" => "tF-F+F+FFF-F-F+F"), "4F+F+F+F")
thirty_two_segment    = LSystem(Dict("F" => "t-F+F-F-F+F+FF-F+F+FF+F-F-FF+FF-FF+F+F-FF-F-F+FF-F-F+F+F-F+"), "F+F+F+F")
sierpinski_triangle   = LSystem(Dict("F" => "G+F+Gt", "G"=>"F-G-F"), "G") #  6  # 60 Degree
square_curve          = LSystem(Dict("X"=>"XF-F+F-XF+F+XtF-F+F-X"), "F+XF+F+XF")
dragon_curve          = LSystem(Dict("F"=>"F+G+t", "G"=>"-F-G"), "F") #  90 degrees
hilbert               = LSystem(Dict("L" => "+RF-LFL-cFR+", "R" => "-LF+RFR+FL-"), "1L")
hilbert_curve         = LSystem(Dict("L" => "+RF-LFL-tFR+", "R" => "-LF+RFR+FL-"), "3L") # 90deg
hilbert_curve2        = LSystem(Dict("X" => "XFYFX+F+YFXFcY-F-XFYFX", "Y" => "YFXFY-F-XFYFX+F+YFXFY"), "2X")
plant                 = LSystem(Dict("F" => "F[-F]cF[+F][F]"), "F") # use turn eg 17, 23
plant1                = LSystem(Dict("F" => "FF", "X" => "F−[[cX]+X]+F[+FX]−X"), "1X")
branch                = LSystem(Dict("F" => "FF-[F+F+Fc]+[+F-F-F][+++F+F-F---][---F+F-F---]"), "1FFFF")
penrose               = LSystem(Dict("X"  =>  "PM++QM----YM[-PM----XM]++t",
                                      "Y"  => "+PM--QM[---XM--YM]+t",
                                      "P"  => "-XM++YM[+++PM++QM]-t",
                                      "Q"  => "--PM++++XM[+QM++++YM]--YMt",
                                      "M"  => "F",
                                      "F"  => ""),
                                      "1[Y]++[Y]++[Y]++[Y]++[Y]") # 36 degrees

drawLSystem(simple, forward=50, turn=90, iterations=6, startingx=0, startingy=-150, filename="/tmp/simple.pdf")

drawLSystem(koch, forward=5, turn=60, iterations=6, startingx=-1800, startingy= 0, width=4000, height=4000, filename="/tmp/koch.pdf")

drawLSystem(quadratic_Koch, forward=10, iterations=2, turn=90, filename="/tmp/quadratic_koch.pdf")

drawLSystem(hilbert, forward=12, turn=90, iterations=6, startingx=-450, startingy= -450, filename="/tmp/hilbert.pdf")

drawLSystem(hilbert_curve, forward=25, turn=90, iterations=4, startingx=-200, startingy=-200, filename="/tmp/hilbert_curve.pdf")

drawLSystem(hilbert_curve2, forward=10, turn=90, iterations=4, startingx=-450, startingy= -450, filename="/tmp/hilbert_curve2.pdf")

drawLSystem(dragon_curve, forward=12, turn=90, iterations=10, filename="/tmp/dragon_curve.pdf")

drawLSystem(peano, turn=90, forward=20, iterations=3, startingx=-250, filename="/tmp/peano.pdf")

drawLSystem(peano_gosper, forward=10, turn=60, iterations=4, startingpen=(0, 0.8, 0.2), startingorientation=-pi/2, startingx=-200, startingy= -50, filename="/tmp/peano-gosper.pdf")

drawLSystem(thirty_two_segment, forward=5, iterations=2, turn=90, filename="/tmp/32segments.pdf")

drawLSystem(sierpinski_triangle, forward=3, startingx=-400, startingy= -350, turn=60, iterations=8, filename="/tmp/sierpinski-triangle.pdf")

drawLSystem(plant, forward=7, startingpen=(0, 0.8, 0.3), startingx=0, startingy= 460, startingorientation=-pi/2, turn=23, iterations=6, filename="/tmp/plant.pdf")

drawLSystem(plant1, forward=3, turn=13, iterations=7, startingpen=(0, 0.8, 0.2), startingorientation=-pi/2, startingx=-50, startingy= 450, filename="/tmp/plant1.pdf")

drawLSystem(branch, forward=12, turn=20, iterations=3, startingpen=(0, 0.9, 0.2), startingorientation=-pi/2, startingx=0, startingy= 300, filename="/tmp/branch.pdf")

drawLSystem(penrose, forward=25, turn=36, iterations=7, startingpen=(.5, 0.8, 0.2), startingorientation=-pi/2, startingx=0, startingy= 0, filename="/tmp/penrose.pdf")
