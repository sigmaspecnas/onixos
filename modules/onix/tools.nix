{
  pkgs,
  ...
}:
let
  tool = name:
    pkgs.writeTextFile {
      name = "onix-${name}";
      text = builtins.readFile ../../tools/onix-${name};
      executable = true;
      destination = "/bin/onix-${name}";
    };
in
{
  environment.systemPackages = map tool [
    "rebuild"
    "update"
    "search"
    "install"
    "remove"
    "rollback"
    "gc"
    "generate-config"
  ];
}