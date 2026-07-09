# nixos-config

Flake-based NixOS configuration, git-managed. Structure follows the per-host
layout used by etherealwake/config-nix.

## Layout

```
flake.nix                          # inputs (nixpkgs 26.05, home-manager) + outputs
hosts/
  default.nix                      # nixosSystem wrapper: appends modules + users to every host
  sharktopus/
    configuration.nix              # host: bootloader, hostname, timezone, feature toggles
    steam.nix                      # per-host gaming (Steam + Proton-GE + GameMode)
    hardware-configuration.nix     # GENERATED per machine (not committed yet)
modules/
  default.nix                      # shared: nix/flakes, SSH, GC, locale; imports desktop.nix + home-manager
  desktop.nix                      # option `local.desktop.enable` -> GNOME + Intel graphics + PipeWire
users/
  module.nix                       # option `users.local` -> site users via home-manager
  mkaraffa/
    user.nix                       # account (groups, SSH key, initial password)
    home.nix                       # home-manager (git, per-user packages)
```

Add a machine: create `hosts/<name>/configuration.nix` and add a `<name> = nixosSystem { ... }`
entry to `hosts/default.nix`.

## First install (from the NixOS USB, at the console)

1. Connect WiFi (`nmtui`, or the GNOME network menu on the graphical ISO).
2. Partition/mount — format ONLY the old Ubuntu partition, reuse the existing ESP:
   ```
   sudo -i
   mkfs.ext4 -F -L nixos /dev/nvme0n1p5
   mount /dev/nvme0n1p5 /mnt
   mkdir -p /mnt/boot
   mount /dev/nvme0n1p1 /mnt/boot            # existing ESP — do NOT format
   ```
3. Get this repo on the box and generate the hardware config into it:
   ```
   cd /root
   git clone <your-repo-url> nixos-config    # or copy from a USB / download from Drive
   nixos-generate-config --root /mnt --show-hardware-config \
     > nixos-config/hosts/sharktopus/hardware-configuration.nix
   ```
4. Install from the flake:
   ```
   nixos-install --flake ./nixos-config#sharktopus --no-root-passwd
   reboot
   ```

## Day-2 changes

```
sudo nixos-rebuild switch --flake ~/nixos-config#sharktopus
nix flake update        # bump nixpkgs/home-manager
```

## Notes

- `local.desktop.enable = true;` in the host toggles the whole GNOME + gaming stack.
- No secrets in this repo. For WiFi PSKs / tokens later, use `sops-nix` or `agenix`.
  The SSH public key and `initialPassword = "changeme"` are not sensitive (change
  the password with `passwd` after first login).
- To keep Secure Boot on later, adopt `lanzaboote` (as etherealwake does) instead
  of plain systemd-boot.
