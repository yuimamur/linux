#!/bin/bash

# 確認するパッケージとライブラリのリスト
PACKAGES=(
    "python3"
    "python2"
    "iptables"
    "nftables"
    "gdb"
)

LIBRARIES=(
    "libpopt.so.0"
    "libcurl.so.4"
    "linux-vdso.so.1"
    "libelf.so.1"
    "libnsl.so.1"
    "libattr.so.1"
    "librt.so.1"
    "libz.so.1"
    "libpthread.so.0"
    "libudev.so.1"
    "libm.so.6"
    "libcap.so.2"
    "libgcc_s.so.1"
    "librpm.so"
    "libc.so.6"
    "librpmio.so"
    "ld-linux-x86-64.so.2"
    "libdl.so.2"
)

echo "Checking installed packages..."
for pkg in "${PACKAGES[@]}"; do
    if rpm -q "$pkg" &>/dev/null; then
        echo "[✔] $pkg is installed"
    else
        echo "[✘] $pkg is NOT installed"
    fi
done

echo -e "\nChecking installed libraries..."
for lib in "${LIBRARIES[@]}"; do
    if ldconfig -p | grep "$lib" &>/dev/null; then
        echo "[✔] $lib is available"
    else
        echo "[✘] $lib is NOT available"
    fi
done

