# linux-thox — Development

## Architecture

A Linux LTS fork maintained as a readable patch series plus published
configuration on top of the pinned upstream tag. After the first
import, `git log v6.6..HEAD` is the whole THOX delta and the audit
surface. Patch families and configuration classes are specified in
[../PATCHES.md](../PATCHES.md), [KERNEL.md](KERNEL.md) and
[../configs/README.md](../configs/README.md).

## Dev environment

Standard kernel build toolchain (see QUICKSTART). Builds run through
`tools/build-linux-thox.sh`, which verifies the pinned tarball's
SHA-256 against kernel.org sums before extracting anything.

## Conventions

- Default branch `main`. DCO sign-off (`Signed-off-by`) on every
  commit. AI-generated contributions must be disclosed in the PR
  description.
- Every patch must be upstreamable in principle and carry its
  rationale. Target: fewer than 30 patches total.
- GPL-2.0-only. No binary blobs live in this repository.

## Known limitations (v0.1.0)

- No THOX patch exists yet; the series is explicitly empty.
- No defconfig files exist yet; per-class fragments carry the intent.
- The kernel build was not executed in the v0.1.0 packaging
  environment; blockers are recorded in the release's build log
  (thoxos-core release record).

## Roadmap

First import: LTS source import, patch-series extraction from the
Insider line on a fleet host, defconfigs generated from the fragments,
arm64 + x86_64 CI.

## Work log

- 2026-10-29: Phase 1 staging scaffold created.
- 2026-10-31: Public release v0.1.0 (packaging) under programme
  decision D10.
