{ ... }:
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "refined";
        plugins = [
          "git"
        ];
      };
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
    };
  };

  home.file.".zshrc".text = ''
    export EDITOR=nvim
    ZSH_THEME="refined"
    export PATH="$HOME/.krew/bin:$PATH"


    source <(fzf --zsh)
    bindkey -s ^f "tmux-sessionizer\n"

    alias task="go-task"
    alias sopsd="sops --decrypt" 
    alias sopsdi="sops --decrypt --in-place" 
    alias sopsei="sops --encrypt --in-place"

  '';
}
