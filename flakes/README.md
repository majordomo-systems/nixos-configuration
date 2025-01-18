# Using Flakes

## 1. Enter the Flake's Development Shell

This sets up an isolated shell with the development environment defined in your flake.

```zsh
nix develop ./development
```

This command uses the devShell attribute in your flake.
If you're using a remote flake, replace ./development with the flake URL (e.g., github:user/repo).

## 2. Use the Flake with nix-shell (For Compatibility)

If you are on an older NixOS setup or want to ensure compatibility with tools expecting nix-shell:

```zsh
nix-shell ./development/flake.nix
```

This uses the flake to generate an environment, similar to nix develop.

## 3. Clean Up Development Environment

If you want to clean up residual files or garbage collected dependencies created during the development process, you can manually run:

```zsh
nix-collect-garbage
```

This ensures any temporary or cached data used during the session is cleaned up, freeing up disk space.

## 4. Run a Specific Application from the Flake

If your flake defines applications under apps, you can directly run them.

```zsh
nix run ./development#<app-name>
```

Example:

```zsh
nix run ./development#my-tool
```

## 5. Install the Flake as a Profile

This installs the tools, packages, or environments defined in your flake into your user profile. It’s persistent across shell sessions.

```zsh
nix profile install ./development
```

This makes all the tools and packages available globally to your user profile.
You can remove it later with:

```zsh
nix profile remove <profile-name>
```

## 6. Use Direnv for Per-Project Persistence

For a project-specific but persistent setup, use direnv with Nix.

Install direnv and enable it:

```zsh
use flake .
```

Allow the .envrc file:

```zsh
direnv allow
```

Now every time you enter the project folder, direnv will automatically activate the flake’s environment, and it will persist until you leave the folder.
