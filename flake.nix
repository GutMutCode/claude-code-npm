{
  description = "Claude Code (npm version) for NixOS and Nix users";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # Overlay for adding claude-code-npm package to nixpkgs
      overlays.default = import ./overlay.nix;

      # NixOS module
      nixosModules.default = import ./module.nix;

      # home-manager module
      homeManagerModules.default = import ./module.nix;

      # Packages for each system
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          claude-code-npm = pkgs.claude-code-npm;
          default = pkgs.claude-code-npm;
        }
      );

      # Apps (for nix run)
      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.claude-code-npm}/bin/claude-code";
        };
      });

      # Development shell
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = [ self.packages.${system}.claude-code-npm ];
            shellHook = ''
              echo "Claude Code (npm) development environment"
              echo "Run 'claude-code' to start"
            '';
          };
        }
      );
    };
}
