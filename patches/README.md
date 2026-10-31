# THOX patch series — v0.1.0

The THOX patch series is applied in the order listed in `series`, one file
per patch, with `git apply` (the build script in `tools/` does this).

**v0.1.0 state: the series is EMPTY.** No THOX kernel patches ship in
v0.1.0. The series lands with the first import, which extracts it from the
Insider line (`thoxos-insider`, Developer Edition) on a fleet host — see
`../PATCHES.md` for the six intent areas the series will cover (target:
fewer than 30 patches, each upstreamable in principle).

A build from v0.1.0 therefore produces the pinned upstream LTS kernel,
unmodified except for configuration. That is the honest scope of this
release; anything else would be claiming work that has not landed.

## Format for future entries

```
# series — one patch filename per line, applied in order
0001-example-short-description.patch
```

Each patch file carries its own commit message header (Subject, body,
Signed-off-by) so the series can be replayed with `git am` as well as
`git apply`.
