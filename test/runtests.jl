using Lindenmayer, Test

function run_all_tests()
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

drawLSystem(simple, forward=50, turn=90, iterations=6, startingx=0, startingy=-150, filename="simple.pdf", showpreview=false)

drawLSystem(koch, forward=5, turn=60, iterations=6, startingx=-1800, startingy= 0, width=4000, height=4000, filename="koch.pdf", showpreview=false)

drawLSystem(quadratic_Koch, forward=10, iterations=2, turn=90, filename="quadratic_koch.pdf", showpreview=false)

drawLSystem(hilbert, forward=12, turn=90, iterations=6, startingx=-450, startingy= -450, filename="hilbert.pdf", showpreview=false)

drawLSystem(hilbert_curve, forward=25, turn=90, iterations=4, startingx=-200, startingy=-200, filename="hilbert_curve.pdf", showpreview=false)

drawLSystem(hilbert_curve2, forward=10, turn=90, iterations=4, startingx=-450, startingy= -450, filename="hilbert_curve2.pdf", showpreview=false)

drawLSystem(dragon_curve, forward=12, turn=90, iterations=10, filename="dragon_curve.pdf", showpreview=false)

drawLSystem(peano, turn=90, forward=20, iterations=3, startingx=-250, filename="peano.pdf", showpreview=false)

drawLSystem(peano_gosper, forward=10, turn=60, iterations=4, startingpen=(0, 0.8, 0.2), startingorientation=-pi/2, startingx=-200, startingy= -50, filename="peano-gosper.pdf", showpreview=false)

drawLSystem(thirty_two_segment, forward=5, iterations=2, turn=90, filename="32segments.pdf", showpreview=false)

drawLSystem(sierpinski_triangle, forward=3, startingx=-400, startingy= -350, turn=60, iterations=8, filename="sierpinski-triangle.pdf", showpreview=false)

drawLSystem(plant, forward=7, startingpen=(0, 0.8, 0.3), startingx=0, startingy= 460, startingorientation=-pi/2, turn=23, iterations=6, filename="plant.pdf", showpreview=false)

drawLSystem(plant1, forward=3, turn=13, iterations=7, startingpen=(0, 0.8, 0.2), startingorientation=-pi/2, startingx=-50, startingy= 450, filename="plant1.pdf", showpreview=false)

drawLSystem(branch, forward=12, turn=20, iterations=3, startingpen=(0, 0.9, 0.2), startingorientation=-pi/2, startingx=0, startingy= 300, filename="branch.pdf", showpreview=false)

drawLSystem(penrose, forward=25, turn=36, iterations=7, startingpen=(.5, 0.8, 0.2), startingorientation=-pi/2, startingx=0, startingy= 0, filename="penrose.pdf", showpreview=false)

end


if get(ENV, "LINDENMAYER_KEEP_TEST_RESULTS", false) == "true"
        # they changed mktempdir in v1.3
        if VERSION <= v"1.2"
            cd(mktempdir())
        else
            cd(mktempdir(cleanup=false))
        end
        @info("...Keeping the Lindenmayer test output in: $(pwd())")
        run_all_tests()
        @info("Lindenmayer test images were saved in: $(pwd())")
else
    mktempdir() do tmpdir
        cd(tmpdir) do
            @info("running Lindenmayer tests in: $(pwd())")
            @info("but not keeping the results")
            @info("because you didn't do: ENV[\"LINDENMAYER_KEEP_TEST_RESULTS\"] = \"true\"")
            run_all_tests()
            @info("Test images weren't saved. To see the test images, next time do this before running:")
            @info(" ENV[\"LINDENMAYER_KEEP_TEST_RESULTS\"] = \"true\"")
        end
    end
end
