{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
  ];

  home.username = "shone";
  home.homeDirectory = "/home/shone";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
