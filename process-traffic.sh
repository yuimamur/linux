#!/bin/bash

# ヘッダー
echo "プロセスID, プロセス名, 宛先IP, 宛先ポート, 送信バイト数, 
受信バイト数"

# 各プロセスが行っている通信を表示
ss -tnp | awk 'NR>1 {print $6, $4, $5, $1, $2}' | while read line
do
    # プロセスIDと通信先情報を抽出
    pid=$(echo $line | awk '{print $1}' | cut -d',' -f1 | cut -d'=' -f2)
    process_name=$(ps -p $pid -o comm=)
    destination=$(echo $line | awk '{print $2}' | cut -d':' -f1)
    destination_port=$(echo $line | awk '{print $2}' | cut -d':' -f2)

    # 送受信バイト数の取得
    bytes_sent=$(cat /proc/$pid/net/dev | grep -w eth0 | awk '{print 
$10}')
    bytes_received=$(cat /proc/$pid/net/dev | grep -w eth0 | awk '{print 
$2}')
    
    # 結果を表示
    echo "$pid, $process_name, $destination, $destination_port, 
$bytes_sent, $bytes_received"
done

