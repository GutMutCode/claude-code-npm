{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.claude-code-npm;
in
{
  options.services.claude-code-npm = {
    enable = mkEnableOption "Claude Code (npm version)";

    package = mkOption {
      type = types.package;
      default = pkgs.claude-code-npm;
      defaultText = literalExpression "pkgs.claude-code-npm";
      description = "Claude Code npm package to use";
    };
  };

  config = mkIf cfg.enable {
    # Install package
    home.packages = [ cfg.package ];
  };
}
