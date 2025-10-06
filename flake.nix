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
            pkgs.supabase-cli
          ];

          shellHook = ''
            export DOCKER_HOST=unix:///var/run/docker.sock
            export COCOINDEX_DATABASE_URL="postgresql://cocoindex:cocoindex@localhost:5432/cocoindex"
            export CUDA_VISIBLE_DEVICES=""  # Force CPU for PyTorch Delete or comment if you unlike me have a compatible GPU
            pixi install
            pixi shell
          '';
        };
      }
    );
}

