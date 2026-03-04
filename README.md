## SentinelX

**High-Performance Zsh Theme for Offensive Security.**

SentinelX is a lightweight, high-fidelity Zsh theme optimized for penetration testing and red teaming. It provides real-time situational awareness and process tracking for long-running security tools.

### Key Features

* **Live Process Spinner**: Uses `gum` to provide a visual heartbeat for tools like `nmap` and `ffuf`.
* **VPN Guard**: Automatic icon (`󰖂`) when `tun0` or `wg0` is active.
* **Privilege Alert**: Dynamic **Red Skull (`󱗓`)** and red username when running as `root`.
* **Execution Timer**: Displays command duration (e.g., `45s 󱑎`) in the status bar.
* **Dual-Line UI**: Separates metadata from the input line for cleaner payload typing.

### Pentest Aliases

| Alias | Command | Purpose |
| --- | --- | --- |
| `nscan` | `nmap -Pn -sC -sV` | Stealthy service discovery |
| `fscan` | `nmap -p- -T4` | Full port discovery |
| `dirb` | `ffuf -recursion` | Directory fuzzing |
| `git-clone` | `git clone` | Directory fuzzing |

### Quick Start

1. **Prerequisites**: Install a [Nerd Font](https://www.nerdfonts.com/) and `golang`.
2. **Install**:
```bash
cat sentinelx.zsh >> ~/.zshrc && source ~/.zshrc

```


3. **Usage**:
```bash
scan <command>  # Runs any command with the live spinner

```


---
Demo Image:

 <img width="1922" height="391" alt="image" src="https://github.com/user-attachments/assets/9cce46f4-980b-443e-b23c-b6d55f5fe9fa" />
