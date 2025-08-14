# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
if [[ $EUID == 0 ]]; then
  PROMPT='%K{#DD4B39}%F{#FFFFFF} #%K{#0087AF}%F{#DD4B39}%F{#555555}%K{#0087AF}%F{#FFFFFF} %m %K{#555555}%F{#0087AF}%F{#555555}%K{#555555}%F{#555555}%F{#FFFFFF}%~ %K{#555555}%F{#555555}%k%f '
else
  PROMPT='%K{#697910}%F{#FFFFFF} $%K{#5f00af}%F{#697910}%F{#555555}%K{#5f00af}%F{#FFFFFF} %n@%m %K{#555555}%F{#5f00af}%F{#555555}%K{#555555}%F{#555555}%F{#FFFFFF}%~ %K{#555555}%F{#555555}%k%f '
fi
# ~/.zshrc inside container


# Change Container prompt to make sure we have a different Prompt
if [ "$CONTAINER_PROMPT" = "fedora" ]; then
    # sim hostname
    hostname() { echo "fedora-gaming"; }

    # colours
    autoload -U colors && colors

    # define prompt
    PROMPT="%{$fg[green]%}%n@$(hostname)%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%} $ "

    # Zsh-Autosuggestions
    if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
        source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi
fi

alias fedora='/usr/local/bin/mount-system-update.sh && /usr/bin/distrobox-enter --name fedora-gaming --additional-flags "--env CONTAINER_PROMPT=fedora"'
