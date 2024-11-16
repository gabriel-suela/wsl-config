{
  # secrets,
  pkgs,
  username,
  nix-index-database,
  ...
}: let
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
    tmux
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
    go
    python311
    python311Packages.pip
    ripgrep
    kubectl
    kubernetes-helm
    helmfile
    sops
    sd
    tmux
    tree
    unzip
    neovim
    wget
    zip
    lua-language-server
  ];

  stable-packages = with pkgs; [
    gh
    just
    rustup
    cargo-cache
    cargo-expand
    mkcert
    httpie
    tree-sitter
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    nil
    alejandra
    deadnix
    nodePackages.prettier
    shellcheck
    shfmt
    statix
  ];
in
{
  imports = [
    nix-index-database.hmModules.nix-index
    ./programs/zsh.nix
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
    zoxide.options = ["--cmd cd"];
    broot.enable = true;
    broot.enableFishIntegration = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userEmail = "gscsuela@gmail.com";
    userName = "gabriel-suela";
    signing.key = "D4033338";
    signing.signByDefault = true;
  };
}

