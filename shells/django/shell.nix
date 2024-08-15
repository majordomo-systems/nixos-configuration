{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "django-env";

  buildInputs = [
    pkgs.python3Packages.django
    pkgs.python3Packages.djangorestframework
  ];

  shellHook = ''
    echo "Welcome to your centralized Django development environment!"
  '';
}
