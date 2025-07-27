# Raspberry Pi Setup

This script automates the initial setup of a Raspberry Pi boot volume, preparing it for cloud-init, network configuration, and hardware-specific settings.

## Usage

Run the script with the following command:

```shell
./setup-rpi-boot-volume boot-init [node_id] [username]
```

- `node_id`: Numeric identifier for the node (e.g., `0`)
- `username`: The username to create on the Raspberry Pi (e.g., `nandi`)

**Example:**
```shell
./setup-rpi-boot-volume boot-init 0 nandi
```

## Features

- **Cloud-init configuration**: Sets timezone, locale, hostname, disables password SSH, installs extra Raspberry Pi modules, and adds custom CA certificates.
- **User setup**: Creates a user with sudo privileges and SSH key authentication.
- **Kernel command line**: Configures boot parameters for K3s and Raspberry Pi.
- **Network configuration**: Enables DHCP on Ethernet and disables WiFi for reliable boot networking.
- **PoE Hat Fan Speeds**: Optionally configures fan speed overlays for Raspberry Pi PoE Hat.

## Requirements

- macOS system
- SD card mounted at `/Volumes/system-boot`
- Custom CA certificates at `credentials/certs/intermediate/cert.pem` and `credentials/certs/root-ca/cert.pem`
- SSH public key at `~/.ssh/id_rsa.pub`

## Notes

- Ensure the SD card is inserted and mounted at `/Volumes/system-boot` before running the script.
- The script will overwrite `user-data`, `cmdline.txt`, and `network-config` on the boot volume.
- Fan speed configuration is only appended if not already present in `config.txt`.

## License

MIT License.