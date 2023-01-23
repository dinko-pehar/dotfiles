{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ----------------------------------- RECON ---------------------------------- #
    naabu # port scanning tool
    subfinder # subdomain discovery tool
    httpx # HTTP Probe toolkit
    # --------------------------------- DISCOVERY -------------------------------- #
    ffuf # Web Fuzzer
    trufflehog # Credentials finder
    nmap # NMap
    rustscan
    #git-hound # Finds exposed API keys
    #secretscanner
    # -------------------------------- PENETRATION ------------------------------- #
    metasploit # Penetration framework
    sqlmap # SQL Injection
    #mitmproxy
    #thc-hydra
    #burpsuite
    mongoaudit
    commix
    inql
    scorecard
    arsenal
    # ----------------------------------- META ----------------------------------- #
    exploitdb # Database of exploits
    #wapiti
  ];
}
