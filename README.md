# nixos-dotfiles

NixOS Configuration files

## Demo

![demo.gif](/assets/demo.gif)

## Setup

1. Install pre-commit hook for checking secrets leaks

```sh
nix run nixpkgs#pre-commit autoupdate
nix run nixpkgs#pre-commit install
```
