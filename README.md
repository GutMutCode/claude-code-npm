# Claude Code (npm) for Nix/NixOS

Claude Code npm package packaged for NixOS and Nix users.

## About

This flake provides the npm version of Claude Code (@anthropic-ai/claude-code) using node2nix for proper dependency management.

- **Version**: 2.0.32
- **Source**: npm registry
- **License**: Proprietary

## Usage

### With Flakes

Add to your `flake.nix`:

```nix
{
  inputs = {
    claude-code-npm.url = "github:GutMutCode/claude-code-npm";
  };

  outputs = { self, nixpkgs, claude-code-npm, ... }: {
    nixosConfigurations.your-host = nixpkgs.lib.nixosSystem {
      modules = [
        {
          nixpkgs.overlays = [ claude-code-npm.overlays.default ];
          home-manager.users.your-user = {
            home.packages = [ pkgs.claude-code-npm ];
          };
        }
      ];
    };
  };
}
```

### Direct Installation

```bash
nix profile install github:GutMutCode/claude-code-npm
```

### Run Without Installing

```bash
nix run github:GutMutCode/claude-code-npm
```

## Building from Source

```bash
git clone https://github.com/GutMutCode/claude-code-npm
cd claude-code-npm
nix build
./result/bin/claude-code
```

## Updating

To update the npm package version:

1. Edit `node-packages/node-packages.json`
2. Run: `nix-shell -p node2nix --run "node2nix --input node-packages.json --output node-packages.nix --composition default.nix"`
3. Update version in `overlay.nix` comment

## License

MIT (for the packaging code)

Claude Code itself is proprietary software by Anthropic.
