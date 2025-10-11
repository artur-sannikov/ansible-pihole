{
  inputs = {
    # nixos-unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            python313
            python313Packages.ansible
            python313Packages.ansible-core
          ];
          # shellHook = ''
          #   export ANSIBLE_COLLECTIONS_PATH="$PWD/ansible/ansible_collections"
          #   export ANSIBLE_ROLES_PATH="$PWD/ansible/roles"
          #   ansible-galaxy install -r ansible/requirements.yaml
          # '';
        };
      }
    );
}
