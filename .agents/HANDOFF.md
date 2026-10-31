# Handoff — linux-thox

Status: PUBLIC v0.1.0 released 2026-10-31 (programme decision D10).
Repository: https://github.com/Thox-ai/linux-thox — release:
https://github.com/Thox-ai/linux-thox/releases/tag/v0.1.0

Done:
- Pins verified against kernel.org: Linux 6.6.161 (devices),
  6.12.115 (desktop).
- Build script (download, SHA-256 verify fail-closed, apply series,
  merge fragment, build).
- Patch-series framework with an explicitly empty series; six intent
  families in PATCHES.md.
- Per-class config fragments (e2/p4/p6/desktop) in configs/.

Next:
- First import on a fleet host: LTS source import, patch-series
  extraction from the Insider line, defconfigs generated from the
  fragments, arm64 + x86_64 CI.

Key files: tools/build-linux-thox.sh, BUILDING.md, PATCHES.md,
docs/KERNEL.md.

Conventions: DCO sign-off; patches upstreamable in principle;
GPL-2.0-only; no binary blobs.

Blockers: the import needs a fleet host with the source tree; it does
not happen from the packaging skeleton.

Last verified: 2026-10-31, publish pass (pins re-verified at packaging;
bundle sha256sum -c passed).
