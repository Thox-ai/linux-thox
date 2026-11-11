# linux-thox

[![License](https://img.shields.io/badge/license-GPL--2.0--only-blue?style=flat-square)](LICENSE)
[![THOX.ai](https://img.shields.io/badge/THOX.ai-portfolio-05A451?style=flat-square)](https://thox.ai)

The THOX kernel package: Linux LTS with the THOX patch series and published defconfigs per compute class (E2, P4, P6, desktop). This is the kernel that shipping ThoxOS Core devices run.

**Status:** v0.1.0 source package (2026-10-31). Honest scope: v0.1.0 is the
linux-thox **packaging** — the pinned upstream LTS bases, the patch-series
framework, and the per-class config fragments — **not** a full fork tree and
**not** a built kernel. The THOX patch series itself and the full
`thox_*_defconfig` files land with the first import, which extracts the
series from the Insider line (`thoxos-insider`, Developer Edition) on a
fleet host. Until that import lands, a build from this package produces
the pinned upstream LTS kernel with the THOX config fragments applied —
nothing more is claimed. See [BUILDING.md](BUILDING.md).

## Shape

- Base: Linux 6.6 LTS (devices), 6.12 LTS (desktop class). The THOX delta is a
  readable commit series on top of the LTS tag: `git log v6.6..HEAD` is the
  whole THOX story.
- Configs: `thox_e2_defconfig`, `thox_p4_defconfig`, `thox_p6_defconfig`,
  `thox_desktop_defconfig` (to land with the first import). v0.1.0 ships the
  config **fragments** those defconfigs will be generated from, in
  [`configs/`](configs/).
- The first import extracts the patch series from the Insider line
  (`thoxos-insider`, Developer Edition) and is executed on a fleet host with
  the source tree; it does not happen from this staging skeleton.

## Quick start

```sh
git clone https://github.com/Thox-ai/linux-thox.git
cd linux-thox
tools/build-linux-thox.sh desktop   # or: e2 / p4 / p6 with ARCH/CROSS_COMPILE set
```

The script verifies the pinned tarball's SHA-256 against kernel.org
before building. Full path: [docs/QUICKSTART.md](docs/QUICKSTART.md).

## Models

The THOX model family lives on the THOX.ai Hugging Face organisation:
https://huggingface.co/Thox-ai — including the ThoxOS-Kernel family
cards (weights ship with ThoxOS host deployments).

## Documentation

- [Building](BUILDING.md)
- [Kernel guide](docs/KERNEL.md)
- [User Guide](docs/USER_GUIDE.md)
- [Quickstart](docs/QUICKSTART.md)
- [Development](docs/DEVELOPMENT.md)
- [Previews](docs/previews/)
- Agent handoff: [.agents/HANDOFF.md](.agents/HANDOFF.md)

## Releases

Formal releases live on the
[Releases page](https://github.com/Thox-ai/linux-thox/releases).
v0.1.0 is the packaging release; its tarball and SHA-256 sidecar are
attached there.

## Governance

THOX.ai LLC is the steward of this repository. Changes to public contracts
(ABIs, local APIs, the free/paid line) require an RFC. The THOX trademark
policy applies: the license covers the code, not the THOX marks.
Publishing and announcement decisions for THOX programmes are made by
the THOX.ai founders.

## Research

The architecture, evidence boundaries and validation protocol for this work are documented in:

**ThoxOS and ThoxInux: Architecture, Evidence, and a Validation Protocol for Local-First AI** (public technical draft, version 0.2.0-review, 1 November 2026), Craig Ross and Tommy Xaypanya, THOX.ai LLC. Paper, source and evidence ledger: https://github.com/ttracx/thox-research-paper/tree/main/papers/thoxos — Release: https://github.com/ttracx/thox-research-paper/releases/tag/thoxos-0.2.0-review — DOI: https://doi.org/10.5281/zenodo.23876230

Status: public technical draft; experimental validation is incomplete; not peer reviewed.

## License

GPL-2.0-only. See [LICENSE](LICENSE) and [NOTICE.md](NOTICE.md).

---

## Legal

Copyright (c) 2024-2026 THOX.ai LLC. All rights reserved.

**THOX.ai LLC**
- CTO: Tommy Xaypanya
- CEO: Craig Ross

This packaging is licensed under the GNU General Public License, version 2
only (GPL-2.0-only). See [LICENSE](LICENSE) for terms. The trademark policy
above is separate from the copyright license: the GPL covers the code, not
the THOX marks.
