using Documenter, Lindenmayer

makedocs(
    sitename = "Lindenmayer",
    modules  = [Lindenmayer],
    warnonly = true,
    format   = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        assets=["assets/extra.css"]
        ), 
    pages=Any[
        "Lindenmayer.jl" => "index.md",
        "Examples"       => "examples.md",
        "Function reference"=>"api.md",
        ]
)
    
repo   = "github.com/cormullion/Lindenmayer.jl.git"
withenv("GITHUB_REPOSITORY" => repo) do
    deploydocs(
        repo=repo,
        target="build",
        push_preview=true,
        forcepush=true,
    )
end
