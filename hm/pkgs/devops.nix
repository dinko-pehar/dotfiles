{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2
    #awsweeper
    #docker
    podman
    qemu
    kubectx
    kubernetes-helm
    terraform
    #sops
    #groff # Related to AWS.
    #act # Run your GitHub Actions locally
  ];
}
