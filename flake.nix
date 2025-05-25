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
          overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
        };
        nix-nvim-module = import ./nix/homeModules { inherit pkgs; };
      in
      {
        homeManagerModules = {
          nix-nvim = nix-nvim-module;
          default = nix-nvim-module;
        };
      }
    );
}
