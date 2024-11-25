{
  # secrets,
  pkgs
, username
, nix-index-database
, lib
, ...
}:
let
  unstable-packages = with pkgs.unstable; [
    bat
    bottom
    coreutils
    curl
    du-dust
    fd
    findutils
    git-crypt
    htop
    yq-go
    k9s
    krew
    go-task
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    kustomize
    killall
    mosh
    procs
    gcc
    nodejs
    lazygit
    lua-language-server
    go
    python311
    python311Packages.pip
    ripgrep
    kubectl
    kubernetes-helm
    helmfile
    sops
    sd
    tree
    unzip
    neovim
    wget
    cargo
    zip
    lua-language-server
  ];

  stable-packages = with pkgs; [
    gh
    mkcert
    deadnix
    shellcheck
    statix
  ];
in
{
  imports = [
    nix-index-database.hmModules.nix-index
    ./programs/zsh.nix
    ./programs/tmux.nix
  ];

  home.stateVersion = "22.11";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/zsh";
  };

  home.packages =
    stable-packages
    ++ unstable-packages
    ++ [
      # pkgs.some-package
      # pkgs.unstable.some-other-package
    ];

  home.file = {
    ".local/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;

    starship.enable = true;
    starship.settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;
      git_branch.style = "242";
      directory.style = "blue";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
      python.disabled = true;
      ruby.disabled = true;
      hostname.ssh_only = false;
      hostname.style = "bold green";
    };

    fzf.enable = true;
    fzf.enableFishIntegration = true;
    lsd.enable = true;
    lsd.enableAliases = true;
    zoxide.enable = true;
    zoxide.enableFishIntegration = true;
    zoxide.options = [ "--cmd cd" ];
    broot.enable = true;
    broot.enableFishIntegration = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };

  home.file.".npmrc".text = lib.generators.toINIWithGlobalSection { } {
    globalSection = {
      prefix = "~/.npm";
    };
  };


  programs.git = {
    enable = true;
    userEmail = "gscsuela@gmail.com";
    userName = "gabriel-suela";
    signing.key = "D4033338";
    signing.signByDefault = true;
  };
}

