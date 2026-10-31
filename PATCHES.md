# THOX patch series — intent

Target: fewer than 30 patches, each upstreamable in principle.

1. BSP/device enablement per production compute class (category-level).
2. MagStack connector detection + power/clustering uevents (interface only; scheduling lives in userspace).
3. Accelerator plumbing via upstream DRM/accel + dma-buf; no binary blobs in this repo.
4. Hardening config (KSPP), module signing, lockdown, dm-verity support.
5. Low-memory tuning for E2 (zram, MGLRU); inference-burst scheduler/cpufreq defaults.
6. Memory-tier pressure signals for `thox-kvd` v1 (no KV transfer in-kernel).
