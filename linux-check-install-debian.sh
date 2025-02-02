#!/bin/bash

# 必要なパッケージとライブラリ
PACKAGES=(
    "python3" "python2" "iptables" "nftables" "gdb"
)

LIBRARIES=(
    "libpopt0" "libcurl4" "libelf1"
    "libnsl1" "libattr1" "libc6" "libzstd1"
    "libpthread-stubs0-dev" "libudev1" "libm6" "libcap2"
    "libgcc-s1" "librpm9" "librpmio9" "libc6"
    "libc-bin" "libdl2"
)

# パッケージリストの更新
sudo apt update -y

# 必要なパッケージのインストール
for pkg in "${PACKAGES[@]}"; do
    if ! dpkg -l | grep -qw "$pkg"; then
        echo "Installing $pkg..."
        sudo apt install -y "$pkg"
    else
        echo "$pkg is already installed."
    fi
done

# 必要なライブラリのインストール
for lib in "${LIBRARIES[@]}"; do
    if ! dpkg -l | grep -qw "$lib"; then
        echo "$lib is missing. Installing..."
        sudo apt install -y "$lib"
    else
        echo "$lib is already installed."
    fi
done

echo "Installation check complete."

