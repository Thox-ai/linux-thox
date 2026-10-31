# linux-thox config fragments

The full `thox_e2_defconfig`, `thox_p4_defconfig`, `thox_p6_defconfig` and
`thox_desktop_defconfig` files land with the first import (see the top-level
README). What v0.1.0 ships is the **config intent** those defconfigs will be
generated from: one fragment per class, merged over the upstream arch
defconfig by `tools/build-linux-thox.sh` (via the kernel's own
`scripts/kconfig/merge_config.sh`).

| Fragment | Class | Base pinned by the build script |
| --- | --- | --- |
| `thox_e2.fragment` | E2 entry devices (quad-core Arm, 2 GB floor) | Linux 6.6.161 LTS, arm64 defconfig |
| `thox_p4.fragment` | P4 performance devices (8-core Arm, 4 GB floor) | Linux 6.6.161 LTS, arm64 defconfig |
| `thox_p6.fragment` | P6 performance+ devices (8-core Arm, 6 GB floor) | Linux 6.6.161 LTS, arm64 defconfig |
| `thox_desktop.fragment` | Desktop class (x86-64 and arm64) | Linux 6.12.115 LTS, arch defconfig |

The fragments encode intent areas 4 and 5 of `../PATCHES.md` (KSPP
hardening baseline; low-memory tuning for the smallest class). They are
configuration only: they do not add drivers, and BSP/device enablement
(intent area 1) arrives with the patch series, not with config.

Fragment values follow the Kernel Self Protection Project recommended
settings where a setting exists on the pinned bases. Where a symbol does
not exist on a base (renamed/removed between 6.6 and 6.12), the merge step
drops it with a warning; the generated `.config` is the record of what
actually took effect.
