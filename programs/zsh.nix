{ ... }:
{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
    };
  };

  home.file.".zshrc".text = ''
    export EDITOR=nvim
    ZSH_THEME="refined"
    export PATH="$HOME/.krew/bin:$PATH"

    eval "$(starship init zsh)"


    source <(fzf --zsh)
    bindkey -s ^f "tmux-sessionizer\n"

    alias task="go-task"
    alias sopsd="sops --decrypt" 
    alias sopsdi="sops --decrypt --in-place" 
    alias sopsei="sops --encrypt --in-place"

  '';
}
