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
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ ];
        };
        nix-nvim-module = import ./nix/homeModules self;
      in
      {
        homeManagerModules = {
          nix-nvim = nix-nvim-module;
          default = nix-nvim-module;
        };

        overlays.default = pkgs.lib.composeManyExtensions [
          inputs.neovim-nightly-overlay.overlays.default
        ];
      }
    );
}
