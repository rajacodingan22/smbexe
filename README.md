# smbexec Improvements and New Features

## 1. Modernization of Dependencies
- **Installer Update**: Rewrite `install.sh` to support Ubuntu 22.04+ and modern Ruby versions.
- **Gemfile Update**: Update gems to their latest stable versions.
- **Impacket Integration**: Add support for Impacket's `wmiexec.py`, `psexec.py`, and `smbexec.py` as alternatives to the aging `pth-winexe`.

## 2. Core Logic Enhancements
- **Command Execution**: Update `Poet` and `Lib_smb` to support multiple execution methods (Winexe, WMI, SMBExec).
- **Error Handling**: Improve regex-based error detection for modern Windows versions (Windows 10/11, Server 2019/2022).
- **Payload Generation**: Update `Lib_meta` to use `msfvenom` exclusively, removing deprecated `msfpayload` and `msfencode`.

## 3. New Features
- **Modern AV Bypass**: Implement a basic shellcode runner in C# or updated C that uses dynamic API resolution or syscalls to evade basic AV.
- **Mimikatz Integration**: Add a module to execute Mimikatz in memory via PowerShell (Invoke-Mimikatz style).
- **Auto-Discovery**: Add a module to automatically discover Domain Controllers and high-value targets using LDAP queries if domain credentials are provided.
- **JSON Logging**: Add an option to export results in JSON format for easier integration with other tools.

## 4. User Interface Improvements
- **Interactive Shell**: Improve the `getshell` module to provide a more stable interactive experience.
- **Progress Bars**: Add progress bars for long-running scans using the `ruby-progressbar` gem.

## 5. Security
- **Credential Handling**: Ensure credentials are not leaked in process lists (using environment variables or stdin where possible).
- **Cleanup**: Enhance the cleanup routine to ensure no services or files are left on the target system.
