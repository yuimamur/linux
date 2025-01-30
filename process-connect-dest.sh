#!/bin/bash

# cybereason-sensor のプロセスIDを取得
PID=$(pgrep -f cybereason-sensor)

if [ -z "$PID" ]; then
    echo "cybereason-sensor プロセスが見つかりません。"
    exit 1
fi

echo "監視対象: cybereason-sensor (PID: $PID)"
echo "========================================"

# 宛先アドレスごとの通信バイトを表示
echo "通信先 IP アドレスとバイト数:"
echo "----------------------------------------"
ss -ntp | awk -v pid="$PID" '$0 ~ pid {print $5}' | cut -d':' -f1 | sort | 
uniq -c | awk '{printf "%s - %s connections\n", $2, $1}'

# プロセスのネットワークバイト統計
echo "========================================"
echo "プロセスの送受信バイト数:"
echo "----------------------------------------"
cat /proc/$PID/net/dev | awk 'NR>2 {print $1, "受信:", $2, "バイト 送信:", 
$10, "バイト"}'


