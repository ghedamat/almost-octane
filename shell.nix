with (import <nixpkgs> {});
let
  # define packages to install with special handling for OSX
  basePackages = [python nodejs-10_x yarn gnumake gcc readline openssl zlib libxml2 curl libiconv];

  inputs = if system == "x86_64-darwin" then
              basePackages ++ [darwin.apple_sdk.frameworks.CoreServices]
           else
              basePackages;

  hooks = ''
    mkdir -p .nix-node
    export NODE_PATH=$PWD/.nix-node
    export NPM_CONFIG_PREFIX=$PWD/.nix-node
    export PATH=$NODE_PATH/bin:$PATH
  '';

in stdenv.mkDerivation {
  name = "generic-node";
  buildInputs = inputs;
  shellHook = hooks;
}
