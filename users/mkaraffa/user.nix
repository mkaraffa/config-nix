{ ... }:

{
  isNormalUser = true;
  description = "Matt";
  extraGroups = [ "wheel" "networkmanager" ];
  initialPassword = "changeme";   # run `passwd` after first login
  openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPhU+TU8ZL+wofNQHb+OCpqUPr0PxRgifoSWHkDcBQng mac"
  ];
}
