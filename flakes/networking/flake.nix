{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
  {
    self,
    nixpkgs,
    systems,
  }:
  let
    forEachSystem =
      f: nixpkgs.lib.genAttrs (import systems) (system: f {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      });
  in
  {
    devShells = forEachSystem (
      { pkgs }:
      {
        default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            dnsutils
            whois
            nethogs
            termshark
          ];
        };
      }
    );
  };
}

# Kali Linux:
# Network and Web Security Tools
# Nmap - Network discovery and security auditing.
# Wireshark - Network protocol analyzer.
# Aircrack-ng - Tools for auditing wireless networks.
# Burp Suite - Web vulnerability scanner.
# Nikto - Web server scanner.
# OWASP ZAP - Web application security scanner.
# SQLmap - Automated SQL injection tool.
# Exploitation Tools
# Metasploit Framework - Exploitation framework.
# Armitage - GUI for Metasploit.
# BeEF (Browser Exploitation Framework) - Focused on web browsers.
# Exploit Database - Archive of exploits and vulnerable software.
# Password Cracking Tools
# John the Ripper - Password cracking tool.
# Hashcat - Advanced password recovery utility.
# Hydra - Network login cracker.
# Wireless Tools
# Kismet - Wireless network detector and sniffer.
# Reaver - Brute-force attack against Wi-Fi Protected Setup (WPS).
# Fern WiFi Cracker - Wireless security auditing and attack software.
# Vulnerability Analysis Tools
# OpenVAS - Vulnerability scanner.
# Nessus - Vulnerability scanner (though it is commercial, you can get a free version).
# Forensics Tools
# Autopsy - Digital forensics platform.
# Volatility - Advanced memory forensics framework.
# Binwalk - Firmware analysis tool.
# Foremost - File carving tool for recovering deleted files.
# Reverse Engineering Tools
# Ghidra - Software reverse engineering tool.
# Radare2 - Reverse engineering framework.
# OllyDbg - Windows debugger.
# Social Engineering Tools
# Social-Engineer Toolkit (SET) - Social engineering framework.
# Maltego - Interactive data mining tool that renders directed graphs for link analysis.
# Sniffing and Spoofing Tools
# Ettercap - Network sniffer/interceptor/logger.
# Dsniff - Tools for network auditing and penetration testing.
# Post Exploitation Tools
# Empire - Post-exploitation framework.
# Powersploit - PowerShell Post-Exploitation Framework.
# Information Gathering Tools
# theHarvester - E-mail, subdomain, and people names harvester.
# Shodan - Searches for devices connected to the internet.
# Wireless Attacks
# WiFite - Automated wireless auditor.
# Ghost Phisher - Wireless and Ethernet security auditing tool.
# Exploit Writing Tools
# MSFvenom - Payload generation tool (part of Metasploit).
# NASM - Assembler for the x86 CPU architecture.
# Miscellaneous Tools
# Netcat - Network utility for reading/writing network connections.
# Proxychains - Proxy server chains for TCP connections.
# Tor - Privacy-focused browser/network.
# Docker - Used to containerize and run various security tools in isolated environments.



  # FLUXION - https://github.com/FluxionNetwork/fluxion
  # JOHN THE RIPPER - https://www.openwall.com/john/
  # LYNIS - https://cisofy.com/lynis/
  # NIKTO - https://securitytrails.com/blog/nikto-website-vulnerability-scanner
  # NMAP - https://nmap.org/
  # SKIPFISH - https://gitlab.com/kalilinux/packages/skipfish/
  # SET - https://github.com/trustedsec/social-engineer-toolkit
  # AIRCRACK-NG - https://www.aircrack-ng.org/
  # SNORT - https://www.snort.org/?ref=itsfoss.com
  # APKTOOL - https://github.com/iBotPeaches/Apktool
  # BEEF - https://beefproject.com/

  # INSTALL TSHARK & Others
  # https://lindevs.com/install-tshark-on-ubuntu
  # https://opensource.com/article/20/1/wireshark-linux-tshark
  # https://www.tutorialspoint.com/monitoring-network-usage-in-linux