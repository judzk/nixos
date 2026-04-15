{ }:
let
  sources = builtins.fromJSON (builtins.readFile ./sources.json);

  mkSource = pin:
    if pin.type == "github" then
      builtins.fetchTarball {
        url = "https://github.com/${pin.owner}/${pin.repo}/archive/${pin.revision}.tar.gz";
      }
    else
      throw "Unsupported pin type '${pin.type}' in npins/sources.json";
in
  builtins.mapAttrs (_name: pin: mkSource pin) sources.pins
