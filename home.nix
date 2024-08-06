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

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # wezterm is my preferred term with JetBrains Mono font and onedark theme or jet brains new dark ui font
    # wl-clipboard as the preferred clipboard manager
    # dont forget to switch caps lock key with esc key with DE settings or a tool like xremap
    helix
    lazygit
    volta # used to install node
    biome
    dprint
    zellij
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    nodePackages.intelephense
    php83Packages.php-cs-fixer
    phpactor
    vscode-langservers-extracted
    jdt-language-server
    marksman
    ltex-ls
    python311Packages.python-lsp-server
    black
    nil
    alejandra
    emmet-ls
    zoxide
    fzf
  ];

  home.file = {
    ".config/helix/config.toml".source = ./helix/config.toml;
    ".config/helix/languages.toml".source = ./helix/languages.toml;
    ".local/bin/php_format".source = ./bin/php_format;
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_add_path ~/.local/bin
      fish_add_path ~/.volta/bin
      fish_add_path ~/.nix-profile/bin
      fish_add_path /nix/var/nix/profiles/default/bin

      zoxide init fish | source

      function cheat
          curl cheat.sh/$argv
      end

      function 0x0
          curl -F"file=@$argv" 0x0.st
      end

      function jo
          set template_path (xdg-user-dir DOCUMENTS)/Obsidian\ Vault/Templates/Journal.md
          set journal_path (xdg-user-dir DOCUMENTS)/Obsidian\ Vault/Journal/(date '+%Y/%m/%a %d-%m-%Y.md')

          # Ensure directory exists before copying
          mkdir -p (dirname $journal_path)

          if test ! -f $journal_path
              cp $template_path $journal_path
          end

          hx $journal_path
      end
    '';
  };

  programs.home-manager.enable = true;
}
