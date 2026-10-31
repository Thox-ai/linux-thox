# linux-thox — Quickstart

Build the pinned upstream kernel with the THOX config fragments, in
the fewest steps. Host: 64-bit Linux with the standard kernel build
toolchain.

```sh
git clone https://github.com/Thox-ai/linux-thox.git
cd linux-thox

# host dependencies (Debian/Ubuntu names)
sudo apt install build-essential bc flex bison libssl-dev libelf-dev dwarves xz-utils curl

# device class (cross-compile from an x86-64 host)
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- tools/build-linux-thox.sh e2

# desktop class (native)
tools/build-linux-thox.sh desktop
```

The script downloads the pinned tarball for the class (6.6.161 for
devices, 6.12.115 for desktop), verifies SHA-256 against kernel.org's
published sums and aborts on mismatch, applies the patch series
(empty in v0.1.0), merges the class config fragment, and builds.
Artifacts land in `build-<class>/linux-<version>/`.

What this build is and is not: [../BUILDING.md](../BUILDING.md).
