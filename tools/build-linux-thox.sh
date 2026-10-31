#!/bin/sh
# build-linux-thox.sh — build a linux-thox v0.1.0 kernel for one class.
#
# What this does, in order:
#   1. Checks the host build dependencies and fails fast, naming what is
#      missing (kernel kconfig needs flex/bison; bc is required by the
#      kernel build system).
#   2. Downloads the PINNED upstream LTS tarball from kernel.org and
#      verifies its SHA-256 against kernel.org's own sha256sums.asc
#      (fail closed: any mismatch or missing sum aborts the build).
#   3. Extracts the tarball into ./build-<class>/.
#   4. Applies every patch listed in patches/series, in order
#      (v0.1.0: the series is empty; this step is a logged no-op).
#   5. Configures: upstream arch defconfig + the class fragment from
#      configs/, merged with the kernel's scripts/kconfig/merge_config.sh.
#   6. Builds with make -j$(nproc).
#
# Usage:
#   tools/build-linux-thox.sh <class> [jobs]
#   class: e2 | p4 | p6 | desktop
#
# Pins (verified against kernel.org releases.json on 2026-10-31):
#   device classes (e2/p4/p6): Linux 6.6.161  (6.6 longterm branch)
#   desktop:                   Linux 6.12.115 (6.12 longterm branch)
# Cross-compile: set CROSS_COMPILE and ARCH in the environment for device
# classes on an x86-64 host, e.g.
#   ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- tools/build-linux-thox.sh e2
#
# Honest scope: with the v0.1.0 empty patch series, this builds the pinned
# upstream kernel with THOX configuration applied. It does NOT build a
# THOX-patched kernel; the patch series lands with the first import.

set -eu

CLASS="${1:-}"
JOBS="${2:-$(nproc)}"

case "$CLASS" in
  e2|p4|p6)
    KVER="6.6.161"; KMAJ="6.6"; FRAGMENT="configs/thox_${CLASS}.fragment"
    ARCH="${ARCH:-arm64}" ;;
  desktop)
    KVER="6.12.115"; KMAJ="6.12"; FRAGMENT="configs/thox_desktop.fragment"
    ARCH="${ARCH:-$(uname -m | sed 's/x86_64/x86_64/;s/aarch64/arm64/')}" ;;
  *)
    echo "usage: $0 <e2|p4|p6|desktop> [jobs]" >&2; exit 2 ;;
esac

PKG_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
WORK="$PKG_DIR/build-$CLASS"
TARBALL="linux-$KVER.tar.xz"
URL="https://cdn.kernel.org/pub/linux/kernel/v${KMAJ%%.*}.x/$TARBALL"
SUMS_URL="https://cdn.kernel.org/pub/linux/kernel/v${KMAJ%%.*}.x/sha256sums.asc"

echo "== linux-thox v0.1.0 build: class=$CLASS base=linux-$KVER arch=$ARCH =="

# --- 1. dependency check (fail fast, name what is missing) ---
missing=""
for tool in gcc make bc flex bison perl xz curl tar; do
  command -v "$tool" >/dev/null 2>&1 || missing="$missing $tool"
done
if [ -n "$missing" ]; then
  echo "ERROR: missing build dependencies:$missing" >&2
  echo "Install them first (Debian/Ubuntu: sudo apt install build-essential bc flex bison libssl-dev libelf-dev dwarves xz-utils curl)." >&2
  exit 1
fi

mkdir -p "$WORK"
cd "$WORK"

# --- 2. download + verify (fail closed) ---
if [ ! -f "$TARBALL" ]; then
  echo "-- downloading $URL"
  curl -fL -o "$TARBALL" "$URL"
fi
echo "-- fetching kernel.org sha256sums.asc"
curl -fsSL -o sha256sums.asc "$SUMS_URL"
expected=$(awk -v t="$TARBALL" '$2 == t || $2 == "*" t {print $1}' sha256sums.asc)
if [ -z "$expected" ]; then
  echo "ERROR: no sha256 entry for $TARBALL in kernel.org sha256sums.asc; refusing to build an unverified tarball." >&2
  exit 1
fi
actual=$(sha256sum "$TARBALL" | awk '{print $1}')
if [ "$actual" != "$expected" ]; then
  echo "ERROR: sha256 mismatch for $TARBALL" >&2
  echo "  expected (kernel.org): $expected" >&2
  echo "  actual:                $actual" >&2
  exit 1
fi
echo "-- sha256 verified: $actual"

# --- 3. extract ---
SRC="$WORK/linux-$KVER"
if [ ! -d "$SRC" ]; then
  echo "-- extracting"
  tar -xf "$TARBALL"
fi
cd "$SRC"

# --- 4. apply the THOX patch series (empty in v0.1.0) ---
applied=0
while IFS= read -r line; do
  case "$line" in ''|'#'*) continue ;; esac
  echo "-- applying patch $line"
  git apply "$PKG_DIR/patches/$line" 2>/dev/null || patch -p1 < "$PKG_DIR/patches/$line"
  applied=$((applied + 1))
done < "$PKG_DIR/patches/series"
echo "-- patch series: $applied patch(es) applied"

# --- 5. configure: arch defconfig + THOX fragment ---
echo "-- configuring (defconfig + $FRAGMENT)"
make ARCH="$ARCH" ${CROSS_COMPILE:+CROSS_COMPILE="$CROSS_COMPILE"} defconfig
scripts/kconfig/merge_config.sh -m .config "$PKG_DIR/$FRAGMENT"
make ARCH="$ARCH" ${CROSS_COMPILE:+CROSS_COMPILE="$CROSS_COMPILE"} olddefconfig

# --- 6. build ---
echo "-- building with -j$JOBS"
make ARCH="$ARCH" ${CROSS_COMPILE:+CROSS_COMPILE="$CROSS_COMPILE"} -j"$JOBS"

echo "== done: build artifacts are under $SRC (arch/$ARCH/boot/) =="
