function fish_prompt
    set -l last_status $status

    set -l normal (set_color normal)
    set -l usercolor (set_color $fish_color_user)
    set -l cwd (set_color 3e8fb0)  # Fixed color: #3e8fb0

    set -l delim "> "
    # Fallback to ASCII delimiter if Unicode isn't supported
    string match -qi "*.utf-8" -- $LANG $LC_CTYPE $LC_ALL; or set delim ">"

    fish_is_root_user; and set delim "#"

    # Show exit status if non-zero
    set -l prompt_status
    test $last_status -ne 0; and set prompt_status (set_color $fish_color_status)"[$last_status]$normal"

    # Only show host in SSH/containers (cached for performance)
    if not set -q prompt_host
        set -g prompt_host ""
        if set -q SSH_TTY
            or begin
                command -sq systemd-detect-virt
                and systemd-detect-virt -q
            end
            set prompt_host $usercolor$USER$normal@(set_color $fish_color_host)$hostname$normal":"
        end
    end

    # Display the prompt
    echo -n -s $prompt_host $cwd(prompt_pwd) $normal $prompt_status $delim
end
