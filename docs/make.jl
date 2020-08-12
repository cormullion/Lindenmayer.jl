using Documenter
using Lindenmayer

makedocs(
    sitename = "Lindenmayer",
    modules = [Lindenmayer],
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages    = Any[
        "Lindenmayer.jl" => "index.md",
        "Examples" =>    "examples.md",
        ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/cormullion/Lindenmayer.jl.git",
    target = "build"
)
