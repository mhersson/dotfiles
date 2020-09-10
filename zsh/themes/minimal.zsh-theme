# PROMPT=" %B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b " # Print some system information when the shell is first started
PROMPT=" %(4~|%-1~/.../%2~|%~) %{$fg[red]%}>>>%{$reset_color%} "

if [ -n "${SSH_CLIENT}" ]; then
  hostname=$(hostname)
  PROMPT="[SSH "${hostname}"] %(4~|%-1~/.../%2~|%~) %{$fg[green]%}>>>%{$reset_color%} "
fi
