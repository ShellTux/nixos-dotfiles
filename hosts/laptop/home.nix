{ inputs, lib, pkgs, ... }:
let
  genCdAliases = len:
    let
      strRepeat0 = str: acc: n: if n == 0 then str else strRepeat0 (acc + str) acc (n - 1);
      strRepeat = str: n: strRepeat0 str str n;
      alias = strRepeat "." len;
      pathStr = strRepeat "../" len;

      genCdAliases0 = depth: attrs:
        if depth <= 1 then attrs
        else (genCdAliases0 (depth - 1) attrs) //
          { ${builtins.substring 0 depth alias} = ("cd " + builtins.substring 0 ((depth - 1) * 3) pathStr); };
    in
    genCdAliases0 len {};
in
{
  home.username = "luisgois";
  home.homeDirectory = "/home/luisgois";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = let path = ../../modules/home-manager; in [
  	(path + "/bat.nix")
  	(path + "/btop.nix")
  	(path + "/direnv.nix")
  	(path + "/eza.nix")
  	(path + "/fd.nix")
  	(path + "/firefox.nix")
  	(path + "/fzf.nix")
  	(path + "/git/default.nix")
  	(path + "/htop.nix")
  	(path + "/kitty.nix")
  	(path + "/mpv.nix")
  	(path + "/neovim/default.nix")
  	(path + "/shell/default.nix")
  	(path + "/ssh.nix")
  	(path + "/starship.nix")
  	(path + "/tealdeer.nix")
  	(path + "/tmux.nix")
  	(path + "/vim.nix")
  	(path + "/wezterm/default.nix")
  	(path + "/window-managers/wayland/hyprland/default.nix")
  	(path + "/yazi.nix")
  	(path + "/yt-dlp.nix")
  	(path + "/zathura.nix")
  ] ++ [
      inputs.nixvim.homeManagerModules.nixvim
  ];

  bash.enable = true;
  bat.enable = true;
  btop.enable = true;
  direnv.enable = true;
  eza.enable = true;
  fd.enable = true;
  firefox.enable = true;
  fzf.enable = true;
  git.enable = true;
  htop.enable = true;
  hyprland.enable = true;
  kitty.enable = true;
  mpv.enable = true;
  neovim.enable = true;
  ssh.enable = true;
  starship.enable = true;
  tealdeer.enable = true;
  tmux.enable = true;
  vim.enable = true;
  wezterm.enable = true;
  yazi.enable = true;
  yt-dlp.enable = true;
  zathura.enable = true;
  zsh.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
	  builtins.elem (lib.getName pkg) [
	  "codeium"
	  "slack"
	  ];

  home.packages = with pkgs; [
	ani-cli
	anki
	ffmpeg-full
	jellyfin-media-player
	libqalculate
	mediainfo
	nemo
	nvtopPackages.intel
	procs
	qbittorrent
	slack
	stremio
	translate-shell
	unar
	webcord
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.shellAliases = lib.mkMerge [
  {
	  bathelp = "bat --plain --language=help";
	  cd1 = "cd ..";
	  cd2 = "cd ../../";
	  cd3 = "cd ../../../";
	  cd4 = "cd ../../../../";
	  cd5 = "cd ../../../../../";
	  chmod = "chmod --changes";
	  chown = "chown --changes";
	  clang-format = "clang-format --verbose";
	  cp = "cp --interactive --verbose";
	  df = "df --human-readable";
	  diff = "diff --color=auto";
	  du = "du --human-readable";
	  free = "free --human --wide --total";
	  gdb = "gdb --tui";
	  grep = "grep --colour=auto";
	  install = "install --verbose";
	  ip = "ip --color=auto";
	  kernel = "uname --kernel-release";
	  lower = "tr \"[:upper:]\" \"[:lower:]\"";
	  lsblk-label = "lsblk -o name,fstype,mountpoint,label,partlabel,size";
	  mkdir = "mkdir --parents --verbose";
	  more = "less";
	  mv = "mv --verbose";
	  np = "nano --nowrap PKGBUILD";
	  open = "xdg-open";
	  port = "netstat --tcp --udp --listening --all --numeric --program --wide";
	  procs = "procs --watch-interval=.5 --watch";
	  progress = "progress --wait-delay .5 --monitor-continuously";
	  publicIP = "printf '%s\n' \"$(curl --ipv4 --silent ifconfig.me)\"";
	  ":q" = "exit";
	  randomcolor = "printf \"#$(openssl rand -hex 3 | tr \"[:lower:]\" \"[:upper:]\")\n\"";
	  rmdir = "rmdir --verbose --parents";
	  rm = "rm --verbose --one-file-system --no-preserve-root --interactive=once";
	  shred = "shred --verbose";
	  silicon = "silicon --theme OneHalfDark --font \"FiraCode Nerd Font\"";
	  ssh-agentd = "eval $(ssh-agent -s)";
	  sshfs = "sshfs -o \"compression=yes,reconnect\"";
	  suvim = "doas vim";
	  tree = "eza --color=auto --color-scale all --icons --tree --git-ignore";
	  upper = "tr \"[:lower:]\" \"[:upper:]\"";
	  watch = "watch --color --interval 1";
	  ytdownload = "yt-dlp --embed-subs --all-subs --embed-thumbnail --embed-metadata --embed-chapters --format \"bestvideo[height<=1440]+bestaudio/best\"";
  }
  (genCdAliases 20)
  ];

  services.ssh-agent.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
