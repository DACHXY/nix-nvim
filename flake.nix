{
  description = "Flake utils demo";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nix-nvim-module = import ./nix/homeModules { inherit inputs system pkgs; };
      in
      {
        homeManagerModules = {
          nix-nvim = nix-nvim-module;
          default = nix-nvim-module;
        };
      }
    );
}
