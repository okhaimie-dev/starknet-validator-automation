# Starknet Validator Node Automation

This repository contains automation scripts for setting up a Starknet validator node using Juno. The automation handles everything from system requirements verification to node setup.

## Prerequisites

- Operating System: Fedora, Ubuntu, or Debian
- Minimum 1024GB of available storage
- Root/sudo access
- Internet connection

## Quick Start

1. Clone this repository:
```bash
git clone https://github.com/yourusername/starknet-validator-automation.git
cd starknet-validator-automation
```

2. Run the installation script:
```bash
./install.sh
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
   - Verifies installation with hello-world test

4. **Validator Setup**
   - Downloads and extracts the Sepolia snapshot
   - Pulls the Nethermind Juno container
   - Sets up the validator environment

## Directory Structure

- `install.sh` - Main installation script
- `validator-node.yml` - Ansible playbook for node setup
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

[Add your license information here]

## Security

- The automation script requires sudo access for system configuration
- Docker installation and configuration involve system-level changes
- Review the code before running in your environment

## Future Improvements

- [ ] Add support for more Linux distributions
- [ ] Implement configuration customization
- [ ] Add backup and recovery procedures
- [ ] Include monitoring setup
