{
  config,
  pkgs,
  ...
}: {
  home.username = "shone";
  home.homeDirectory = "/home/shone";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # wezterm is my preferred term with JetBrains Mono font and onedark theme
    # dont forget to switch caps lock key with esc key with DE settings or a tool like xremap
    helix
    lazygit
    wl-clipboard
    volta # used to install node
    dprint
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    vscode-langservers-extracted
    marksman
    ltex-ls
    phpactor
    python311Packages.python-lsp-server
    black
    nil
    alejandra
    emmet-ls

    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  home.file = {
    ".config/helix/config.toml".source = ./assets/helix/config.toml;
    ".config/helix/languages.toml".source = ./assets/helix/languages.toml;
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
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
