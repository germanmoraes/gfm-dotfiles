#!/bin/bash

INTERVAL=1

PREV_RX=0
PREV_TX=0
PREV_NET_TIME=0

GPU_PATH=""

find_gpu()
{
    GPU_PATH=""

    for card in /sys/class/drm/card*; do
        [ -e "$card/device/driver" ] || continue

        driver="$(readlink -f "$card/device/driver" 2>/dev/null)"

        case "$driver" in
            */amdgpu)
                GPU_PATH="$card/device"
                return
                ;;
        esac
    done
}

read_cpu()
{
    awk '
    /^cpu[[:space:]]/ {
        total=$2+$3+$4+$5+$6+$7+$8+$9+$10
        idle=$5+$6
    }

    END {
        print total, idle
    }
    ' /proc/stat
}

read_cpu_temperature()
{
    local temperature=""

    for hwmon in /sys/class/hwmon/hwmon*; do
        [ -d "$hwmon" ] || continue

        name="$(cat "$hwmon/name" 2>/dev/null)"

        case "$name" in
            k10temp|zenpower)
                for sensor in "$hwmon"/temp*_input; do
                    [ -f "$sensor" ] || continue

                    value="$(cat "$sensor" 2>/dev/null)"

                    if [[ "$value" =~ ^[0-9]+$ ]]; then
                        temperature=$((value / 1000))
                        break 2
                    fi
                done
                ;;
        esac
    done

    if [ -z "$temperature" ]; then
        temperature=0
    fi

    printf '%s\n' "$temperature"
}

read_memory()
{
    awk '
    /^MemTotal:/ {
        total=$2
    }

    /^MemAvailable:/ {
        available=$2
    }

    END {
        if (total > 0)
            printf "%.1f\n", ((total - available) / total) * 100
        else
            print "0"
    }
    ' /proc/meminfo
}

read_network()
{
    local rx
    local tx
    local now
    local down=0
    local up=0

    read -r rx tx < <(
        awk '
        NR > 2 {
            gsub(":", "", $1)

            if ($1 != "lo") {
                rx += $2
                tx += $10
            }
        }

        END {
            printf "%d %d\n", rx, tx
        }
        ' /proc/net/dev
    )

    now="$(date +%s%N)"

    if [ "$PREV_NET_TIME" -gt 0 ]; then
        elapsed_ns=$((now - PREV_NET_TIME))

        if [ "$elapsed_ns" -gt 0 ]; then
            down=$(( (rx - PREV_RX) * 1000000000 / elapsed_ns ))
            up=$(( (tx - PREV_TX) * 1000000000 / elapsed_ns ))
        fi
    fi

    [ "$down" -lt 0 ] && down=0
    [ "$up" -lt 0 ] && up=0

    PREV_RX="$rx"
    PREV_TX="$tx"
    PREV_NET_TIME="$now"

    DOWNLOAD="$down"
    UPLOAD="$up"
}

read_gpu()
{
    [ -n "$GPU_PATH" ] || find_gpu

    if [ -z "$GPU_PATH" ]; then
        printf '0\n'
        return
    fi

    busy="$(cat "$GPU_PATH/gpu_busy_percent" 2>/dev/null || echo 0)"

    [[ "$busy" =~ ^[0-9]+([.][0-9]+)?$ ]] || busy=0

    printf '%s\n' "$busy"
}

PREV_CPU_TOTAL=0
PREV_CPU_IDLE=0

while true; do

    read -r CPU_TOTAL CPU_IDLE <<< "$(read_cpu)"

    CPU_USAGE=0

    if [ "$PREV_CPU_TOTAL" -gt 0 ]; then
        CPU_TOTAL_DELTA=$((CPU_TOTAL - PREV_CPU_TOTAL))
        CPU_IDLE_DELTA=$((CPU_IDLE - PREV_CPU_IDLE))

        if [ "$CPU_TOTAL_DELTA" -gt 0 ]; then
            CPU_USAGE=$(
                awk -v total="$CPU_TOTAL_DELTA" \
                    -v idle="$CPU_IDLE_DELTA" \
                    'BEGIN {
                        value=((total-idle)/total)*100
                        if (value < 0) value=0
                        if (value > 100) value=100
                        printf "%.1f", value
                    }'
            )
        fi
    fi

    PREV_CPU_TOTAL="$CPU_TOTAL"
    PREV_CPU_IDLE="$CPU_IDLE"

    CPU_TEMP="$(read_cpu_temperature)"
    MEMORY_USAGE="$(read_memory)"
    GPU_USAGE="$(read_gpu)"

    read_network

    printf 'CPU|%s|%s\n' \
        "$CPU_USAGE" \
        "$CPU_TEMP"

    printf 'MEM|%s\n' \
        "$MEMORY_USAGE"

    printf 'GPU|%s\n' \
        "$GPU_USAGE"

    printf 'NET|%s|%s\n' \
        "$DOWNLOAD" \
        "$UPLOAD"

    sleep "$INTERVAL"
done
