function fish_prompt --description 'Write out the prompt'
    # Edit from https://github.com/fish-shell/fish-shell/blob/master/share/functions/fish_prompt.fish
    set -l normal (set_color normal)
    set -l color_vcs $fish_color_vcs

    set -l color_cwd $fish_color_cwd
    set -l suffix '$'
    if contains -- $USER root toor
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    set -l prompt_status (__fish_print_pipestatus $last_status " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    echo -n -s (set_color $color_cwd) (prompt_pwd) (set_color $color_vcs) (fish_git_prompt " %s") $normal $prompt_status $suffix " "
end
