def rga-fzf [...argv] {
    $env.RG_PREFIX = 'rga --files-with-matches'

    if ($argv | length) > 1 {
        $env.RG_PREFIX = $"($env.RG_PREFIX) ($argv | first (($argv | length) - 1))"
    }

    let rgafzf_command = (
        $"FZF_DEFAULT_COMMAND=$env.RG_PREFIX '($argv | last)' \\
        fzf --sort \\\n" + 
        "--preview='({} | length) != 0 and rga --pretty --context 5 {q} {}' \\
        --phony -q "($argv | last)" \\
        --bind $'change:reload:" + $"($env.RG_PREFIX)" + " {q}' \\
        --preview-window='50%:wrap'"
    )

    let file = ^$rgafzf_command
    echo "opening $file"
    open "$file"
}