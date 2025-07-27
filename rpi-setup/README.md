# Raspberry Pi Boot Volume Setup

Automates the initial setup of a Raspberry Pi boot volume for cloud-init, networking, hardware configuration, and certificate management.

## Quick Start

1. **Insert and mount your SD card at** `/Volumes/system-boot` **on macOS.**
2. **Generate CA certificates (if needed):**
   ```shell
   ./scripts/generate-certs.sh
   ```
3. **Run the setup script:**
   ```shell
   ./setup-rpi-boot-volume boot-init [node_id] [username]
   ```
    - `node_id`: Numeric node identifier (e.g., `0`)
    - `username`: New Raspberry Pi user (e.g., `nandi`)

   **Example:**
   ```shell
   ./setup-rpi-boot-volume boot-init 0 nandi
   ```

## Features

- **Cloud-init configuration:** Sets timezone, locale, hostname, disables password SSH, installs extra modules, and adds custom CA certificates.
- **User setup:** Creates a sudo user with SSH key authentication.
- **Kernel command line:** Configures boot parameters for K3s and Raspberry Pi.
- **Network:** Enables Ethernet DHCP, disables WiFi for reliable boot.
- **PoE Hat:** Optionally configures fan speed overlays.
- **Certificate management:** `generate-certs.sh` creates intermediate and k3s CA certificates using an existing root CA.

## Requirements

- macOS
- SD card mounted at `/Volumes/system-boot`
- CA certificates:
    - `credentials/certs/intermediate/cert.pem`
    - `credentials/certs/root-ca/cert.pem`
- SSH public key at `~/.ssh/id_rsa.pub`

## File Operations

- Overwrites: `user-data`, `cmdline.txt`, `network-config` on the boot volume.
- Appends PoE Hat fan config to `config.txt` if not present.
- Certificate generation: `generate-certs.sh` creates and manages CA files in `credentials/certs`.

## Troubleshooting

- Ensure all required files and directories exist before running.
- Scripts exit with error messages if prerequisites are missing.
- For custom CA generation, use `scripts/generate-certs.sh`.

## License

MIT License
```

This version documents the certificate generation script, clarifies usage, and improves structure for maintainability.