final: prev:
let
  # Import node2nix generated packages
  nodePackages = import ./node-packages {
    pkgs = prev;
    inherit (prev) system;
    nodejs = prev.nodejs;
  };
in
{
  # Claude Code from npm (latest version 2.0.37)
  # Generated using node2nix for proper dependency management
  claude-code-npm = nodePackages."@anthropic-ai/claude-code";
}
