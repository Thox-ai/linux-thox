# linux-thox — User Guide

linux-thox is the kernel ThoxOS Core runs: a Linux LTS fork whose THOX
delta is a readable patch series plus published configuration, so
anyone can see exactly what THOX changes and why.

Your AI. Your Data. Your Rules.™

## Honest scope of v0.1.0

v0.1.0 is the linux-thox **packaging**: pinned upstream LTS bases, a
build script, the patch-series framework with an **explicitly empty
series**, and per-class config fragments. It is not a full fork tree
and not a built kernel. The patch series and the full
`thox_*_defconfig` files land with the first import. A build from this
package produces the pinned upstream LTS kernel with the THOX config
fragments applied — nothing more is claimed. Full design detail:
[KERNEL.md](KERNEL.md) and [../BUILDING.md](../BUILDING.md).

## Pins (verified against kernel.org, 2026-10-31)

| Class | Base |
| --- | --- |
| Device classes E2, P4, P6 | Linux 6.6.161 (6.6 LTS) |
| Desktop class | Linux 6.12.115 (6.12 LTS) |

## Configuration classes

Four defconfigs are specified — `thox_e2_defconfig` (ThoxAir class),
`thox_p4_defconfig` (ThoxMini class), `thox_p6_defconfig` (ThoxClip
class), `thox_desktop_defconfig` (64-bit x86_64 and ARM64 PCs) — plus a
QEMU virtual-lab class mirroring E2. No defconfig file exists yet;
v0.1.0 publishes the same intent as per-class fragments in `configs/`,
which the build script merges over the pinned base configuration.

## The patch series (intent)

Fewer than 30 upstreamable patches in six families: BSP and device
enablement; MagStack connector detection (interface only — scheduling
lives in userspace); accelerator plumbing via upstream DRM/accel;
hardening; low-memory and burst tuning; memory-tier pressure signals.
In v0.1.0 the series is empty; the families are the intent it will
carry, recorded in [../PATCHES.md](../PATCHES.md).

## Building

See [QUICKSTART.md](QUICKSTART.md) and [../BUILDING.md](../BUILDING.md).
The build script downloads the pinned tarball, verifies its SHA-256
against kernel.org's published sums (fail closed), applies the series,
merges the class fragment, and builds.

## Source offer

linux-thox is GPL-2.0-only. Full source accompanies every binary image
built from it, with the GPL source offer, at release.

License: GPL-2.0-only. See [LICENSE](../LICENSE) and
[NOTICE.md](../NOTICE.md).
