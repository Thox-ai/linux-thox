# Building linux-thox v0.1.0

## What v0.1.0 is

v0.1.0 is the linux-thox **packaging**: pinned upstream LTS bases, the
patch-series framework, and per-class config fragments. The THOX patch
series is **empty** in v0.1.0 (see `patches/README.md`); it lands with the
first import from the Insider line on a fleet host. A build from this
package therefore produces **the pinned upstream LTS kernel with the THOX
config fragments applied** — a real, bootable upstream kernel with THOX
hardening and tuning configuration, and no THOX kernel code. Future
releases add the patch series on top of the same pins and the same script.

## Pins

| Class | Base | Branch | Verified |
| --- | --- | --- | --- |
| e2, p4, p6 (devices) | Linux **6.6.161** | 6.6 longterm | kernel.org `releases.json`, 2026-10-31 |
| desktop | Linux **6.12.115** | 6.12 longterm | kernel.org `releases.json`, 2026-10-31 |

The build script downloads the tarball from `cdn.kernel.org` and verifies
its SHA-256 against kernel.org's published `sha256sums.asc` before
extracting anything. A mismatch aborts the build.

## Build

```sh
# host dependencies (Debian/Ubuntu names)
sudo apt install build-essential bc flex bison libssl-dev libelf-dev dwarves xz-utils curl

# device class (cross-compile from an x86-64 host)
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- tools/build-linux-thox.sh e2

# desktop class (native)
tools/build-linux-thox.sh desktop
```

Artifacts land in `build-<class>/linux-<version>/` (kernel image under
`arch/<arch>/boot/`). An out-of-tree output directory can be used by
running the steps in `tools/build-linux-thox.sh` manually with `O=`.

## Relationship to the full defconfigs

The published `thox_e2_defconfig` / `thox_p4_defconfig` /
`thox_p6_defconfig` / `thox_desktop_defconfig` files land with the first
import. They will be generated from the fragments in `configs/` over the
same pinned bases, so a defconfig build and a fragment build converge.
