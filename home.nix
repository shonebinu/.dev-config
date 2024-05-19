{
  config,
  pkgs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.username = "shone";
  home.homeDirectory = "/home/shone";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # wezterm is my preferred term with JetBrains Mono font and onedark theme
    # wl-clipboard as the preferred clipboard manager
    # dont forget to switch caps lock key with esc key with DE settings or a tool like xremap
    helix
    lazygit
    volta # used to install node
    biome
    dprint
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    nodePackages.intelephense
    phpactor
    vscode-langservers-extracted
    marksman
    ltex-ls
    python311Packages.python-lsp-server
    black
    nil
    alejandra
    emmet-ls
  ];

  home.file = {
    ".config/helix/config.toml".source = ./helix/config.toml;
    ".config/helix/languages.toml".source = ./helix/languages.toml;
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_add_path ~/.volta/bin

      function cheat
          curl cheat.sh/$argv
      end

      function 0x0
          curl -F"file=@$argv" 0x0.st
      end

      function jo
          set template_path (xdg-user-dir DOCUMENTS)/Obsidian\ Vault/Templates/Journal.md
          set journal_path (xdg-user-dir DOCUMENTS)/Obsidian\ Vault/Journal/(date '+%Y/%m/%a %d-%m-%Y.md')

          if test ! -f $journal_path
              cp $template_path $journal_path
          end

          hx $journal_path
      end
    '';
  };
  programs.home-manager.enable = true;
}
