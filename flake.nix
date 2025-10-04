{
  description = "Env for Pixi + Deno + Supabase";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.pixi
            pkgs.docker
          ];

          shellHook = ''
            export DOCKER_HOST=unix:///var/run/docker.sock
            pixi install
          '';
        };
      }
    );
}

