{
  description = "nix neovim";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      neovim-nightly-overlay,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        nix-nvim-module = import ./nix/homeModules;
      in
      {
        homeManagerModules = {
          nix-nvim = nix-nvim-module;
          default = nix-nvim-module;
        };
      }
    );
}
