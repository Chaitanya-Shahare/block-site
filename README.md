# block-site

`block-site` is a simple CLI tool that allows you to block and unblock websites by modifying the `/etc/hosts` file on macOS. The tool supports blocking and unblocking websites with a single command.

## Features
- **Block websites**: Redirects domains to `127.0.0.1`, effectively blocking access to them.
- **Unblock websites**: Removes domains from the `/etc/hosts` file, restoring access to them.
- **Flushes DNS cache automatically**: Ensures changes take effect immediately.

## Requirements
- macOS or Linux
- Homebrew (for installation)

## Installation

To install `block-site` using Homebrew, follow these steps:

1. Tap the repository:
   ```bash
   brew tap Chaitanya-Shahare/formulae
   ```

2. Install the `block-site` tool:
   ```bash
   brew install block-site
   ```

## Usage

Once installed, you can block and unblock websites with the following commands:

### Block a Website

To block a website (e.g., `example.com`):

```bash
block-site --block example.com
```

This will add `example.com` and `www.example.com` to your `/etc/hosts` file, redirecting them to `127.0.0.1` and blocking access.

### Unblock a Website

To unblock a website (e.g., `example.com`):

```bash
block-site --unblock example.com
```

This will remove `example.com` and `www.example.com` from your `/etc/hosts` file, restoring access.

## Example Commands

- **Block YouTube**:
  ```bash
  block-site --block youtube.com
  ```

- **Unblock YouTube**:
  ```bash
  block-site --unblock youtube.com
  ```

## How It Works

The script modifies the `/etc/hosts` file to block websites by redirecting their domain names to `127.0.0.1`, which points to your local machine. When a domain is blocked, your computer will fail to reach the server, and the site will not load.

To ensure the changes take effect immediately, the script also flushes the DNS cache using:
```bash
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

## Caveats

- The script requires `sudo` privileges to modify the `/etc/hosts` file. When you run the command, you will be prompted to enter your password.
- Currently, this tool is primarily tested on macOS. It should also work on Linux, but further testing is encouraged.

## Contributing

If you'd like to contribute to `block-site`, feel free to fork the repository,
make changes, and submit a pull request. Bug reports and feature requests are
welcome via the [Issues](https://github.com/Chaitanya-Shahare/block-site/issues)
tab.

