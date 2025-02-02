#!/bin/bash

# 必要なパッケージとライブラリ
PACKAGES=(
    "python3" "python2" "iptables" "nftables" "gdb"
)

LIBRARIES=(
    "libpopt.so.0" "libcurl.so.4" "linux-vdso.so.1" "libelf.so.1"
    "libnsl.so.1" "libattr.so.1" "librt.so.1" "libz.so.1"
    "libpthread.so.0" "libudev.so.1" "libm.so.6" "libcap.so.2"
    "libgcc_s.so.1" "librpm.so" "libc.so.6" "librpmio.so"
    "ld-linux-x86-64.so.2" "libdl.so.2"
)

# 使用可能なパッケージマネージャの確認
if command -v dnf &> /dev/null; then
    PM="dnf"
elif command -v yum &> /dev/null; then
    PM="yum"
else
    echo "Neither dnf nor yum is available. Exiting."
    exit 1
fi

# 必要なパッケージのインストール
for pkg in "${PACKAGES[@]}"; do
    if ! rpm -q "$pkg" &> /dev/null; then
        echo "Installing $pkg..."
        sudo $PM install -y "$pkg"
    else
        echo "$pkg is already installed."
    fi
done

# 必要なライブラリのインストール
for lib in "${LIBRARIES[@]}"; do
    if ! ldconfig -p | grep -q "$lib"; then
        echo "$lib is missing. Searching for package..."
        package=$(dnf provides */$lib | awk -F: '/:/ {print $1}' | head -n 1)
        if [ -n "$package" ]; then
            echo "Installing package $package for $lib..."
            sudo $PM install -y "$package"
        else
            echo "No package found for $lib. Please install it manually."
        fi
    else
        echo "$lib is already installed."
    fi
done

echo "Installation check complete."

