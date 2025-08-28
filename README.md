# Starknet Validator Node Automation

This repository contains automation scripts for setting up a Starknet validator node using Juno. The automation handles everything from system requirements verification to node setup.

## Prerequisites

- Operating System: Fedora, Ubuntu, or Debian
- Minimum 1024GB of available storage
- Root/sudo access
- ETH RPC (wss://): (e.g., [Alchemy](https://www.alchemy.com/), [Blast](https://blastapi.io/), or setup a local node.)

## Quick Start

After you setup your hosting environment, follow these steps:

1. Setup Env Variables:
```bash
export ETH_RPC_URL="wss://eth-mainnet.g.alchemy.com/v2/<YOUR_ALCHEMY_API_KEY>"
export STARKNET_NETWORK="mainnet"
```

2. Run the installation script:
```bash
curl -sSL https://tinyurl.com/starkvalidator | sh
```

## What the Automation Does

The automation performs the following tasks:

1. **System Requirements Check**
   - Verifies OS compatibility
   - Checks for sufficient storage space (1024GB minimum)
   - Tests write permissions

2. **Dependencies Installation**
   - Ansible (for automation)
   - Docker (for running the validator)
   - Other required system packages

3. **Docker Configuration**
   - Installs Docker
   - Configures Docker service
   - Sets up user permissions

4. **Validator Setup**
   - Downloads and extracts the network snapshot
   - Pulls the Nethermind Juno container
   - Sets up the validator environment

## Directory Structure

- `install.sh` - Main installation script
- `README.md` - This documentation file

## Troubleshooting

### Common Issues

1. **Insufficient Storage**
   - Error: "No mount point has 1024GB available"
   - Solution: Free up space or use a different mount point

2. **Docker Installation Fails**
   - Verify internet connectivity
   - Check system requirements
   - Review logs for specific errors

3. **Snapshot Download Issues**
   - Ensure stable internet connection
   - Verify sufficient disk space
   - Check if the snapshot URL is accessible

### Getting Help

If you encounter issues:
1. Check the error messages in the output
2. Verify all prerequisites are met
3. Create an issue in the repository with:
   - Your OS version
   - Error messages
   - Steps to reproduce

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Security

- The automation script requires sudo access for system configuration
- Docker installation and configuration involve system-level changes
- Review the code before running in your environment

## Future Improvements

- [ ] Add support for more Linux distributions
- [ ] Implement configuration customization
- [ ] Add backup and recovery procedures
- [ ] Include monitoring setup
