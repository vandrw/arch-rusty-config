def rga-fzf [file, ...argv] {

    $env.RG_PREFIX = 'rga --files-with-matches'

    if ($argv | length) > 1 {
        $env.RG_PREFIX = $"($env.RG_PREFIX) ($argv[1..-2])"
    }

    let FZF_DEFAULT_COMMAND = $"($env.RG_PREFIX) ($argv | last)"
    let file = (
        fzf --sort \
        --preview='test ! -z {} && \
        rga --pretty --context 5 {q} {}' \
        --phony -q $"($argv | last)" \
        --bind $"change:reload:($env.RG_PREFIX) {q}" \
        --preview-window='50%:wrap'
        )

    echo "opening $file"
    open "$file"
}